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

		//public ActionResult Registration()
		//{
		//	AccountDAO dao = new AccountDAO();
		//	var lstArea = dao.GetAllProvinces();
		//	var lstCity = dao.GetAllDistrict();
		//	this.ViewBag.lstArea = lstArea;
		//	this.ViewBag.lstCity= lstCity;
		//	return View();
		//}

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

		public JsonResult InsertRegister(UserBC item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.id == item.id);
			if (old != null)
			{
				return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
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
				}
				else if (UserFb != null)
				{
					old.username = UserFb.ToString();
					old.name = NameFB.ToString();
					old.email = item.email;
				}
				old.Area = item.Area;
				old.City = item.City;
				old.birthday = item.birthday;
				old.adrs = item.adrs;
				old.phone = item.phone;
				old.deleted = 0;
				old.idRole = item.idRole;
				old.dateCreated = DateTime.Now;
				old.active = 0;
				old.deleted = 0;
				dao.Model.UserBCs.Add(old);
				dao.Model.SaveChanges();
				return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
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
			}
			return RedirectToAction("AddProduct", "Product");
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
					return RedirectToAction("AddProduct", "Product");
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
