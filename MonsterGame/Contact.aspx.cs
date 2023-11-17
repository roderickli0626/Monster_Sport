using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonsterGame
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSend_Click(object sender, EventArgs e)
        {
            if (!IsValid) return;

            string name = TxtName.Text;
            string email = TxtEmail.Text;
            string phone = TxtPhone.Text;
            string message = TxtMessage.Text;

            //Send Email
            MailMessage Msg = new MailMessage();
            Msg.From = new MailAddress("Krandall2005@gmail.com", "FantaGame365.it");// Sender details here, replace with valid value
            Msg.Subject = "Messaggio dal sito"; // subject of email
            Msg.To.Add("krandall2005@gmail.com"); //Add Email id, to which we will send email
            Msg.Body = name + " sent a message." + "\nMessage:" + message + "\nPhone:" + phone;
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