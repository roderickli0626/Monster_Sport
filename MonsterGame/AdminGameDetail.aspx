<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="AdminGameDetail.aspx.cs" Inherits="MonsterGame.AdminGameDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Game Details</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="AdminGame.aspx">Games</a></li>
                        <li>Game Details</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg);">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfGameID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfGameStatus" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfTicketResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfResultID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfCurrentRound" runat="server" ClientIDMode="Static" />
                <div class="row">
                    <div class="col-3">
                        <ul class="privacy-policy-sidebar-menu" style="padding-top:120px;">
                            <li style="padding-left:30px;">
                                <a href="#tickets" class="nav-link">TICKETS</a>
                            </li>
                            <li style="padding-left:30px;">
                                <a href="#results" class="nav-link">RESULTS</a>
                            </li>
                            <li runat="server" id="liWinner" style="padding-left:30px;">
                                <a href="#winners" class="nav-link">WINNERS</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-9">
                        <div class="privacy-policy-content">
                            <div class="content-item mb-0">
                                <h3 class="title" id="tickets" style="padding-top:120px;">TICKETS</h3>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="ticket-table">
                                    </table>
                                </div>
                            </div>
                            <div class="content-item mb-0">
                                <h3 class="title" id="results" style="padding-top:120px;">RESULTS</h3>
                                <div class="row justify-content-center pt-5">
                                    <div class="col-lg-4 col-xl-4 ms-auto">
                                         <asp:Button runat="server" ID="BtnRound" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="NEW ROUND" OnClick="BtnRound_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="result-table">
                                    </table>
                                </div>
                            </div>
                            <div runat="server" id="DivWinners" class="content-item mb-0">
                                <h3 class="title" id="winners" style="padding-top: 120px;">WINNERS</h3>
                                <div class="row justify-content-center ">
                                    <div class="col-lg-4 col-xl-4 ms-auto">
                                         <asp:Button runat="server" ID="BtnPrize" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="DIVIDE PRIZE" OnClick="BtnPrize_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="winner-table">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Winner</th>
                                                <th>Percent</th>
                                                <th>Prize</th>
                                                <th>Action</th>
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
                                <h4 class="modal-title text-dark" id="modalTitle">Change Team</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Save Failed." Display="None"></asp:CustomValidator>
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
                                <asp:Button runat="server" ID="BtnChangeTeam" CssClass="btn btn--warning btn--md" Text="Save" CausesValidation="false" OnClick="BtnChangeTeam_Click"/>
                                <button runat="server" id="btnClose" clientIDMode="static" class="btn btn--danger btn--md">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal custom--modal fade show" id="ResultChangeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle1">Change Team</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary1" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Save Failed." Display="None"></asp:CustomValidator>
                                        <div class="col-md-8 mx-auto">
                                            <div class="form-group">
                                                <asp:DropDownList runat="server" ID="ComboResults" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnResult" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnResult" CssClass="btn btn--warning btn--md" Text="Save" CausesValidation="false" OnClick="BtnResult_Click"/>
                                <button type="button" class="btn btn--danger btn--md" data-bs-dismiss="modal">Close</button>
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
                    columns.push({
                        "title": "No",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    });
                    columns.push({
                        "title": "User",
                        "width": "15%",
                        "render": function (data, type, row, meta) {
                            return row.UserName;
                        }
                    });
                    var numColumns = (dataArray.length > 0) ? dataArray[0].TicketResults.length : 0;
                    for (var i = 0; i < numColumns; i++) {
                        columns.push({
                            "class": "ps-0 pe-0",
                            "title": "Round " + (i + 1),
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
                        "title": "Action",
                        "class": modifyTeam,
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.TicketResults[row.TicketResults.length - 1].RoundResult == null || row.TicketResults.length == 0) return "";
                            else return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px"></i></a>';
                        }
                    });

                    if (datatable) datatable.destroy();

                    datatable = $('#ticket-table').dataTable({
                        "serverSide": false,
                        "dom": '<"table-responsive"t>pr',
                        "autoWidth": false,
                        "pageLength": 100,
                        "processing": true,
                        "ordering": false,
                        "scrollX": true,
                        "columns": columns,

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
                        var modalTitle = "Team Change in Round " + row.TicketResults.length;
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
                        "title": "No",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    });
                    columnsForResult.push({
                        "title": "Team",
                        "width": "15%",
                        "render": function (data, type, row, meta) {
                            return row.TeamName;
                        }
                    });
                    var numColumns = (dataArrayForResult.length > 0) ? dataArrayForResult[0].Results.length : 0;
                    for (var i = 0; i < numColumns; i++) {
                        columnsForResult.push({
                            "class": "ps-0 pe-0",
                            "title": "Round " + (i + 1),
                            "render": function (data, type, row, meta) {
                                var result = row.Results[meta.col - 2].RoundResult;
                                var bg = "";
                                var content = "";
                                switch (result) {
                                    case 1: {
                                        bg = "bg-success";
                                        content = "W";
                                    } break;
                                    case 2: {
                                        bg = "bg-warning";
                                        content = "P";
                                    } break;
                                    case 3: {
                                        bg = "bg-danger";
                                        content = "L"
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
                        "title": "Action",
                        "width": "5%",
                        "render": function (data, type, row, meta) {
                            if (row.Results.length > 0) return '<a href="#" class="btn-edit mr-4"><i class="fa fa-edit" style="font-size:25px"></i></a>';
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
                        var modalTitle = "Match Result in Round " + row.Results.length;
                        var roundResult = row.Results[row.Results.length - 1].RoundResult;
                        $("#HfResultID").val(row.Results[row.Results.length - 1].Id);
                        $(".modal-title").text(modalTitle);
                        $("#ValSummary1").addClass("d-none");
                        $("#ComboResults").val(roundResult);

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
                if (confirm("Create A New Round?")) return true;
                else return false;
            });
        })
    </script>
</asp:Content>
