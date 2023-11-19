using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Model
{
    public class NotificationCheck
    {
        Notification notification;
        public NotificationCheck() { }
        public NotificationCheck(Notification notification) 
        { 
            this.notification = notification;
            if (notification == null) { return; }
            Id = notification.Id;
            Title = notification.Title;
            Description = notification.Description;
            CreateDate = notification.CreatedDate?.ToString("dd/MM/yyyy HH.mm");
            IsNew = notification.IsNew ?? false;
        }
        public int Id
        {
            get; set;
        }
        public string Title
        {
            get; set;
        }
        public string Description
        {
            get; set;
        }
        public string CreateDate
        {
            get; set;
        }
        public bool IsNew
        {
            get; set;
        }
    }
}