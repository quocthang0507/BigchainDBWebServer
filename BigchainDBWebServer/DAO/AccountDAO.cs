using BigchainDBWebServer.Models;
using System.Collections.Generic;
using System.Linq;

namespace BigchainDBWebServer.DAO
{
	public class AccountDAO : BaseDAO
	{
		public List<UserBC> GetAllSP()
		{
			List<UserBC> lst = Model.UserBCs.OrderBy(p => p.id).ToList();
			return lst;
		}

		public List<AdminBC> GetAllUserAD()
		{
			List<AdminBC> lst = Model.AdminBCs.OrderBy(p => p.id).ToList();
			return lst;
		}

		public List<UserBC> GetListUserByIdRoles(int id = 1)
		{
			List<UserBC> lst = Model.UserBCs.Where(x => x.idRole == id).ToList();
			return lst;
		}
		public ResultOfRequest ActiveUser(string username, bool active = true)
		{
			UserBC userBC = Model.UserBCs.FirstOrDefault(x => x.username == username);
			if (userBC == null)
				return new ResultOfRequest(false, "Không tồn tại tài khoản này!");
			if (active == true)
				userBC.active = 1;
			else userBC.active = 0;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Đã kích hoạt!");
			return new ResultOfRequest(false, "Lỗi kích hoạt!");
		}

		public List<Notification> GetAllNotification()
		{
			List<Notification> lst = Model.Notifications.OrderBy(p => p.dateCreate).ToList();
			return lst;
		}
		public string GetCoByUsername(string username)
		{
			UserBC userBC = Model.UserBCs.FirstOrDefault(x => x.username == username);
			string companyName = userBC.company;
			return companyName;
		}
	}
}