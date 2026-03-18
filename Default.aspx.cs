using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization;
using Oracle.ManagedDataAccess.Client;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            if (!IsPostBack) 
            {
                // Sync all sequences to avoid ORA-00001 after manual imports
                DBHelper.SyncSequence("USERS", "UserId", "SEQ_USER");
                DBHelper.SyncSequence("MOVIE", "MovieId", "SEQ_MOVIE");
                DBHelper.SyncSequence("THEATER", "TheaterId", "SEQ_THEATER");
                DBHelper.SyncSequence("HALL", "HallId", "SEQ_HALL");
                DBHelper.SyncSequence("SHOW_TABLE", "ShowId", "SEQ_SHOW");
                DBHelper.SyncSequence("TICKET", "TicketId", "SEQ_TICKET");
                
                LoadDashboard();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "<b>Runtime Error:</b> " + ex.Message + "<br/><small>" + ex.StackTrace.Substring(0, Math.Min(ex.StackTrace.Length, 200)) + "...</small>";
            lblMsg.Visible = true;
        }
    }

    void LoadDashboard()
    {
        // Stats
        lblMovies.Text = DBHelper.ExecuteScalarString("SELECT COUNT(*) FROM MOVIE");
        lblTickets.Text = DBHelper.ExecuteScalarString("SELECT COUNT(*) FROM TICKET");
        
        string revSql = "SELECT SUM(TicketPrice) FROM TICKET WHERE PaymentStatus='Completed'";
        object rev = DBHelper.ExecuteScalar(revSql);
        lblRevenue.Text = rev != null && rev != DBNull.Value ? Convert.ToDecimal(rev).ToString("N0") : "0";

        string occSql = @"SELECT ROUND(AVG(OccupancyPct), 1) FROM (
                            SELECT th.TheaterId, 
                                   COUNT(t.TicketId) * 100.0 / NULLIF(SUM(h.TotalSeats), 0) as OccupancyPct
                            FROM THEATER th
                            JOIN TICKETSHOW ts ON th.TheaterId = ts.TheaterId
                            JOIN HALL h ON ts.HallId = h.HallId
                            JOIN TICKET t ON ts.TicketId = t.TicketId
                            WHERE t.PaymentStatus = 'Completed'
                            GROUP BY th.TheaterId
                          )";
        object occ = DBHelper.ExecuteScalar(occSql);
        lblAvgOccupancy.Text = occ != null && occ != DBNull.Value ? occ.ToString() : "0";

        // Recent Tickets
        string sql = @"SELECT * FROM (
                           SELECT t.TicketId, u.Username, m.MovieTitle, t.TicketPrice, t.TicketStatus
                           FROM TICKET t
                           JOIN TICKETSHOW ts ON t.TicketId = ts.TicketId
                           JOIN USERS u ON ts.UserId = u.UserId
                           JOIN MOVIE m ON ts.MovieId = m.MovieId
                           ORDER BY t.TicketId DESC
                       ) WHERE ROWNUM <= 5";
        gvRecent.DataSource = DBHelper.ExecuteQuery(sql);
        gvRecent.DataBind();
    }

    protected string GetChartLabels()
    {
        // Last 6 months
        var labels = new List<string>();
        for (int i = 5; i >= 0; i--)
            labels.Add(DateTime.Today.AddMonths(-i).ToString("MMM"));
        return new JavaScriptSerializer().Serialize(labels);
    }

    protected string GetChartData()
    {
        // Monthly revenue for last 6 months
        var data = new List<decimal>();
        for (int i = 5; i >= 0; i--)
        {
            DateTime start = new DateTime(DateTime.Today.AddMonths(-i).Year, DateTime.Today.AddMonths(-i).Month, 1);
            DateTime end = start.AddMonths(1).AddDays(-1);
            
            string sql = "SELECT SUM(TicketPrice) FROM TICKET WHERE PaymentStatus='Completed' AND TicketDate BETWEEN :s AND :e";
            OracleParameter[] p = {
                new OracleParameter("s", start),
                new OracleParameter("e", end)
            };
            object val = DBHelper.ExecuteScalar(sql, p);
            data.Add(val != null && val != DBNull.Value ? Convert.ToDecimal(val) : 0);
        }
        return new JavaScriptSerializer().Serialize(data);
    }

    protected string GetOccupancyLabels()
    {
        DataTable dt = DBHelper.ExecuteQuery("SELECT TheaterName FROM (SELECT TheaterName FROM THEATER) WHERE ROWNUM <= 5");
        var labels = new List<string>();
        foreach (DataRow r in dt.Rows) labels.Add(r["TheaterName"].ToString());
        return new JavaScriptSerializer().Serialize(labels);
    }

    protected string GetOccupancyData()
    {
        DataTable dt = DBHelper.ExecuteQuery(@"
            SELECT * FROM (
                SELECT th.TheaterName, COUNT(t.TicketId) as Sales
                FROM THEATER th
                LEFT JOIN TICKETSHOW ts ON th.TheaterId = ts.TheaterId
                LEFT JOIN TICKET t ON ts.TicketId = t.TicketId AND t.PaymentStatus = 'Completed'
                GROUP BY th.TheaterName
            ) WHERE ROWNUM <= 5");
        var data = new List<int>();
        foreach (DataRow r in dt.Rows) data.Add(Convert.ToInt32(r["Sales"]));
        return new JavaScriptSerializer().Serialize(data);
    }
}
