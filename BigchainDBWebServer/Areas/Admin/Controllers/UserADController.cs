using BigchainDBWebServer.DAO;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;


namespace BigchainDBWebServer.Areas.Admin.Controllers
{
	public class UserADController : Controller
	{
		public ActionResult getNotification()
		{
			AccountDAO dao = new AccountDAO();
			var lstNotifi = dao.GetAllNotification();
			return PartialView(lstNotifi);
		}

		public ActionResult readedNotification(int ID, string UserName)
		{
			ProductDAO dao = new ProductDAO();
			var old = dao.Model.NewNotis.FirstOrDefault(f => f.id == ID);
			if (old != null)
			{
				dao.Model.NewNotis.Remove(old);
				dao.Model.SaveChanges();
				return RedirectToAction("UserBCDetailsProduct", "HomeAD", new { username = UserName });
			}
			return RedirectToAction("Farmer", "HomeAD");
		}

		// GET: Admin/User
		public ActionResult Login()
		{
			return View();
		}

		public static string MD5Hash(string text)
		{
			MD5 md5 = new MD5CryptoServiceProvider();

			//compute hash from the bytes of text  
			md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

			//get hash result after compute it  
			byte[] result = md5.Hash;

			StringBuilder strBuilder = new StringBuilder();
			for (int i = 0; i < result.Length; i++)
			{
				//change it into 2 hexadecimal digits  
				//for each byte  
				strBuilder.Append(result[i].ToString("x2"));
			}

			return strBuilder.ToString();
		}

		public JsonResult ValidateUser(string userid, string password)
		{
			AccountDAO dao = new AccountDAO();
			var Pwd = MD5Hash(password);
			var data = from c in dao.Model.AdminBCs where c.username == userid && c.pwd == Pwd select c;
			if (data.Count() > 0)
			{
				Session["UserAD"] = userid;
				return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
			}
            else
            {
                //var temp = new BigchainDBWebServer.Models.AdminBC()
                //{
                //    username = userid,
                //    pwd = Pwd,
                //    adrs = "Ko",
                //    birthday = new DateTime(1998, 12, 12),
                //    dateCreated = DateTime.Now,
                //    dateUpdate = DateTime.Now,
                //    deleted = 0,
                //    email = "a@g.c",
                //    name = "admin",
                //    phone = "0905061131"
                //};
                //dao.Model.AdminBCs.Add(temp);
                //dao.Model.SaveChanges();
                return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
            }
        }

		public ActionResult LogOut()
		{
			Session.RemoveAll();
			return RedirectToAction("", "Admin");
		}

		[HttpPost]
		public JsonResult UpBD(string id)
		{
			//return Json(new ResultOfRequest(true,id), JsonRequestBehavior.AllowGet);
			ProductDAO dao = new ProductDAO();
			var result = dao.UpBD(int.Parse(id));
			return Json(result, JsonRequestBehavior.AllowGet);
		}
	}
}