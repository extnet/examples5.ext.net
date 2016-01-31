using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Xml;
using Ext.Net;
using xSubmitHandler = Ext.Net.SubmitHandler;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SubmitHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            xSubmitHandler submitData = new xSubmitHandler(context);
            Response response = new Response(true);

            try
            {
                string json = submitData.Json;
                XmlNode xml = submitData.Xml;
                List<Country> objects = submitData.Object<Country>();
                //process data
            }
            catch (Exception e)
            {
                response.Success = false;
                response.Message = e.Message;
            }

            response.Write();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    public class Country
    {
        public string Name { get; set; }
    }
}
