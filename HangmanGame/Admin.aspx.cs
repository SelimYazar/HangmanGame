using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace _152120191023_Selim_Can_Yazar_Hw3
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWords();
            }
        }

        private void LoadWords()
        {
            string connStr = ConfigurationManager.ConnectionStrings["HangmanDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ID, Word, Question FROM Words ORDER BY ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string newWord = txtNewWord.Text.Trim();
            string newQuestion = txtNewQuestion.Text.Trim();

            if (string.IsNullOrEmpty(newWord) || string.IsNullOrEmpty(newQuestion))
            {
                lblInfo.Text = "Kelime ve Soru alanları boş bırakılamaz.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["HangmanDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string insertQuery = "INSERT INTO Words (Word, Question) VALUES (@w, @q)";
                SqlCommand cmd = new SqlCommand(insertQuery, conn);
                cmd.Parameters.AddWithValue("@w", newWord);
                cmd.Parameters.AddWithValue("@q", newQuestion);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblInfo.Text = "Kelime eklendi.";
            txtNewWord.Text = "";
            txtNewQuestion.Text = "";
            LoadWords();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteWord")
            {
                int id = Convert.ToInt32(e.CommandArgument);


                string connStr = ConfigurationManager.ConnectionStrings["HangmanDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string deleteQuery = "DELETE FROM Words WHERE ID = @id";
                    SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblInfo.Text = "Kelime silindi.";
                LoadWords();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Giris.aspx");
        }
    }
}
