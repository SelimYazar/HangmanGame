<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="_152120191023_Selim_Can_Yazar_Hw3.Game" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Hangman Game</title>
    <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css" integrity="sha512-9xKTRVabjVeZmc+GUW8GgSmcREDunMM+Dt/GrzchfN8tkwHizc5RP4Ok/MXFFy5rIjJjzhndFScTceq5e6GvVQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script type="text/javascript">
        document.onkeydown = function (e) {
            e = e || window.event;
            var key = e.key || String.fromCharCode(e.keyCode);
            if (key) {
                // Eğer küçük 'i' ise, direkt 'İ' olarak ayarla, aksi halde toUpperCase kullan.
                if (key === 'i') {
                    key = 'İ';
                } else {
                    key = key.toUpperCase();
                }
                // Sadece A-Z ve Türkçe karakterleri (Ç,Ğ,İ,Ö,Ş,Ü) yakalayalım
                if (key.match(/^[A-ZÇĞİÖŞÜ]$/)) {
                    __doPostBack('<%= btnHidden.UniqueID %>', key);
                }
            }
        };

    </script>
    <script type="text/javascript">
        document.addEventListener('click', function (e) {
            // Hedef bir buton ya da input ise ve class içerisinde "btn" varsa
            var target = e.target;
            if (target && (target.tagName === 'BUTTON' || target.tagName === 'INPUT')) {
                if (target.className && target.className.indexOf("btn") !== -1) {
                    var audio = document.getElementById("audioClick");
                    if (audio) {
                        audio.currentTime = 0;
                        audio.play();
                    }
                }
            }
        });
    </script>

    <style>
        /* Resimlerin yan yana, küçük boyutlarda ve aralarında boşluk olacak şekilde düzenlenmesi */
        .hangmanImage {
            width: 150px;
            height: 150px;
            display: inline-block;
            margin: 2px;
            border-radius: 10%;
        }
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('images/bg2.png') no-repeat center center fixed;
            background-size: cover;
            opacity: 0.6;
            z-index: -1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- ASP.NET Ajax için ScriptManager -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <!-- Timer kontrolü -->
        <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
        
        
        <!-- Aşağıdaki UpdatePanel eklendi, hiçbir mevcut kod silinmedi -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<!-- Gizli buton: Klavye girişleri için -->
        <asp:Button ID="btnHidden" runat="server" Style="display:none" OnClick="btnHidden_Click" />
                <div class="container text-center mt-4">
                    <!-- Oyuna Başla Butonu -->
                    <asp:Button ID="btnStart" runat="server" Text="Oyuna Başla" OnClick="btnStart_Click" CssClass="text-white btn btn-warning btn-lg mb-3" />
                     <!-- Girişe Dön Butonu -->
                <button id="btnBack" runat="server" onserverclick="btnBack_Click" class="btn btn-danger btn-lg text-white mb-3">
                    <i class="fa-solid fa-arrow-rotate-left"></i> Girişe Dön
                </button>                    <br />
                    <!-- Zaman Göstergesi -->
                    <asp:Label ID="lblTimer" runat="server" Text="30" Font-Bold="true" Font-Size="Large" CssClass="bg-danger text-warning d-inline-block p-2 mt-3 mb-3 rounded-pill"></asp:Label> 
                    <br />
                    <!-- Skor Göstergesi -->
                    <asp:Label ID="lblScore" runat="server" Text="Skor: 0" Font-Bold="true" Font-Size="Large" CssClass="bg-info text-white d-inline-block p-2 mt-3 mb-3 rounded"></asp:Label>
                    <br />
                    <!-- Soru Gösterimi -->
                    <asp:Label ID="lblQuestion" runat="server" Font-Bold="true" Font-Size="Large" CssClass="bg-warning text-white d-inline-block p-2 mt-3 mb-3 rounded"></asp:Label>
                    <br />
                    <!-- Kelimenin Alt Çizgilerle Gösterimi -->
                    <asp:Label ID="lblWord" runat="server" Font-Bold="true" Font-Size="Large" CssClass="d-block mb-3"></asp:Label>
                    
                    <!-- Mesaj / Uyarılar -->
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" CssClass="bg-info text-white d-inline-block p-2 mt-2 mb-3 rounded"></asp:Label>
                    <br />
                    <!-- Sanal Klavye: Klavye butonları orijinal haliyle korunuyor, bootstrap stilleri eklenmiştir -->
                    <div class="mb-3">
                        <asp:Button ID="btnA" runat="server" Text="A" OnClick="Letter_Click" CommandArgument="A" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnB" runat="server" Text="B" OnClick="Letter_Click" CommandArgument="B" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnC" runat="server" Text="C" OnClick="Letter_Click" CommandArgument="C" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnÇ" runat="server" Text="Ç" OnClick="Letter_Click" CommandArgument="Ç" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnD" runat="server" Text="D" OnClick="Letter_Click" CommandArgument="D" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnE" runat="server" Text="E" OnClick="Letter_Click" CommandArgument="E" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnF" runat="server" Text="F" OnClick="Letter_Click" CommandArgument="F" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnG" runat="server" Text="G" OnClick="Letter_Click" CommandArgument="G" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnĞ" runat="server" Text="Ğ" OnClick="Letter_Click" CommandArgument="Ğ" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnH" runat="server" Text="H" OnClick="Letter_Click" CommandArgument="H" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnI" runat="server" Text="I" OnClick="Letter_Click" CommandArgument="I" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="Button1" runat="server" Text="İ" OnClick="Letter_Click" CommandArgument="İ" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnJ" runat="server" Text="J" OnClick="Letter_Click" CommandArgument="J" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnK" runat="server" Text="K" OnClick="Letter_Click" CommandArgument="K" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnL" runat="server" Text="L" OnClick="Letter_Click" CommandArgument="L" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnM" runat="server" Text="M" OnClick="Letter_Click" CommandArgument="M" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnN" runat="server" Text="N" OnClick="Letter_Click" CommandArgument="N" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnO" runat="server" Text="O" OnClick="Letter_Click" CommandArgument="O" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnÖ" runat="server" Text="Ö" OnClick="Letter_Click" CommandArgument="Ö" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnP" runat="server" Text="P" OnClick="Letter_Click" CommandArgument="P" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnR" runat="server" Text="R" OnClick="Letter_Click" CommandArgument="R" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnS" runat="server" Text="S" OnClick="Letter_Click" CommandArgument="S" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnŞ" runat="server" Text="Ş" OnClick="Letter_Click" CommandArgument="Ş" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnT" runat="server" Text="T" OnClick="Letter_Click" CommandArgument="T" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnU" runat="server" Text="U" OnClick="Letter_Click" CommandArgument="U" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnÜ" runat="server" Text="Ü" OnClick="Letter_Click" CommandArgument="Ü" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnV" runat="server" Text="V" OnClick="Letter_Click" CommandArgument="V" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnY" runat="server" Text="Y" OnClick="Letter_Click" CommandArgument="Y" CssClass="btn btn-primary btn-lg m-1" />
                        <asp:Button ID="btnZ" runat="server" Text="Z" OnClick="Letter_Click" CommandArgument="Z" CssClass="btn btn-primary btn-lg m-1" />
                    </div>
                    
                    <!-- Hangman/Balon Resimleri: imgPart0 başlangıçta görünür, diğerleri hatalı tahminle ortaya çıkacak -->
                    <div class="text-center">
                        <asp:Image ID="imgPart0" runat="server" ImageUrl="~/images/part0.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart1" runat="server" ImageUrl="~/images/part1.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart2" runat="server" ImageUrl="~/images/part2.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart3" runat="server" ImageUrl="~/images/part3.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart4" runat="server" ImageUrl="~/images/part4.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart5" runat="server" ImageUrl="~/images/part5.png" Visible="false" CssClass="hangmanImage" />
                        <asp:Image ID="imgPart6" runat="server" ImageUrl="~/images/part6.png" Visible="false" CssClass="hangmanImage" />
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
            </Triggers>
        </asp:UpdatePanel>
        <audio id="audioClick" src="Sounds/Click.wav" preload="auto"></audio>
        <audio id="audioGameOver" src="Sounds/GameOver.wav" preload="auto"></audio>
        <audio id="audioGameWin" src="Sounds/GameWin.wav" preload="auto"></audio>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    </form>
</body>
</html>
