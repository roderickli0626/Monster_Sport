<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="SettingFeedback.aspx.cs" Inherits="MonsterSport.SettingFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') top;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Settings</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Reset Password & Feedback</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <div class="contact-section padding-top padding-bottom">
        <div class="container">
            <div class="contact-wrapper">
                <form class="contact-form" runat="server" id="form1" autocomplete="off">
                    <div class="row g-5 align-items-center">
                        <asp:ValidationSummary ID="ValSummary1" runat="server" CssClass="mt-3 mb-lg text-left bg-gradient" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ID="ReqValTitle" runat="server" ErrorMessage="Scrivere il Titolo." CssClass="text-black" ControlToValidate="TxtTitle" Display="None"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="ReqValDescription" runat="server" ErrorMessage="Scrivere il Descrizione." CssClass="text-black" ControlToValidate="TxtDescription" Display="None"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="ServerValidator1" runat="server" ErrorMessage="Feedback inviato con successo." Display="None"></asp:CustomValidator>
                        <asp:CustomValidator ID="ServerValidator2" runat="server" ErrorMessage="Scrivere la password corretta.." Display="None"></asp:CustomValidator>
                        <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="La password attuale non è corretta" Display="None"></asp:CustomValidator>
                        <div class="col-lg-5">
                            <div class="contact-info-wrapper">
                                <h3 class="title mb-3 mb-lg-4">FEEDBACK</h3>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="TxtTitle" class="form-label">Title <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtTitle" CssClass="form-control form--control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <div class="form-group">
                                        <label for="TxtDescription" class="form-label">Description <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtDescription" CssClass="form-control form--control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="text-center col-12">
                                    <asp:Button runat="server" ID="BtnFeedback" CssClass="cmn--btn active w-100 btn--round" Text="Send Feedback" OnClick="BtnFeedback_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <h3 class="title mb-3">RESET PASSWORD</h3>
                            <div class="row gy-3">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="TxtCurrent" class="form-label">Current Password <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtCurrent" CssClass="form-control form--control" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="TxtPassword" class="form-label">New Password <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtPassword" CssClass="form-control form--control" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <div class="form-group">
                                        <label for="TxtConfirmPW" class="form-label">Confirm Password <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtConfirmPW" CssClass="form-control form--control" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="text-center col-12">
                                    <asp:Button runat="server" ID="BtnReset" CssClass="cmn--btn active w-100 btn--round" CausesValidation="false" Text="Reset Password" OnClick="BtnReset_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
