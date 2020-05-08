using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using Facebook;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using System;
using System.Configuration;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
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

		public ActionResult Registration()
		{
			return View();
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
				var claimsPrincipal = HttpContext.User.Identity as ClaimsIdentity;
				var UserFb = Session["usernameFB"];
				var NameFB = Session["NameFB"];
				old = new UserBC();
				if (claimsPrincipal.Claims.Count() != 0)
				{
					old.username = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier).Value;
					old.name = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
					old.email = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
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
					old.name = item.name;
					old.email = item.email;
					old.pwd = item.pwd;
				}				
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
			Session.Remove("usernameFB");
			Session.Remove("NameFB");
			FormsAuthentication.SignOut();
			return Redirect("~/");
		}

		public void LoginGoogle(string ReturnUrl = "/", string type = "")
		{
			if (!Request.IsAuthenticated)
			{
				if (type == "Google")
				{
					HttpContext.GetOwinContext().Authentication.Challenge(new AuthenticationProperties { RedirectUri = "User/GoogleLoginCallback" }, "Google");
				}
			}
		}

		public ActionResult SignOutGO()
        {
            Session.Remove("usernameGO");
			Session.Remove("NameGO");
			HttpContext.GetOwinContext().Authentication.SignOut(CookieAuthenticationDefaults.AuthenticationType);
            return Redirect("~/");
        }

		[AllowAnonymous]
		public ActionResult GoogleLoginCallback()
		{
			var claimsPrincipal = HttpContext.User.Identity as ClaimsIdentity;
			if (claimsPrincipal.Claims.Count() == 0 || claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email) == null)
			{
				return Redirect("Login");
			}
			string username = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier).Value;
			string email = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
			string name = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
			Session["usernameGO"] = username;
			Session["NameGO"] = name;
			if (CheckFirstLogin(username) == true)
			{
				return RedirectToAction("Registration", "User");
			}
			return RedirectToAction("AddProduct", "Product");
		}
	}
}
