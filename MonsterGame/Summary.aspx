﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Summary.aspx.cs" Inherits="MonsterGame.Summary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <link rel="stylesheet" href="Content/CSS/jquery.datetimepicker.min.css" />
    <link rel="stylesheet" href="Content/CSS/select2.css" />
    <link rel="stylesheet" href="Content/CSS/select2-bootstrap.css" />
    <style>
        .select2-selection.select2-selection--single {
            box-shadow: none !important;
            border: 1px solid rgba(255, 255, 255, 0.17);
            background-color: #350b2d;
            width:100%;
            height: 100%;
        }
        .select2-container--default.select2-container, .selection {
            width:100% !important;
            height: 100% !important;
        }
        .select2-container--default.select2-container--focus .select2-selection--single {
            border: 1px solid rgba(255, 255, 255, 0.17);
            width:100%;
            height: 100% !important;
        }
        .select2-selection__choice {
            background-color:#2e0327 !important;
        }
        .select2-dropdown.select2-dropdown--above {
            background-color:#2e0327;
        }
        #select2-ComboStatus-results {
            background-color: #350b2d;
        }
        #select2-ComboGroup-results {
            background-color: #350b2d;
        }
        #select2-ComboStatus-container {
            padding-top: 10px;
            padding-left: 12px;
            color: rgba(255, 255, 255, 0.8);
        }
        #select2-ComboGroup-container {
            padding-top: 10px;
            padding-left: 12px;
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Report</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Report</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:TextBox runat="server" ID="TxtFrom" CssClass="form--control form-control" ClientIDMode="Static" placeholder="DAL ..."></asp:TextBox>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:TextBox runat="server" ID="TxtTo" CssClass="form--control form-control" ClientIDMode="Static" placeholder="AL ..."></asp:TextBox>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:DropDownList runat="server" ID="ComboStatus" CssClass="form-select form--control" ClientIDMode="Static"></asp:DropDownList>
                        <%--<asp:TextBox runat="server" ID="TxtReceiver" CssClass="form--control form-control" ClientIDMode="Static" placeholder="SEARCH RECEIVER"></asp:TextBox>--%>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:DropDownList runat="server" ID="ComboGroup" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                        <%--<asp:TextBox runat="server" ID="TxtSender" CssClass="form--control form-control" ClientIDMode="Static" placeholder="SEARCH SENDER"></asp:TextBox>--%>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
                    <table class="table text-center" id="summary-table">
                        <thead>
                            <tr>
                                <th>Nr.</th>
                                <th>Ruolo</th>
                                <th>Giocato</th>
                                <th>Vinto</th>
                                <th>Utile</th>
                                <th>Ticket</th>
                                <th>Player</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot class="bg-dark text-white">
                        </tfoot>
                    </table>
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
    <script>
        $.datetimepicker.setLocale('it');

        $("#TxtFrom").datetimepicker({
            format: "d/m/Y H.i",
        });

        $("#TxtTo").datetimepicker({
            format: "d/m/Y H.i",
        });

        $("#ComboStatus").select2();

        $("#ComboGroup").select2();
    </script>
    <script>
        $(function () {
            var datatable = $('#summary-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindSummary',
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
                    "data": "fullTitle",
                }, {
                    "data": "Amount",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "Prize",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "Utile",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "Tickets",
                }, {
                    "data": "Players",
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchOwner = $('#ComboGroup').val();
                    aoData.status = $('#ComboStatus').val();
                    aoData.searchFrom = $('#TxtFrom').val();
                    aoData.searchTo = $('#TxtTo').val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#summary-table_wrapper").css('width', '100%');
                },

                "drawCallback": function () {
                    $(".pagination").children('li').addClass("page-item");
                },

                "footerCallback": function (row, data, start, end, display) {

                    var amount = 0;
                    var prize = 0;
                    var players = 0;
                    var tickets = 0;
                    var utile = 0;

                    for (var i = 0; i < data.length; i++) {
                        amount += parseFloat(data[i].Amount);
                        prize += parseFloat(data[i].Prize);
                        players += parseFloat(data[i].Players);
                        utile += parseFloat(data[i].Utile);
                        tickets += parseFloat(data[i].Tickets);
                    }

                    // Add the new row to the footer
                    var newRow = $('<tr><th></th><th>Total:</th><th>€ ' + amount + '</th><th>€ ' + prize + '</th><th>€ ' + utile + '</th><th>' + tickets + '</th><th>' + players + '</th></tr>');

                    // Remove the existing footer row
                    $(this).find('tfoot').empty();

                    // Append the new row to the footer
                    $(this).find('tfoot').append(newRow);
                }
            });

            $('#TxtFrom, #TxtTo').change(function () {
                datatable.fnDraw();
            });

            $('#ComboGroup').change(function () {
                datatable.fnDraw();
            });

            $('#ComboStatus').change(function () {
                datatable.fnDraw();
            });
        })
    </script>
</asp:Content>
