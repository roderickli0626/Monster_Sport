﻿using Microsoft.AspNet.SignalR;
using MonsterGame.Common;
using MonsterGame.Controller;
using MonsterGame.Util;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MonsterGame
{
    public partial class Notifications : System.Web.UI.Page
    {
        private User admin;
        private LoginController loginSystem = new LoginController();
        private ExtraController extraController = new ExtraController();
        protected void Page_Load(object sender, EventArgs e)
        {
            admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            HfUserID.Value = (admin?.Id ?? 0).ToString();
            if (!IsPostBack)
            {
                if (loginSystem.IsSuperAdminLoggedIn())
                {
                    HfManage.Value = "true";
                }
                else
                {
                    HfManage.Value = "false";
                    BtnSave.Visible = false;
                    BtnAddNews.Visible = false;
                }
            }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string title = TxtTitle.Text;
            string description = TxtDescription.Text;

            //Image Save
            string imageTitle = UploadImage(HfNewsImage);

            int? notificationID = ParseUtil.TryParseInt(HfNotificationID.Value);

            bool success = extraController.SaveNews(notificationID, title, description, imageTitle);
            if (success)
            {
                // Send Notification to All Users
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                hubContext.Clients.All.receiveNewsAddMessage("News Added!");

                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }

        private string UploadImage(HiddenField hiddenField)
        {
            string base64String = hiddenField.Value;
            if (string.IsNullOrEmpty(base64String)) return "";
            // Extract the file extension from the Base64 string
            // Extract image format and data from the Base64 string
            string[] base64Data = base64String.Split(',');
            string imageFormat = base64Data[0].Split('/')[1].Split(';')[0];
            byte[] imageData = Convert.FromBase64String(base64Data[1]);

            // Generate a unique filename
            string filename = Guid.NewGuid().ToString() + "." + imageFormat;

            // Save the byte array as an image to a specific folder
            string path = Server.MapPath("~/Upload/News/" + filename);
            File.WriteAllBytes(path, imageData);

            return filename;
        }
    }
}