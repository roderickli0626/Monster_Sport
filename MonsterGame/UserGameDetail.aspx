<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="UserGameDetail.aspx.cs" Inherits="MonsterGame.UserGameDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <style>
        .id-mark {
            position: absolute;
            width: 30px;
            height: 30px;
            background-color: darkgreen;
            color: white;
            border-radius: 50%;
            text-align: center;
            line-height: 30px;
            font-size: 15px;
        }
        .id-complete-mark {
            position: absolute;
            color: darkgreen;
            text-align: center;
            line-height: 30px;
            font-size: 15px;
            width: 90%;
        }
        .font-complete-mark {
            color: greenyellow;
            text-align: center;
        }

        .box {
            position: relative;
            background: #eeee;
            float: left;
        }

        .ribbon {
            position: absolute;
            right: -5px;
            top: -5px;
            z-index: 1;
            overflow: hidden;
            width: 93px;
            height: 93px;
            text-align: right;
        }

            .ribbon span {
                font-size: 0.8rem;
                color: #fff;
                text-transform: uppercase;
                text-align: center;
                font-weight: bold;
                line-height: 32px;
                transform: rotate(45deg);
                width: 125px;
                display: block;
                background: #79a70a;
                background: linear-gradient(#9bc90d 0%, #79a70a 100%);
                box-shadow: 0 3px 10px -5px rgba(0, 0, 0, 1);
                position: absolute;
                top: 17px;
            }

                .ribbon span::before {
                    content: '';
                    position: absolute;
                    left: 0px;
                    top: 100%;
                    z-index: -1;
                    border-left: 3px solid #79A70A;
                    border-right: 3px solid transparent;
                    border-bottom: 3px solid transparent;
                    border-top: 3px solid #79A70A;
                }

                .ribbon span::after {
                    content: '';
                    position: absolute;
                    right: 0%;
                    top: 100%;
                    z-index: -1;
                    border-right: 3px solid #79A70A;
                    border-left: 3px solid transparent;
                    border-bottom: 3px solid transparent;
                    border-top: 3px solid #79A70A;
                }

        .red span {
            background: linear-gradient(#f70505 0%, #8f0808 100%);
        }

            .red span::before {
                border-left-color: #8f0808;
                border-top-color: #8f0808;
            }

            .red span::after {
                border-right-color: #8f0808;
                border-top-color: #8f0808;
            }

        .blue span {
            background: linear-gradient(#2989d8 0%, #1e5799 100%);
        }

            .blue span::before {
                border-left-color: #1e5799;
                border-top-color: #1e5799;
            }

            .blue span::after {
                border-right-color: #1e5799;
                border-top-color: #1e5799;
            }

        .orange span {
            background: linear-gradient(#f2c307 0%, #FFA500 100%);
        }

            .orange span::before {
                border-left-color: #FFA500;
                border-top-color: #FFA500;
            }

            .orange span::after {
                border-right-color: #FFA500;
                border-top-color: #FFA500;
            }

        .foo {
            clear: both;
        }

        .bar {
            content: "";
            left: 0px;
            top: 100%;
            z-index: -1;
            border-left: 3px solid #79a70a;
            border-right: 3px solid transparent;
            border-bottom: 3px solid transparent;
            border-top: 3px solid #79a70a;
        }

        .baz {
            font-size: 1rem;
            color: #fff;
            text-transform: uppercase;
            text-align: center;
            font-weight: bold;
            line-height: 2em;
            transform: rotate(45deg);
            width: 100px;
            display: block;
            background: #79a70a;
            background: linear-gradient(#9bc90d 0%, #79a70a 100%);
            box-shadow: 0 3px 10px -5px rgba(0, 0, 0, 1);
            position: absolute;
            top: 100px;
            left: 1000px;
        }

        .my-card {
            background-color: greenyellow;
        }

        .my-card-0 {
            background-color: red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium3.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 runat="server" id="GameTitle" class="title text-white">Dettagli del Torneo</h2>
                    <ul runat="server" id="SubTitle" class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="UserGame.aspx">Tornei</a></li>
                        <li>Dettagli del Torneo</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfUserID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfBalance" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameStatus" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfFee" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfCurrentRound" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfWinnerID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfHaveTicket" runat="server" ClientIDMode="Static" />
                <div class="row">
                    <div class="col-12 col-md-3">
                        <ul class="privacy-policy-sidebar-menu" style="padding-top:120px;">
                            <li runat="server" id="liMyTicket" style="padding-left:30px;">
                                <a href="#myTickets" class="nav-link">I MIEI TICKETS</a>
                            </li>
                            <li style="padding-left:30px;">
                                <a href="#tickets" class="nav-link">TUTTI I TICKETS DEL TORNEO</a>
                            </li>
                            <li style="padding-left:30px;">
                                <a href="#results" class="nav-link">RISULTATI</a>
                            </li>
                            <li runat="server" id="liWinner" style="padding-left:30px;">
                                <a href="#winners" class="nav-link">VINCENTI</a>
                            </li>
                            <li runat="server" id="liGame" style="padding-left:30px;">
                                <a href="#games" class="nav-link">I MIEI TORNEI</a>
                            </li>
                            <li style="padding-top: 30px;">
                                <img src="Upload/Game/default.jpg" id="GameImage" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail GameImage" style="height: auto; width: 100%;" />
                            </li>
                            <li style="padding-top: 30px; font-size: 20px;">
                                <pre runat="server" id="GameNote"></pre>
                            </li>
                        </ul>
                    </div>
                    <div class="col-12 col-md-9">
                        <div class="privacy-policy-content">
                            <div runat="server" id="DivMyTicket" class="content-item mb-0">
                                <h3 class="title" id="myTickets" style="padding-top:120px;">I MIEI TICKETS DI QUESTO TORNEO</h3>
                                <div class="row justify-content-center pt-5">


                            <table>
                            <thead>

                                <tr><th><p style="padding-left:15px; font-size: 14px; color:orange;"><b><u>PER INIZIARE:</u></b></p></th></tr>
                                <tr><th style="padding-left:15px; font-size: 14px; color:orange;">- Acquista un nuovo Ticket</th></tr>                                 
                                <tr><th style="padding-left:15px; font-size: 14px; color:orange;">- Vai su <span class="fa fa-edit" style="font-size:18px; color:greenyellow;"> </span> e scegli la squadra</th></tr>
                                <tr><th style="padding-left:15px; font-size: 14px; color:orange;">- Attendi l' esito dell' incontro</th></tr>
                                
                            </thead>                        
                            </table>




                                    <div class="col-lg-4 col-xl-4 ms-auto">
                                         <asp:Button runat="server" ID="BtnTicket" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="NUOVO TICKET"></asp:Button>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="myTicket-table">
                                    </table>
                                </div>
                            </div>
                            <div class="content-item mb-0">
                                <h3 class="title" runat="server" id="tickets" clientIDMode="static" style="padding-top:120px;">TUTTI I TICKETS DEL TORNEO</h3>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="ticket-table">
                                    </table>
                                </div>
                            </div>
                            <div class="content-item mb-0">
                                <h3 class="title" id="results" style="padding-top:120px;">RISULTATI DI QUESTO TORNEO</h3>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="result-table">
                                    </table>
                                </div>
                            </div>
                            <div runat="server" id="DivWinners" class="content-item mb-0">
                                <h3 class="title" id="winners" style="padding-top: 120px;">VINCENTI DI QUESTO TORNEO</h3>
                                <div class="row justify-content-center pb-3">
                                    <div class="col-lg-8 col-xl-8 col-md-8 col-sm-8">
                                        <div class="dashboard__card" style="border: 2px solid #ffdd2d;">
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="Prize" class="price">€ 0</h2>
                                                <p class="info">PREMIO</p>
                                            </div>
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="DividDate" class="price"></h2>
                                            </div>
                                            <div class="dashboard__card-icon">
                                                <i class="las la-wallet"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="winner-table">
                                        <thead>
                                            <tr>
                                                <th>Nr.</th>
                                                <th>Vincente</th>
                                                <th>Premio</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div runat="server" id="DivGameContent" class="content-item mb-0">
                                <h3 class="title" id="games" style="padding-top: 120px;">I MIEI TORNEI</h3>
                                <div class="row gy-4 justify-content-center">
                                    <asp:Repeater runat="server" ID="RepeaterGame">
                                        <ItemTemplate>
                                            <div class="col-lg-4 col-xl-4 col-md-6 col-sm-6 position-relative">
                                                <div class="game-item">
                                                    <div class="game-inner">
                                                        <div class="game-item__thumb">
                                                            <%# Eval("Mark") %>
                                                            <img class="GameImage" src="Upload/Game/<%# (Eval("Image1") == "" || Eval("Image1") == null) ? "default.jpg" : Eval("Image1") %>" alt="game">
                                                        </div>
                                                        <div class="game-item__content">
                                                            <h4 class="title"><%# Eval("Title") %></h4>
                                                            <div class="<%# ((int)Eval("Status") == 5 || (int)Eval("Status") == 6) ? "d-none" : "" %>">
                                                                <p class="invest-info" title="Quota di partecipazione">Quota ingresso: <span class="invest-amount">€ <%# Eval("Fee") %></span></p>
                                                                <p class="invest-info" title="Player necessari all'inizio del Torneo">Player necessari: <span class="invest-amount"><%# Eval("MinPlayers") %></span></p>
                                                                <p class="invest-info" title="Player già registrati al Torneo">Player attuali: <span class="invest-amount"><%# Eval("RealPlayers") %> (<%# Eval("RemainedPlayers") %>)</span></p>                                                
                                                                <p class="invest-info" title="Numero di squadre da cui poter scegliere" style="color: orange;">Numero squadre: <span class="invest-amount TeamShow" style="cursor: pointer;" data-id="<%# Eval("Id") %>" data-img="<%# Eval("Image2") %>"><%# Eval("NumberOfTeams") %></span> *</p>
                                                                <p class="invest-info" title="Montepremi min. lo stesso viene adeguato in base ai ticket venduti">Premio min.: <span class="invest-amount">€ <%# Eval("Prize") %></span></p>
                                                                <p class="invest-info" title="Num. di Vincitori di questo Torneo">Vincenti: <span class="invest-amount"><%# Eval("Winners") %></span></p>
                                                            </div>
                                                            <div style="height: 183.6px;" class="<%# ((int)Eval("Status") == 5 || (int)Eval("Status") == 6) ? "" : "d-none" %> d-flex align-items-center ps-2">
                                                                <%# Eval("CompletedInfo") %>
                                                            </div>
                                                            <a class="cmn--btn active btn--md radius-1" href="UserGameDetail.aspx?gameId=<%# Eval("Id") %>"><%# Eval("ButtonTitle") %></a>
                                                        </div>
                                                    </div>
                                                    <div class="ball <%# Eval("MyMark") %>"></div>
                                                </div>
                                                <span class="id-mark top-0 mt-2 start-0 ms-4" style="z-index:2;"><%# Eval("Id") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="TeamChangeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle">Scegli la Squadra</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:DropDownList runat="server" ID="ComboTeams" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnChangeTeam" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnChangeTeam" CssClass="btn btn--warning btn--md" Text="Conferma" CausesValidation="false" OnClick="BtnChangeTeam_Click"/>
                                <button runat="server" id="btnClose" clientIDMode="static" class="btn btn--danger btn--md">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="NewTicketModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle1">Nuovo Ticket</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>   
                                        <asp:ValidationSummary ID="ValSummary1" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator0" runat="server" ErrorMessage="Inserisci quanti ticket comprare." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtBalance" class="form-label">Saldo</label>
                                                <asp:TextBox runat="server" ID="TxtBalance" ClientIDMode="Static" CssClass="form-control form--control style-two" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtNumOfTickets" class="form-label">Numero di Tickets</label>
                                                <asp:TextBox runat="server" ID="TxtNumOfTickets" ClientIDMode="Static" CssClass="form-control form--control style-two" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnNewTicket" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnNewTicket" CssClass="btn btn--warning btn--md" Text="Conferma" CausesValidation="false" OnClick="BtnNewTicket_Click"/>
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class=" modal custom--modal fade show" id="MessageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark">MESSAGGIO DALL'ADMIN</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <div class="row gy-3">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="TxtMessage" class="form-label">Messaggio</label>
                                            <asp:TextBox runat="server" ID="TxtMessage" ClientIDMode="Static" CssClass="form-control form--control style-two" TextMode="MultiLine" Rows="2" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer modal--footer">
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class=" modal custom--modal fade show" id="gameTeamsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark">TEAMS</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <div class="d-flex">
                                    <div class="col-md-4">
                                        <h5 class="p-5 teamNames" style="white-space:nowrap;"><br></h5>
                                    </div>
                                    <div class="col-md-8 text-center d-flex justify-content-center" style="padding-right: 30px;">
                                        <img src="Upload/Game/default.jpg" id="TeamImage" runat="server" clientidmode="Static" alt="service-image" class="m-3 mt-auto mb-auto img-thumbnail GameImage" style="max-width: 100%;" />
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer modal--footer">
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
    <script src="Scripts/JS/jquery.dataTables.js"></script>
    <script src="Scripts/JS/datatables.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.js"></script>
    <script src="signalr/hubs"></script>
    <script>
        $(function () {
            // Ticket Table
            var gameStatus = $("#HfGameStatus").val();
            var modifyTeam = "d-none";
            if (gameStatus == "1" || gameStatus == "3") {
                modifyTeam = "";
            }
            var dataArray = [];
            var dataArrayForResult = [];
            var dataArrayForMyTicket = [];
            var columns = [];
            var columnsForResult = [];
            var columnsForMyTicket = [];
            var datatable;
            var datatableForResult;
            var datatableForMyTicket;

            // My Ticket Table
            var drawTableForMyTicket = () => $.ajax({
                type: "GET",
                url: 'DataService.asmx/FindMyTickets',
                data: {
                    gameID: $("#HfGameID").val(),
                    userID: $("#HfUserID").val(),
                },
                success: function (res) {
                    dataArrayForMyTicket = res.data;
                    console.log(res.data);
                    // Draw DataTable
                    columnsForMyTicket.length = 0;
                    columnsForMyTicket.push({
                        "title": "Nr.",
                        "width": "5%",
                        "data": "Id",
                        "render": function (data, type, row, meta) {
                            return data;
                            //return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    });
                    columnsForMyTicket.push({
                        "title": "Player",
                        "width": "15%",
                        "render": function (data, type, row, meta) {
                            return row.UserName;
                        }
                    });
                    var numColumns = (dataArrayForMyTicket.length > 0) ? dataArrayForMyTicket[0].TicketResults.length : 0;
                    for (var i = 0; i < numColumns; i++) {
                        columnsForMyTicket.push({
                            "class": "ps-0 pe-0",
                            "title": "Turno " + (i + 1),
                            "render": function (data, type, row, meta) {
                                var result = row.TicketResults[meta.col - 2].RoundResult;
                                var bg = "";
                                switch (result) {
                                    case 1: bg = "bg-success"; break;
                                    case 2: bg = "bg-warning"; break;
                                    case 3: bg = "bg-danger"; break;
                                    default: bg = ""; break;
                                }
                                var roundResult = '<p class="' + bg + '">' + row.TicketResults[meta.col - 2].TeamName + '</p>'
                                return roundResult;
                            }
                        });
                    }
                    columnsForMyTicket.push({
                        "title": "Azione",
                        "class": modifyTeam,
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.TicketResults.length == 0 || row.TicketResults[row.TicketResults.length - 1].RoundResult == null || row.TicketResults[row.TicketResults.length - 1].TeamID != 0) return "";
                            else return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px; color:greenyellow;"></i></a>';

                        }
                    });

                    if (datatableForMyTicket) datatableForMyTicket.fnDestroy();

                    datatableForMyTicket = $('#myTicket-table').dataTable({
                        "serverSide": false,
                        "dom": '<"table-responsive"t>pr',
                        "autoWidth": false,
                        "pageLength": 100,
                        "processing": true,
                        "ordering": false,
                        "scrollX": true,
                        "columns": columnsForMyTicket,
                        "data": [],

                        "rowCallback": function (row, data, index) {
                            $(row).find('td').css({ 'vertical-align': 'middle' });
                            $("#ticket-table_wrapper").css('width', '100%');
                        },

                        "drawCallback": function () {
                            $(".pagination").children('li').addClass("page-item");
                        }
                    });

                    for (var i = 0; i < dataArrayForMyTicket.length; i++) {
                        datatableForMyTicket.fnAddData(dataArrayForMyTicket[i]);
                    }

                    datatableForMyTicket.fnDraw();
                    /*onSuccess({ success: true });*/

                    datatableForMyTicket.on('click', '.btn-edit', function (e) {
                        e.preventDefault();

                        var row = datatableForMyTicket.fnGetData($(this).closest('tr'));

                        $("#TeamChangeModal").modal('show');
                        var modalTitle = "Scegli la squadra per superare il Turno " + row.TicketResults.length;
                        for (var k = 0; k < (row.TicketResults.length - 1); k++) {
                            // Remove before assigned Teams
                            $('#ComboTeams option[value="' + row.TicketResults[k].TeamID + '"]').remove();
                        }
                        var teamID = row.TicketResults[row.TicketResults.length - 1].TeamID;
                        $("#HfTicketResultID").val(row.TicketResults[row.TicketResults.length - 1].Id);
                        $(".modal-title").text(modalTitle);
                        $("#HfTicketID").val(row.Id);
                        $("#ValSummary").addClass("d-none");
                        $("#ComboTeams").val(teamID);
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
            drawTableForMyTicket();

            // Ticket Table
            var drawTable = () => $.ajax({
                type: "GET",
                url: 'DataService.asmx/FindTickets',
                data: {
                    gameID: $("#HfGameID").val()
                },
                success: function (res) {
                    dataArray = res.data;
                    console.log(res.data);
                    // Draw DataTable
                    columns.length = 0;
                    columns.push({
                        "title": "Nr.",
                        "width": "5%",
                        "data": "Id",
                        "render": function (data, type, row, meta) {
                            //return meta.row + meta.settings._iDisplayStart + 1;
                            return data;
                        }
                    });
                    columns.push({
                        "title": "Player",
                        "width": "15%",
                        "render": function (data, type, row, meta) {
                            return row.UserName;
                        }
                    });
                    var numColumns = (dataArray.length > 0) ? dataArray[0].TicketResults.length : 0;
                    for (var i = 0; i < numColumns; i++) {
                        columns.push({
                            "class": "ps-0 pe-0",
                            "title": "Turno " + (i + 1),
                            "render": function (data, type, row, meta) {
                                var result = row.TicketResults[meta.col-2].RoundResult;
                                var bg = "";
                                switch (result) {
                                    case 1: bg = "bg-success"; break;
                                    case 2: bg = "bg-warning"; break;
                                    case 3: bg = "bg-danger"; break;
                                    default: bg = ""; break;
                                }
                                var roundResult = '<p class="' + bg + '">' + row.TicketResults[meta.col-2].TeamName + '</p>'
                                return roundResult;
                            }
                        });
                    }

                    columns.push({
                        "title": "Stato",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.TicketResults.length == 0) return "<p class='text-warning'>OK</p>";
                            else if (row.TicketResults[row.TicketResults.length - 1].RoundResult == null) return "<p class='text-danger'>PERSO</p>";
                            else if (gameStatus == "6") return "<p class='text-success'>VINTO</p>";
                            else return "<p class='text-warning'>OK</p>";
                        }
                    });

                    if (datatable) datatable.fnDestroy();

                    datatable = $('#ticket-table').dataTable({
                        "serverSide": false,
                        "dom": '<"table-responsive"t>pr',
                        "autoWidth": false,
                        "pageLength": 100,
                        "processing": true,
                        "ordering": false,
                        "scrollX": true,
                        "columns": columns,
                        "data": [],

                        "rowCallback": function (row, data, index) {
                            $(row).find('td').css({ 'vertical-align': 'middle' });
                            $("#ticket-table_wrapper").css('width', '100%');
                        },

                        "drawCallback": function () {
                            $(".pagination").children('li').addClass("page-item");
                            var api = this.api();
                            var rowsCount = api.rows().count();
                            var columnsCount = api.columns().count();
                            var footer = '<tfoot class="bg-dark text-white"><tr><th></th><th>Nr. di Tickets :</th>';
                            for (var i = 2; i < columnsCount; i++) {
                                if (i == columnsCount - 1) {
                                    footer += "<th>" + rowsCount + "</th>";
                                }
                                else {
                                    footer += "<th></th>";
                                }
                            }
                            footer += '</tr></tfoot>';
                            $(this).append(footer);
                        }
                    });

                    for (var i = 0; i < dataArray.length; i++) {
                        datatable.fnAddData(dataArray[i]);
                    }

                    datatable.fnDraw();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
            drawTable();

            // Result Table
            var drawResultTable = () => $.ajax({
                type: "GET",
                url: 'DataService.asmx/FindResults',
                data: {
                    gameID: $("#HfGameID").val()
                },
                success: function (res) {
                    dataArrayForResult = res.data;
                    console.log(res.data);
                    // Draw DataTable
                    columnsForResult.length = 0;
                    columnsForResult.push({
                        "title": "Nr.",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    });
                    columnsForResult.push({
                        "title": "Squadra",
                        "width": "15%",
                        "class": "text-nowrap",
                        "render": function (data, type, row, meta) {
                            return row.TeamName;
                        }
                    });
                    var numColumns = (dataArrayForResult.length > 0) ? dataArrayForResult[0].Results.length : 0;
                    for (var i = 0; i < numColumns; i++) {
                        columnsForResult.push({
                            "class": "ps-0 pe-0",
                            "title": "Turno " + (i + 1),
                            "render": function (data, type, row, meta) {
                                var result = row.Results[meta.col - 2].RoundResult;
                                var bg = "";
                                var content = "";
                                switch (result) {
                                    case 1: {
                                        bg = "bg-success";
                                        content = "VINCE";
                                    } break;
                                    case 2: {
                                        bg = "bg-warning";
                                        content = "PARI";
                                    } break;
                                    case 3: {
                                        bg = "bg-danger";
                                        content = "PERDE"
                                    } break;
                                    default: {
                                        bg = "";
                                        content = "";
                                    } break;
                                }
                                var roundResult = '<p class="' + bg + '">' + content + '</p>'
                                return roundResult;
                            }
                        });
                    }

                    if (datatableForResult) datatableForResult.fnDestroy();

                    datatableForResult = $('#result-table').dataTable({
                        "serverSide": false,
                        "dom": '<"table-responsive"t>pr',
                        "autoWidth": false,
                        "pageLength": 100,
                        "processing": true,
                        "ordering": false,
                        "scrollX": true,
                        "columns": columnsForResult,
                        "data": [],

                        "rowCallback": function (row, data, index) {
                            $(row).find('td').css({ 'vertical-align': 'middle' });
                            $("#result-table_wrapper").css('width', '100%');
                        },

                        "drawCallback": function () {
                            $(".pagination").children('li').addClass("page-item");
                        }
                    });

                    for (var i = 0; i < dataArrayForResult.length; i++) {
                        datatableForResult.fnAddData(dataArrayForResult[i]);
                    }

                    datatableForResult.fnDraw();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
            drawResultTable();

            // Winner Table
            var datatableForWinner = $('#winner-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindWinners',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 20,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "render": function (data, type, row, meta) {
                        return meta.row + meta.settings._iDisplayStart + 1;
                    }
                }, {
                    "data": "Winner",
                }, {
                    "data": "Prize",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.gameID = $("#HfGameID").val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#winner-table_wrapper").css('width', '100%');
                },

                "drawCallback": function () {
                    $(".pagination").children('li').addClass("page-item");
                }
            });

            $("#BtnTicket").click(function () {

                $("#NewTicketModal").modal('show');
                $("#modalTitle1").text("NUOVO TICKET");
                $("#ValSummary1").addClass("d-none");
                $("#TxtNumOfTickets").val("");
                return false;

            })

            $('#TxtNumOfTickets').on('input', function () {
                var amount = $('#TxtNumOfTickets').val() * $('#HfFee').val();
                if (amount > $("#HfBalance").val()){
                    alert("Saldo insufficiente");
                    $('#TxtNumOfTickets').val($('#TxtNumOfTickets').val() - 1);
                    return;
                }
                if ($('#TxtNumOfTickets').val() > 10) {
                    alert("Troppi Tickets!");
                    $('#TxtNumOfTickets').val($('#TxtNumOfTickets').val() - 1);
                    return;
                }
                $("#TxtBalance").val("€ " + ($("#HfBalance").val().replaceAll(',', '.') - amount).toFixed(2));
            });

            $('.GameImage').addClass('img-enlargable').click(function () {
                var src = $(this).attr('src');
                $('<div>').css({
                    background: 'RGBA(0,0,0,.5) url(' + src + ') no-repeat center',
                    backgroundSize: 'contain',
                    width: '100%', height: '100%',
                    position: 'fixed',
                    zIndex: '10000',
                    top: '0', left: '0',
                    cursor: 'zoom-out'
                }).click(function () {
                    $(this).remove();
                }).appendTo('body');
            });

            $(".TeamShow").click(function () {
                var img = $(this)[0].dataset.img;
                var id = $(this)[0].dataset.id;
                $.ajax({
                    type: "GET",
                    url: 'DataService.asmx/GetTeams',
                    data: {
                        gameID: id
                    },
                    success: function (res) {
                        var dataArrayForTeams = res.data;
                        $("#gameTeamsModal").modal('show');
                        $(".teamNames").html(dataArrayForTeams.join('<br/>'));
                        $("#TeamImage").attr('src', "Upload/Game/" + (img ? img : "default.jpg"));
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        // Handle the error response
                        console.log('Error:', textStatus, errorThrown);
                    }
                });
            });

            // Real Time Notification
            var proxy = $.connection.notificationHub;

            proxy.client.receiveTeamChoiceNotification = function (message) {
                drawTableForMyTicket();
                drawTable();
            };

            proxy.client.receiveTicketNotificationA = function (message) {
                drawTable();
            };

            proxy.client.receiveTeamChoiceNotificationA = function (message) {
                drawTable();
            };

            proxy.client.receiveResultNotification = function (message) {
                drawTableForMyTicket();
                drawTable();
                drawResultTable();
            };

            proxy.client.receiveRoundNotification = function (message) {
                if ($("#HfHaveTicket").val() == "true") {
                    alert(message);
                }
                drawTableForMyTicket();
                drawTable();
                drawResultTable();
                datatableForWinner.fnDraw();
                window.location.reload();
            };

            proxy.client.receivePrizeNotification = function (message) {
                alert(message);
                datatableForWinner.fnDraw();
            };

            proxy.client.receiveStartGameNotification = function (message) {
                alert(message);
                window.location.reload();
            };

            proxy.client.receiveUserMessage = function (message) {
                var userID = $("#HfUserID").val();
                var splitList = message.split(",");
                if (splitList.indexOf(userID) > -1) {
                    $("#TxtMessage").val(splitList[1]);
                    $("#MessageModal").modal('show');
                }
                else return false;
            };
            
            $.connection.hub.start();
        })
    </script>
</asp:Content>
