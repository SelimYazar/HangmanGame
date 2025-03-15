using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _152120191023_Selim_Can_Yazar_Hw3
{
    public partial class Game : System.Web.UI.Page
    {
        private int defaultTime = 30; // Her tur için 30 saniye
        private int maxWrong = 6;     // Maksimum 6 yanlış tahmin

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Timer1.Enabled = false;
                ViewState["TimeLeft"] = defaultTime;
                ViewState["WrongCount"] = 0;
                ViewState["Score"] = 0;
                lblTimer.Text = defaultTime.ToString();
                lblScore.Text = "Skor: 0";
            }
        }

        protected void btnStart_Click(object sender, EventArgs e)
        {
            ResetGame();
            LoadRandomWord();
            Timer1.Enabled = true;
        }

        // Oyun başladığında resimlerin resetlenmesi: imgPart0 görünür, diğerleri gizli.
        private void ResetGame()
        {
            imgPart0.Visible = true;
            imgPart1.Visible = false;
            imgPart2.Visible = false;
            imgPart3.Visible = false;
            imgPart4.Visible = false;
            imgPart5.Visible = false;
            imgPart6.Visible = false;

            ViewState["TimeLeft"] = defaultTime;
            lblTimer.Text = defaultTime.ToString();
            ViewState["WrongCount"] = 0;
            ViewState["Score"] = 0;
            lblScore.Text = "Skor: 0";

            lblMessage.Text = "";
            lblQuestion.Text = "";
            lblWord.Text = "";
            EnableAllLetterButtons(form1);
        }

        private void LoadRandomWord()
        {
            string connStr = ConfigurationManager.ConnectionStrings["HangmanDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 1 * FROM Words ORDER BY NEWID()";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string word = dr["Word"].ToString().Trim();
                    string question = dr["Question"].ToString().Trim();

                    lblQuestion.Text = question;
                    ViewState["CurrentWord"] = word;

                    // Kelimeyi alt çizgilerle göster
                    string displayed = "";
                    foreach (char c in word)
                    {
                        displayed += (c == ' ') ? " " : "_";
                    }
                    lblWord.Text = displayed;
                    ViewState["DisplayedWord"] = displayed;
                }
                dr.Close();
            }
            // Her yeni kelime yüklendiğinde süreyi 30 saniyeye sıfırla:
            ViewState["TimeLeft"] = defaultTime;
            lblTimer.Text = defaultTime.ToString();
            // Yeni soruya geçince resimlerin resetlenmesi:
            imgPart0.Visible = true;
            imgPart1.Visible = false;
            imgPart2.Visible = false;
            imgPart3.Visible = false;
            imgPart4.Visible = false;
            imgPart5.Visible = false;
            imgPart6.Visible = false;
        }

        protected void Letter_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string letter = btn.CommandArgument;
            btn.Enabled = false;
            ProcessLetter(letter);
        }

        // Gizli butonun tıklama olayı: klavyeden gelen harfleri işler.
        protected void btnHidden_Click(object sender, EventArgs e)
        {
            string letter = Request["__EVENTARGUMENT"];
            if (!string.IsNullOrEmpty(letter))
            {
                ProcessLetter(letter);
            }
        }

        private void ProcessLetter(string letter)
        {
            // Klavye butonları varsa ilgili butonu devre dışı bırak.
            Button btn = (Button)FindControl("btn" + letter);
            if (btn != null)
                btn.Enabled = false;

            if (ViewState["CurrentWord"] == null) return;

            string currentWord = ViewState["CurrentWord"].ToString();
            string displayed = ViewState["DisplayedWord"].ToString();

            letter = letter.ToLower();
            currentWord = currentWord.ToLower();

            bool found = false;
            char[] displayedArray = displayed.ToCharArray();
            char[] wordArray = ViewState["CurrentWord"].ToString().ToCharArray();

            for (int i = 0; i < currentWord.Length; i++)
            {
                if (currentWord[i] == letter[0])
                {
                    displayedArray[i] = wordArray[i];
                    found = true;
                }
            }

            if (found)
            {
                lblMessage.Text = "Doğru tahmin!";
                displayed = new string(displayedArray);
                lblWord.Text = displayed;
                ViewState["DisplayedWord"] = displayed;

                if (!displayed.Contains("_"))
                {
                    int score = Convert.ToInt32(ViewState["Score"]);
                    score++;
                    ViewState["Score"] = score;
                    lblScore.Text = "Skor: " + score;
                    lblMessage.Text = "Tebrikler, kazandınız! Yeni kelime geliyor...";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "playGameWin", "document.getElementById('audioGameWin').play();", true);
                    StartNewRound();
                }
            }
            else
            {
                lblMessage.Text = "Yanlış tahmin!";
                int wrongCount = (int)ViewState["WrongCount"] + 1;
                ViewState["WrongCount"] = wrongCount;

                ShowHangmanPart(wrongCount);

                if (wrongCount >= maxWrong)
                {
                    lblMessage.Text = "Kaybettiniz! Kelime: " + ViewState["CurrentWord"];
                    Timer1.Enabled = false;
                    DisableAllLetterButtons(form1);
                    // GameOver sesini çal
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "playGameOver", "document.getElementById('audioGameOver').play();", true);
                }
            }
        }

        private void ShowHangmanPart(int wrongCount)
        {
            // Sadece yanlış tahminlerde imgPart1'den imgPart6'ya kadar görünür olacak.
            switch (wrongCount)
            {
                case 1: imgPart1.Visible = true; break;
                case 2: imgPart2.Visible = true; break;
                case 3: imgPart3.Visible = true; break;
                case 4: imgPart4.Visible = true; break;
                case 5: imgPart5.Visible = true; break;
                case 6: imgPart6.Visible = true; break;
            }
        }

        private void DisableAllLetterButtons(Control parent)
        {
            foreach (Control ctrl in parent.Controls)
            {
                if (ctrl is Button btn && btn.ID != "btnStart" && btn.ID != "btnHidden" && btn.ID != "btnBack")
                {
                    btn.Enabled = false;
                }
                if (ctrl.HasControls())
                {
                    DisableAllLetterButtons(ctrl);
                }
            }
        }

        private void EnableAllLetterButtons(Control parent)
        {
            foreach (Control ctrl in parent.Controls)
            {
                if (ctrl is Button btn && btn.ID != "btnStart" && btn.ID != "btnHidden" && btn.ID != "btnBack")
                {
                    btn.Enabled = true;
                }
                if (ctrl.HasControls())
                {
                    EnableAllLetterButtons(ctrl);
                }
            }
        }

        // Yeni tur: Yanlış sayısı sıfırlanır, klavye butonları aktif edilir ve yeni kelime yüklenir.
        private void StartNewRound()
        {
            ViewState["WrongCount"] = 0;
            lblMessage.Text = "";
            EnableAllLetterButtons(form1);
            LoadRandomWord();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            int timeLeft = Convert.ToInt32(ViewState["TimeLeft"]);
            timeLeft--;
            ViewState["TimeLeft"] = timeLeft;
            lblTimer.Text = timeLeft.ToString();

            if (timeLeft <= 0)
            {
                Timer1.Enabled = false;
                lblMessage.Text = "Süre doldu! Kaybettiniz. Kelime: " + ViewState["CurrentWord"];
                DisableAllLetterButtons(form1);
                // GameOver sesini çal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "playGameOver", "document.getElementById('audioGameOver').play();", true);
            }
        }

        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {
            string[] validKeys = new string[] { "A", "B", "C", "Ç", "D", "E", "F", "G", "Ğ", "H", "I", "İ", "J", "K", "L", "M", "N", "O", "Ö", "P", "R", "S", "Ş", "T", "U", "Ü", "V", "Y", "Z" };
            foreach (string key in validKeys)
            {
                ClientScript.RegisterForEventValidation(btnHidden.UniqueID, key);
            }
            base.Render(writer);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Giris.aspx");
        }
    }
}
