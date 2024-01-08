<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="MonsterGame.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') top;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Contatti</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="Dashboard.aspx">Dashboard</a></li>
                        <li>Contatti</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Section Starts Here -->
    <div class="contact-section padding-top padding-bottom">
        <div class="container">
            <div class="contact-wrapper">
                <div class="row g-5 align-items-center">
                    <div class="col-lg-5">
                        <div class="contact-info-wrapper">
                            <h3 class="title mb-3 mb-lg-4">Contatti</h3>
                            <ul class="contact-info-list m-0">
                                <li><a href="#"></a> <i class="las la-map-marker-alt"></i> <span>CDN - Via G. Porzio, 6/A - 80121 Napoli (NA)</span></li>
                                <li><a href="#"> <i class="las la-phone-volume"></i> <span>(+39)-0815541943</span></a></li>
                                <li><a href="#"> <i class="las la-phone-volume"></i> <span>(+39)-3386958521</span></a></li>
                                <li><a href="#"> <i class="las la-envelope"></i> <span>info@FantaGame365.it</span></a></li>
                                <li><a href="#"> <i class="las la-envelope"></i> <span>support@FantaGame365.it</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <form class="contact-form" runat="server" id="form1" autocomplete="off">
                            <h3 class="title mb-3">Lascia il tuo commento</h3>
                            <div class="row gy-3">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="fname" class="form-label">Nome <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtName" CssClass="form-control form--control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email" class="form-label">Email <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtEmail" CssClass="form-control form--control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="phone" class="form-label">Numbero Cellulare <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtPhone" CssClass="form-control form--control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <div class="form-group">
                                        <label for="msg" class="form-label">Messaggio <span class="text--danger">*</span></label>
                                        <asp:TextBox runat="server" ID="TxtMessage" CssClass="form-control form--control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="text-center col-12">
                                    <asp:Button runat="server" ID="BtnSend" CssClass="cmn--btn active w-100 btn--round" Text="Invia Messaggio" OnClick="BtnSend_Click" />
                                </div>

                                <asp:ValidationSummary ID="ValSummary" runat="server" CssClass="mt-lg mb-lg text-left bg-gradient" ClientIDMode="Static" />
                                <asp:RequiredFieldValidator ID="ReqValName" runat="server" ErrorMessage="Inserire un indirizzo Name." CssClass="text-bg-danger" ControlToValidate="TxtName" Display="None"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="ReqValPhone" runat="server" ErrorMessage="Inserire un indirizzo Phone." CssClass="text-bg-danger" ControlToValidate="TxtPhone" Display="None"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="ReqValEmail" runat="server" ErrorMessage="Inserire un indirizzo Email." CssClass="text-bg-danger" ControlToValidate="TxtEmail" Display="None"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="ReqValMessage" runat="server" ErrorMessage="Scrivere il Messaggio." CssClass="text-black" ControlToValidate="TxtMessage" Display="None"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="ServerValidator" runat="server" ErrorMessage="Messaggio inviato con successo." Display="None"></asp:CustomValidator>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact Section Ends Here -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
