<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MonsterGame.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') top;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Register</h2>
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
                            <h3 class="pt-3 me-auto"><strong class="text-warning">Monster</strong> Game</h3>
                        </a>
                    </div>
                    <form runat="server" id="form1" class="account__form form row g-4" autocomplete="off">
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="TxtName" class="input-pre-icon"><i class="las la-user"></i></div>
                                <asp:TextBox runat="server" ID="TxtName" CssClass="form--control form-control style--two" placeholder="Name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="lname" class="input-pre-icon"><i class="las la-user"></i></div>
                                <asp:TextBox runat="server" ID="TxtSurname" CssClass="form--control form-control style--two" placeholder="Surname"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="lname" class="input-pre-icon"><i class="las la-user"></i></div>
                                <asp:TextBox runat="server" ID="TxtNickname" CssClass="form--control form-control style--two" placeholder="Nickname"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="email" class="input-pre-icon"><i class="las la-phone"></i></div>
                                <asp:TextBox runat="server" ID="TxtMobile" CssClass="form--control form-control style--two" TextMode="Phone" placeholder="Mobile"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-12 col-md-12">
                            <div class="form-group">
                                <div for="email" class="input-pre-icon"><i class="las la-envelope"></i></div>
                                <asp:TextBox runat="server" ID="TxtEmail" CssClass="form--control form-control style--two" TextMode="Email" placeholder="Email"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <asp:TextBox runat="server" ID="TxtPassword" CssClass="form--control form-control style--two" TextMode="Password" placeholder="Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-6 col-md-6">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <asp:TextBox runat="server" ID="TxtPasswordRepeat" CssClass="form--control form-control style--two" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-12 col-md-12">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-book"></i></div>
                                <asp:TextBox runat="server" ID="TxtNote" CssClass="form--control form-control style--two" placeholder="Note"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <asp:Button runat="server" ID="BtnRegister" CssClass="cmn--btn active w-100 btn--round" Text="Register" OnClick="BtnRegister_Click" />
                            </div>
                        </div>

                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ID="ReqValEmail" runat="server" ErrorMessage="Inserire un indirizzo Email." CssClass="text-bg-danger" ControlToValidate="TxtEmail" Display="None"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="ReqValPassword" runat="server" ErrorMessage="Inserire una Password." CssClass="text-black" ControlToValidate="TxtPassword" Display="None"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="PasswordValidator" runat="server" ErrorMessage="Le Password non corrispondono." Display="None"></asp:CustomValidator>
                        <asp:CustomValidator ID="EmailValidator" runat="server" ErrorMessage="Email non è corretta." Display="None"></asp:CustomValidator>
                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Questo indirizzo Email è già registrato." Display="None"></asp:CustomValidator>
                    </form>
                </div>
                <div class="account__content__wrapper" >
                    <div class="content text-center text-white">
                        <h3 class="title text--base mb-4">Welcome to Monster Game</h3>
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
