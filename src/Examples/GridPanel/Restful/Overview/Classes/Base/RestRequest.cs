using System;
using System.Text.RegularExpressions;
using System.Web;
using Ext.Net.Utilities;
using System.IO;

namespace Ext.Net.Examples.Restful
{
    public class RestRequest
    {
        public RestRequest(HttpContext context)
        {
            this.Context = context;

            this.Method = this.Context.Request.HttpMethod;
            using(StreamReader sr = new StreamReader(context.Request.InputStream))
            {
                this.Data = sr.ReadToEnd();
            }

            if (context.Request.PathInfo.IsNotEmpty())
            {
                Regex cai = new Regex("^\\/([a-z]+\\w)\\/([a-z]+\\w)\\/([0-9]+)$"); //   /controller/action/id
                Regex ca = new Regex("^\\/([a-z]+\\w)\\/([a-z]+\\w)\\/([0-9]+)$");  //   /controller/action
                Regex ci = new Regex("^\\/([a-z]+\\w)\\/([0-9]+)$");                //   /controller/id
                Regex c = new Regex("^\\/([a-z]+\\w)$");                            //   /controller
                Regex i = new Regex("^\\/([0-9]+)$");                               //   /id   

                Match match;

                if ((match = cai.Match(context.Request.PathInfo)).Success)
                {
                    this.ControllerName = match.Groups[1].Value;
                    this.Action = match.Groups[2].Value;
                    this.Id = int.Parse(match.Groups[3].Value);
                }
                else if ((match = ca.Match(context.Request.PathInfo)).Success)
                {
                    this.ControllerName = match.Groups[1].Value;
                    this.Action = match.Groups[2].Value;
                }
                else if ((match = ci.Match(context.Request.PathInfo)).Success)
                {
                    this.ControllerName = match.Groups[1].Value;
                    this.Id = int.Parse(match.Groups[2].Value);
                }
                else if ((match = c.Match(context.Request.PathInfo)).Success)
                {
                    this.ControllerName = match.Groups[1].Value;
                }
                else if ((match = i.Match(context.Request.PathInfo)).Success)
                {
                    this.Id = int.Parse(match.Groups[1].Value);
                }
            }
        }

        public Controller Controller
        {
            get
            {
                if (this.ControllerName.IsEmpty())
                {
                    return null;
                }

                // It is better to use Activator.CreateInstance<T> Method
                // but it is not working in medium trust level: Security exception

                switch (this.ControllerName)
                {
                    case  "person":
                        return new PersonController();
                }

                return null;
            }
        }

        public HttpContext Context { get; private set; }

        public string Method { get; private set; }

        public string ControllerName { get; private set; }

        public string Action { get; private set; }

        public int Id { get; private set; }

        public string Data { get; private set; }
    }
}
