using ASPSnippets.GoogleAPI;
using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using Facebook;
using Microsoft.Owin.Security.Cookies;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace BigchainDBWebServer.Controllers
{
	public class UserController : Controller
	{
		private Uri RedirectUri
		{
			get
			{
				var uriBuilder = new UriBuilder(Request.Url);
				uriBuilder.Query = null;
				uriBuilder.Fragment = null;
				uriBuilder.Path = Url.Action("FacebookCallback");
				return uriBuilder.Uri;
			}
		}

		// GET: User
		public ActionResult Login()
		{
			return View();
		}
		public ActionResult NoActiveLogin()
		{
			return View();
		}
		public async Task<ActionResult> Registration()
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
		public async Task<ActionResult> RegistrationNormal()
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

		public async Task<JsonResult> GetDetailArea(string name)
		{
			string Baseurl = "https://thongtindoanhnghiep.co/";
			List<Tinh> lstCity = new List<Tinh>();
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
			}
			int ID = 0;
			foreach (var item in lst)
			{
				if (name == item.Title)
				{
					ID = item.ID;
				}
			}
			using (var client = new HttpClient())
			{
				client.BaseAddress = new Uri(Baseurl);

				client.DefaultRequestHeaders.Clear();

				client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

				HttpResponseMessage Res = await client.GetAsync("/api/city/" + ID + "/district");

				if (Res.IsSuccessStatusCode)
				{
					//Storing the response details recieved from web api   
					string SachResponse = Res.Content.ReadAsStringAsync().Result;
					List<Tinh> lstArea = new JavaScriptSerializer().Deserialize<List<Tinh>>(SachResponse);
					lstCity = lstArea;
				}
				return Json(new { Success = lstCity }, JsonRequestBehavior.AllowGet);
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
			var data = (from c in dao.Model.UserBCs where c.username == userid && c.pwd == Pwd select c).ToList();
			if (data.Count() > 0)
			{
				var acitve = (from c in dao.Model.UserBCs where c.username == userid && c.pwd == Pwd && c.active == 1 select c).ToList();
				if (acitve.Count() > 0)
				{
					Session["UserID"] = userid;
					Session["ComNa"] = dao.GetCoByUsername(userid);
					return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
				}
				else
				{
					return Json(new { Success = "NoActive" }, JsonRequestBehavior.AllowGet);
				}
			}
			else
				return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
		}
		public JsonResult InsertRegister(UserBC item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return Json(new ResultOfRequest(false, "Dữ liệu nhận bị lỗi!"), JsonRequestBehavior.AllowGet);
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.username == item.username);
			if (old != null)
			{
				return Json(new ResultOfRequest(false, "Đã tồn tại tài khoản này, vui lòng nhập lại!"), JsonRequestBehavior.AllowGet);
			}
			else
			{
				var UserFb = Session["usernameFB"];
				var NameFB = Session["NameFB"];
				var UserGo = Session["usernameGO"];
				var NameGo = Session["NameGO"];
				var EmailGo = Session["Email"];
				old = new UserBC();
				if (UserGo != null)
				{
					old.username = UserGo.ToString();
					old.name = NameGo.ToString();
					old.email = EmailGo.ToString();
					old.pwd = "";
				}
				else if (UserFb != null)
				{
					old.username = UserFb.ToString();
					old.name = NameFB.ToString();
					old.email = item.email;
					old.pwd = "";
				}
				else
				{
					old.username = item.username;
					old.name = item.username;
					old.email = item.email;
					old.pwd = MD5Hash(item.pwd);
				}
				old.Area = item.Area;
				old.City = item.City;
				old.birthday = item.birthday;
				old.adrs = item.adrs;
				old.phone = item.phone;
				old.deleted = 0;
				old.idRole = item.idRole;
				old.dateCreated = DateTime.Now;
				old.dateUpdate = DateTime.Now;
				old.active = 0;
				old.deleted = 0;
				old.company = item.company;
				dao.Model.UserBCs.Add(old);
				if (dao.Model.SaveChanges() > 0)
				{
					return Json(new ResultOfRequest(true), JsonRequestBehavior.AllowGet);
				}
				return Json(new ResultOfRequest(false, "Lỗi lưu dữ liệu!"), JsonRequestBehavior.AllowGet);
			}
		}

		public bool CheckFirstLogin(string item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return false;
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.username == item);
			if (old != null)
			{
				return false;
			}
			return true;
		}

		public ActionResult LoginFacebook()
		{
			var fb = new FacebookClient();
			var loginUrl = fb.GetLoginUrl(new
			{
				client_id = ConfigurationManager.AppSettings["FbAppId"],
				client_secret = ConfigurationManager.AppSettings["FbAppSecret"],
				redirect_uri = RedirectUri.AbsoluteUri,
				response_type = "code",
				scope = "email",
			});
			return Redirect(loginUrl.AbsoluteUri);
		}

		public ActionResult FacebookCallback(string code)
		{
			var fb = new FacebookClient("access_token");
			dynamic result = fb.Post("oauth/access_token", new
			{
				client_id = ConfigurationManager.AppSettings["FbAppId"],
				client_secret = ConfigurationManager.AppSettings["FbAppSecret"],
				redirect_uri = RedirectUri.AbsoluteUri,
				code = code
			});

			var accessToken = result.access_token;
			if (!string.IsNullOrEmpty(accessToken))
			{
				fb.AccessToken = accessToken;
				dynamic me = fb.Get("me?fiels=name,id");
				string username = me.id;
				string name = me.name;
				string email = me.email;
				Session["usernameFB"] = username;
				Session["NameFB"] = name;
				if (CheckFirstLogin(username) == true)
				{
					return RedirectToAction("Registration", "User");
				}
				AccountDAO dao = new AccountDAO();
				Session["ComNa"] = dao.GetCoByUsername(username);
			}
			return RedirectToAction("Manager", "Product");
		}

		public ActionResult LogoutFb()
		{
			Session.RemoveAll();
			FormsAuthentication.SignOut();
			return Redirect("~/");
		}

		//public void LoginGoogle(string ReturnUrl = "/", string type = "")
		//{
		//	if (!Request.IsAuthenticated)
		//	{
		//		if (type == "Google")
		//		{
		//			HttpContext.GetOwinContext().Authentication.Challenge(new AuthenticationProperties { RedirectUri = "User/GoogleLoginCallback" }, "Google");
		//		}
		//	}
		//}

		public ActionResult SignOutGO()
		{
			Session.RemoveAll();
			HttpContext.GetOwinContext().Authentication.SignOut(CookieAuthenticationDefaults.AuthenticationType);
			return Redirect("~/");
		}
		public ActionResult SignOut()
		{
			Session.RemoveAll();
			return Redirect("~/");
		}
		//[AllowAnonymous]
		//public ActionResult GoogleLoginCallback()
		//{
		//	var claimsPrincipal = HttpContext.User.Identity as ClaimsIdentity;
		//	if (claimsPrincipal.Claims.Count() == 0 || claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email) == null)
		//	{
		//		return Redirect("Login");
		//	}
		//	string username = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier).Value;
		//	string email = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
		//	string name = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
		//	Session["usernameGO"] = username;
		//	Session["NameGO"] = name;
		//          Session["usernameInTB"] = username;
		//          if (CheckFirstLogin(username) == true)
		//	{
		//		return RedirectToAction("Registration", "User");
		//	}
		//	return RedirectToAction("AddProduct", "Product");
		//}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public void LoginWithGooglePlus()
		{
			GoogleConnect.ClientId = "988136019750-lrkpmiauffr8dlbjbqjjmh82aiti7iqs.apps.googleusercontent.com";
			GoogleConnect.ClientSecret = "aMCHg7U8aJhjcvH-A5LiQmvn";
			GoogleConnect.RedirectUri = Request.Url.AbsoluteUri.Split('?')[0];
			GoogleConnect.Authorize("profile", "email");
		}

		[ActionName("LoginWithGooglePlus")]
		public ActionResult LoginWithGooglePlusConfirmed()
		{

			if (!string.IsNullOrEmpty(Request.QueryString["code"]))
			{
				string code = Request.QueryString["code"].ToString();
				string json = GoogleConnect.Fetch("me", code.ToString());
				GoogleProfile profile = new JavaScriptSerializer().Deserialize<GoogleProfile>(json);
				//code for showing data on my page
				Session["usernameGO"] = profile.Id;
				Session["NameGO"] = profile.Name;
				Session["Email"] = profile.Email;
				Session["ImgGO"] = profile.Picture;
				if (CheckFirstLogin(profile.Id) == true)
				{
					return RedirectToAction("Registration", "User");
				}
				else
				{
					AccountDAO dao = new AccountDAO();
					Session["ComNa"] = dao.GetCoByUsername(profile.Id);
					return RedirectToAction("Manager", "Product");
				}
			}
			if (Request.QueryString["error"] == "access_denied")
			{
				return Content("access_denied");
			}
			return RedirectToAction("Index", "Home");
		}

	}
}
