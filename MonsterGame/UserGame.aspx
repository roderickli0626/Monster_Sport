<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="UserGame.aspx.cs" Inherits="MonsterGame.UserGame" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/CSS/datatables.css" />
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
        .my-card {
            background-color: greenyellow;
        }
    </style>
    <style>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium3.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Games</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Games</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg);">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-5 col-xl-5 pt-1">
                        <asp:DropDownList runat="server" ID="ComboStatus" CssClass="form-select form--control" ClientIDMode="Static" OnSelectedIndexChanged="ComboStatus_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <div class="col-lg-5 col-xl-5 pt-1">
                        <asp:TextBox runat="server" ID="TxtSearch" ClientIDMode="Static" CssClass="form--control form-control" placeholder="SEARCH"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-xl-2">
                        <asp:Button runat="server" ID="BtnSearch" CssClass="cmn--btn active radius-1 w-100" ClientIDMode="Static" Text="SEARCH" OnClick="BtnSearch_Click" />
                    </div>
                </div>
                <asp:ScriptManager runat="server" ID="ScriptManager"></asp:ScriptManager>
                <asp:UpdatePanel runat="server" ID="UpdatePanel" class="row gy-4 justify-content-center">
                    <ContentTemplate>
                        <asp:Repeater runat="server" ID="RepeaterGame">
                            <ItemTemplate>
                                <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                                    <div class="game-item">
                                        <div class="game-inner">
                                            <div class="game-item__thumb">
                                                <%# Eval("Mark") %>
                                                <img src="Content/Images/<%# Eval("Image") %>" alt="game">
                                            </div>
                                            <div class="game-item__content">
                                                <h4 class="title"><%# Eval("Title") %></h4>
                                                <p class="invest-info">Invest Limit: <span class="invest-amount">$<%# Eval("Fee") %></span></p>
                                                <p class="invest-info">Min Players: <span class="invest-amount"><%# Eval("MinPlayers") %></span></p>
                                                <p class="invest-info">Reached Players: <span class="invest-amount"><%# Eval("RealPlayers") %></span></p>
                                                <p class="invest-info">Prize Pool: <span class="invest-amount"><%# Eval("Prize") %></span></p>
                                                <a class="cmn--btn active btn--md radius-1" href="UserGameDetail.aspx?gameId=<%# Eval("Id") %>"><%# Eval("ButtonTitle") %></a>
                                            </div>
                                        </div>
                                        <div class="ball <%# Eval("MyMark") %>"></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ComboStatus" />
                        <asp:AsyncPostBackTrigger ControlID="BtnSearch" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="row gy-4 justify-content-center mt-5" runat="server" id="AllGameDiv">
                    <table class="table text-center" id="game-table">
                        <thead>
                            <tr>
                                <th>Game</th>
                                <th>Title</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Teams</th>
                                <th>Fee</th>
                                <th>Players</th>
                                <th>Prize</th>
                                <th>Action</th>
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
    <script src="Scripts/jquery.signalR-2.4.3.js"></script>
    <script src="signalr/hubs"></script>
    <script>
        var proxy = $.connection.notificationHub;

        proxy.client.receiveStartGameNotification = function (message) {
            alert(message);
            window.location.reload();
        };

        $.connection.hub.start();
    </script>
    <script>
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
                    return '<div class="game-table-item"><div class="game-item__thumb mb-0">' + row.Mark +
                        '<img src="Content/Images/' + row.Image + '" alt = "game"></div></div>';
                }
            }, {
                "data": "Title",
            }, {
                "data": "StartDate",
            }, {
                "data": "EndDate",
            }, {
                "data": "NumberOfTeams",
            }, {
                "data": "Fee",
            }, {
                "data": "RealPlayers",
            }, {
                "data": "Prize",
            }, {
                "data": null,
                "render": function (data, type, row, meta) {
                    return '<div class="justify-content-center">' +
                        '<a class="cmn--btn active btn--md radius-1 w-100 mt-1" href="UserGameDetail.aspx?gameId=' + row.Id + '">Detail</a>' +
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

        $("#BtnSearch").click(function () {
            datatable.fnDraw();
        });
    </script>
</asp:Content>
