<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="PaymentCancel.aspx.cs" Inherits="MonsterGame.PaymentCancel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section class="inner-banner bg_img" style="background: url('Content/Images/stadium2.jpg') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6 text-center">
                    <h2 class="title text-white">Pagamento Cancellato</h2>
                    <ul class="breadcrumbs d-flex flex-wrap align-items-center justify-content-center">
                        <li><a href="UserInfo.aspx">Informazioni</a></li>
                        <li>Pagamento Cancellato</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="game-section text-center">
        <div class="container">
            <form runat="server" id="form1" autocomplete="off">
                <h2>Pagamento Cancellato</h2>
            </form>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
