<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Movements.aspx.cs" Inherits="MonsterGame.Movements" %>
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
        #select2-ComboReceiver-results {
            background-color: #350b2d;
        }
        #select2-ComboSender-results {
            background-color: #350b2d;
        }
        #select2-ComboReceiver-container {
            padding-top: 10px;
            padding-left: 12px;
            color: rgba(255, 255, 255, 0.8);
        }
        #select2-ComboSender-container {
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
                    <h2 class="title text-white">Movimenti</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Movimenti</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg);">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfMovementID" runat="server" ClientIDMode="Static" />
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:TextBox runat="server" ID="TxtFrom" CssClass="form--control form-control" ClientIDMode="Static" placeholder="DAL ..."></asp:TextBox>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:TextBox runat="server" ID="TxtTo" CssClass="form--control form-control" ClientIDMode="Static" placeholder="AL ..."></asp:TextBox>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:DropDownList runat="server" ID="ComboReceiver" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                        <%--<asp:TextBox runat="server" ID="TxtReceiver" CssClass="form--control form-control" ClientIDMode="Static" placeholder="SEARCH RECEIVER"></asp:TextBox>--%>
                    </div>
                    <div class="col-lg-3 col-xl-3 ">
                        <asp:DropDownList runat="server" ID="ComboSender" CssClass="form-select form--control style-two" ClientIDMode="Static"></asp:DropDownList>
                        <%--<asp:TextBox runat="server" ID="TxtSender" CssClass="form--control form-control" ClientIDMode="Static" placeholder="SEARCH SENDER"></asp:TextBox>--%>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
                    <table class="table text-center" id="movement-table">
                        <thead>
                            <tr>
                                <th>A</th>
                                <th>DA</th>
                                <th>Data movimento</th>
                                <th>Importo</th>
                                <th>Note</th>
                                <th>Tipo</th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
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

        $("#ComboReceiver").select2();

        $("#ComboSender").select2();
    </script>
    <script>
        $(function () {
            var datatable = $('#movement-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindMovements',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 20,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "data": "Receiver",
                }, {
                    "data": "Sender",
                }, {
                    "data": "MoveDate",
                }, {
                    "data": "Amount",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "width": "25%",
                    "data": "Note",
                    "render": function (data, type, row, meta) {
                        var note = (data != null && data.length > 40) ? data.substring(0, 40) : data;
                        return '<p class="text-white" title="' + row.Note + '">' + (note == null ? "" : note) + '</p>';
                    }
                }, {
                    "data": "Type",
                    "render": function (data, type, row, meta) {
                        if (data == 1) return "<p class='text-white bg-success' style='border-radius: 8px;'>DEPOSITO</p>";
                        else return "<p class='text-white bg-danger' style='border-radius: 8px;'>PRELIEVO</p>";
                    }
                }, {
                    "width": "15%",
                    "data": null,
                    "render": function (data, type, row, meta) {
                        return '<div class="justify-content-center">' +
                            '<button class="cmn--btn active btn--md radius-1 btn--danger btn-delete">Cancella</button>' +
                            '</div > ';
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchReceiver = $('#ComboReceiver').val();
                    aoData.searchSender = $('#ComboSender').val();
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

            $('#TxtFrom, #TxtTo').change(function () {
                datatable.fnDraw();
            });

            $('#ComboReceiver').change(function () {
                datatable.fnDraw();
            });

            $('#ComboSender').change(function () {
                datatable.fnDraw();
            });

            datatable.on('click', '.btn-delete', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                if (!confirm("Click OK per cancellare."))
                    return;

                $.ajax({
                    type: "POST",
                    url: 'DataService.asmx/DeleteMovement',
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
</asp:Content>
