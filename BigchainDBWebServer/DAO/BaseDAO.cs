using BigchainDBWebServer.Models;
using Newtonsoft.Json;

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

	/// <summary>
	/// Lớp Trạng thái phê duyệt
	/// </summary>
	public class ResultOfRequest
	{
		public bool Success { get; set; }
		public string Message { get; set; }

		public ResultOfRequest()
		{
			Success = true;
			Message = "";
		}

		public ResultOfRequest(bool success)
		{
			Success = success;
			Message = "";
		}

		public ResultOfRequest(bool success, string message)
		{
			this.Success = success;
			this.Message = message;
		}

		public string ToJson()
		{
			return JsonConvert.SerializeObject(this);
		}
	}
}