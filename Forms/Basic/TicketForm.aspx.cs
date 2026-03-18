using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_TicketForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { LoadDropdowns(); LoadGrid(); }
    }

    void LoadDropdowns()
    {
        DataTable dtU = DBHelper.ExecuteQuery("SELECT UserId, Username FROM USERS ORDER BY Username");
        ddlUser.DataSource = dtU; ddlUser.DataTextField = "Username"; ddlUser.DataValueField = "UserId";
        ddlUser.DataBind(); ddlUser.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select User --", ""));

        DataTable dtM = DBHelper.ExecuteQuery("SELECT MovieId, MovieTitle FROM MOVIE ORDER BY MovieTitle");
        ddlMovie.DataSource = dtM; ddlMovie.DataTextField = "MovieTitle"; ddlMovie.DataValueField = "MovieId";
        ddlMovie.DataBind(); ddlMovie.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Movie --", ""));

        DataTable dtT = DBHelper.ExecuteQuery("SELECT TheaterId, TheaterName FROM THEATER ORDER BY TheaterName");
        ddlTheater.DataSource = dtT; ddlTheater.DataTextField = "TheaterName"; ddlTheater.DataValueField = "TheaterId";
        ddlTheater.DataBind(); ddlTheater.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Theater --", ""));

        DataTable dtH = DBHelper.ExecuteQuery("SELECT HallId, HallType || ' (Cap:' || HallCapacity || ')' AS HallName FROM HALL ORDER BY HallId");
        ddlHall.DataSource = dtH; ddlHall.DataTextField = "HallName"; ddlHall.DataValueField = "HallId";
        ddlHall.DataBind(); ddlHall.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Hall --", ""));

        DataTable dtS = DBHelper.ExecuteQuery("SELECT ShowId, ShowName || ' - ' || TO_CHAR(ShowDate,'DD-Mon-YYYY') AS SName FROM SHOW_TABLE ORDER BY ShowDate DESC");
        ddlShow.DataSource = dtS; ddlShow.DataTextField = "SName"; ddlShow.DataValueField = "ShowId";
        ddlShow.DataBind(); ddlShow.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Show --", ""));
    }

    void LoadGrid()
    {
        string sql = @"SELECT t.TicketId, u.Username, m.MovieTitle, th.TheaterName,
                              s.ShowName, t.TicketPrice, t.TicketDate, t.TicketStatus, t.PaymentStatus
                       FROM TICKET t
                       JOIN TICKETSHOW ts ON t.TicketId = ts.TicketId
                       JOIN USERS u ON ts.UserId = u.UserId
                       JOIN MOVIE m ON ts.MovieId = m.MovieId
                       JOIN THEATER th ON ts.TheaterId = th.TheaterId
                       JOIN SHOW_TABLE s ON ts.ShowId = s.ShowId
                       ORDER BY t.TicketId DESC";
        gvList.DataSource = DBHelper.ExecuteQuery(sql);
        gvList.DataBind();
    }

    void ShowMsg(string msg, bool err = false)
    {
        lblMsg.Text = msg;
        lblMsg.CssClass = err ? "alert alert-danger d-block mb-3" : "alert alert-success d-block mb-3";
        lblMsg.Visible = true;
    }

    void ClearForm()
    {
        hfTicketId.Value = "";
        txtPrice.Text = txtDate.Text = "";
        ddlUser.SelectedIndex = 0; ddlMovie.SelectedIndex = 0;
        ddlTheater.SelectedIndex = 0; ddlHall.SelectedIndex = 0;
        ddlShow.SelectedIndex = 0; ddlStatus.SelectedIndex = 0;
        ddlPayment.SelectedIndex = 0;
        lblFormTitle.Text = "Add New Ticket";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlUser.SelectedValue) || string.IsNullOrEmpty(ddlMovie.SelectedValue))
        { ShowMsg("Please select User and Movie.", true); return; }

        try
        {
            if (string.IsNullOrEmpty(hfTicketId.Value))
            {
                // Insert ticket
                object newId = DBHelper.ExecuteScalar("SELECT SEQ_TICKET.NEXTVAL FROM DUAL");
                DBHelper.ExecuteNonQuery("INSERT INTO TICKET (TicketId, TicketPrice, TicketDate, TicketStatus, PaymentStatus) VALUES (:id,:p,:d,:s,:pay)",
                    new[] { new OracleParameter("id", newId),
                            new OracleParameter("p", decimal.Parse(txtPrice.Text)),
                            new OracleParameter("d", DateTime.Parse(txtDate.Text)),
                            new OracleParameter("s", ddlStatus.SelectedValue),
                            new OracleParameter("pay", ddlPayment.SelectedValue) });

                // Insert TICKETSHOW junction
                DBHelper.ExecuteNonQuery("INSERT INTO TICKETSHOW (TicketId, UserId, MovieId, TheaterId, HallId, ShowId) VALUES (:tid,:uid,:mid,:thid,:hid,:sid)",
                    new[] { new OracleParameter("tid", newId),
                            new OracleParameter("uid", int.Parse(ddlUser.SelectedValue)),
                            new OracleParameter("mid", int.Parse(ddlMovie.SelectedValue)),
                            new OracleParameter("thid", string.IsNullOrEmpty(ddlTheater.SelectedValue) ? (object)DBNull.Value : int.Parse(ddlTheater.SelectedValue)),
                            new OracleParameter("hid", string.IsNullOrEmpty(ddlHall.SelectedValue) ? (object)DBNull.Value : int.Parse(ddlHall.SelectedValue)),
                            new OracleParameter("sid", string.IsNullOrEmpty(ddlShow.SelectedValue) ? (object)DBNull.Value : int.Parse(ddlShow.SelectedValue)) });
                ShowMsg("Ticket added.");
            }
            else
            {
                DBHelper.ExecuteNonQuery("UPDATE TICKET SET TicketPrice=:p, TicketDate=:d, TicketStatus=:s, PaymentStatus=:pay WHERE TicketId=:id",
                    new[] { new OracleParameter("p", decimal.Parse(txtPrice.Text)),
                            new OracleParameter("d", DateTime.Parse(txtDate.Text)),
                            new OracleParameter("s", ddlStatus.SelectedValue),
                            new OracleParameter("pay", ddlPayment.SelectedValue),
                            new OracleParameter("id", int.Parse(hfTicketId.Value)) });
                ShowMsg("Ticket updated.");
            }
            ClearForm(); LoadGrid();
        }
        catch (Exception ex) { ShowMsg("Error: " + ex.Message, true); }
    }

    protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

    protected void gvList_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = int.Parse(e.CommandArgument.ToString());
        if (e.CommandName == "EditRow")
        {
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM TICKET WHERE TicketId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfTicketId.Value = id.ToString();
                txtPrice.Text = dt.Rows[0]["TicketPrice"].ToString();
                txtDate.Text = Convert.ToDateTime(dt.Rows[0]["TicketDate"]).ToString("yyyy-MM-dd");
                try { ddlStatus.SelectedValue = dt.Rows[0]["TicketStatus"].ToString(); } catch { }
                try { ddlPayment.SelectedValue = dt.Rows[0]["PaymentStatus"].ToString(); } catch { }
                lblFormTitle.Text = "Edit Ticket";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                DBHelper.ExecuteNonQuery("DELETE FROM TICKETSHOW WHERE TicketId=:id",
                    new[] { new OracleParameter("id", id) });
                DBHelper.ExecuteNonQuery("DELETE FROM TICKET WHERE TicketId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("Ticket deleted."); LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Cannot delete: " + ex.Message, true); }
        }
    }
}
