using Microsoft.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Owin;

namespace BigchainDBWebServer
{
	public partial class Startup
	{
		public void ConfigureAuth(IAppBuilder app)
		{
			app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);
			app.UseCookieAuthentication(new CookieAuthenticationOptions
			{
				LoginPath = new PathString("/User/Login"),
				SlidingExpiration = true
			});
			app.UseGoogleAuthentication(new GoogleOAuth2AuthenticationOptions()
			{
				ClientId = "988136019750-lrkpmiauffr8dlbjbqjjmh82aiti7iqs.apps.googleusercontent.com",
				ClientSecret = "aMCHg7U8aJhjcvH-A5LiQmvn",
				CallbackPath = new PathString("/GoogleLoginCallback")
			});
		}
		public void Configuration(IAppBuilder app)
		{
			ConfigureAuth(app);
		}
	}
}