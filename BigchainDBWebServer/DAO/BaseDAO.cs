using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BigchainDBWebServer.DAO
{
    public class BaseDAO
    {
        public BaseDAO()
        {
            Model = new QLNongSanEntities();
        }
        public QLNongSanEntities Model { get; set; }
    }
}