using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame
{
    public class NotificationHub : Hub
    {
        public void SendNotifications(string message)
        {
            Clients.All.receiveNotification(message);
        }
    }
}