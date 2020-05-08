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
        public ActionResult Transporters()
        {
            return View();
        }
        public ActionResult Distributor()
        {
            return View();
        }
        public ActionResult Farmer()
        {
            return View();
        }

    }
}