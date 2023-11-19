using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterSport.Model
{
    public class FeedbackCheck
    {
        Feedback feedback;
        public FeedbackCheck() { }
        public FeedbackCheck(Feedback feedback) 
        {
            this.feedback = feedback;
            if (feedback == null) return;
            Id = feedback.Id;
            CreaterID = feedback.Creater;
            Creater = feedback.User.Name;
            Title = feedback.Title;
            Description = feedback.Description;
            CreateDate = feedback.CreatedDate?.ToString("dd/MM/yyyy HH.mm");
        }

        public int Id
        {
            get; set;
        }
        public int? CreaterID
        {
            get; set;
        }
        public string Creater
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

    }
}