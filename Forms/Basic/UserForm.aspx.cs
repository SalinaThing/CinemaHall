using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_UserForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) LoadGrid();
    }

    void LoadGrid()
    {
        gvUsers.DataSource = DBHelper.ExecuteQuery("SELECT UserId, Username, UserEmail, Address FROM USERS ORDER BY UserId");
        gvUsers.DataBind();
    }

    void ShowMsg(string msg, bool isError = false)
    {
        lblMsg.Text = msg;
        lblMsg.CssClass = isError ? "alert alert-danger d-block mb-3" : "alert alert-success d-block mb-3";
        lblMsg.Visible = true;
    }

    void ClearForm()
    {
        hfUserId.Value = "";
        txtUsername.Text = txtEmail.Text = txtPassword.Text = txtAddress.Text = "";
        lblFormTitle.Text = "Add New User";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(hfUserId.Value))
            {
                string sql = "INSERT INTO USERS (UserId, Username, UserEmail, Password, Address) VALUES (SEQ_USER.NEXTVAL,:u,:e,:p,:a)";
                OracleParameter[] p = {
                    new OracleParameter("u", txtUsername.Text.Trim()),
                    new OracleParameter("e", txtEmail.Text.Trim()),
                    new OracleParameter("p", txtPassword.Text.Trim()),
                    new OracleParameter("a", txtAddress.Text.Trim())
                };
                DBHelper.ExecuteNonQuery(sql, p);
                ShowMsg("User added successfully.");
            }
            else
            {
                string sql = "UPDATE USERS SET Username=:u, UserEmail=:e, Password=:p, Address=:a WHERE UserId=:id";
                OracleParameter[] p = {
                    new OracleParameter("u", txtUsername.Text.Trim()),
                    new OracleParameter("e", txtEmail.Text.Trim()),
                    new OracleParameter("p", txtPassword.Text.Trim()),
                    new OracleParameter("a", txtAddress.Text.Trim()),
                    new OracleParameter("id", int.Parse(hfUserId.Value))
                };
                DBHelper.ExecuteNonQuery(sql, p);
                ShowMsg("User updated successfully.");
            }
            ClearForm();
            LoadGrid();
        }
        catch (Exception ex) { ShowMsg("Error: " + ex.Message, true); }
    }

    protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

    protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = int.Parse(e.CommandArgument.ToString());
        if (e.CommandName == "EditRow")
        {
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM USERS WHERE UserId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfUserId.Value = id.ToString();
                txtUsername.Text = dt.Rows[0]["Username"].ToString();
                txtEmail.Text = dt.Rows[0]["UserEmail"].ToString();
                txtPassword.Text = dt.Rows[0]["Password"].ToString();
                txtAddress.Text = dt.Rows[0]["Address"].ToString();
                lblFormTitle.Text = "Edit User";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                DBHelper.ExecuteNonQuery("DELETE FROM USERS WHERE UserId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("User deleted.");
                LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Cannot delete (has related records): " + ex.Message, true); }
        }
    }
}
