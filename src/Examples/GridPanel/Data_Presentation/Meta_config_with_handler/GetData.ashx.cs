using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ext.Net.Examples.Examples.GridPanel.Data_Presentation.Meta_config_with_handler
{
    /// <summary>
    /// Summary description for GetData
    /// </summary>
    public class GetData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";
            string meta = context.Request["meta"] ?? "1";

            object data;
            if (meta == "1")
            {
                data = new List<object> { 
                    new { ID = 1,  StringField = "string", BooleanField = "boolean"},
                    new { ID = 2,  StringField = "string", BooleanField = "boolean"},
                    new { ID = 3,  StringField = "string", BooleanField = "boolean"},
                    new { ID = 4,  StringField = "string", BooleanField = "boolean"},
                    new { ID = 5,  StringField = "string", BooleanField = "boolean"}
                };
            }
            else
            {
                data = new List<object> { 
                    new { ID = 1,  DateField = DateTime.Now, NumberField = 472.96},
                    new { ID = 2,  DateField = DateTime.Now, NumberField = 472.96},
                    new { ID = 3,  DateField = DateTime.Now, NumberField = 472.96},
                    new { ID = 4,  DateField = DateTime.Now, NumberField = 472.96},
                    new { ID = 5,  DateField = DateTime.Now, NumberField = 472.96}
                };
            }

            MetaConfig metaData = MetaConfig.From(data);
            metaData.IDProperty = "ID";
            metaData.RootProperty = "data";

            new StoreResponseData
            {
                Data = JSON.Serialize(data),
                MetaData = metaData
            }.Return();
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