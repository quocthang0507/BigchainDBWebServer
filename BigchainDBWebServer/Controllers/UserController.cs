using BigchainDBWebServer.DAO;
using BigchainDBWebServer.Models;
using Facebook;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using System;
using System.Collections.Generic;
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
        public JsonResult InsertRegister(amsm item)
        {
            AccountDAO dao = new AccountDAO();
            if (item == null)
                return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
            var old = dao.Model.amsms.FirstOrDefault(f => f.id == item.id);
            if (old != null)
            {
                return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var claimsPrincipal = HttpContext.User.Identity as ClaimsIdentity;
                var UserFb = Session["usernameFB"];
                var IdFb = Session["IdFB"];
                var emailFb = Session["EmailFB"];
                old = new amsm();
                if (claimsPrincipal.Claims.Count() != 0)
                {
                    old.username = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
                    old.name = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
                    old.email = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
                }
                else if (UserFb != null)
                {
                    old.username = UserFb.ToString();
                    old.name = IdFb.ToString();
                    old.email = emailFb.ToString();
                }
                else
                {
                    old.username = item.username;
                    old.name = item.name;
                    old.email = item.email;
                }
                old.pwd = old.pwd;
                old.birthday = item.birthday;
                old.adrs = item.adrs;
                old.teleNum1 = item.teleNum1;
                old.teleNum2 = item.teleNum2;
                old.rolls = 0;
                old.token = item.token;
                dao.Model.amsms.Add(old);
                dao.Model.SaveChanges();
                return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
            }
        }
        public bool CheckLogin(string item)
        {
            AccountDAO dao = new AccountDAO();
            if (item == null)
                return false;
            var old = dao.Model.amsms.FirstOrDefault(f => f.username == item);
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
                dynamic me = fb.Get("me?fiels=name,id,email");
                string username = me.name;
                string Id = me.id;
                string email = me.email;
                Session["usernameFB"] = username;
                Session["IdFB"] = Id;
                Session["EmailFB"] = email;
                if (CheckLogin(username) == true)
                {
                    return RedirectToAction("Registration", "User");
                }
            }
            return RedirectToAction("Index", "Product");
        }
        public ActionResult LogoutFb()
        {
            Session.Remove("usernameFB");
            Session.Remove("IdFB");
            Session.Remove("EmailFB");
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
        public ActionResult SignOut()
        {
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
            string username = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Email).Value;
            if (CheckLogin(username) == true)
            {
                return RedirectToAction("Registration", "User");
            }
            return RedirectToAction("Index", "Product");
        }
    }
}
