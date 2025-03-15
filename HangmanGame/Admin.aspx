<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="_152120191023_Selim_Can_Yazar_Hw3.Admin" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Panel - Kelime Yönetimi</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css" integrity="sha512-9xKTRVabjVeZmc+GUW8GgSmcREDunMM+Dt/GrzchfN8tkwHizc5RP4Ok/MXFFy5rIjJjzhndFScTceq5e6GvVQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
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
        .table td, .table th {
            padding: 12px !important;
        }
        input[type="text"] {
            padding: 10px !important;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
    </style>
    <script type="text/javascript">
    document.addEventListener('click', function(e) {
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
          <div class="container text-center mt-4">  
            <div style="margin:20px;">
                <h2 class="bg-warning p-2 text-white d-inline-block rounded">Kelime Yönetimi</h2>
                <br />
                <asp:Label ID="lblInfo" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                <br /><br />
                <!-- GridView panel: Card içerisinde, yüksekliği 60vh, scroll eklenmiş -->
                <div class="card mb-3 bg-transparent">
                    <div class="card-body" style="height: 60vh; overflow-y: auto;">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                            OnRowCommand="GridView1_RowCommand" CssClass="table table-bordered text-center mx-auto">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                                <asp:BoundField DataField="Word" HeaderText="Kelime" />
                                <asp:BoundField DataField="Question" HeaderText="Soru" />
                                <asp:TemplateField HeaderText="Sil">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" Text="Sil" 
                                            CssClass="btn btn-danger" CommandName="DeleteWord" 
                                            CommandArgument='<%# Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <br /><br />
                <!-- Yeni Kelime Ekleme Alanları -->
                <asp:TextBox ID="txtNewWord" runat="server" Width="250" placeholder="Yeni Cevap"></asp:TextBox>
                <asp:TextBox ID="txtNewQuestion" runat="server" Width="350" placeholder="Yeni Soru"></asp:TextBox>
                <asp:Button ID="btnAdd" runat="server" Text="Ekle" OnClick="btnAdd_Click" 
                    CssClass="btn btn-info btn-lg text-white"/>
                <%--<asp:Button ID="btnBack" runat="server" Text="Girişe Dön" OnClick="btnBack_Click" 
                    CssClass="btn btn-danger btn-lg text-white"/>--%>
                <button id="btnBack" runat="server" onserverclick="btnBack_Click" class="btn btn-danger btn-lg text-white">
                     <i class="fa-solid fa-arrow-rotate-left"></i> Girişe Dön
                </button>

            </div>
          
        </div>
                  <audio id="audioClick" src="Sounds/Click.wav" preload="auto"></audio>

    </form>
</body>
</html>
