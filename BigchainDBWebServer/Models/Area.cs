using System.Collections.Generic;

namespace BigchainDBWebServer.Models
{
	public class Area
	{
		public List<Tinh> LtsItem { get; set; }
		public int TotalDoanhNghiep { get; set; }
	}
	public class Tinh
	{
		public string Type { get; set; }
		public string SolrID { get; set; }
		public int ID { get; set; }
		public string Title { get; set; }
		public int STT { get; set; }
		public string Created { get; set; }
		public string Updated { get; set; }
		public int TotalDoanhNghiep { get; set; }
	}
}