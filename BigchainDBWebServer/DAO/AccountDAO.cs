using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BigchainDBWebServer.DAO
{
    public class AccountDAO:BaseDAO
    {
        public List<amsm> GetAllSP()
        {
            var lst = Model.amsms.OrderBy(p => p.id).ToList();
            return lst;
        }
    }
}