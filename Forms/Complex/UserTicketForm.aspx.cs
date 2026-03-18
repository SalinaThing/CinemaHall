using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Complex_UserTicketForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt = DBHelper.ExecuteQuery("SELECT UserId, Username FROM USERS ORDER BY Username");
            lbUser.DataSource = dt;
            lbUser.DataTextField = "Username";
            lbUser.DataValueField = "UserId";
            lbUser.DataBind();

            // Default: last 6 months
            txtTo.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtFrom.Text = DateTime.Today.AddMonths(-6).ToString("yyyy-MM-dd");
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lbUser.SelectedItem == null)
        {
            lblMsg.Text = "Please select a user.";
            lblMsg.Visible = true;
            return;
        }
        lblMsg.Visible = false;

        int userId = int.Parse(lbUser.SelectedValue);
        DateTime fromDate = string.IsNullOrEmpty(txtFrom.Text) ? DateTime.Today.AddMonths(-6) : DateTime.Parse(txtFrom.Text);
        DateTime toDate = string.IsNullOrEmpty(txtTo.Text) ? DateTime.Today : DateTime.Parse(txtTo.Text);

        // User details
        DataTable dtUser = DBHelper.ExecuteQuery("SELECT * FROM USERS WHERE UserId=:id",
            new[] { new OracleParameter("id", userId) });
        if (dtUser.Rows.Count > 0)
        {
            lblUName.Text = dtUser.Rows[0]["Username"].ToString();
            lblUEmail.Text = dtUser.Rows[0]["UserEmail"].ToString();
            lblUAddr.Text = dtUser.Rows[0]["Address"].ToString();
            pnlUser.Visible = true;
        }

        // Tickets in period
        string sql = @"SELECT t.TicketId, m.MovieTitle, th.TheaterName, th.TheaterCity,
                              h.HallType, s.ShowName, s.ShowDate,
                              t.TicketPrice, t.TicketDate, t.TicketStatus, t.PaymentStatus
                       FROM TICKET t
                       JOIN TICKETSHOW ts ON t.TicketId = ts.TicketId
                       JOIN MOVIE m ON ts.MovieId = m.MovieId
                       JOIN THEATER th ON ts.TheaterId = th.TheaterId
                       JOIN HALL h ON ts.HallId = h.HallId
                       JOIN SHOW_TABLE s ON ts.ShowId = s.ShowId
                       WHERE ts.UserId = :uid
                         AND t.TicketDate BETWEEN :fd AND :td
                       ORDER BY t.TicketDate DESC";

        OracleParameter[] p = {
            new OracleParameter("uid", userId),
            new OracleParameter("fd", fromDate),
            new OracleParameter("td", toDate)
        };

        DataTable dtTickets = DBHelper.ExecuteQuery(sql, p);
        lblUTotal.Text = dtTickets.Rows.Count.ToString();
        gvTickets.DataSource = dtTickets;
        gvTickets.DataBind();

        // Total paid amount
        decimal total = 0;
        foreach (DataRow row in dtTickets.Rows)
            if (row["PaymentStatus"].ToString() == "Completed")
                total += Convert.ToDecimal(row["TicketPrice"]);
        lblTotalAmt.Text = total.ToString("N0");

        pnlTickets.Visible = true;
    }

    public string GetStatusBadge(string status)
    {
        switch (status)
        {
            case "Paid": return "bg-success";
            case "Cancelled": return "bg-danger";
            default: return "bg-warning text-dark";
        }
    }

    public string GetPaymentBadge(string status)
    {
        switch (status)
        {
            case "Completed": return "bg-success";
            case "Failed": return "bg-danger";
            default: return "bg-secondary";
        }
    }
}
