using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;

namespace Ext.Net.Examples.Restful
{
    /// <summary>
    /// The handler for Restful operations on a Person
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class RestfulPersons : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                PersonModel.InitDB();
                RestRequest r = new RestRequest(context);
                r.Controller.Dispatch(r).Return();
            }
            catch (Exception e)
            {
                new Response(false, e.Message).Return();
            }
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
