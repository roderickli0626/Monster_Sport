using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Model;
using MonsterGame.Common;
using MonsterGame.Util;

namespace MonsterSport
{
    public partial class AdminGame : System.Web.UI.Page
    {
        private User user;
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
                LoadStatus();
            }
        }

        private void LoadGames()
        {
            int status = ControlUtil.GetSelectedValue(ComboStatus) ?? 0;
            string search = TxtSearch.Text;
            GameController gameController = new GameController();
            List<GameCheck> list = gameController.FindAll(status, search);
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("ALL STATUS", "0"));
            ComboStatus.Items.Add(new ListItem("OPEN", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("STARTED", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("TEAMCHOICE", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SUSPENDED", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CLOSED", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("COMPLETED", ((int)GameStatus.COMPLETED).ToString()));
        }

        protected void ComboStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGames();
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            LoadGames();
        }
    }
}