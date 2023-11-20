using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Common;
using MonsterGame.Util;
using PayPal.Api;

namespace MonsterSport
{
    public partial class MessageBoardDetail : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        private ExtraController extraController = new ExtraController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (user == null || !loginSystem.IsUserLoggedIn()))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int gameID = ParseUtil.TryParseInt(Request.Params["gameId"]) ?? 0;
            HfGameID.Value = gameID.ToString();

            if (!IsPostBack)
            {
                if (loginSystem.IsSuperAdminLoggedIn())
                {
                    HfManage.Value = "true";
                    liUserBoard.Visible = false;
                }
                else
                {
                    HfManage.Value = "false";
                    liAdminBoard.Visible = false;
                }
            }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string title = TxtTitle.Text;
            string description = TxtDescription.Text;

            int? boardID = ParseUtil.TryParseInt(HfMessageBoardID.Value);
            int? gameID = ParseUtil.TryParseInt(HfGameID.Value);
            int userID = (user == null ? 0 : user.Id);

            bool success = extraController.SaveBoard(boardID, gameID, userID, title, description);
            if (success)
            {
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }

        }
    }
}