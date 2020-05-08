using BigchainDBWebServer.Models;
using System.Collections.Generic;
using System.Linq;

namespace BigchainDBWebServer.DAO
{
	public class AccountDAO : BaseDAO
	{
		public List<UserBC> GetAllSP()
		{
			var lst = Model.UserBCs.OrderBy(p => p.id).ToList();
			return lst;
		}
        public List<UserBC> GetListUserByIdRoles(int id = 1)
        {
            List<UserBC> lst = Model.UserBCs.Where(x => x.idRole == id).ToList();
            return lst;
        }
	}
}