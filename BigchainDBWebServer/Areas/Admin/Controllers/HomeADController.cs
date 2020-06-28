using BigchainDBWebServer.DAO;
using System.Linq;
using System.Web.Mvc;
using QRCoder;
using System.Drawing;
using System.IO;

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
		public int CheckRolesInAD(string item)
		{
			AccountDAO dao = new AccountDAO();
			if (item == null)
				return 0;
			var old = dao.Model.UserBCs.FirstOrDefault(f => f.username == item);
			if (old.idRole == 1)
			{
				return 1;
			}
			if (old.idRole == 2)
			{
				return 2;
			}
			if (old.idRole == 3)
			{
				return 3;
			}
			return 0;
		}
		public ActionResult UserBCDetailsProduct(string username)
		{
			if (Session["UserAD"] != null)
			{
				if (username == null)
					return RedirectToAction("Index", "Home");
				ProductDAO dao = new ProductDAO();
				ViewBag.userInfo = (from c in dao.Model.UserBCs where c.username == username select c).FirstOrDefault();
				ViewBag.Roles = CheckRolesInAD(username.ToString());
				ViewBag.lstProduct = dao.GetAllByUsername(username.ToString());
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
		[HttpGet]
		public ActionResult ProductPlanting(string IdProduct)
		{
			if (Session["UserAD"] != null)
			{
				ProductPlantingDAO dao = new ProductPlantingDAO();
				ViewBag.lstPlanting = dao.GetListProductPlantingProcessesByIdProduct(IdProduct);
				return View();
			}
			return RedirectToAction("Login", "UserAD");
		}
		[HttpPost]
		public JsonResult UpBDPlanting(int id)
		{
			//return Json(new ResultOfRequest(true,id), JsonRequestBehavior.AllowGet);
			ProductPlantingDAO dao = new ProductPlantingDAO();
			var result = dao.HasUpBD(id);
			return Json(result, JsonRequestBehavior.AllowGet);
		}
        [HttpPost]
        public JsonResult GenerateQRCode(string code)
        {
            QRCodeGenerator.ECCLevel eccLevel = QRCodeGenerator.ECCLevel.H;
            string urlPath = this.Server.MapPath(@"~\imgQR\test\");
            string fileName = code + ".png";
            urlPath = System.IO.Path.Combine(urlPath, fileName);
            if (System.IO.File.Exists(urlPath))
                return Json(new ResultOfRequest(false, "Đã tạo mã QR cho sản phẩm này!"));
            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                using (QRCodeData qrCodeData = qrGenerator.CreateQrCode(code, eccLevel))
                {
                    using (QRCode qrCode = new QRCode(qrCodeData))
                    {
                        var qrImg = qrCode.GetGraphic(20, Color.Black, Color.White,true);
                        Bitmap fileSave = new Bitmap(qrImg, new Size(400, 400));
                        using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
                        {
                            using (System.IO.FileStream fs = new System.IO.FileStream(urlPath, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                            {
                                fileSave.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                                byte[] bytes = ms.ToArray();
                                fs.Write(bytes, 0, bytes.Length);
                            }
                        }
                    }
                }
            }
            if (System.IO.File.Exists(urlPath))
                return Json(new ResultOfRequest(true, "Tạo thành công!"));
            return Json(new ResultOfRequest(false, "Không tìm thấy file!"));
        }
	}
}