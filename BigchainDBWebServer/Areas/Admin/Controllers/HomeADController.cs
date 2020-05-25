using BigchainDBWebServer.DAO;
using System.Web.Mvc;
using System.Linq;

namespace BigchainDBWebServer.Areas.Admin.Controllers
{
	public class HomeADController : Controller
	{
		// GET: Admin/Home
		//public ActionResult Index()
		//{
		//	return View();
		//}
		public ActionResult Supplier()
		{
			if (Session["UserAD"] != null)
			{
				AccountDAO dao = new AccountDAO();
				ViewBag.lstUserBC = dao.GetListUserByIdRoles(3);
				return View();
			}
			return RedirectToAction("Login", "UserAD");
		}

		public ActionResult Distributor()
		{
			if (Session["UserAD"] != null)
			{
				AccountDAO dao = new AccountDAO();
				ViewBag.lstUserBC = dao.GetListUserByIdRoles(2);
				return View();
			}
			return RedirectToAction("Login", "UserAD");
		}

		public ActionResult Farmer()
		{
			if (Session["UserAD"] != null)
			{
				AccountDAO dao = new AccountDAO();
				ViewBag.lstUserBC = dao.GetListUserByIdRoles(1);
				return View();
			}
			return RedirectToAction("Login", "UserAD");
		}

		public ActionResult UserBCDetailsProduct(string username)
		{
			if (Session["UserAD"] != null)
			{
				if (username == null)
					return RedirectToAction("Index", "Home");
				ProductDAO dao = new ProductDAO();
                ViewBag.userInfo = (from c in dao.Model.UserBCs where c.username == username select c).FirstOrDefault();
                ViewBag.lstPtoduct = dao.GetAllByUsername(username.ToString());
				return View();
			}
			return RedirectToAction("Login", "UserAD");
		}

		[HttpPost]
		public JsonResult ActiveUser(string username, int active = 1)
		{
			AccountDAO dao = new AccountDAO();
			//var result = new ResultOfRequest(true, username);
			var result = dao.ActiveUser(username, active == 1);
			return Json(result, JsonRequestBehavior.AllowGet);
		}
	}
}