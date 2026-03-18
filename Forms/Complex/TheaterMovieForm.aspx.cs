using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

public partial class Forms_Complex_TheaterMovieForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt = DBHelper.ExecuteQuery(
                "SELECT TheaterId, TheaterName || ' - ' || TheaterCity AS DisplayName FROM THEATER ORDER BY TheaterName");
            lbTheater.DataSource = dt;
            lbTheater.DataTextField = "DisplayName";
            lbTheater.DataValueField = "TheaterId";
            lbTheater.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lbTheater.SelectedItem == null)
        {
            lblMsg.Text = "Please select a theater.";
            lblMsg.Visible = true;
            return;
        }
        lblMsg.Visible = false;

        int theaterId = int.Parse(lbTheater.SelectedValue);

        DataTable dtT = DBHelper.ExecuteQuery("SELECT * FROM THEATER WHERE TheaterId=:id",
            new[] { new OracleParameter("id", theaterId) });
        if (dtT.Rows.Count > 0)
        {
            lblTName.Text = dtT.Rows[0]["TheaterName"].ToString();
            lblTCity.Text = dtT.Rows[0]["TheaterCity"].ToString();
            lblTType.Text = dtT.Rows[0]["TheatreType"].ToString();
            pnlTheater.Visible = true;
        }

        string sql = @"SELECT DISTINCT m.MovieTitle, m.Genre, m.Language, m.Duration, m.ReleaseDate,
                              h.HallType, h.HallCapacity,
                              s.ShowName, s.ShowDate, s.ShowType, s.ShowStatus
                       FROM MOVIE m
                       JOIN TICKETSHOW ts ON m.MovieId = ts.MovieId
                       JOIN THEATER th ON ts.TheaterId = th.TheaterId
                       JOIN HALL h ON ts.HallId = h.HallId
                       JOIN SHOW_TABLE s ON ts.ShowId = s.ShowId
                       WHERE th.TheaterId = :tid
                       ORDER BY s.ShowDate DESC, m.MovieTitle";

        DataTable dtMovies = DBHelper.ExecuteQuery(sql,
            new[] { new OracleParameter("tid", theaterId) });
        gvMovies.DataSource = dtMovies;
        gvMovies.DataBind();
        pnlMovies.Visible = true;
    }
}
