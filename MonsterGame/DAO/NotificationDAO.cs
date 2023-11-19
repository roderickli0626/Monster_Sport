using MonsterGame.DAO;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace MonsterGame.DAO
{
    public class NotificationDAO : BasicDAO
    {
        public NotificationDAO() { }

        public List<Notification> FindAll()
        {
            Table<Notification> table = GetContext().Notifications;
            return table.ToList();
        }
        public Notification FindByID(int id)
        {
            return GetContext().Notifications.Where(g => g.Id == id).FirstOrDefault();
        }
        public bool Insert(Notification notification)
        {
            GetContext().Notifications.InsertOnSubmit(notification);
            GetContext().SubmitChanges();
            return true;
        }

        public bool Update(Notification notification)
        {
            GetContext().SubmitChanges();
            GetContext().Refresh(RefreshMode.OverwriteCurrentValues, notification);
            return true;
        }
        public bool Delete(int id)
        {
            Notification notification = GetContext().Notifications.SingleOrDefault(u => u.Id == id);
            GetContext().Notifications.DeleteOnSubmit(notification);
            GetContext().SubmitChanges();
            return true;
        }
    }
}