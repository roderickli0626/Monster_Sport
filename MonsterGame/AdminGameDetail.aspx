<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="AdminGameDetail.aspx.cs" Inherits="MonsterGame.AdminGameDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <link rel="stylesheet" href="Content/CSS/jquery.datetimepicker.min.css" />
    <style>
        .hidden-input {
            position: absolute;
            width: 0px;
            height: 0px;
            overflow: hidden;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 runat="server" id="GameTitle" class="title text-white">Dettagli del Torneo</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="AdminGame.aspx">TORNEI</a></li>
                        <li>Dettagli del Torneo</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfGameID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameStatus" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfCurrentRound" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfWinnerID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameImage1" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameImage2" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameImage3" runat="server" ClientIDMode="Static" />
                <div class="row">
                    <div class="col-12 col-md-3">
                        <ul class="privacy-policy-sidebar-menu" style="padding-top:120px;">
                            <li style="padding-left:30px;">
                                <a href="#results" class="nav-link">RISULTATI</a>
                            </li>
                            <li style="padding-left:30px;">
                                <a href="#tickets" class="nav-link">TUTTI I TICKETS</a>
                            </li>
                            <li runat="server" id="liWinner" style="padding-left:30px;">
                                <a href="#winners" class="nav-link">VINCENTI</a>
                            </li>
                            <li id="liEdit" style="padding-left:30px;">
                                <a href="#0" class="nav-link">EDIT</a>
                            </li>
                            <li style="padding-top: 30px;">
                                <img src="Upload/Game/default.jpg" id="GameImage" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail" style="height: auto; width: 100%;" />
                            </li>
                            <li style="padding-top: 30px; font-size: 20px;">
                                <pre runat="server" id="GameNote"></pre>
                            </li>
                        </ul>
                    </div>
                    <div class="col-12 col-md-9">
                        <div class="privacy-policy-content">
                            <div class="content-item mb-0">
                                <h3 class="title" id="results" style="padding-top:120px;">RISULTATI</h3>
                                <div class="row justify-content-center pt-5">
                                    <div class="col-lg-4 col-xl-4 ms-auto">
                                         <asp:Button runat="server" ID="BtnRound" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="NUOVO TURNO" OnClick="BtnRound_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="result-table">
                                    </table>
                                </div>
                            </div>
                            <div class="content-item mb-0">
                                <h3 class="title" id="tickets" style="padding-top:120px;">TICKETS</h3>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="ticket-table">
                                    </table>
                                </div>
                            </div>
                            <div runat="server" id="DivWinners" class="content-item mb-0">
                                <h3 class="title" id="winners" style="padding-top: 120px;">VINCENTI</h3>
                                <div class="row justify-content-center pb-3">
                                    <div class="col-lg-8 col-xl-8 col-md-8 col-sm-8">
                                        <div class="dashboard__card" style="border: 2px solid #ffdd2d;">
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="Prize" class="price">$0</h2>
                                                <p class="info">Premio</p>
                                            </div>
                                            <div class="dashboard__card-icon">
                                                <i class="las la-wallet"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-xl-4 d-flex flex-column justify-content-end">
                                         <asp:Button runat="server" ID="BtnPrize" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="DIVIDI I PREMI" OnClick="BtnPrize_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="winner-table">
                                        <thead>
                                            <tr>
                                                <th>Nr.</th>
                                                <th>Vincente</th>
                                                <th>%</th>
                                                <th>Importo</th>
                                                <th>Azione</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="TeamChangeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle">Cambia Squadre</h4>
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
                <div class="modal custom--modal fade show" id="ResultChangeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle1">Cambia Squadre</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary1" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-8 mx-auto">
                                            <div class="form-group">
                                                <asp:RadioButtonList ID="ResultOptions" runat="server" CssClass="justify-content-center mx-auto" ClientIDMode="Static">
                                                    <asp:ListItem Text=" VINCENTE " Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" PAREGGIO " Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" PERDENTE " Value="3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <%--<asp:DropDownList runat="server" ID="ComboResults" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>--%>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnResult" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnResult" CssClass="btn btn--warning btn--md" ClientIDMode="Static" Text="Conferma" CausesValidation="false" OnClick="BtnResult_Click"/>
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="PercentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle2">% Perc.</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel2" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary2" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator2" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-8 mx-auto">
                                            <div class="form-group">
                                                <asp:TextBox runat="server" ID="TxtPercent" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnPercent" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnPercent" CssClass="btn btn--warning btn--md" Text="Conferma" CausesValidation="false" OnClick="BtnPercent_Click"/>
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Chiudi</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="gameDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark">Dettagli del Torneo</h4>
                            </div>
                            <div class="modal-body modal--body modal-body-select2">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel3" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary3" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="ReqValTitle" runat="server" ErrorMessage="Inserisci il Titolo." CssClass="text-bg-danger" ControlToValidate="TxtTitle" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValFee" runat="server" ErrorMessage="Inserisci la quota di partecipazione." CssClass="text-black" ControlToValidate="TxtFee" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValTax" runat="server" ErrorMessage="Inserisci la tassa." CssClass="text-black" ControlToValidate="TxtTax" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValMinPlayers" runat="server" ErrorMessage="Inserisci il numero Min di Players." CssClass="text-black" ControlToValidate="TxtMinPlayers" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValTeamNum" runat="server" ErrorMessage="Inserisci il numero di squadre." CssClass="text-black" ControlToValidate="TxtTeamNum" Display="None"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ServerValidator0" runat="server" ErrorMessage="Inserisci le Squadre valide." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator3" runat="server" ErrorMessage="Inserisci % e Vincenti validi." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator4" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Titolo</label>
                                                <asp:TextBox runat="server" ID="TxtTitle" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="ComboModalStatus" class="form-label">Stato</label>
                                                <asp:DropDownList runat="server" ID="ComboModalStatus" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtStartDate" class="form-label">Start</label>
                                                <asp:TextBox runat="server" ID="TxtStartDate" ClientIDMode="Static" CssClass="form-control form--control style-two text-white" style="border: 1px solid rgba(255, 255, 255, 0.17); padding-left:10px;"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtEndDate" class="form-label">End </label>
                                                <asp:TextBox runat="server" ID="TxtEndDate" ClientIDMode="Static" CssClass="form-control form--control style-two text-white" style="border: 1px solid rgba(255, 255, 255, 0.17); padding-left:10px;"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="TxtTeamNum" class="form-label">Nr. di Squadre</label>
                                                <asp:TextBox runat="server" ID="TxtTeamNum" ClientIDMode="Static" CssClass="form-control form--control style-two" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="TxtMinPlayers" class="form-label">Player min.</label>
                                                <asp:TextBox runat="server" ID="TxtMinPlayers" ClientIDMode="Static" CssClass="form-control form--control style-two" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="TxtFee" class="form-label">Quota</label>
                                                <asp:TextBox runat="server" ID="TxtFee" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="TxtTax" class="form-label">Tax</label>
                                                <asp:TextBox runat="server" ID="TxtTax" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="TxtNote" class="form-label">Note</label>
                                                <asp:TextBox runat="server" ID="TxtNote" ClientIDMode="Static" CssClass="form-control form--control style-two" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4">
                                            <div class="form-group">
                                                <label for="TxtNote" class="form-label">Photo 1</label>
                                                <img src="Content/Images/gamemark3.jpg" id="GameImage1" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail" style="height: 150px; width: 100%;" />
                                                <asp:FileUpload runat="server" ID="ImageFile1" ClientIDMode="Static" CssClass="hidden-input" />
                                            </div> 
                                        </div>
                                        <div class="col-lg-4 col-md-4">
                                            <div class="form-group">
                                                <label for="TxtNote" class="form-label">Photo 2</label>
                                                <img src="Content/Images/gamemark3.jpg" id="GameImage2" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail" style="height: 150px; width: 100%;" />
                                                <asp:FileUpload runat="server" ID="ImageFile2" ClientIDMode="Static" CssClass="hidden-input" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4">
                                            <div class="form-group">
                                                <label for="TxtNote" class="form-label">Photo 3</label>
                                                <img src="Content/Images/gamemark3.jpg" id="GameImage3" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail" style="height: 150px; width: 100%;" />
                                                <asp:FileUpload runat="server" ID="ImageFile3" ClientIDMode="Static" CssClass="hidden-input" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent1" class="form-label">% al 1°</label>
                                                <asp:TextBox runat="server" ID="TxtPercent1" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent2" class="form-label">% al 2°</label>
                                                <asp:TextBox runat="server" ID="TxtPercent2" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent3" class="form-label">% al 3°</label>
                                                <asp:TextBox runat="server" ID="TxtPercent3" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent4" class="form-label">% al 4°</label>
                                                <asp:TextBox runat="server" ID="TxtPercent4" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent5" class="form-label">% al 5°</label>
                                                <asp:TextBox runat="server" ID="TxtPercent5" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="TxtPercent6" class="form-label">Vincenti</label>
                                                <asp:TextBox runat="server" ID="TxtWinners" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnSave" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnSave" CssClass="btn btn--warning btn--md" Text="Conferma" OnClick="BtnSave_Click"/>
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
    <script src="Scripts/bootstrap.bundle.min.js"></script>
    <script src="Scripts/JS/jquery.datetimepicker.full.min.js"></script>
    <script src="Scripts/jquery-3.4.1.sec.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.js"></script>
    <script src="signalr/hubs"></script>
    <script>
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoadedHandler);

        function pageLoadedHandler(sender, args) {
            // This function will be called after each UpdatePanel postback
            var updatedPanels = args.get_panelsUpdated();

            for (var i = 0; i < updatedPanels.length; i++) {
                var updatePanelID = updatedPanels[i].id;

                if (updatePanelID === "UpdatePanel3") {
                    SelectSetting();
                }
            }
        };

        SelectSetting();
        function SelectSetting() {

            $.datetimepicker.setLocale('it');

            $("#TxtStartDate").datetimepicker({
                format: "d/m/Y H.i",
            });

            $("#TxtEndDate").datetimepicker({
                format: "d/m/Y H.i",
            });

            $("#ImageFile1").change(function () {
                readURL(this, '#GameImage1', "#HfGameImage1");
            });

            $("#ImageFile2").change(function () {
                readURL(this, '#GameImage2', "#HfGameImage2");
            });

            $("#ImageFile3").change(function () {
                readURL(this, '#GameImage3', "#HfGameImage3");
            });

            $("#GameImage1").click(function () {
                $("#ImageFile1").click();
            });

            $("#GameImage2").click(function () {
                $("#ImageFile2").click();
            });

            $("#GameImage3").click(function () {
                $("#ImageFile3").click();
            });
        };

        function readURL(input, target, source) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $(target).attr('src', e.target.result);
                    var base64string = e.target.result;
                    $(source).val(base64string);
                };

                reader.readAsDataURL(input.files[0]);
            }
        };

        $("#liEdit").click(function () {
            $("#gameDetailModal").modal('show');
            $(".modal-title").text("AGGIORNA TORNEO");
        });
                                        </script>
    <script>
        $(function () {
            // Ticket Table
            var gameStatus = $("#HfGameStatus").val();
            var modifyTeam = "d-none";
            var inputResult = "d-none";
            if (gameStatus == "1" || gameStatus == "3") {
                modifyTeam = "";
            }
            if (gameStatus == "2") {
                inputResult = "";
            }
            var dataArray = [];
            var dataArrayForResult = [];
            var columns = [];
            var columnsForResult = [];
            var datatable;
            var datatableForResult;
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
                        "title": "Fase",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.TicketResults.length == 0) return "<p class='text-warning'>PLAYING</p>";
                            else if (row.TicketResults[row.TicketResults.length - 1].RoundResult == null) return "<p class='text-danger'>PERSO</p>";
                            else if (gameStatus == "6") return "<p class='text-success'>VINCE</p>";
                            else return "<p class='text-warning'>PLAYING</p>";
                        }
                    });

                    columns.push({
                        "title": "Azione",
                        "class": modifyTeam,
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.TicketResults.length == 0 || row.TicketResults[row.TicketResults.length - 1].RoundResult == null) return "";
                            else return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px; color:greenyellow;"></i></a>';
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
                        }
                    });

                    for (var i = 0; i < dataArray.length; i++) {
                        datatable.fnAddData(dataArray[i]);
                    }

                    datatable.fnDraw();
                    /*onSuccess({ success: true });*/

                    datatable.on('click', '.btn-edit', function (e) {
                        e.preventDefault();

                        var row = datatable.fnGetData($(this).closest('tr'));

                        $("#TeamChangeModal").modal('show');
                        var modalTitle = "Scelta Squadra per il Turno " + row.TicketResults.length;
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
                    columnsForResult.push({
                        "title": "Azione",
                        "class": inputResult,
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.Results.length > 0) return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px; color:greenyellow;"></i></a>';
                            else return "";
                        }
                    });

                    if (datatableForResult) datatableForResult.destroy();

                    datatableForResult = $('#result-table').dataTable({
                        "serverSide": false,
                        "dom": '<"table-responsive"t>pr',
                        "autoWidth": false,
                        "pageLength": 100,
                        "processing": true,
                        "ordering": false,
                        "scrollX": true,
                        "columns": columnsForResult,

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
                    /*onSuccess({ success: true });*/

                    datatableForResult.on('click', '.btn-edit', function (e) {
                        e.preventDefault();

                        var row = datatableForResult.fnGetData($(this).closest('tr'));

                        $("#ResultChangeModal").modal('show');
                        var modalTitle = "Esiti del Turno " + row.Results.length;
                        var roundResult = row.Results[row.Results.length - 1].RoundResult;
                        $("#HfResultID").val(row.Results[row.Results.length - 1].Id);
                        $(".modal-title").text(modalTitle);
                        $("#ValSummary1").addClass("d-none");
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // Handle the error response
                    console.log('Error:', textStatus, errorThrown);
                }
            });
            drawResultTable();

            $("#BtnRound").click(function () {
                var currentRound = datatableForResult.fnGetData(0).Results.length + 1;
                $("#HfCurrentRound").val(currentRound);
                if (confirm("Creare un nuovo Turno ?")) return true;
                else return false;
            });

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
                    "data": "Percent",
                }, {
                    "data": "Prize",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": null,
                    "render": function (data, type, row, meta) {
                        if (row.Prize == null || row.Prize == 0) return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px; color:greenyellow;"></i></a>';
                        else return "";
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

            datatableForWinner.on('click', '.btn-edit', function (e) {
                e.preventDefault();

                var row = datatableForWinner.fnGetData($(this).closest('tr'));

                $("#PercentModal").modal('show');
                $(".modal-title").text("SET PERCENT");
                $("#HfWinnerID").val(row.Id);
                $("#ValSummary2").addClass("d-none");
                $("#TxtPercent").val(row.Percent);
            });

            $("#BtnPrize").click(function () {
                if (confirm("Dividere il Montepremi tra i Vincitori?")) return true;
                else return false;
            });

            $('#GameImage').addClass('img-enlargable').click(function () {
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

            // Real Time Notification
            var proxy = $.connection.notificationHub;

            proxy.client.receiveTicketNotificationA = function (message) {
                drawTable();
                window.location.reload();
            };

            proxy.client.receiveTeamChoiceNotificationA = function (message) {
                drawTable();
            };

            proxy.client.receiveStartGameNotification = function (message) {
                alert(message);
                window.location.reload();
            };

            $.connection.hub.start();
        })
    </script>
</asp:Content>
