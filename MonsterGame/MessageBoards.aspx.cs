using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Model;

namespace MonsterGame
{
    public partial class MessageBoards : System.Web.UI.Page
    {
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!loginSystem.IsSuperAdminLoggedIn())
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
            List<GameCheck> list = gameController.FindAll(0, "", 0).ToList();
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
    }
}