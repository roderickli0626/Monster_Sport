﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Master.aspx.cs" Inherits="MonsterGame.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <link rel="stylesheet" href="Content/CSS/jquery.datetimepicker.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Master</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Master</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfMasterID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfAdminBalance" runat="server" ClientIDMode="Static" />
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-4 col-xl-4 me-auto">
                        <button class="cmn--btn active radius-1 w-100 btn-add">Agg. Nuovo</button>
                    </div>
                    <div class="col-lg-4 col-xl-4 pt-1 ms-auto">
                        <asp:TextBox runat="server" ID="TxtSearch" CssClass="form--control form-control" ClientIDMode="Static" placeholder="CERCA ..."></asp:TextBox>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
                    <table class="table text-center" id="master-table">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Nick Name</th>
                                <th>Email</th>
                                <th>Mobile</th>
                                <th>Saldo</th>
                                <th>Admin</th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal custom--modal fade show" id="MasterModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle">Master</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="ReqValEmail" runat="server" ErrorMessage="Inserire un indirizzo Email." CssClass="text-bg-danger" ControlToValidate="TxtEmail" Display="None"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="PasswordValidator" runat="server" ErrorMessage="Le Password non corrispondono." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="EmailValidator" runat="server" ErrorMessage="Email non è corretta." Display="None"></asp:CustomValidator>
                                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Questo indirizzo Email è già registrato." Display="None"></asp:CustomValidator>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Nome</label>
                                                <asp:TextBox runat="server" ID="TxtName" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Cognome</label>
                                                <asp:TextBox runat="server" ID="TxtSurname" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Nick Name</label>
                                                <asp:TextBox runat="server" ID="TxtNickName" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Mobile</label>
                                                <asp:TextBox runat="server" ID="TxtMobile" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Email</label>
                                                <asp:TextBox runat="server" ID="TxtEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Password</label>
                                                <asp:TextBox runat="server" ID="TxtPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Conferma Password</label>
                                                <asp:TextBox runat="server" ID="TxtPasswordRepeat" ClientIDMode="Static" TextMode="Password" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Note</label>
                                                <asp:TextBox runat="server" ID="TxtNote" ClientIDMode="Static" TextMode="MultiLine" Rows="2" CssClass="form-control form--control style-two"></asp:TextBox>
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
                <div class="modal custom--modal fade show" id="PurchaseModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle1">Trasferimento Crediti</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary1" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Salvataggio Fallito." Display="None"></asp:CustomValidator>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtCurrentBalance" class="form-label">Saldo</label>
                                                <asp:TextBox runat="server" ID="TxtCurrentBalance" ClientIDMode="Static" CssClass="form-control form--control style-two" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="TxtBalance" class="form-label">Deposito/Prelievo Importo</label>
                                                <asp:TextBox runat="server" ID="TxtBalance" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="TxtBalanceNote" class="form-label">Note</label>
                                                <asp:TextBox runat="server" ID="TxtBalanceNote" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="BtnSavePurchase" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer modal--footer">
                                <asp:Button runat="server" ID="BtnSavePurchase" ClientIDMode="Static" CssClass="btn btn--warning btn--md" Text="Deposita/Preleva" CausesValidation="false" OnClick="BtnSavePurchase_Click"/>
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
    <script>
        $(".btn-add").click(function () {
            $("#MasterModal").modal('show');
            $(".modal-title").text("AGGIUNGI MASTER");
            $("#HfMasterID").val("");
            $("#ValSummary").addClass("d-none");
            $("#TxtName").val("");
            $("#TxtSurname").val("");
            $("#TxtNickName").val("");
            $("#TxtMobile").val("");
            $("#TxtEmail").val("");
            $("#TxtNote").val("");
            $("#TxtPassword").val("");
            $("#TxtPasswordRepeat").val("");
            return false;
        });
    </script>
    <script>
        $(function () {
            var datatable = $('#master-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindMasters',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 20,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "data": "Name",
                }, {
                    "data": "NickName",
                }, {
                    "data": "Email",
                }, {
                    "data": "Mobile",
                }, {
                    "data": "Balance",
                    "render": function (data, type, row, meta) {
                        return "€ " + data;
                    }
                }, {
                    "data": "admin",
                }, {
                    "width": "25%",
                    "data": null,
                    "render": function (data, type, row, meta) {
                        return '<div class="justify-content-center">' +
                            '<i class="fa fa-edit mt-1 btn-edit" style="font-size:20px; padding-right: 10px; color:greenyellow"></i>' +
                            '<i class="fa fa-trash mt-1 btn-delete" style="font-size:20px; padding-right: 10px; color:red"></i>' +
                            '<i class="fa fa-money-check-alt btn-purchase mt-1" style="font-size:20px; padding-right: 10px;color:gold"></i>' +
                            '</div > ';
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchVal = $('#TxtSearch').val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#master-table_wrapper").css('width', '100%');
                },

                "drawCallback": function () {
                    $(".pagination").children('li').addClass("page-item");
                }
            });

            $('#TxtSearch').on('input', function () {
                datatable.fnDraw();
            });

            datatable.on('click', '.btn-edit', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                $("#MasterModal").modal('show');
                $(".modal-title").text("AGGIORNA MASTER");
                $("#HfMasterID").val(row.Id);
                $("#ValSummary").addClass("d-none");
                $("#TxtName").val(row.Name);
                $("#TxtSurname").val(row.Surname);
                $("#TxtNickName").val(row.NickName);
                $("#TxtMobile").val(row.Mobile);
                $("#TxtEmail").val(row.Email);
                $("#TxtNote").val(row.Note);
                $("#TxtPassword").val("");
                $("#TxtPasswordRepeat").val("");
            });

            datatable.on('click', '.btn-purchase', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                $("#PurchaseModal").modal('show');
                $(".modal-title").text("TRASFERIMENTO CREDITI");
                $("#HfMasterID").val(row.Id);
                $("#TxtCurrentBalance").val("€ " + row.Balance);
                $("#TxtBalance").val("");
                $("#TxtBalanceNote").val("");
                $("#ValSummary1").addClass("d-none");
            });

            datatable.on('click', '.btn-delete', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                if (!confirm("Click OK per cancellare."))
                    return;

                $.ajax({
                    type: "POST",
                    url: 'DataService.asmx/DeleteMaster',
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

            $("#BtnSavePurchase").click(function () {
                var amount = parseFloat($("#TxtBalance").val());
                var balance = parseFloat($("#HfAdminBalance").val());
                if ($("#HfAdminBalance").val() != "" && (amount) > (balance)) {
                    alert("Disponibilità non sufficiente a completare il trasferimento.");
                    return false;
                }
                else if (amount < 0 && Math.abs(amount) > $("#TxtCurrentBalance").val().substring(2)) {
                    alert("Fido non consentito.");
                    return false;
                }
                return true;
            });
        })
    </script>
</asp:Content>
