using MonsterGame.Controller;
using MonsterGame;
using MonsterSport.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MonsterGame.Common;
using MonsterGame.Util;
using System.Text.RegularExpressions;

namespace MonsterSport
{
    public partial class Agency : System.Web.UI.Page
    {
        private User admin;
        private LoginController loginSystem = new LoginController();
        private UserController userController = new UserController();
        protected void Page_Load(object sender, EventArgs e)
        {
            admin = loginSystem.GetCurrentUserAccount();
            if (!loginSystem.IsSuperAdminLoggedIn() && (admin == null || !loginSystem.IsAdminLoggedIn()) && (admin == null || !loginSystem.IsMasterLoggedIn()))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (loginSystem.IsSuperAdminLoggedIn() || admin.Role == (int)Role.MASTER)
                {
                    HfManage.Value = "true";
                }
                else
                {
                    HfManage.Value = "false";
                    BtnSave.Visible = false;
                    BtnAddAgency.Visible = false;
                }
            }
        }

        protected void BtnSavePurchase_Click(object sender, EventArgs e)
        {
            int? agencyID = ParseUtil.TryParseInt(HfAgencyID.Value);
            double amount = ParseUtil.TryParseDouble(TxtBalance.Text) ?? 0;
            string balanceNote = TxtBalanceNote.Text;
            if (admin != null && admin.Role == (int)Role.ADMIN)
            {
                ServerValidator1.IsValid = false;
                return;
            }
            bool success = userController.UpdateAgencyBalance(agencyID, admin?.Id ?? 0, amount, balanceNote);
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
            int? agencyID = ParseUtil.TryParseInt(HfAgencyID.Value);

            if (admin != null && admin.Role == (int)Role.ADMIN)
            {
                ServerValidator.IsValid = false;
                return;
            }

            bool success = userController.SaveAgency(agencyID, admin?.Id ?? 0, name, surname, nickname, email, pass, mobile, note);
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