using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ext.Net.Examples.Examples.Loaders.Data.Overview
{
    /// <summary>
    /// Сводное описание для DataHandler
    /// </summary>
    public class DataHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            Ext.Net.Utilities.CompressionUtils.GZipAndSend(JSON.Serialize(new List<object>()
            {
                new {FirstName = "First 1", LastName = "Last 1"},
                new {FirstName = "First 2", LastName = "Last 2"},
                new {FirstName = "First 3", LastName = "Last 3"},
                new {FirstName = "First 4", LastName = "Last 4"},
                new {FirstName = "First 5", LastName = "Last 5"}
            }));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}