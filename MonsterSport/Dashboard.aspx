<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MonsterSport.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark1.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game01</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark2.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game02</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark3.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game03</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark4.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game04</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark1.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game05</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark2.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game06</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark3.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game07</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6 col-sm-6">
                        <div class="game-item">
                            <div class="game-inner">
                                <div class="game-item__thumb">
                                    <img src="Content/Images/gamemark4.png" alt="game">
                                </div>
                                <div class="game-item__content">
                                    <h4 class="title">Game08</h4>
                                    <p class="invest-info">Invest Limit</p>
                                    <p class="invest-amount">$10.49 - $1,000</p>
                                    <a href="#0" class="cmn--btn active btn--md radius-0">Play Now</a>
                                </div>
                            </div>
                            <div class="ball"></div>
                        </div>
                    </div>
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
