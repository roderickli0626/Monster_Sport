<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="MonsterGame.Notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
    <style>
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

        .hidden-input {
            position: absolute;
            width: 0px;
            height: 0px;
            overflow: hidden;
        }

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">News</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>News</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <asp:HiddenField ID="HfUserID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfNotificationID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfManage" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="HfNewsImage" runat="server" ClientIDMode="Static" />
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-4 col-xl-4 me-auto">
                        <button class="cmn--btn active radius-1 w-100 btn-add" runat="server" id="BtnAddNews">Aggiungi</button>
                    </div>
                    <div class="col-lg-4 col-xl-4 pt-1 ms-auto">
                        <asp:TextBox runat="server" ID="TxtSearch" CssClass="form--control form-control" ClientIDMode="Static" placeholder="CERCA.."></asp:TextBox>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
                    <table class="table text-center" id="news-table">
                        <thead>
                            <tr>
                                <th>Fase</th>
                                <th>Descrizione</th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal custom--modal fade show" id="NewsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" data-bs-backdrop="static" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark" id="modalTitle">News</h4>
                            </div>
                            <div class="modal-body modal--body">
                                <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel" ClientIDMode="Static" class="row gy-3">
                                    <ContentTemplate>
                                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="ReqValTitle" runat="server" ErrorMessage="Inserire un indirizzo Email." CssClass="text-bg-danger" ControlToValidate="TxtTitle" Display="None"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Questo indirizzo Email è già registrato." Display="None"></asp:CustomValidator>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="TxtTitle" class="form-label">Titolo</label>
                                                <asp:TextBox runat="server" ID="TxtTitle" ClientIDMode="Static" CssClass="form-control form--control style-two"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4">
                                            <div class="form-group">
                                                <label for="TxtNote" class="form-label">Photo</label>
                                                <img src="Content/Images/news.jpg" id="NewsImage" runat="server" clientidmode="Static" alt="service-image" class="img-thumbnail" style="height: 150px; width: 100%;" />
                                                <asp:FileUpload runat="server" ID="ImageFile" ClientIDMode="Static" CssClass="hidden-input" />
                                            </div> 
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="TxtDescription" class="form-label">Descrizione</label>
                                                <asp:TextBox runat="server" ID="TxtDescription" ClientIDMode="Static" TextMode="MultiLine" Rows="2" CssClass="form-control form--control style-two"></asp:TextBox>
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
                <div class=" modal custom--modal fade show" id="MessageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-modal="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content section-bg border-0">
                            <div class="modal-header modal--header bg--base">
                                <h4 class="modal-title text-dark">MESSAGGIO DALL' ADMIN</h4>
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
        var proxy = $.connection.notificationHub;

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
    </script>
    <script>
        $(".btn-add").click(function () {
            $("#NewsModal").modal('show');
            $(".modal-title").text("AGG. NEWS");
            $("#HfNotificationID").val("");
            $("#ValSummary").addClass("d-none");
            $("#TxtTitle").val("");
            $("#TxtDescription").val("");
            $("#NewsImage").attr('src', "Upload/News/news.jpg");
            return false;
        });
    </script>
    <script>
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoadedHandler);

        function pageLoadedHandler(sender, args) {
            // This function will be called after each UpdatePanel postback
            var updatedPanels = args.get_panelsUpdated();

            for (var i = 0; i < updatedPanels.length; i++) {
                var updatePanelID = updatedPanels[i].id;

                if (updatePanelID === "UpdatePanel") {
                    ImageSetting();
                }
            }
        };

        ImageSetting();
        function ImageSetting() {
            $("#ImageFile").change(function () {
                readURL(this, '#NewsImage', "#HfNewsImage");
            });

            $("#NewsImage").click(function () {
                $("#ImageFile").click();
            });
        }

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
    <script>
        $(function () {
            var datatable = $('#news-table').dataTable({
                "serverSide": true,
                "ajax": 'DataService.asmx/FindNews',
                "dom": '<"table-responsive"t>pr',
                "autoWidth": false,
                "pageLength": 20,
                "processing": true,
                "ordering": false,
                "columns": [{
                    "class": "NewsImage",
                    "render": function (data, type, row, meta) {
                        return '<div class="game-table-item"><div class="game-item__thumb mb-0">' + 
                            '<img src="Upload/News/' + ((row.Image == null || row.Image == "") ? "news.jpg" : row.Image) + '" alt = "news"></div></div>';
                    }
                }, {
                    "class": "position-relative",
                    "render": function (data, type, row, meta) {
                        if (row.IsNew) {
                            return '<div class="p-3">' + '<div class="ribbon red"><span>NEW</span></div>' +
                                '<h3>' + row.Title + '</h3><p>' + row.Description + '</p><span class="bg-primary mb-2 float-end radius-5">' + row.CreateDate + '</span>'
                            '</div>';
                        }
                        else {
                            return '<div class="p-3">' + 
                                '<h3>' + row.Title + '</h3><p>' + row.Description + '</p><span class="bg-primary mb-2 float-end radius-5">' + row.CreateDate + '</span>'
                            '</div>';
                        }
                    }
                }, {
                    "width": "15%",
                    "data": null,
                    "render": function (data, type, row, meta) {
                        var manage = $("#HfManage").val();
                        if (manage == "true") {
                            return '<div class="justify-content-center">' +
                                '<button class="cmn--btn active btn--md radius-1 btn--success w-100 mt-1 btn-edit float-start">Edit</button>' +
                                '<button class="cmn--btn active btn--md radius-1 btn--danger w-100 mt-1 btn-delete float-end">Cancella</button>' +
                                '</div > ';
                        }
                        else {
                            return '<div class="justify-content-center">' +
                                '<button class="cmn--btn active btn--md radius-1 btn-view">Vedi</button></div>';
                        }
                    }
                }],

                "fnServerParams": function (aoData) {
                    aoData.searchVal = $('#TxtSearch').val();
                },

                "rowCallback": function (row, data, index) {
                    $(row).find('td').css({ 'vertical-align': 'middle' });
                    $("#news-table_wrapper").css('width', '100%');
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

                $("#NewsModal").modal('show');
                $(".modal-title").text("AGGIORNA NEWS");
                $("#HfNotificationID").val(row.Id);
                $("#ValSummary").addClass("d-none");
                $("#TxtTitle").val(row.Title);
                $("#TxtDescription").val(row.Description);
                $("#NewsImage").attr('src', "Upload/News/" + (row.Image ? row.Image : "news.jpg"));
            });

            datatable.on('click', '.btn-view', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                $.ajax({
                    type: "POST",
                    url: 'DataService.asmx/UpdateNews',
                    data: {
                        id: row.Id
                    },
                    success: function () {
                        onSuccess({ success: true });
                        $("#NewsModal").modal('show');
                        $(".modal-title").text("VEDI NEWS");
                        $("#HfNotificationID").val(row.Id);
                        $("#ValSummary").addClass("d-none");
                        $("#TxtTitle").val(row.Title);
                        $("#TxtDescription").val(row.Description);
                        $("#NewsImage").attr('src', "Upload/News/" + (row.Image ? row.Image : "news.jpg"));
                    }
                }).error(function () {
                    onSuccess({ success: false });
                });
            });

            datatable.on('click', '.btn-delete', function (e) {
                e.preventDefault();

                var row = datatable.fnGetData($(this).closest('tr'));

                if (!confirm("Click OK per cancellare."))
                    return;

                $.ajax({
                    type: "POST",
                    url: 'DataService.asmx/DeleteNews',
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

            datatable.on('click', '.NewsImage', function (e) {
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
