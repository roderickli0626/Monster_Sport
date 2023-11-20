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

        public bool SaveFeedback(string title, string description, int userID)
        {
            Feedback feedback = new Feedback();
            feedback.Title = title;
            feedback.Description = description;
            feedback.Creater = userID;
            feedback.CreatedDate = DateTime.Now;
            feedback.IsNew = true;
            return feedbackDAO.Insert(feedback);
        }

        public SearchResult SearchFeedbacks(int start, int length, string searchVal)
        {
            SearchResult result = new SearchResult();
            IEnumerable<Feedback> feedbackList = feedbackDAO.FindAll();
            if (!string.IsNullOrEmpty(searchVal)) feedbackList = feedbackList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = feedbackList.Count();
            feedbackList = feedbackList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (Feedback feedback in feedbackList)
            {
                FeedbackCheck feedbackcheck = new FeedbackCheck(feedback);
                checks.Add(feedbackcheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteFeedback(int id)
        {
            Feedback item = feedbackDAO.FindByID(id);
            if (item == null) return false;

            return feedbackDAO.Delete(id);
        }
        public bool UpdateFeedback(int id)
        {
            Feedback item = feedbackDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return feedbackDAO.Update(item);
        }
        public bool UpdateNews(int id)
        {
            Notification item = notificationDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return notificationDAO.Update(item);
        }

        public SearchResult SearchBoards(int start, int length, string searchVal, int gameID)
        {
            SearchResult result = new SearchResult();
            IEnumerable<GameBoard> boardList = boardDAO.FindAll().Where(g => g.GameID == gameID);
            if (!string.IsNullOrEmpty(searchVal)) boardList = boardList.Where(x => x.Title.ToLower().Contains(searchVal.ToLower())).ToList();

            result.TotalCount = boardList.Count();
            boardList = boardList.Skip(start).Take(length);

            List<object> checks = new List<object>();
            foreach (GameBoard board in boardList)
            {
                GameBoardCheck boardCheck = new GameBoardCheck(board);
                checks.Add(boardCheck);
            }
            result.ResultList = checks;

            return result;
        }
        public bool DeleteBoard(int id)
        {
            GameBoard item = boardDAO.FindByID(id);
            if (item == null) return false;

            return boardDAO.Delete(id);
        }
        public bool UpdateBoard(int id)
        {
            GameBoard item = boardDAO.FindByID(id);
            if (item == null) return false;
            item.IsNew = false;
            return boardDAO.Update(item);
        }

        public bool SaveBoard(int? boardID, int? gameID, int userID, string title, string description)
        {
            GameBoard board = boardDAO.FindByID(boardID ?? 0);
            if (board == null)
            {
                if (gameID == null) { return false; }
                GameBoard newBoard = new GameBoard();
                newBoard.Title = title;
                newBoard.Description = description;
                newBoard.CreatedDate = DateTime.Now;
                newBoard.GameID = gameID;
                newBoard.IsNew = true;
                if (userID != 0) newBoard.Creater = userID;
                return boardDAO.Insert(newBoard);
            }
            else
            {
                board.Title = title;
                board.Description = description;
                board.IsNew = true;
                return boardDAO.Update(board);
            }
        }
    }
}