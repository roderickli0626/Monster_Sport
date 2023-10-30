<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Policy.aspx.cs" Inherits="MonsterSport.Policy" %>
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
                        <li>Policy</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <!-- Privacy Policy Section Starts Here -->
    <section class="privacy-policy padding-top padding-bottom">
        <div class="container">
            <div class="row gy-5">
                <div class="col-lg-3">
                    <ul class="privacy-policy-sidebar-menu">
                        <li>
                            <a href="#overview" class="active nav-link">Overview</a>
                        </li>
                        <li>
                            <a href="#data-collection" class="nav-link">Data Collection & Use</a>
                        </li>
                        <li>
                            <a href="#cookies" class="nav-link">Cookies Data</a>
                        </li>
                        <li>
                            <a href="#data-security" class="nav-link">Data Security</a>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-9">
                    <div class="privacy-policy-content">
                        <div class="content-item">
                            <h4 class="title" id="overview">Overview</h4>
                            <p>
                                This is Overview Part.
                            </p>
                        </div>
                        <div class="content-item">
                            <h4 class="title" id="data-collection">Data Collection & Use</h4>
                            <p>
                                This is Data Collection & Use Part.
                            </p>
                            <ul class="info-list">
                                <li>Information 1</li>
                                <li>Information 2</li>
                                <li>Information 3</li>
                            </ul>
                        </div>
                        <div class="content-item">
                            <h4 class="title" id="cookies">Cookies Data</h4>
                            <p>
                                This is Cookies Data Part.
                            </p>
                        </div>
                        <div class="content-item">
                            <h4 class="title" id="data-security">Data Security</h4>
                            <p>
                                This is Data Security Part.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Privacy Policy Section Ends Here -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterPlaceHolder" runat="server">
</asp:Content>
