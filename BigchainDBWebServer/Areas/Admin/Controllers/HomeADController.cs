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
	}
}