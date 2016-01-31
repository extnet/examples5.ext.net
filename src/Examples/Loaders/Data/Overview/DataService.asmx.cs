using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Ext.Net.Examples.Examples.Loaders.Data.Overview
{
    /// <summary>
    /// Сводное описание для DataService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    [System.Web.Script.Services.ScriptService]
    public class DataService : System.Web.Services.WebService
    {
        [WebMethod]
        public List<object> GetData()
        {
            return new List<object>()
            {
                new {FirstName = "First 1", LastName = "Last 1"},
                new {FirstName = "First 2", LastName = "Last 2"},
                new {FirstName = "First 3", LastName = "Last 3"},
                new {FirstName = "First 4", LastName = "Last 4"},
                new {FirstName = "First 5", LastName = "Last 5"}
            };
        }
    }
}
