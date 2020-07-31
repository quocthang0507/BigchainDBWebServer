using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Script.Serialization;

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

		public async Task<ActionResult> RegistrationAD()
		{
			string Baseurl = "https://thongtindoanhnghiep.co/";
			List<Tinh> lst = new List<Tinh>();
			using (var client = new HttpClient())
			{
				client.BaseAddress = new Uri(Baseurl);

                client.DefaultRequestHeaders.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage Res = await client.GetAsync("/api/city");

                if (Res.IsSuccessStatusCode)
                {
                    //Storing the response details recieved from web api   
                    string SachResponse = Res.Content.ReadAsStringAsync().Result;
                    Area lstArea = new JavaScriptSerializer().Deserialize<Area>(SachResponse);
                    lst = lstArea.LtsItem;
                }
                this.ViewBag.lst = lst;
                return View();
            }
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
		public JsonResult InsertRegisterAD(AdminBC item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return Json(new ResultOfRequest(false, "Dữ liệu nhận bị lỗi!"), JsonRequestBehavior.AllowGet);
			var old = dao.Model.AdminBCs.FirstOrDefault(f => f.username == item.username);
			if (old != null)
			{
				return Json(new ResultOfRequest(false, "Đã tồn tại tài khoản này, vui lòng nhập lại!"), JsonRequestBehavior.AllowGet);
			}
			else
			{
				old = new AdminBC();
				old.username = item.username;
				old.pwd = MD5Hash(item.pwd);
				old.name = item.name;
				old.adrs = item.adrs;
				old.birthday = item.birthday;
				old.phone = item.phone;
				old.deleted = 0;
				old.email = item.email;
				old.dateCreated = DateTime.Now;
				old.dateUpdate = DateTime.Now;
				old.deleted = 0;
				dao.Model.AdminBCs.Add(old);
				if (dao.Model.SaveChanges() > 0)
				{
					return Json(new ResultOfRequest(true), JsonRequestBehavior.AllowGet);
				}
				return Json(new ResultOfRequest(false, "Lỗi lưu dữ liệu!"), JsonRequestBehavior.AllowGet);
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