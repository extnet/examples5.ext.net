using System;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;

namespace Ext.Net.Examples.FeedViewer
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class FeedProxy : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string url = context.Request["feed"];

            if (url == null || !url.StartsWith("http://"))
            {
                return;
            }

            Encoding enc = Encoding.GetEncoding("ISO-8859-1");

            WebRequest request = WebRequest.Create(url);
            WebResponse response = request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream(), enc);
            context.Response.ContentType = "text/xml";
            context.Response.ContentEncoding = enc;
            context.Response.Cache.SetExpires(DateTime.Now.AddSeconds(60));
            context.Response.Cache.SetCacheability(HttpCacheability.Public);

            StringBuilder sb = new StringBuilder(reader.ReadToEnd());
            sb.Replace("<content:encoded>", "<content>")
              .Replace("</content:encoded>", "</content>")
              .Replace("</dc:creator>", "</author>")              
              .Replace("<dc:creator", "<author");

            var xml = sb.ToString();
            xml = Regex.Replace(xml, "[\\n\\r]", "");
            xml = Regex.Replace(xml, ">\\s+<", "><");
            xml = Regex.Replace(xml, "<title>(?!<\\!\\[CDATA\\[)", "<title><![CDATA[");
            xml = Regex.Replace(xml, "([^\\]][^\\]][^>])<\\/title>", "$1]]></title>");
            xml = Regex.Replace(xml, "<author>(?!<\\!\\[CDATA\\[)", "<author><![CDATA[");
            xml = Regex.Replace(xml, "([^\\]][^\\]][^>])<\\/author>", "$1]]></author>");
            xml = Regex.Replace(xml, "<description>(?!<\\!\\[CDATA\\[)", "<description><![CDATA[");
            xml = Regex.Replace(xml, "([^\\]][^\\]][^>])<\\/description>", "$1]]></description>");
            xml = Regex.Replace(xml, "<link>(?!<\\!\\[CDATA\\[)", "<link><![CDATA[");
            xml = Regex.Replace(xml, "([^\\]][^\\]][^>])<\\/link>", "$1]]></link>");
   
            context.Response.Write(xml);
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
