using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Model;
using MonsterGame.Util;

namespace MonsterGame
{
    public partial class MessageBoard : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user == null || !loginSystem.IsUserLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadGames();
            }
        }
        private void LoadGames()
        {
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindUserGames(user.Id).Where(g => g.AllowedBoard).ToList();
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
    }
}