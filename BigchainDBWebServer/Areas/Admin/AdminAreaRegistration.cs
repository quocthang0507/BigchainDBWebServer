using System.Web.Mvc;

namespace BigchainDBWebServer.Areas.Admin
{
	public class AdminAreaRegistration : AreaRegistration
	{
		public override string AreaName
		{
			get
			{
				return "Admin";
			}
		}

		public override void RegisterArea(AreaRegistrationContext context)
		{
			context.MapRoute("AdminLogin", "Admin/",
				new { action = "Login", controller = "UserAD" });
			context.MapRoute("AdminAction", "Admin/{action}",
				new { controller = "HomeAD" });
			context.MapRoute(
				"Admin_default",
				"Admin/{controller}/{action}/{id}",
				new { action = "Index", id = UrlParameter.Optional }
			);
		}
	}
}