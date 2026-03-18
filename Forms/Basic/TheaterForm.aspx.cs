using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_TheaterForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) LoadGrid(); }

    void LoadGrid()
    {
        gvList.DataSource = DBHelper.ExecuteQuery("SELECT * FROM THEATER ORDER BY TheaterId");
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
        hfTheaterId.Value = "";
        txtName.Text = txtCity.Text = "";
        ddlType.SelectedIndex = 0;
        lblFormTitle.Text = "Add New Theater";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(hfTheaterId.Value))
            {
                DBHelper.ExecuteNonQuery("INSERT INTO THEATER (TheaterId, TheaterName, TheaterCity, TheatreType) VALUES (SEQ_THEATER.NEXTVAL,:n,:c,:t)",
                    new[] { new OracleParameter("n", txtName.Text.Trim()),
                            new OracleParameter("c", txtCity.Text.Trim()),
                            new OracleParameter("t", ddlType.SelectedValue) });
                ShowMsg("Theater added.");
            }
            else
            {
                DBHelper.ExecuteNonQuery("UPDATE THEATER SET TheaterName=:n, TheaterCity=:c, TheatreType=:t WHERE TheaterId=:id",
                    new[] { new OracleParameter("n", txtName.Text.Trim()),
                            new OracleParameter("c", txtCity.Text.Trim()),
                            new OracleParameter("t", ddlType.SelectedValue),
                            new OracleParameter("id", int.Parse(hfTheaterId.Value)) });
                ShowMsg("Theater updated.");
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
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM THEATER WHERE TheaterId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfTheaterId.Value = id.ToString();
                txtName.Text = dt.Rows[0]["TheaterName"].ToString();
                txtCity.Text = dt.Rows[0]["TheaterCity"].ToString();
                ddlType.SelectedValue = dt.Rows[0]["TheatreType"].ToString();
                lblFormTitle.Text = "Edit Theater";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                // Delete Tickets linked to this theater
                DBHelper.ExecuteNonQuery("DELETE FROM TICKET WHERE TicketId IN (SELECT TicketId FROM TICKETSHOW WHERE TheaterId=:id)", 
                    new[] { new OracleParameter("id", id) });

                // Delete from junction tables
                string[] junctionTables = { "TICKETSHOW", "THEATERMOVIEMAP", "HALLTHEATER", "SHOWHALL" };
                foreach (var table in junctionTables)
                {
                    DBHelper.ExecuteNonQuery($"DELETE FROM {table} WHERE TheaterId=:id", 
                        new[] { new OracleParameter("id", id) });
                }

                // Finally delete theater
                DBHelper.ExecuteNonQuery("DELETE FROM THEATER WHERE TheaterId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("Theater and all associated records deleted."); LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Error deleting theater: " + ex.Message, true); }
        }
    }
}
