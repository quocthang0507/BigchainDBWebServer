﻿using Antlr.Runtime.Misc;
using System.Collections.Generic;
using System.Web.Mvc;

namespace BigchainDBWebServer.Controllers
{
	public class HomeController : Controller
	{
		public ActionResult Index()
		{
			return View();
		}

		public ActionResult Instruction()
		{
			return View();
		}

		public ActionResult Introduction()
		{
            DAO.ProductDAO dao = new DAO.ProductDAO();
            ViewBag.dhdl = dao.GetViewIntro("Viện nông nghiệp công nghệ cao");
            ViewBag.langfarm = dao.GetViewIntro("L'ang Farm");
			return View();
		}

		public ActionResult Login()
		{
			return View();
		}
	}
}