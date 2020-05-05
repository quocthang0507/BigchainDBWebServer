using BigchainDBWebServer.Models;
using System.Collections.Generic;
using System.Linq;

namespace BigchainDBWebServer.DAO
{
	public class AccountDAO : BaseDAO
	{
		public List<amsm> GetAllSP()
		{
			var lst = Model.amsms.OrderBy(p => p.id).ToList();
			return lst;
		}
	}
}