using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_HallForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) LoadGrid(); }

    void LoadGrid()
    {
        gvList.DataSource = DBHelper.ExecuteQuery("SELECT * FROM HALL ORDER BY HallId");
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
        hfHallId.Value = "";
        txtCapacity.Text = txtFloor.Text = txtSeats.Text = "";
        txtFloor.Text = "1";
        ddlHallType.SelectedIndex = 0;
        lblFormTitle.Text = "Add New Hall";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(hfHallId.Value))
            {
                DBHelper.ExecuteNonQuery("INSERT INTO HALL VALUES (SEQ_HALL.NEXTVAL,:c,:t,:f,:s)",
                    new[] { new OracleParameter("c", int.Parse(txtCapacity.Text)),
                            new OracleParameter("t", ddlHallType.SelectedValue),
                            new OracleParameter("f", int.Parse(txtFloor.Text)),
                            new OracleParameter("s", int.Parse(txtSeats.Text)) });
                ShowMsg("Hall added.");
            }
            else
            {
                DBHelper.ExecuteNonQuery("UPDATE HALL SET HallCapacity=:c, HallType=:t, FloorNo=:f, TotalSeats=:s WHERE HallId=:id",
                    new[] { new OracleParameter("c", int.Parse(txtCapacity.Text)),
                            new OracleParameter("t", ddlHallType.SelectedValue),
                            new OracleParameter("f", int.Parse(txtFloor.Text)),
                            new OracleParameter("s", int.Parse(txtSeats.Text)),
                            new OracleParameter("id", int.Parse(hfHallId.Value)) });
                ShowMsg("Hall updated.");
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
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM HALL WHERE HallId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfHallId.Value = id.ToString();
                txtCapacity.Text = dt.Rows[0]["HallCapacity"].ToString();
                ddlHallType.SelectedValue = dt.Rows[0]["HallType"].ToString();
                txtFloor.Text = dt.Rows[0]["FloorNo"].ToString();
                txtSeats.Text = dt.Rows[0]["TotalSeats"].ToString();
                lblFormTitle.Text = "Edit Hall";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                // Delete Tickets linked to this hall
                DBHelper.ExecuteNonQuery("DELETE FROM TICKET WHERE TicketId IN (SELECT TicketId FROM TICKETSHOW WHERE HallId=:id)", 
                    new[] { new OracleParameter("id", id) });

                // Delete from junction tables
                string[] junctionTables = { "TICKETSHOW", "HALLTHEATER", "SHOWHALL" };
                foreach (var table in junctionTables)
                {
                    DBHelper.ExecuteNonQuery($"DELETE FROM {table} WHERE HallId=:id", 
                        new[] { new OracleParameter("id", id) });
                }

                // Finally delete hall
                DBHelper.ExecuteNonQuery("DELETE FROM HALL WHERE HallId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("Hall and all associated records deleted."); LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Error deleting hall: " + ex.Message, true); }
        }
    }
}
