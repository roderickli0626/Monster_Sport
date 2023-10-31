using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonsterGame.Common
{
    public enum GameStatus
    {
        OPEN = 1,
        STARTED = 2,
        TEAMCHOICE = 3,
        SUSPENDED = 4,
        CLOSED = 5,
        COMPLETED = 6,
    }
}