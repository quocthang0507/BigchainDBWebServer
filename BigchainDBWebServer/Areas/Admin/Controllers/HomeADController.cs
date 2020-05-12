using BigchainDBWebServer.DAO;
using System.Web.Mvc;

namespace BigchainDBWebServer.Areas.Admin.Controllers
{
	public class HomeADController : Controller
	{
		// GET: Admin/Home
		public ActionResult Index()
		{
			return View();
		}
        public ActionResult Supplier()
        {
            AccountDAO dao = new AccountDAO();
            ViewBag.lstUserBC = dao.GetListUserByIdRoles(3);
            return View();
        }
        public ActionResult Distributor()
        {
            AccountDAO dao = new AccountDAO();
            ViewBag.lstUserBC = dao.GetListUserByIdRoles(2);
            return View();
        }
        public ActionResult Farmer()
        {
            AccountDAO dao = new AccountDAO();
            ViewBag.lstUserBC = dao.GetListUserByIdRoles(1);
            return View();
        }
        public ActionResult UserBCDetailsProduct(string username)
        {
            ProductDAO dao = new ProductDAO();
            ViewBag.lstPtoduct = dao.GetAllByUsername(username.ToString());
            return View();
        }
        [HttpPost]
        public JsonResult ActiveUser(string username,int active = 1)
        {
            AccountDAO dao = new AccountDAO();
            //var result = new ResultOfRequest(true, username);
            var result = dao.ActiveUser(username, active == 1 ? true : false);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}