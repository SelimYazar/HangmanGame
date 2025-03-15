<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Giris.aspx.cs" Inherits="_152120191023_Selim_Can_Yazar_Hw3.Giris" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Giriş Sayfası</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <style>
    
        body::before {
           content: "";
           position: fixed;
           top: 0;
           left: 0;
           right: 0;
           bottom: 0;
           background: url('images/bg1.png') no-repeat center center fixed;
           background-size: cover;
           z-index: -1;
        }
    </style>
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
</head>
<body>
      
    <form id="form1" runat="server">
      <div class="container mt-5 text-center">
          <h1 class="text-warning fw-bold fst-italic ">Hangman Oyununa Hoşgeldiniz</h1>
               
          <asp:Button ID="btnGame" runat="server" CssClass="btn btn-warning btn-lg text-white" Text="Oyuna Başla" OnClick="btnGame_Click" />
          <br /><br />
          <asp:Button ID="btnAdmin" runat="server" CssClass="btn btn-danger btn-lg" Text="Kelime Ekle/Sil" OnClick="btnAdmin_Click" />
      </div>
          <audio id="audioClick" src="Sounds/Click.wav" preload="auto"></audio>

    </form>
</body>
</html>
