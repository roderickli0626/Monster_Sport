using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame
{
    public class NotificationHub : Hub
    {
        public void SendTicketNotifications(string message)
        {
            Clients.All.receiveTicketNotification(message);
        }
        public void SendTeamChoiceNotifications(string message)
        {
            Clients.All.receiveTeamChoiceNotification(message);
        }
        public void SendTicketNotificationsA(string message)
        {
            Clients.All.receiveTicketNotificationA(message);
        }
        public void SendTeamChoiceNotificationsA(string message)
        {
            Clients.All.receiveTeamChoiceNotificationA(message);
        }
        public void SendResultNotifications(string message)
        {
            Clients.All.receiveResultNotification(message);
        }
        public void SendRoundNotifications(string message)
        {
            Clients.All.receiveRoundNotification(message);
        }
        public void SendPrizeNotifications(string message)
        {
            Clients.All.receivePrizeNotification(message);
        }
        public void SendStartGameNotifications(string message)
        {
            Clients.All.receiveStartGameNotification(message);
        }
        public void SendMessageToUser(string message)
        {
            Clients.All.receiveUserMessage(message);
        }
        public void SendNewsAddMessage(string message)
        {
            Clients.All.receiveNewsAddMessage(message);
        }
    }
}