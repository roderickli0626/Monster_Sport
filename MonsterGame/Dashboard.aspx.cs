using MonsterGame.Controller;
using MonsterGame.DAO;
using MonsterGame.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
            user = loginSystem.GetCurrentUserAccount();
            if (user != null || loginSystem.IsSuperAdminLoggedIn())
            {
                InDiv.Visible = false;
            }
            else
            {
                OutDiv.Visible = false;
            }

            if (!IsPostBack)
            {
                LoadGames();
            }
        }

        private void LoadGames()
        {
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindAll();
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
    }
}