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
using MonsterGame.DAO;
using PayPal.Api;
using System.IO;

namespace MonsterGame
{
    public partial class AdminGame : System.Web.UI.Page
    {
        private User user;
        private LoginController loginSystem = new LoginController();
        private GameController gameController = new GameController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!loginSystem.IsSuperAdminLoggedIn()) 
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                //LoadGames();
                LoadStatus();
                LoadTeams();
            }
        }
        private void LoadTeams()
        {
            List<Team> teams = new TeamDAO().FindAll().OrderBy(t => t.Description).ToList();
            List<TeamCheck> checks = new List<TeamCheck>();
            foreach (Team t in teams)
            {
                TeamCheck check = new TeamCheck(t);
                checks.Add(check);
            }
            ControlUtil.DataBind(ComboTeams, checks, "Id", "Description");
        }

        private void LoadStatus()
        {
            ComboStatus.Items.Clear();
            ComboStatus.Items.Add(new ListItem("TUTTI ...", "0"));
            ComboStatus.Items.Add(new ListItem("APERTO", ((int)GameStatus.OPEN).ToString()));
            ComboStatus.Items.Add(new ListItem("INIZIATO", ((int)GameStatus.STARTED).ToString()));
            ComboStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboStatus.Items.Add(new ListItem("SOSPESO", ((int)GameStatus.SUSPENDED).ToString()));
            ComboStatus.Items.Add(new ListItem("CHIUSO", ((int)GameStatus.CLOSED).ToString()));
            ComboStatus.Items.Add(new ListItem("TERMINATO", ((int)GameStatus.COMPLETED).ToString()));
            ComboModalStatus.Items.Clear();
            ComboModalStatus.Items.Add(new ListItem("APERTO", ((int)GameStatus.OPEN).ToString()));
            ComboModalStatus.Items.Add(new ListItem("INIZIATO", ((int)GameStatus.STARTED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("SCELTA TEAM", ((int)GameStatus.TEAMCHOICE).ToString()));
            ComboModalStatus.Items.Add(new ListItem("SOSPESO", ((int)GameStatus.SUSPENDED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("CHIUSO", ((int)GameStatus.CLOSED).ToString()));
            ComboModalStatus.Items.Add(new ListItem("TERMINATO", ((int)GameStatus.COMPLETED).ToString()));
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) { return; }
            string title = TxtTitle.Text;
            DateTime? sdate = ParseUtil.TryParseDate(TxtStartDate.Text, "dd/MM/yyyy HH.mm");
            DateTime? edate = ParseUtil.TryParseDate(TxtEndDate.Text, "dd/MM/yyyy HH.mm");
            double fee = ParseUtil.TryParseDouble(TxtFee.Text) ?? 0;
            double tax = ParseUtil.TryParseDouble(TxtTax.Text) ?? 0;
            int status = ControlUtil.GetSelectedValue(ComboModalStatus) ?? (int)GameStatus.OPEN;
            int minPlayers = ParseUtil.TryParseInt(TxtMinPlayers.Text) ?? 0;
            int teamNum = ParseUtil.TryParseInt(TxtTeamNum.Text) ?? 0;
            string note = TxtNote.Text;
            double percent1 = ParseUtil.TryParseDouble(TxtPercent1.Text) ?? 0;
            double percent2 = ParseUtil.TryParseDouble(TxtPercent2.Text) ?? 0;
            double percent3 = ParseUtil.TryParseDouble(TxtPercent3.Text) ?? 0;
            double percent4 = ParseUtil.TryParseDouble(TxtPercent4.Text) ?? 0;
            double percent5 = ParseUtil.TryParseDouble(TxtPercent5.Text) ?? 0;
            int NumOfWinners = ParseUtil.TryParseInt(TxtWinners.Text) ?? 0;

            bool WinnerValid = false;
            if (NumOfWinners == 1 && percent1 > 0 && percent2 == 0 && percent3 == 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 2 && percent1 > 0 && percent2 > 0 && percent3 == 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 3 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 == 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 4 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 > 0 && percent5 == 0) WinnerValid = true;
            else if (NumOfWinners == 5 && percent1 > 0 && percent2 > 0 && percent3 > 0 && percent4 > 0 && percent5 > 0) WinnerValid = true;
            else if (NumOfWinners > 5) WinnerValid = true;

            if ((percent1 + percent2 + percent3 + percent4 + percent5) != 100 || !WinnerValid)
            {
                ServerValidator1.IsValid = false;
                return;
            }

            string[] selectedValues = Request.Form.GetValues(ComboTeams.UniqueID);
            List<int> teamList = new List<int>();

            if (selectedValues == null || teamNum != selectedValues.Count())
            {
                ServerValidator0.IsValid = false;
                return;
            }

            if (selectedValues != null)
            {
                foreach (string itemID in selectedValues)
                {
                    int selectedValue = ParseUtil.TryParseInt(itemID) ?? 0;
                    teamList.Add(selectedValue);
                }
            }
            
            int? gameID = ParseUtil.TryParseInt(HfGameID.Value);
            //Image Save
            string imageTitle1 = UploadImage(HfGameImage1);
            string imageTitle2 = UploadImage(HfGameImage2);

            bool success = gameController.SaveGame(gameID, title, sdate, edate, fee, tax, status, minPlayers, teamNum, note, percent1, percent2, percent3, percent4, percent5, NumOfWinners, teamList, imageTitle1, imageTitle2);
            if (!success)
            {
                ServerValidator.IsValid = false;
                return;
            }

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
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
            string path = Server.MapPath("~/Upload/Game/" + filename);
            File.WriteAllBytes(path, imageData);

            return filename;
        }
    }
}