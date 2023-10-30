<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="MonsterSport.Contact" %>
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
                        <li>Contact</li>
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
                            <h3 class="title mb-3 mb-lg-4">Contact Information</h3>
                            <ul class="contact-info-list m-0">
                                <li><a href="#"></a> <i class="las la-map-marker-alt"></i> <span>12/A Kingfisher Road <br> Medino Washington, NY 10012, USA</span></li>
                                <li><a href="#"> <i class="las la-phone-volume"></i> <span>+47 8519-9415 1515</span>a</a></li>
                                <li><a href="#"> <i class="las la-phone-volume"></i> <span>+47 8519-9415 1515</span>a</a></li>
                                <li><a href="#"> <i class="las la-envelope"></i> <span><span class="__cf_email__" data-cfemail="73071600070600160133141e121a1f5d101c1e">[email&#160;protected]</span></span></a></li>
                                <li><a href="#"> <i class="las la-envelope"></i> <span><span class="__cf_email__" data-cfemail="bacedfc9cecfc9dfc8faddd7dbd3d694d9d5d7">[email&#160;protected]</span></span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <form class="contact-form">
                            <h3 class="title mb-3">Get In Touch</h3>
                            <div class="row gy-3">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="fname" class="form-label">First Name <span class="text--danger">*</span></label>
                                        <input id="fname" type="text" class="form-control form--control"></input>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lname" class="form-label">Last Name <span class="text--danger">*</span></label>
                                        <input id="lname" type="text" class="form-control form--control"></input>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email" class="form-label">Email Address <span class="text--danger">*</span></label>
                                        <input id="email" type="text" class="form-control form--control"></input>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone" class="form-label">Phone Number <span class="text--danger">*</span></label>
                                        <input id="phone" type="text" class="form-control form--control"></input>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="msg" class="form-label">Your Message <span class="text--danger">*</span></label>
                                        <textarea id="msg" class="form-control form--control"></textarea>
                                    </div>
                                </div>
                                <div class="col">
                                    <button class="cmn--btn active">Send Message</button>
                                </div>
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
