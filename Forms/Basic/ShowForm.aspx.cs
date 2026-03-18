using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_ShowForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) LoadGrid(); }

    void LoadGrid()
    {
        gvList.DataSource = DBHelper.ExecuteQuery("SELECT * FROM SHOW_TABLE ORDER BY ShowId");
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
        hfShowId.Value = "";
        txtName.Text = txtDate.Text = "";
        ddlType.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
        lblFormTitle.Text = "Add New Show";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime showDate = DateTime.Parse(txtDate.Text);
            if (string.IsNullOrEmpty(hfShowId.Value))
            {
                DBHelper.ExecuteNonQuery("INSERT INTO SHOW_TABLE (ShowId, ShowName, ShowDate, ShowType, ShowStatus) VALUES (SEQ_SHOW.NEXTVAL,:n,:d,:t,:s)",
                    new[] { new OracleParameter("n", txtName.Text.Trim()),
                            new OracleParameter("d", showDate),
                            new OracleParameter("t", ddlType.SelectedValue),
                            new OracleParameter("s", ddlStatus.SelectedValue) });
                ShowMsg("Show added.");
            }
            else
            {
                DBHelper.ExecuteNonQuery("UPDATE SHOW_TABLE SET ShowName=:n, ShowDate=:d, ShowType=:t, ShowStatus=:s WHERE ShowId=:id",
                    new[] { new OracleParameter("n", txtName.Text.Trim()),
                            new OracleParameter("d", showDate),
                            new OracleParameter("t", ddlType.SelectedValue),
                            new OracleParameter("s", ddlStatus.SelectedValue),
                            new OracleParameter("id", int.Parse(hfShowId.Value)) });
                ShowMsg("Show updated.");
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
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM SHOW_TABLE WHERE ShowId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfShowId.Value = id.ToString();
                txtName.Text = dt.Rows[0]["ShowName"].ToString();
                txtDate.Text = Convert.ToDateTime(dt.Rows[0]["ShowDate"]).ToString("yyyy-MM-dd");
                ddlType.SelectedValue = dt.Rows[0]["ShowType"].ToString();
                ddlStatus.SelectedValue = dt.Rows[0]["ShowStatus"].ToString();
                lblFormTitle.Text = "Edit Show";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                DBHelper.ExecuteNonQuery("DELETE FROM SHOW_TABLE WHERE ShowId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("Show deleted."); LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Cannot delete: " + ex.Message, true); }
        }
    }
}
