//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BigchainDBWebServer.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserBC
    {
        public int id { get; set; }
        public string username { get; set; }
        public string pwd { get; set; }
        public string Area { get; set; }
        public string City { get; set; }
        public string name { get; set; }
        public Nullable<System.DateTime> birthday { get; set; }
        public string email { get; set; }
        public string adrs { get; set; }
        public string phone { get; set; }
        public Nullable<int> idRole { get; set; }
        public Nullable<int> active { get; set; }
        public Nullable<System.DateTime> dateCreated { get; set; }
        public Nullable<System.DateTime> dateUpdate { get; set; }
        public Nullable<int> deleted { get; set; }
        public string company { get; set; }
    }
}
