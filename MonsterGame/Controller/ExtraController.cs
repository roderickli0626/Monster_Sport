using MonsterGame.Common;
using MonsterGame.DAO;
using MonsterGame.Model;
using MonsterGame.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Controller
{
    public class ExtraController
    {
        private GameBoardDAO boardDAO;
        private FeedbackDAO feedbackDAO;
        private NotificationDAO notificationDAO;
        public ExtraController() 
        { 
            boardDAO = new GameBoardDAO();
            feedbackDAO = new FeedbackDAO();
            notificationDAO = new NotificationDAO();
        }

        public SearchResult SearchNews(int start, int length, string searchVal)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Notification> notificationList = notificationDAO.FindAll();
            if (!string.IsNullOrEmpty(searchVal)) notificationList = notificationList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = notificationList.Count();
            notificationList = notificationList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Notification notification in notificationList)
            {
                NotificationCheck notificationcheck = new NotificationCheck(notification);
                checks.Add(notificationcheck);
            }
            result.ResultList = checks;

            return result;
        }

        public bool SaveNews(int? notificationID, string title, string description)
        {
            Notification notification = notificationDAO.FindByID(notificationID ?? 0);
            if (notification == null)
            {
                Notification newNotification = new Notification();
                newNotification.Title = title;
                newNotification.Description = description;
                newNotification.CreatedDate = DateTime.Now;
                newNotification.IsNew = true;
                return notificationDAO.Insert(newNotification);
            }
            else 
            {
                notification.Title = title;
                notification.Description = description;
                notification.IsNew = true;
                notification.CreatedDate = DateTime.Now;
                return notificationDAO.Update(notification);
            }
        }

        public bool DeleteNews(int id)
        {
            Notification item = notificationDAO.FindByID(id);
            if (item == null) return false;

            return notificationDAO.Delete(id);
        }
    }
}