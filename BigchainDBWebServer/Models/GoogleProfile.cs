using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BigchainDBWebServer.Models
{
    public class GoogleProfile
    {
		public string Id { get; set; }
		public string Name { get; set; }
		public string Picture { get; set; }
		public string Email { get; set; }
		public string Gender { get; set; }
		public string ObjectType { get; set; }
	}
}