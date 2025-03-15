using System;
using System.Web.UI;

namespace _152120191023_Selim_Can_Yazar_Hw3
{
    public partial class Giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Herhangi bir ek işlem gerekmez.
        }

        protected void btnGame_Click(object sender, EventArgs e)
        {
            // "Oyuna Başla" butonuna tıklanınca Game.aspx'e yönlendir.
            Response.Redirect("Game.aspx");
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            // "Kelime Ekle/Sil" butonuna tıklanınca Admin.aspx'e yönlendir.
            Response.Redirect("Admin.aspx");
        }
    }
}
