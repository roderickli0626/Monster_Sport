using MonsterGame.Controller;
using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Util;
using System.Text.RegularExpressions;

namespace MonsterGame
{
    public partial class Master : System.Web.UI.Page
    {
        private User admin;
        private LoginController loginSystem = new LoginController();
        private UserController userController = new UserController();
        protected void Page_Load(object sender, EventArgs e)
        {
            admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn()))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            HfAdminBalance.Value = admin == null ? "" : admin.Balance.ToString();
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string name = TxtName.Text;
            string surname = TxtSurname.Text;
            string nickname = TxtNickName.Text;
            string email = TxtEmail.Text;
            string password = TxtPassword.Text;
            string repeatPW = TxtPasswordRepeat.Text;
            string note = TxtNote.Text;
            string mobile = TxtMobile.Text;

            if (password != repeatPW)
            {
                PasswordValidator.IsValid = false;
                return;
            }
            string emailPattern = @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                EmailValidator.IsValid = false;
                return;
            }
            EncryptedPass pass = null;
            if (!string.IsNullOrEmpty(password))
            {
                pass = new EncryptedPass() { Encrypted = new CryptoController().EncryptStringAES(password), UnEncrypted = password };
            }
            int? masterID = ParseUtil.TryParseInt(HfMasterID.Value);

            bool success = userController.SaveMaster(masterID, admin?.Id ?? 0, name, surname, nickname, email, pass, mobile, note);
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

        protected void BtnSavePurchase_Click(object sender, EventArgs e)
        {
            int? masterID = ParseUtil.TryParseInt(HfMasterID.Value);
            double amount = ParseUtil.TryParseDouble(TxtBalance.Text) ?? 0;
            string balanceNote = TxtBalanceNote.Text;
            bool success = userController.UpdateMasterBalance(masterID, admin?.Id ?? 0, amount, balanceNote);
            if (success)
            {
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                ServerValidator1.IsValid = false;
                return;
            }
        }
    }
}