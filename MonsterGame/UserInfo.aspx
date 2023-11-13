<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="MonsterGame.UserInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <link rel="stylesheet" href="Content/CSS/jquery.datetimepicker.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Scheda Personale</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Scheda</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg);">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row">
                    <div class="col-3">
                        <ul class="privacy-policy-sidebar-menu" style="padding-top:120px;">
                            <li style="padding-left:30px;">
                                <a href="#purchase" class="nav-link">ACQUISTA CON PAYPAL</a>
                            </li>
                            <li style="padding-left:30px;">
                                <a href="#history" class="nav-link">LISTA MOVIMENTI</a>
                            </li>
                            <li runat="server" id="liGame" style="padding-left:30px;">
                                <a href="#games" class="nav-link">I MIEI TORNEI</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-9">
                        <div class="privacy-policy-content">
                            <div class="content-item mb-0">
                                <h3 class="title" id="purchase" style="padding-top:120px;">ACQUISTI</h3>
                                <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                <asp:CustomValidator ID="PaypalAmount" runat="server" ErrorMessage="Please insert valid amount." Display="None"></asp:CustomValidator>
                                <div class="pt-5">
                                    <div class="col-lg-12 col-xl-12 col-md-12 col-sm-10">
                                        <div class="dashboard__card" style="border: 2px solid #ffdd2d;">
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="Balance" class="price">€ 3750</h2>
                                                <p class="info">SALDO</p>
                                            </div>
                                            <div class="dashboard__card-icon">
                                                <i class="las la-wallet"></i>
                                            </div>
                                            <div class="pt-1">
                                                <asp:TextBox runat="server" ID="TxtAmount" CssClass="form--control form-control" ClientIDMode="Static" placeholder="Importo"></asp:TextBox>
                                            </div>
                                            <div>
                                                <asp:Button runat="server" ID="BtnPurchase" ClientIDMode="Static" CssClass="cmn--btn active radius-1 w-100" Text="ACQUISTA CON PAYPAL" OnClick="BtnPurchase_Click"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="pt-5 col-6 ms-auto">
                                    <asp:TextBox runat="server" ID="TxtPaymentSearch" CssClass="form--control form-control" ClientIDMode="Static" placeholder="Cerca..."></asp:TextBox>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="payment-table">
                                        <thead>
                                            <tr>
                                                <th>Data Pag.</th>
                                                <th>Importo</th>
                                                <th>Nr. Transazione Paypal</th>
                                                <th>Note</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="content-item mb-0">
                                <h3 class="title" id="history" style="padding-top:120px;">LISTA MOVIMENTI</h3>
                                <div class="row">
                                    <div class="col-lg-6 col-xl-6 col-md-6 col-sm-10">
                                        <div class="dashboard__card" style="border: 2px solid #ffdd2d;">
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="Deposit" class="price">$4550</h2>
                                                <p class="info">TOTALE ENTRATE</p>
                                            </div>
                                            <div class="dashboard__card-icon">
                                                <i class="las la-wallet"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-xl-6 col-md-6 col-sm-10">
                                        <div class="dashboard__card" style="border: 2px solid #ffdd2d;">
                                            <div class="dashboard__card-content">
                                                <h2 runat="server" id="Withdraw" class="price">$2500</h2>
                                                <p class="info">TOTALE USCITE</p>
                                            </div>
                                            <div class="dashboard__card-icon">
                                                <i class="las la-money-check"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row justify-content-center pt-5">
                                    <div class="col-lg-4 col-xl-4 ">
                                        <asp:TextBox runat="server" ID="TxtFrom" CssClass="form--control form-control" ClientIDMode="Static" placeholder="Dal"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-4 col-xl-4 ">
                                        <asp:TextBox runat="server" ID="TxtTo" CssClass="form--control form-control" ClientIDMode="Static" placeholder="al"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-4 col-xl-4 ">
                                        <asp:TextBox runat="server" ID="TxtTransfer" CssClass="form--control form-control" ClientIDMode="Static" placeholder="Cerca..."></asp:TextBox>
                                    </div>
                                </div>
                                <div class="pt-3 justify-content-center">
                                    <table class="table text-center" id="movement-table">
                                        <thead>
                                            <tr>
                                                <th>Data</th>
                                                <th>Importo</th>
                                                <th>Destinazione</th>
                                                <th>Note</th>
                                                <th>Tipo</th>
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
                                            <div class="col-lg-4 col-xl-4 col-md-6 col-sm-6">
                                                <div class="game-item">
                                                    <div class="game-inner">
                                                        <div class="game-item__thumb">
                                                            <%# Eval("Mark") %>
                                                            <img src="Content/Images/<%# Eval("Image") %>" alt="game">
                                                        </div>
                                                        <div class="game-item__content">
                                                            <h4 class="title"><%# Eval("Title") %></h4>
                                                            <p class="invest-info">Quota ingresso: <span class="invest-amount">€ <%# Eval("Fee") %></span></p>
                                                            <p class="invest-info">Player necessari: <span class="invest-amount"><%# Eval("MinPlayers") %></span></p>
                                                            <p class="invest-info">Player attuali: <span class="invest-amount"><%# Eval("RealPlayers") %></span></p>
                                                            <p class="invest-info">Numero di squadre: <span class="invest-amount"><%# Eval("NumberOfTeams") %></span></p>
                                                            <p class="invest-info">Forziere minimo: <span class="invest-amount">€ <%# Eval("Prize") %></span></p>
                                                            <a class="cmn--btn active btn--md radius-1" href="UserGameDetail.aspx?gameId=<%# Eval("Id") %>"><%# Eval("ButtonTitle") %></a>
                                                        </div>
                                                    </div>
                                                    <div class="ball"></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
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
    <script>
        $(function () {
            var datatable = $('#payment-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindPayments',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 10,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "data": "PayDate",
                }, {
                    "data": "Amount",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "Transition",
                }, {
                    "width": "25%",
                    "data": "Note",
                    "render": function (data, type, row, meta) {
                        var note = (data != null && data.length > 20) ? data.substring(0, 20) : data;
                        return '<p class="text-white" title="' + row.Note + '">' + (note == null ? "" : note) + '</p>';
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchVal = $('#TxtPaymentSearch').val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#payment-table_wrapper").css('width', '100%');
                },

                "drawCallback": function () {
                    $(".pagination").children('li').addClass("page-item");
                }
            });

            $('#TxtPaymentSearch').on('input', function () {
                datatable.fnDraw();
            });
        })
    </script>
    <script>
        $.datetimepicker.setLocale('it');

        $("#TxtFrom").datetimepicker({
            format: "d/m/Y H.i",
        });

        $("#TxtTo").datetimepicker({
            format: "d/m/Y H.i",
        });

        $('#TxtAmount').on('input', function () {
            $("#ValSummary").addClass("d-none");
        });
        
    </script>
    <script>
        $(function () {
            var datatable1 = $('#movement-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindUserMovements',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 10,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "data": "MoveDate"
                }, {
                    "data": "Amount",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "Transfer"
                }, {
                    "width": "20%",
                    "data": "Note",
                    "render": function (data, type, row, meta) {
                        var note = (data != null && data.length > 40) ? data.substring(0, 40) : data;
                        return '<p class="text-white" title="' + row.Note + '">' + (note == null ? "" : note) + '</p>';
                    }
                }, {
                    "data": "Type",
                    "render": function (data, type, row, meta) {
                        if (data == 1) return "<p class='text-white bg-success' style='border-radius: 6px;'>ACCREDITO</p>";
                        else return "<p class='text-white bg-danger' style='border-radius: 6px;'>ADDEBITO</p>";
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchTransfer = $('#TxtTransfer').val();
                    aoData.searchFrom = $('#TxtFrom').val();
                    aoData.searchTo = $('#TxtTo').val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#movement-table_wrapper").css('width', '100%');
                },

                "drawCallback": function () {
                    $(".pagination").children('li').addClass("page-item");
                }
            });

            $('#TxtTransfer').on('input', function () {
                datatable1.fnDraw();
            });

            $('#TxtFrom, #TxtTo').change(function () {
                datatable1.fnDraw();
            });
        })
    </script>
</asp:Content>
