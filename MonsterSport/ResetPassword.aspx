<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="MonsterSport.ResetPassword" %>
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
                        <li>Reset Password</li>
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
                    <form class="account__form form row g-4" runat="server" id="form1" autocomplete="off">
                        <div class="col-12">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <asp:TextBox runat="server" ID="TxtPassword" CssClass="form--control form-control style--two" TextMode="Password" placeholder="Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <div for="pass" class="input-pre-icon"><i class="las la-lock"></i></div>
                                <asp:TextBox runat="server" ID="TxtRepeatPW" CssClass="form--control form-control style--two" TextMode="Password" placeholder="Repeat Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <asp:Button runat="server" ID="ResetPW" CssClass="cmn--btn active w-100 btn--round" Text="Reset Password" OnClick="ResetPW_Click" />
                            </div>
                        </div>

                        <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ID="ReqValPassword" runat="server" ErrorMessage="Inserire la password." CssClass="text-black" ControlToValidate="TxtPassword" Display="None"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Password errata." Display="None"></asp:CustomValidator>
                    </form>
                </div>
                <div class="account__content__wrapper">
                    <div class="content text-center text-white">
                        <h3 class="title text--base mb-4">Reset Password</h3>
                        <p class="">Did you forget your password? Please reset your password.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
