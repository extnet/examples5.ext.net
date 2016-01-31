using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using Ext.Net.Examples;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class PlantHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            StoreRequestParameters prms = new StoreRequestParameters(context);
            Paging<Plant> plants = Plant.PlantsPaging(prms.Start, prms.Limit, prms.Sort[0].Property, prms.Sort[0].Direction.ToString(), string.Empty);

            context.Response.Write(JSON.Serialize(plants));
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
