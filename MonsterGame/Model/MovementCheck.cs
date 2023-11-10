using MonsterGame;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace MonsterGame.Model
{
    public class MovementCheck
    {
        Movement movement;
        public MovementCheck() { }
        public MovementCheck(Movement movement)
        {
            this.movement = movement;
            if (movement == null) return;
            Id = movement.Id;
            ReceiverID = movement.UserID;
            Receiver = movement.User.Name;
            SenderID = movement.SenderID;
            Sender = movement.User1?.Name ?? "";
            MoveDate = movement.MoveDate?.ToString("dd/MM/yyyy HH.mm");
            Amount = Math.Round(movement.Amount ?? 0, 2);
            Description = movement.Description;
            Note = movement.Note;
            Type = movement.Type;
        }
        public int Id
        {
            get; set;
        }
        public int? ReceiverID
        {
            get; set;
        }
        public string Receiver
        {
            get; set;
        }
        public int? SenderID
        {
            get; set;
        }
        public string Sender
        {
            get; set;
        }
        public string MoveDate
        {
            get; set;
        }
        public double Amount
        {
            get; set;
        }
        public string Description
        {
            get; set;
        }
        public string Note
        {
            get; set;
        }
        public int? Type
        {
            get; set;
        }
        public string Transfer
        {
            get; set;
        }
    }
}