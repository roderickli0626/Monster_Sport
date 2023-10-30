<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MonsterSport.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') top;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Sign In</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Log In</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="account-section overflow-hidden bg_img" style="background: url(Content/Images/loginbg.jpg)">
        <div class="container">
            <div class="account__main__wrapper">
                <div class="account__form__wrapper">
                    <div class="logo">
                        <a href="Dashboard.aspx" class="d-flex">
                            <img src="Content/Images/Logo.png" alt="logo" class="ms-auto">
                            <h3 class="pt-3 me-auto"><strong class="text-warning">Monster</strong> Sport</h3>
                        </a>
                    </div>
                    <form class="account__form form row g-4">
                        <div class="col-12">
                            <div class="form-group">
                                <div for="username" class="input-pre-icon"><i class="las la-user"></i></div>
                                <input id="username" type="text" class="form--control form-control style--two" placeholder="Username" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <input id="pass" type="password" class="form--control form-control style--two" placeholder="Password" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <button class="cmn--btn active w-100 btn--round" type="submit">Log In</button>
                            </div>
                        </div>
                        <div class="d-flex flex-wrap flex-sm-nowrap justify-content-between mt-5">
                            <a href="ForgotPassword.aspx" class="forgot-pass d-block text--base mx-auto">Forgot Password ?</a>
                        </div>
                    </form>
                </div>
                <div class="account__content__wrapper">
                    <div class="content text-center text-white">
                        <h3 class="title text--base mb-4">Welcome to Monster Sport</h3>
                        <p class="">Sign in your Account. Atque, fuga sapiente, doloribus qui enim tempora?</p>
                        <p class="account-switch mt-4">Don't have an Account yet ? <a class="text--base ms-2" href="Register.aspx">Register</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
