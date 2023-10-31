<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MonsterGame.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <!-- Banner Section Starts Here -->
    <section class="banner-section bg_img overflow-hidden" style="background:url(Content/Images/stadium1.jpg) center">
        <div class="container">
            <div class="banner-wrapper d-flex flex-wrap align-items-center">
                <div class="banner-content">
                    <h1 class="banner-content__title">Play <span class="text--base">Monster Sport</span> & Win Money Unlimited</h1>
                    <p class="banner-content__subtitle">PLAY MONSTER AND EARN CRYPTO IN ONLINE. THE ULTIMATE ONLINE CASINO PLATFORM.</p>
                    <div class="button-wrapper" runat="server" id="InDiv">
                        <a href="Login.aspx" class="cmn--btn active btn--lg">Log In</a>
                        <a href="Register.aspx" class="cmn--btn btn--lg">Register</a>
                    </div>
                    <div class="button-wrapper" runat="server" id="OutDiv">
                        <a href="Login.aspx" class="cmn--btn active btn--lg">Log Out</a>
                    </div>
                    <img src="Content/Images/thumb.png" alt="" class="shape1">
                </div>
                <div class="banner-thumb">
                    <div class="carousel slide" data-bs-ride="carousel" style="width:750px;">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="Content/Images/slide1.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide2.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide3.png" class="d-block" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Content/Images/slide4.png" class="d-block" alt="...">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner Section Ends Here -->

    <!-- Game Section Starts Here -->
    <section class="game-section padding-top padding-bottom bg_img" style="background: url(Content/Images/gamebg.jpeg);">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-xl-5">
                        <div class="section-header text-center">
                            <h2 class="section-header__title">Top Awesome Games</h2>
                            <p>A monster sport is a game to get cashes from predicting winner in football matches.</p>
                        </div>
                    </div>
                </div>
                <div class="row gy-4 justify-content-center">
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
                                            <p class="invest-info">Invest Limit</p>
                                            <p class="invest-amount">$<%# Eval("Fee") %></p>
                                            <a href="DashboardDetails.aspx?gameId=<%# Eval("Id") %>" class="cmn--btn active btn--md radius-1">Details</a>
                                        </div>
                                    </div>
                                    <div class="ball"></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </form>
        </div>
    </section>
    <!-- Game Section Ends Here -->

    <!-- How Section Starts Here -->
    <section class="how-section padding-top padding-bottom bg_img" style="background: url(Content/Images/playbg.png);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="section-header text-center">
                        <h2 class="section-header__title">How to Play Game</h2>
                        <p>A monster sport is a game to get cashes from predicting winner in football matches.</p>
                    </div>
                </div>
            </div>
            <div class="row gy-4 justify-content-center">
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-user-plus"></i>
                            <div class="badge badge--lg badge--round radius-50">01</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Sign Up First & Login</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-id-card"></i>
                            <div class="badge badge--lg badge--round radius-50">02</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Purchase Your Balance</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="how-item">
                        <div class="how-item__thumb">
                            <i class="las la-dice"></i>
                            <div class="badge badge--lg badge--round radius-50">03</div>
                        </div>
                        <div class="how-item__content">
                            <h4 class="title">Choose a Game & Play</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- How Section Ends Here -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
