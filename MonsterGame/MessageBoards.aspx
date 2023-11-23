<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="MessageBoards.aspx.cs" Inherits="MonsterGame.MessageBoards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Bacheca Messaggi</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Bacheca Messaggi</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg); background-attachment: fixed;">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-5 col-xl-5 pt-1 d-flex">
                        <asp:DropDownList runat="server" ID="ComboStatus" CssClass="form-select form--control" ClientIDMode="Static" OnSelectedIndexChanged="ComboStatus_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
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
                                            <p class="invest-info">Quota ingresso: <span class="invest-amount">€ <%# Eval("Fee") %></span></p>
                                            <p class="invest-info">Player necessari: <span class="invest-amount"><%# Eval("MinPlayers") %></span></p>
                                            <p class="invest-info">Player attuali: <span class="invest-amount"><%# Eval("RealPlayers") %></span></p>
                                            <p class="invest-info">Numero squadre: <span class="invest-amount TeamShow" style="cursor: pointer;" data-id="<%# Eval("Id") %>" data-img="<%# Eval("Image2") %>"><%# Eval("NumberOfTeams") %></span></p>
                                            <p class="invest-info">Premio min.: <span class="invest-amount">€ <%# Eval("Prize") %></span></p>
                                            <p class="invest-info">Vincenti: <span class="invest-amount"><%# Eval("Winners") %></span></p>
                                            <div class="form-check form-switch mt-3" style="font-size: 22px;">
                                                <%# ((bool)Eval("AllowedBoard") == true ? "<input class=\"form-check-input board-allow\" type=\"checkbox\" style=\"float:inherit\" checked>" : "<input class=\"form-check-input board-allow\" type=\"checkbox\" style=\"float:inherit\" >") %>
                                                <label class="form-check-label" data-id="<%# Eval("Id") %>">Abilita </label>
                                            </div>
                                            <a class="cmn--btn active btn--md radius-1 mt-1" href="MessageBoardDetail.aspx?gameId=<%# Eval("Id") %>">Bacheca Torneo <%# Eval("Id") %></a>
                                        </div>
                                    </div>
                                </div>
                                <span class="id-mark top-0 mt-2 start-0 ms-4" style="z-index:2;"><%# Eval("Id") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
    <script>
        $(".board-allow").click(function () {
            var id = $($(this).next())[0].dataset.id;
            var checked = 0;
            if (this.checked) {
                checked = 1;
            }
            else
            {
                checked = 0;
            }
            $.ajax({
                type: "POST",
                url: 'DataService.asmx/UpdateBoardAllow',
                data: {
                    gameID: id,
                    allowed: checked,
                },
                success: function (res) {
                    // ??
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
