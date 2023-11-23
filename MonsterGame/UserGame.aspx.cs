using MonsterGame.Controller;
using MonsterGame.Model;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Common;
using MonsterGame.Util;
using MonsterGame.DAO;

namespace MonsterGame
{
    public partial class UserGame : System.Web.UI.Page
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
            HfUserID.Value = user.Id.ToString();
            HfNewMsg.Value = new NotificationDAO().FindAll().Where(n => n.IsNew ?? false).Count().ToString();
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
            List<GameCheck> list = gameController.FindAll(status, search, user.Id);
            RepeaterGame.DataSource = list;
            RepeaterGame.DataBind();
        }
        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("TUTTI", "0"));
            ComboStatus.Items.Add(new ListItem("APERTI", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("INIZIATI", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SOSPESI", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CHIUSI", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("COMPLETATI", ((int)GameStatus.COMPLETED).ToString()));
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