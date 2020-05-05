using System.Web.Mvc;

namespace BigchainDBWebServer.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Manager()
        {
            if (Session["usernameFB"] != null || Session["usernameGO"] != null)
            {
                    return View();
            }
            return RedirectToAction("Login", "User");
        }
        public ActionResult AddProduct()
        {
            if (Session["usernameFB"] != null || Session["usernameGO"] != null)
            {
                return View();
            }
            return RedirectToAction("Login", "User");
        }
    }
}