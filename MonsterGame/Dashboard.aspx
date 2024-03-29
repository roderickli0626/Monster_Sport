﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MonsterGame.Dashboard" %>
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
            top: 10px;
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

        td .font-complete-mark {
            color: greenyellow;
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
    </style>
    <style>
        .game-table-item {
            text-align: center;
            padding: 0px;
            border-radius: 10px;
            background: #350b2d;
            position: relative;
            transition: all ease .3s;
            z-index: 1;
        }
        .game-table-item::before {
            position: absolute;
            content: "";
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
        }

        div.left-control .section-link {
            margin: 6px 0;
            content: url(Content/Images/left-icon.png)
        }

        div.left-control .section-link:hover {
            margin: 6px 0;
            content: url(Content/Images/left-icon-selected.png)
        }

        div.left-control .section-link:active {
            margin: 6px 0;
            content: url(Content/Images/left-icon-selected.png)
        }

        div.left-control .section-link.active {
            margin: 6px 0;
            content: url(Content/Images/left-icon-selected.png)
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <!-- Banner Section Starts Here -->
    <section class="banner-section bg_img overflow-hidden" id="section1" style="background:url(Content/Images/stadium1.jpg) center">
        <div class="container">
            <div class="banner-wrapper d-flex flex-wrap align-items-center">
                <div class="banner-content">
                    <h1 class="banner-content__title">Gioca su <span class="text--base">FantaGame365</span> & supera la giornata di campionato!!</h1>
                    <p class="banner-content__subtitle">SCEGLI LE TUE SQUADRE VINCENTI E SUPERA I GURU DELLE PREVISIONI</p>
                    <div class="button-wrapper" runat="server" id="InDiv">
                        <a href="Login.aspx" class="cmn--btn active btn--lg">Entra</a>
                        <a href="Register.aspx" class="cmn--btn btn--lg">Registrati</a>
                    </div>
                    <div class="button-wrapper" runat="server" id="OutDiv">
                        <a href="Login.aspx" class="cmn--btn active btn--lg">Esci</a>
                    </div>
                    <div class="position-fixed top-50 translate-middle-y align-self-center start-0 ps-4 ps-sm-5 flex flex-column left-control">
                        <div class="list-group" id="list-example">
                            <a class="section-link" href="#section1"></a>
                            <a class="section-link" href="#section2"></a>
                            <a class="section-link" href="#section3"></a>
                        </div>
                    </div>
                    <img src="Content/Images/thumb.png" alt="" class="shape1">
                </div>
                <div class="banner-thumb">
                    <div class="carousel slide" data-bs-ride="carousel" style="width:750px;">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="Content/Images/slide1.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide2.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide3.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide4.png" class="d-block" alt="...">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner Section Ends Here -->

    <!-- Game Section Starts Here -->
    <section class="game-section padding-top padding-bottom bg_img" id="section2" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-xl-5">
                        <div class="section-header text-center">
                            <h2 class="section-header__title">TORNEI IN CORSO</h2>
                            <p>Scegli i Tornei a cui partecipare e vincere!</p>
                            <h3>Il montepremi cresce con il numero di giocatori!</h3>
                        </div>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center mb-5">
                    <asp:Repeater runat="server" ID="RepeaterGame">
                        <ItemTemplate>
                            <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6 position-relative">
                                <div class="game-item">
                                    <div class="game-inner">
                                        <div class="game-item__thumb">
                                            <%# Eval("Mark") %>
                                            <%--<img src="Content/Images/<%# Eval("Image") %>" alt="game">--%>
                                            <img class="GameImage" src="Upload/Game/<%# (Eval("Image1") == "" || Eval("Image1") == null) ? "default.jpg" : Eval("Image1") %>" alt="game">
                                        </div>
                                        <div class="game-item__content">
                                            <h4 class="title"><%# Eval("Title") %></h4>
                                            <div class="<%# ((int)Eval("Status") == 5 || (int)Eval("Status") == 6) ? "d-none" : "" %>">
                                                <p class="invest-info" title="Quota di partecipazione">Quota ingresso: <span class="invest-amount">€ <%# Eval("Fee") %></span></p>
                                                <p class="invest-info" title="Player necessari all'inizio del Torneo">Player necessari: <span class="invest-amount"><%# Eval("MinPlayers") %></span></p>
                                                <p class="invest-info" title="Player già registrati al Torneo">Player attuali: <span class="invest-amount"><%# Eval("RealPlayers") %> (<%# Eval("RemainedPlayers") %>)</span></p>                                                
                                                <p class="invest-info" title="Numero di squadre da cui poter scegliere" style="color: orange;">Numero squadre: <span class="invest-amount TeamShow" style="cursor: pointer;" data-id="<%# Eval("Id") %>" data-img="<%# Eval("Image2") %>"><%# Eval("NumberOfTeams") %></span> *</p>
                                                <p class="invest-info" title="Montepremi min. lo stesso viene adeguato in base ai ticket venduti" style="color: orange; background: purple;">Premio min.: <span class="invest-amount">€ <%# Eval("Prize") %></span></p>
                                                <p class="invest-info" title="Num. di Vincitori di questo Torneo">Vincenti: <span class="invest-amount"><%# Eval("Winners") %></span></p>
                                            </div>
                                            <div style="height: 183.6px;" class="<%# ((int)Eval("Status") == 5 || (int)Eval("Status") == 6) ? "" : "d-none" %> d-flex align-items-center ps-2">
                                                <%# Eval("CompletedInfo") %>
                                            </div>
                                            <button class="BtnDetails cmn--btn active btn--md radius-1" data-id="<%# Eval("Id") %>" 
                                                data-title="<%# Eval("Title") %>" data-fee="<%# Eval("Fee") %>" data-players="<%# Eval("RealPlayers") %>">Dettagli</button>
                                        </div>
                                    </div>
                                    <div class="ball"></div>
                                </div>
                                <span class="id-mark top-0 mt-2 start-0 ms-4" style="z-index:2;"><%# Eval("Id") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="row justify-content-center mb-5 mt-5" runat="server" id="AllGameSearchDiv">
                    <div class="col-lg-6 col-xl-6 pt-1">
                        <asp:DropDownList runat="server" ID="ComboStatus" CssClass="form-select form--control" ClientIDMode="Static"></asp:DropDownList>
                    </div>
                    <div class="col-lg-6 col-xl-6 pt-1">
                        <asp:TextBox runat="server" ID="TxtSearch" CssClass="form--control form-control" ClientIDMode="Static" placeholder="CERCA..."></asp:TextBox>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center" runat="server" id="AllGameDiv">
                    <table class="table text-center" id="game-table">
                        <thead>
                            <tr>
                                <th>Fase</th>
                                <th>Titolo</th>
                                <th>Start</th>
                                <th>Fine</th>
                                <th><img src="content\images\team.png" alt="Squadre" width="44" height="44" title="Squadre"/></th>
                                <th>Turno</th>
                                <th>Quota</th>
                                <th><img src="content\images\utentemin.png" alt="Necessari" width="44" height="44" title="Player Necessari" /></th>
                                <th><img src="content\images\utentereal.png" alt="Registrati" width="44" height="44" title="Player Registrati" /></th>    
                                <th><img src="content\images\forziere.png" alt="Premio" width="44" height="44" title="Premio"/></th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
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
                                        <h5 class="p-5 teamNames" style="white-space:nowrap;"><br /></h5>
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
    <!-- Game Section Ends Here -->

    <!-- How Section Starts Here -->
    <section class="how-section padding-top padding-bottom bg_img" id="section3" style="background: url(Content/Images/playbg.png);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="section-header text-center">
                        <h2 class="section-header__title">COME GIOCARE</h2>
                        <p>Il tuo obiettivo è superare ogni turno scegliendo saggiamente la squadra di calcio che ritieni sarà la vincente 
                            nello scontro della prossima giornata sportiva.</p>
                    </div>
                </div>
            </div>
            <div class="row gy-4 justify-content-center">
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-user-plus"></i>
                            <div class="badge badge--lg badge--round radius-50">01</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Registrati ed Entra</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-id-card"></i>
                            <div class="badge badge--lg badge--round radius-50">02</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Acquista i crediti</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-dice"></i>
                            <div class="badge badge--lg badge--round radius-50">03</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Scegli il campionato e gioca</h4>
                        </div>
                    </div>
                </div>
            </div>
            <h2 class="section-header__title"><br />Il premio aumenta in base al numero di partecipanti</h2>

        </div>
    </section>
    <!-- How Section Ends Here -->
    <div class=" modal custom--modal fade show" id="gameDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-modal="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content section-bg border-0">
                <div class="modal-header modal--header bg--base">
                    <h4 class="modal-title text-dark" id="modalTitle">Dettagli del Torneo</h4>
                </div>
               <div class="modal-body modal--body">
                    <h3 class="title mb-2">Prima che inizi il Torneo: </h3>
                    <p>Scegli il Torneo -> Compra il biglietto -> Scegli la Squadra -> Attendi l'esito dell'incontro -> Andrai al Turno successivo ? </p>
                    <h3 class="title mb-2 mt-3">Come si gioca: </h3>
                    <p>I giocatori entro la fine della settimana sportiva dovranno scegliere una SQUADRA, dall'elenco fornito dagli organizzatori. <br />
                        Il Venerdi (generalmente entro le 18.00), il Torneo inizia e non sarà più possibile parteciparvi.<br />
                        Ogni partecipante verrà abilitato o meno al successivo Turno in base ai risultati dell'incontro sportivo che si andrà a disputare.<br />
                    <h3 class="title mb-2 mt-3">Informazioni e Regolamento: </h3>    
                        1. I partecipanti devono predire quale squadra, tra quelle selezionate dal Torneo, è Vincente nella successiva giornata di campionato. <br />
                        - In caso di sconfitta si verrà eliminati dal Torneo<br />
                        - In caso di pareggio scatterà un'ammonizione e, alla seconda ammonizione anche se non consecutiva, si procederà all'eliminazione dal Torneo.<br />
                        - In caso di vittoria si passerà al Turno successivo con la scelta di una nuova squadra... e cosi via ..<br />
                        - I risultati di riferimento sono quelli pubblicati sul sito Diretta/Livescore.it <br />
                        <br />
                        2. I partecipanti non possono utilizzare una squadra già selezionata nei propri turni precedenti. <br />
                        <br />
                        3. Se un evento in corso viene sospeso durante un Turno, i partecipanti che hanno selezionato le squadre coinvolte verranno automaticamente promossi al Turno successivo.<br />
                        <br />                        
                        4. Nel caso di rinvio di una singola partita e se il rinvio si verifica dopo l'orario limite per la scelta delle squadre, la selezione rimarrà valida. Se il rinvio avviene prima della scadenza per la consegna, non sarà possibile scegliere le squadre coinvolte nella partita posticipata.<br />
                        <br />
                        5. Il numero max di Turno è uguale al numero di Squadre previste dal Torneo. <br />
                        <br />
                        6. Quando sono esaurite le scelte disponibili da parte di due o più partecipanti (fine delle squadre), il torneo si conclude e il montepremi residuo viene diviso in parti uguali tra i partecipanti ancora in gara.<br />
                        <br />
                        7. In situazioni di sospensione del campionato durante l'evento, se la sospensione è prolungata, il montepremi verrà equamente diviso tra i partecipanti ancora in gioco.<br />
                        <br />
                        8. Se due o più contendenti stanno gareggiando per un premio e le squadre da loro scelte subiscono una sconfitta, il premio sarà assegnato al partecipante che non ha ancora ottenuto un pareggio durante il torneo. <br />
                        <br />
                        9. Nel caso in cui due o più partecipanti stiano competendo per un premio e non abbiano ricevuto alcuna ammonizione, o entrambi ne abbiano ricevuta una, in caso di sconfitta/pareggio delle squadre selezionate, i premi in disputa saranno equamente divisi.<br />
                        <br />
                        10. Se due o più partecipanti stanno gareggiando per un premio e vengono eliminati entrambi, uno per pareggio e l'altro per la sconfitta della squadra scelta, il premio superiore andrà al giocatore eliminato con doppia ammonizione. <br />
                        <br />
                        11. Le selezioni delle squadre dovranno essere effettuate entro 12h antecedenti la giornata di campionato (tale giornata verrà comunicata continuamente sul sito e anche in email).<br />
                        <br />
                        12. In caso di mancata comunicazione della scelta della squadra, verrà effettuata una scelta automatica, in ordine alfabetico, di una squadra tra quelle ancora disponibili.<br />
                        <br />
                        13. Durante il gioco, quando rimangono in gioco almeno quattro Ticket, è possibile stipulare un accordo per dividere il montepremi in qualsiasi modo si ritenga opportuno.
                            La richiesta è da effettuarsi via chat e, per trasparenza, nel message board del sito.<br />
                        <br />
                        14. Se un partecipante raggiunge le fasi finali del torneo con più ticket, in caso di eliminazione dei ticket avversari, vincerà i premi corrispondenti ai piazzamenti dei suoi ticket.<br />
                        <br />
                        15. La quota di partecipazione è variabile in base alle opzioni del Torneo (Lega, numero di squadre, montepremi etc).<br />
                        <br />
                        16. L'iscrizione è valida solo se effettuata prima dell'inizio del primo Turno; non sono ammesse iscrizioni in corso. <br />
                        <br />
                        17. La tasse del Torneo è in proporzione alla quota di partecipazione.<br />
                        <br />
                        18. Alcuni Tornei sono free e pertanto alcun importo è richiesto per la partecipazione.<br />
                        <br />
                        19. Tutti i premi sono esigibili in Agenzia.<br />
                        <br />
                        20. Il Torneo termina in queste determinate condizioni:<br />
                            i. Sono rimasti in gioco il numero di Partecipanti definiti dal Torneo (Vincitori: Xx).<br />
                            ii. Per sopraggiunta sospensione/termine del campionato di riferimento.<br />
                            iii. Per esaurimento del numero di Squadre disponibili per avanzare nel successivo Turno.<br />
                        <br />
                    </p>
                    <h3 class="title mb-2 mt-3">DETTAGLI PER QUESTO TORNEO </h3>
                    <p>La quota di partecipazione per questo torneo è di <strong id="fee"></strong> e attualmente ci sono già <strong id="players"></strong> player registrati.
                    </p>
																  
																																						
                </div>
                <div class="modal-footer modal--footer">
                    <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
    <script src="Scripts/JS/jquery.dataTables.js"></script>
    <script src="Scripts/JS/datatables.js"></script>
    <script>
        $(".BtnDetails").click(function () {
            $("#modalTitle").text($(this)[0].dataset.title);
            $("#fee").text("€ " + $(this)[0].dataset.fee);
            $("#players").text($(this)[0].dataset.players);
            $("#gameDetailModal").modal('show');
            return false;
        });

        var datatable = $('#game-table').dataTable({
            "serverSide": true,
            "ajax": 'DataService.asmx/FindGames',
            "dom": '<"table-responsive"t>pr',
            "autoWidth": false,
            "pageLength": 20,
            "processing": true,
            "ordering": false,
            "columns": [{
                "class": "GameImage",
                "render": function (data, type, row, meta) {
                    if (row.Status == 5 || row.Status == 6) {
                        return '<div class="game-table-item"><div class="game-item__thumb mb-0"><span class="id-mark">' + row.Id + '</span>' + row.CompletedInfo + row.Mark +
                            '<img src="Upload/Game/' + ((row.Image1 == null || row.Image1 == "") ? "default.jpg" : row.Image1) + '" alt = "game"></div></div>';
                    }
                    else return '<div class="game-table-item"><div class="game-item__thumb mb-0"><span class="id-mark">' + row.Id + '</span>' + row.Mark +
                        '<img src="Upload/Game/' + ((row.Image1 == null || row.Image1 == "") ? "default.jpg" : row.Image1) + '" alt = "game"></div></div>';
                }
            }, {
                "data": "Title",
            }, {
                "data": "StartDate",
            }, {
                "data": "EndDate",
            }, {
                "data": "NumberOfTeams",
                "render": function (data, type, row, meta) {
                    return "<p class='TeamShow' style='cursor:pointer;' data-id='" + row.Id + "'>" + data + "</p>";
                }
            }, {
                "data": "Round",
                "render": function (data, type, row, meta) {
                    return "<p class='text-warning'>R 0" + data + "</p>";
                }
            }, {
                "data": "Fee",
                "render": function (data, type, row, meta) {
                    return "<p class='text-success'>€ " + data + "</p>";
                }
            }, {
                "data": "MinPlayers",
                "render": function (data, type, row, meta) {
                    return "<p class='text-success'>" + data + "</p>";
            }
            }, {
                "data": "RealPlayers",
                "render": function (data, type, row, meta) {
                    return "<p class='text-success'>" + data + "</p>";
                }
            }, {
                "data": "Prize",
                "render": function (data, type, row, meta) {
                    return "<p class='text-success'>€ " + data + "</p>";
                }
            }, {
                "data": null,
                "render": function (data, type, row, meta) {
                    return '<div class="justify-content-center">' +
                        '<a class="cmn--btn active btn--md radius-1 w-100 mt-1" href="UserGameDetail.aspx?gameId=' + row.Id + '">Dettagli</a>' +
                        '</div > ';
                }
            }],

            "fnServerParams": function (aoData) {
                aoData.searchVal = $('#TxtSearch').val();
                aoData.status = $('#ComboStatus').val();
            },

            "rowCallback": function (row, data, index) {
                $(row).find('td').css({ 'vertical-align': 'middle' });
                $("#game-table_wrapper").css('width', '100%');
            },

            "drawCallback": function () {
                $(".pagination").children('li').addClass("page-item");
            }
        });

        $('#ComboStatus').change(function () {
            datatable.fnDraw();
        });

        $('#TxtSearch').on('input', function () {
            datatable.fnDraw();
        });

        datatable.on('click', '.TeamShow', function (e) {
            var row = datatable.fnGetData($(this).closest('tr'));
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
                    $(".teamNames").html(dataArrayForTeams.join('<br />'));
                    $("#TeamImage").attr('src', "Upload/Game/" + (row.Image2 ? row.Image2 : "default.jpg"));
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
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
                    $(".teamNames").html(dataArrayForTeams.join('<br />'));
                    $("#TeamImage").attr('src', "Upload/Game/" + (img ? img : "default.jpg"));
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
        });

        datatable.on('click', '.GameImage', function (e) {
            var src = $($(this).find('img')).attr('src');
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
    </script>
</asp:Content>
