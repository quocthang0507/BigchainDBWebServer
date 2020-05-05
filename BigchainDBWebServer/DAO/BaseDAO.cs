using BigchainDBWebServer.Models;

namespace BigchainDBWebServer.DAO
{
	public class BaseDAO
	{
		public BaseDAO()
		{
			Model = new QLNongSanEntities();
		}
		public QLNongSanEntities Model { get; set; }
	}
}