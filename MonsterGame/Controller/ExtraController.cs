using MonsterGame.DAO;
using MonsterSport.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterSport.Controller
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


    }
}