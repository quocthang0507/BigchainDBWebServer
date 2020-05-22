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
        public List<AdminBC> GetAllUserAD()
        {
            var lst = Model.AdminBCs.OrderBy(p => p.id).ToList();
            return lst;
        }
        public List<UserBC> GetListUserByIdRoles(int id = 1)
        {
            List<UserBC> lst = Model.UserBCs.Where(x => x.idRole == id).ToList();
            return lst;
        }
        //public List<Province> GetAllProvinces()
        //{
        //    var lst = Model.Provinces.OrderBy(p => p.Id).ToList();
        //    return lst;
        //}
        //public List<District> GetAllDistrict()
        //{
        //    var lst = Model.Districts.OrderBy(p => p.Id).ToList();
        //    return lst;
        //}
        public ResultOfRequest ActiveUser(string username, bool active = true)
        {
            var userBC = Model.UserBCs.FirstOrDefault(x => x.username == username);
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
            var lst = Model.Notifications.OrderBy(p => p.dateCreate).ToList();
            return lst;
        }
    }
}