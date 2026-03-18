using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Complex_OccupancyForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt = DBHelper.ExecuteQuery("SELECT MovieId, MovieTitle FROM MOVIE ORDER BY MovieTitle");
            lbMovie.DataSource = dt;
            lbMovie.DataTextField = "MovieTitle";
            lbMovie.DataValueField = "MovieId";
            lbMovie.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lbMovie.SelectedItem == null)
        {
            lblMsg.Text = "Please select a movie.";
            lblMsg.Visible = true;
            return;
        }
        lblMsg.Visible = false;

        int movieId = int.Parse(lbMovie.SelectedValue);

        // Movie details
        DataTable dtM = DBHelper.ExecuteQuery("SELECT * FROM MOVIE WHERE MovieId=:id",
            new[] { new OracleParameter("id", movieId) });
        if (dtM.Rows.Count > 0)
        {
            lblMTitle.Text = dtM.Rows[0]["MovieTitle"].ToString();
            lblMGenre.Text = dtM.Rows[0]["Genre"].ToString();
            lblMLang.Text = dtM.Rows[0]["Language"].ToString();
            lblMDur.Text = dtM.Rows[0]["Duration"].ToString();
            if (dtM.Rows[0]["ReleaseDate"] != DBNull.Value)
                lblMRel.Text = Convert.ToDateTime(dtM.Rows[0]["ReleaseDate"]).ToString("yyyy-MM-dd");
            pnlMovie.Visible = true;
        }

        // Top 3 theaters by occupancy (paid tickets only)
        // Note: Occupancy = (Total Paid Tickets) / (Total Capacity of all shows of this movie in that theater)
        string sql = @"SELECT * FROM (
                         SELECT th.TheaterId, th.TheaterName, th.TheaterCity, th.TheatreType,
                                SUM(h.TotalSeats) AS Capacity,
                                COUNT(DISTINCT t.TicketId) AS PaidTickets,
                                ROUND(COUNT(DISTINCT t.TicketId) * 100.0 / NULLIF(SUM(h.TotalSeats), 0), 2) AS OccupancyPct
                         FROM THEATER th
                         JOIN (
                             -- Get distinct shows for each theater to avoid multiplying capacity by ticket count
                             SELECT DISTINCT TheaterId, HallId, ShowId, MovieId 
                             FROM TICKETSHOW 
                             WHERE MovieId = :mid
                         ) ts ON th.TheaterId = ts.TheaterId
                         JOIN HALL h ON ts.HallId = h.HallId
                         LEFT JOIN TICKETSHOW ts2 ON ts.TicketId = ts2.TicketId -- This join is tricky because of the distinct
                         -- Actually, let's simplify:
                         JOIN TICKETSHOW tstall ON th.TheaterId = tstall.TheaterId AND tstall.MovieId = :mid
                         JOIN TICKET t ON tstall.TicketId = t.TicketId
                         WHERE t.PaymentStatus = 'Completed'
                         GROUP BY th.TheaterId, th.TheaterName, th.TheaterCity, th.TheatreType
                         ORDER BY OccupancyPct DESC
                       ) WHERE ROWNUM <= 3";
        // Actually, the above join logic is getting circular. Let's use a cleaner subquery approach.
        sql = @"SELECT * FROM (
                  SELECT th.TheaterId, th.TheaterName, th.TheaterCity, th.TheatreType,
                         (SELECT SUM(h2.TotalSeats)
                          FROM (SELECT DISTINCT TheaterId, HallId, ShowId FROM TICKETSHOW WHERE MovieId = :mid1) ts_inner
                          JOIN HALL h2 ON ts_inner.HallId = h2.HallId
                          WHERE ts_inner.TheaterId = th.TheaterId) AS TotalCapacity,
                         COUNT(t.TicketId) AS PaidTickets,
                         ROUND(COUNT(t.TicketId) * 100.0 / NULLIF((SELECT SUM(h2.TotalSeats)
                                                                    FROM (SELECT DISTINCT TheaterId, HallId, ShowId FROM TICKETSHOW WHERE MovieId = :mid2) ts_inner
                                                                    JOIN HALL h2 ON ts_inner.HallId = h2.HallId
                                                                    WHERE ts_inner.TheaterId = th.TheaterId), 0), 2) AS OccupancyPct
                  FROM THEATER th
                  JOIN TICKETSHOW ts ON th.TheaterId = ts.TheaterId
                  JOIN TICKET t ON ts.TicketId = t.TicketId
                  WHERE ts.MovieId = :mid3 AND t.PaymentStatus = 'Completed'
                  GROUP BY th.TheaterId, th.TheaterName, th.TheaterCity, th.TheatreType
                  ORDER BY OccupancyPct DESC
                ) WHERE ROWNUM <= 3";

        DataTable dtOcc = DBHelper.ExecuteQuery(sql,
            new[] { 
                new OracleParameter("mid1", movieId),
                new OracleParameter("mid2", movieId),
                new OracleParameter("mid3", movieId)
            });
        gvOccupancy.DataSource = dtOcc;
        gvOccupancy.DataBind();
        pnlResults.Visible = true;
    }
}
