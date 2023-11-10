using MonsterGame.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Register : System.Web.UI.Page
    {
        LoginController loginSystem = new LoginController();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;
            string name = TxtName.Text;
            string surname = TxtSurname.Text;
            string nickname = TxtNickname.Text;
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
            EncryptedPass pass = new EncryptedPass() { Encrypted = new CryptoController().EncryptStringAES(password), UnEncrypted = password };
            bool success = loginSystem.RegisterUser(name, surname, nickname, email, pass, mobile, note);
            if (success)
            {
                //Send Email to Admin
                //SendEmail(email);
                Response.Redirect("~/Login.aspx?email=" + email + "&pass=" + password);
            }
            else
            {
                ServerValidator.IsValid = false;
                return;
            }
        }

        private void SendEmail(string email)
        {
            //Send Email
            MailMessage Msg = new MailMessage();
            Msg.From = new MailAddress("Krandall2005@gmail.com", "Monster Game");// Sender details here, replace with valid value
            Msg.Subject = "Un nuovo CLIENTE si è registrato"; // subject of email
            Msg.To.Add("krandall2005@gmail.com"); //Add Email id, to which we will send email
            Msg.Body = email + " è stato aggiunto al gestionale.";
            Msg.IsBodyHtml = true;
            Msg.Priority = MailPriority.High;
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials = false; // to get rid of error "SMTP server requires a secure connection"
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;

            smtp.Credentials = new System.Net.NetworkCredential("krandall2005@gmail.com", "fyjlmiowttdaovfi");// replace with valid value
            smtp.EnableSsl = true;

            smtp.Send(Msg);
        }
    }
}