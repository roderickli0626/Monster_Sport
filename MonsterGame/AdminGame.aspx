<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="AdminGame.aspx.cs" Inherits="MonsterGame.AdminGame" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <link rel="stylesheet" href="Content/CSS/jquery.datetimepicker.min.css" />
    <link rel="stylesheet" href="Content/CSS/select2.css" />
    <link rel="stylesheet" href="Content/CSS/select2-bootstrap.css" />
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
        .gj-icon {
            padding:12px;
            color:white;
        }
        .select2-selection.select2-selection--multiple {
            box-shadow: none !important;
            border: 1px solid rgba(255, 255, 255, 0.17);
            background-color: transparent;
            width:100%;
        }
        .select2-container--default.select2-container, .selection {
            width:100% !important;
        }
        .select2-container--default.select2-container--focus .select2-selection--multiple {
            border: 1px solid rgba(255, 255, 255, 0.17);
            width:100%;
        }
        .select2-selection__choice {
            background-color:#2e0327 !important;
        }
        .select2-dropdown.select2-dropdown--above {
            background-color:#2e0327;
        }
        #select2-ComboTeams-container {
            text-align: center
        }
        .select2-container--default .select2-results__option[aria-selected="true"] {
            background-color: dimgray;
        }
        .select2-search__field {
            color: white;
        }
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
                    <h2 class="title text-white">Tornei</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Tornei</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfGameID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameImage1" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameImage2" runat="server" ClientIDMode="Static" />
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-4 col-xl-4 pt-1">
                        <asp:DropDownList runat="server" ID="ComboStatus" CssClass="form-select form--control" ClientIDMode="Static"></asp:DropDownList>
                    </div>
                    <div class="col-lg-4 col-xl-4">
                        <button class="cmn--btn active radius-1 w-100 btn-add">AGGIUNGI TORNEO</button>
                    </div>
                    <div class="col-lg-4 col-xl-4 pt-1">
                        <asp:TextBox runat="server" ID="TxtSearch" CssClass="form--control form-control" ClientIDMode="Static" placeholder="CERCA ..."></asp:TextBox>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
                    <table class="table text-center" id="game-table">
                        <thead>
                            <tr>
                                <th>Fase</th>
                                <th>Titolo</th>
                                <th>Start</th>
                                <th>Fine</th>
                                <th><img src="content\images\team.png" alt="Squadre" width="44" height="44" title="Squadre"/></th>
                                <th>Quota</th>
                                <th>Tax</th>
                                <th><img src="content\images\utentemin.png" alt="Necessari" width="44" height="44" title="Player Necessari" /></th>
                                <th><img src="content\images\utentereal.png" alt="Registrati" width="44" height="44" title="Player Registrati" /></th>                                
                                <th><img src="content\images\forziere.png" alt="Premio" width="44" height="44" title="Premio"/></th>
                                <th>Turno</th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal custom--modal fade show" id="gameDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle">Dettagli del Torneo</h4>
                            </div>
                            <div class="modal-body modal--body modal-body-select2">
                                <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="ReqValTitle" runat="server" ErrorMessage="Inserisci il Titolo." CssClass="text-bg-danger" ControlToValidate="TxtTitle" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValFee" runat="server" ErrorMessage="Inserisci la quota di partecipazione." CssClass="text-black" ControlToValidate="TxtFee" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValTax" runat="server" ErrorMessage="Inserisci la tassa." CssClass="text-black" ControlToValidate="TxtTax" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValMinPlayers" runat="server" ErrorMessage="Inserisci il numero Min di Players." CssClass="text-black" ControlToValidate="TxtMinPlayers" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="ReqValTeamNum" runat="server" ErrorMessage="Inserisci il numero di squadre." CssClass="text-black" ControlToValidate="TxtTeamNum" Display="None"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ServerValidator0" runat="server" ErrorMessage="Inserisci le Squadre valide." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Inserisci % e Vincenti validi." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
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
                                        <div class="col-md-4">
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
                                        <div class="col-md-12">
                                            <label for="ComboModalStatus" class="form-label teamCount">Elenco Squadre</label>
                                            <div>
                                                <asp:DropDownList runat="server" ID="ComboTeams" CssClass="form-select form--control style-two" ClientIDMode="Static" Multiple="true"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnSave" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnSave" CssClass="btn btn--warning btn--md" Text="Save" OnClick="BtnSave_Click"/>
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
                                    <h5 class="p-5 teamNames" style="white-space:nowrap;"><br /></h5>
                                    <img src="Upload/Game/default.jpg" id="TeamImage" runat="server" clientidmode="Static" alt="service-image" class="m-3 mt-auto mb-auto img-thumbnail" style="height: 100%; width: 100%;" />
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
    <script src="Scripts/bootstrap.bundle.min.js"></script>
    <script src="Scripts/JS/jquery.datetimepicker.full.min.js"></script>
    <script src="Scripts/JS/select2.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.js"></script>
    <script src="signalr/hubs"></script>
    <script>
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoadedHandler);

        function pageLoadedHandler(sender, args) {
            // This function will be called after each UpdatePanel postback
            var updatedPanels = args.get_panelsUpdated();

            for (var i = 0; i < updatedPanels.length; i++) {
                var updatePanelID = updatedPanels[i].id;

                if (updatePanelID === "UpdatePanel") {
                    SelectSetting();
                }
            }
        };
    </script>
    <script>
        var proxy = $.connection.notificationHub;

        proxy.client.receiveStartGameNotification = function (message) {
            alert(message);
            window.location.reload();
        };

        $.connection.hub.start();

        SelectSetting();
        function SelectSetting() {
            $("#ComboTeams").select2({
                dropdownParent: $(".modal-body-select2")
            });

            $('#ComboTeams').change(function () {
                $(".teamCount").text("Elenco Squadre (" + $(this).val().length + ")");
            });

            $('#ComboTeams').on('select2:open', function (e) {
                // Use event delegation to handle the input event for the search input
                $(document).on('input', '.select2-search__field', function () {
                    var items = $("#select2-ComboTeams-results").children();
                    var selectedValues = [];
                    for (var i = 0; i < items.length; i++) {
                        var teamID = items[i].id.split("-")[items[i].id.split("-").length - 1];
                        selectedValues.push(teamID);
                    }
                    $('#ComboTeams').val(selectedValues).trigger('change');
                });
            });

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

            $("#GameImage1").click(function () {
                $("#ImageFile1").click();
            });

            $("#GameImage2").click(function () {
                $("#ImageFile2").click();
            });
        }

        $(".btn-add").click(function () {
            $("#gameDetailModal").modal('show');
            $(".modal-title").text("AGG. TORNEO");
            $("#HfGameID").val("");
            $("#ValSummary").addClass("d-none");
            $("#TxtTitle").val("");
            $("#ComboModalStatus").val("");
            $("#TxtStartDate").val("");
            $("#TxtEndDate").val("");
            $("#TxtFee").val("");
            $("#TxtTax").val("");
            $("#TxtMinPlayers").val("");
            $("#TxtTeamNum").val("");
            $("#TxtNote").val("");
            $("#ComboTeams").val([]).trigger('change');
            $("#TxtPercent1").val("");
            $("#TxtPercent2").val("");
            $("#TxtPercent3").val("");
            $("#TxtPercent4").val("");
            $("#TxtPercent5").val("");
            $("#TxtWinners").val("");
            $("#GameImage1").attr('src', "Upload/Game/default.jpg");
            $("#GameImage2").attr('src', "Upload/Game/default.jpg");

            return false;
        });
    </script>
    <script>
        $(function () {
            var datatable = $('#game-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindGames',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 20,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "render": function (data, type, row, meta) {
                        return '<div class="game-table-item"><div class="game-item__thumb mb-0"><span class="id-mark">' + row.Id + '</span>' + row.Mark +
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
                    "data": "Fee",
                    "render": function (data, type, row, meta) {
                        return "<p class='text-success'>€ " + data + "</p>";
                    }
                }, {
                    "data": "Tax",
                    "render": function (data, type, row, meta) {
                        return "<p class='text-success'>" + data + "%</p>";
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
                    "data": "Round",
                    "render": function (data, type, row, meta) {
                        return "<p class='text-warning'>R 0" + data + "</p>";
                    }
                }, {
                    "data": null,
                    "render": function (data, type, row, meta) {
                            return '<div class="justify-content-center">' +
                                '<button class="cmn--btn active btn--md radius-1 w-100 mt-1 btn--success btn-edit float-start">Edit</button >' + 
                                '<button class="cmn--btn active btn--md radius-1 w-100 mt-1 btn--danger btn-delete float-end">Cancella</button>' +
                                '<a class="cmn--btn active btn--md radius-1 w-100 mt-1" href="AdminGameDetail.aspx?gameId=' + row.Id + '">Dettaglio</a>' +
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
                        $(".teamNames").html(dataArrayForTeams.join('<br/>'));
                        $("#TeamImage").attr('src', "Upload/Game/" + (row.Image2 ? row.Image2 : "default.jpg"));
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        // Handle the error response
                        console.log('Error:', textStatus, errorThrown);
                    }
                });
            });

            datatable.on('click', '.btn-edit', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                $("#gameDetailModal").modal('show');
                $(".modal-title").text("AGGIORNA TORNEO");
                $("#HfGameID").val(row.Id);
                $("#ValSummary").addClass("d-none");
                $("#TxtTitle").val(row.Title);
                $("#ComboModalStatus").val(row.Status);
                $("#TxtStartDate").val(row.StartDate);
                $("#TxtEndDate").val(row.EndDate);
                $("#TxtFee").val(row.Fee);
                $("#TxtTax").val(row.Tax);
                $("#TxtMinPlayers").val(row.MinPlayers);
                $("#TxtTeamNum").val(row.NumberOfTeams);
                $("#TxtNote").val(row.Note);
                selectedValues = row.TeamList;
                $('#ComboTeams').val(selectedValues).trigger('change');
                $("#TxtPercent1").val(row.Percent1);
                $("#TxtPercent2").val(row.Percent2);
                $("#TxtPercent3").val(row.Percent3);
                $("#TxtPercent4").val(row.Percent4);
                $("#TxtPercent5").val(row.Percent5);
                $("#TxtWinners").val(row.Winners);
                $("#GameImage1").attr('src', "Upload/Game/" + (row.Image1 ? row.Image1 : "default.jpg"));
                $("#GameImage2").attr('src', "Upload/Game/" + (row.Image2 ? row.Image2 : "default.jpg"));
            });

            datatable.on('click', '.btn-delete', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                if (!confirm("Click OK per cancellare."))
                    return;

                $.ajax({
                    type: "POST",
                    url: 'DataService.asmx/DeleteGame',
                    data: {
                        id: row.Id
                    },
                    success: function () {
                        onSuccess({ success: true });
                    }
                }).error(function () {
                    onSuccess({ success: false });
                });
            });

            var onSuccess = function (data) {
                if (data.success) {

                    datatable.fnDraw();

                } else {
                    alert("Failed!");
                }
            };
        })
    </script>
    <script>
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
    </script>
</asp:Content>
