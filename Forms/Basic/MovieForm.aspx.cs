using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Basic_MovieForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) LoadGrid(); }

    void LoadGrid()
    {
        gvList.DataSource = DBHelper.ExecuteQuery("SELECT * FROM MOVIE ORDER BY MovieId");
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
        hfMovieId.Value = "";
        txtTitle.Text = txtDuration.Text = txtRelease.Text = "";
        ddlLang.SelectedIndex = 0;
        ddlGenre.SelectedIndex = 0;
        lblFormTitle.Text = "Add New Movie";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            int? dur = null;
            if (!string.IsNullOrEmpty(txtDuration.Text)) dur = int.Parse(txtDuration.Text);
            DateTime? rel = null;
            if (!string.IsNullOrEmpty(txtRelease.Text)) rel = DateTime.Parse(txtRelease.Text);

            if (string.IsNullOrEmpty(hfMovieId.Value))
            {
                string sql = "INSERT INTO MOVIE (MovieId, MovieTitle, Duration, Language, Genre, ReleaseDate) VALUES (SEQ_MOVIE.NEXTVAL,:t,:d,:l,:g,:r)";
                OracleParameter[] p = {
                    new OracleParameter("t", txtTitle.Text.Trim()),
                    new OracleParameter("d", dur.HasValue ? (object)dur.Value : DBNull.Value),
                    new OracleParameter("l", ddlLang.SelectedValue),
                    new OracleParameter("g", ddlGenre.SelectedValue),
                    new OracleParameter("r", rel.HasValue ? (object)rel.Value : DBNull.Value)
                };
                DBHelper.ExecuteNonQuery(sql, p);
                ShowMsg("Movie added.");
            }
            else
            {
                string sql = "UPDATE MOVIE SET MovieTitle=:t, Duration=:d, Language=:l, Genre=:g, ReleaseDate=:r WHERE MovieId=:id";
                OracleParameter[] p = {
                    new OracleParameter("t", txtTitle.Text.Trim()),
                    new OracleParameter("d", dur.HasValue ? (object)dur.Value : DBNull.Value),
                    new OracleParameter("l", ddlLang.SelectedValue),
                    new OracleParameter("g", ddlGenre.SelectedValue),
                    new OracleParameter("r", rel.HasValue ? (object)rel.Value : DBNull.Value),
                    new OracleParameter("id", int.Parse(hfMovieId.Value))
                };
                DBHelper.ExecuteNonQuery(sql, p);
                ShowMsg("Movie updated.");
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
            DataTable dt = DBHelper.ExecuteQuery("SELECT * FROM MOVIE WHERE MovieId=:id",
                new[] { new OracleParameter("id", id) });
            if (dt.Rows.Count > 0)
            {
                hfMovieId.Value = id.ToString();
                txtTitle.Text = dt.Rows[0]["MovieTitle"].ToString();
                txtDuration.Text = dt.Rows[0]["Duration"].ToString();
                if (dt.Rows[0]["ReleaseDate"] != DBNull.Value)
                    txtRelease.Text = Convert.ToDateTime(dt.Rows[0]["ReleaseDate"]).ToString("yyyy-MM-dd");
                ddlLang.SelectedValue = dt.Rows[0]["Language"].ToString();
                ddlGenre.SelectedValue = dt.Rows[0]["Genre"].ToString();
                lblFormTitle.Text = "Edit Movie";
            }
        }
        else if (e.CommandName == "DeleteRow")
        {
            try
            {
                // Delete Tickets linked to this movie
                DBHelper.ExecuteNonQuery("DELETE FROM TICKET WHERE TicketId IN (SELECT TicketId FROM TICKETSHOW WHERE MovieId=:id)", 
                    new[] { new OracleParameter("id", id) });
                
                // Delete from junction tables
                string[] junctionTables = { "TICKETSHOW", "MOVIEUSER", "THEATERMOVIEMAP", "HALLTHEATER", "SHOWHALL" };
                foreach (var table in junctionTables)
                {
                    DBHelper.ExecuteNonQuery($"DELETE FROM {table} WHERE MovieId=:id", 
                        new[] { new OracleParameter("id", id) });
                }

                // Finally delete movie
                DBHelper.ExecuteNonQuery("DELETE FROM MOVIE WHERE MovieId=:id",
                    new[] { new OracleParameter("id", id) });
                ShowMsg("Movie and all associated records deleted."); LoadGrid();
            }
            catch (Exception ex) { ShowMsg("Error deleting movie: " + ex.Message, true); }
        }
    }
}
