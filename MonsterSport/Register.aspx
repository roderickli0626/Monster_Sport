<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MonsterSport.Register" %>
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
                        <li>Register</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <!-- Account Section Starts Here -->
    <section class="account-section overflow-hidden bg_img" style="background:url(Content/Images/registerbg.jpg)">
        <div class="container">
            <div class="account__main__wrapper">
                <div class="account__form__wrapper sign-up">
                    <div class="logo">
                        <a href="Dashboard.aspx" class="d-flex">
                            <img src="Content/Images/Logo.png" alt="logo" class="ms-auto">
                            <h3 class="pt-3 me-auto"><strong class="text-warning">Monster</strong> Sport</h3>
                        </a>
                    </div>
                    <form runat="server" id="form1" class="account__form form row g-4">
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="fname" class="input-pre-icon"><i class="las la-user"></i></div>
                                <input id="fname" type="text" class="form--control form-control style--two" placeholder="Name" required>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="lname" class="input-pre-icon"><i class="las la-user"></i></div>
                                <input id="lname" type="text" class="form--control form-control style--two" placeholder="Surname" required>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="lname" class="input-pre-icon"><i class="las la-user"></i></div>
                                <input id="Nname" type="text" class="form--control form-control style--two" placeholder="Nickname" required>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="input-group">
                                <span class="input-group-text text--base style--two">+80</span>
                                <input type="text" class="form--control form-control style--two" placeholder="Mobile">
                            </div>
                        </div>
                        <div class="col-xl-12 col-md-12">
                            <div class="form-group">
                                <div for="email" class="input-pre-icon"><i class="las la-envelope"></i></div>
                                <input id="email" type="email" class="form--control form-control style--two" placeholder="Email" required>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <input id="pass" type="password" class="form--control form-control style--two" placeholder="Password" required>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <input id="pass" type="password" class="form--control form-control style--two" placeholder="Confirm Password" required>
                            </div>
                        </div>
                        <div class="col-xl-12 col-md-12">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-book"></i></div>
                                <input id="pass" type="password" class="form--control form-control style--two" placeholder="Note" required>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <button class="cmn--btn active w-100 btn--round" type="submit">Register</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="account__content__wrapper" >
                    <div class="content text-center text-white">
                        <h3 class="title text--base mb-4">Welcome to Monster Sport</h3>
                        <p class="">Sign in your Account. Atque, fuga sapiente, doloribus qui enim tempora?</p>
                        <p class="account-switch mt-4">Already have an Account ? <a class="text--base ms-2" href="Login.aspx">Log In</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Account Section Ends Here -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
