using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using Ext.Net.Examples;
using Ext.Net;
using Ext.Net.Utilities;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ExampleLoader : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string id = context.Request["id"];
            string url = context.Request["url"];
            string action = context.Request["action"];

            if (string.IsNullOrEmpty(url))
            {
                return;
            }

            //url = url.ToLower();

            if (!url.EndsWith("/"))
            {
                url = url + "/";
            }
            
            string examplesFolder = new Uri(HttpContext.Current.Request.Url, "Examples/").AbsolutePath.ToLower();

            if (!url.StartsWith(examplesFolder,true, CultureInfo.InvariantCulture))
            {
                url = examplesFolder.TrimEnd(new []{'/'}) + url;
            }

            string wId = context.Request["wId"];

            HttpRequest r = HttpContext.Current.Request;
            Uri uri = new Uri(r.Url.Scheme + "://" + r.Url.Authority + url, UriKind.Absolute);

            string path = context.Server.MapPath(uri.AbsolutePath);
            DirectoryInfo dir = new DirectoryInfo(path);

            ExampleConfig cfg = null;

            if (File.Exists(dir.FullName + "config.xml"))
            {
                cfg = new ExampleConfig(dir.FullName + "config.xml", false);
            }

            if (action.IsNotEmpty() && false)
            {
                switch (action)
                {
                    case "comments.count" :
                        int count = 0;

                        if (cfg != null)
                        {
                            count = cfg.Comments.Count;
                        }

                        context.Response.Write(count);
                        context.Response.End();
                        return;
                    case "comments.build" :
                        if (cfg != null)
                        {
                            context.Response.Write(JSON.Serialize(cfg.Comments));
                        }
                        
                        context.Response.End();
                        return;
                    case "comments.add" :
                        if (cfg != null)
                        {
                            this.AddComment(context, cfg);
                        }
                        return;
                    case "tags.add":
                        if (cfg != null)
                        {
                            this.AddTag(context, cfg);
                        }
                        return;
                    case "tags.read":
                        if (cfg != null)
                        {
                            context.Response.Write(JSON.Serialize(cfg.Tags.ConvertAll(input => new { Tag = input })));
                        }
                        context.Response.End();
                        return;
                }
            }

            if (id.StartsWith("extnet"))
            {
                id = "e" + Math.Abs(url.ToLower().GetHashCode());
            }

            string tabs = BuildSourceTabs(id, wId, cfg, dir);

            //string script = string.Format("var w = Ext.getCmp({0});w.add({1});w.updateLayout();", JSON.Serialize(wId), tabs);
            Ext.Net.Utilities.CompressionUtils.GZipAndSend(tabs);
            //context.Response.Write(tabs);
        }

        private string Shrink(string str, int limit)
        {
            if (str.IsEmpty())
            {
                return "";
            }
            return HttpContext.Current.Server.HtmlEncode(str.Substring(0,  Math.Min(str.Length, limit)));
        }

        private static object lockObj = new object();

        private void AddTag(HttpContext context, ExampleConfig config)
        {
            lock (lockObj)
            {
                try
                {
                    config.AddTag(this.Shrink(context.Request["tag"], 128));
                    new DirectResponse().Return();
                }
                catch (Exception e)
                {
                    new DirectResponse{Success = false, ErrorMessage = e.Message}.Return();
                }
            }
        }

        private void AddComment(HttpContext context, ExampleConfig config)
        {
            lock (lockObj)
            {
                try
                {
                    string title = context.Request["CommentName"];
                    title = this.Shrink(title.IsEmpty() ? "[no title]" : title, 128);
                    string name = context.Request["UserName"];
                    name = this.Shrink( name.IsEmpty() ? "[anonymous]" : name, 128);
                    string message = this.Shrink(context.Request["CommentMessage"], 1024);

                    config.AddComment(new ExampleComment{Name = name, Title = title, Message = message});
                    context.Response.Write(JSON.Serialize(new {success = true}));
                }
                catch (Exception e)
                {
                    context.Response.Write(JSON.Serialize(new { success = false, msg = e.Message }));
                }

                context.Response.End();
            }
        }

        readonly string[] excludeFolders = new[] { ".svn", "_svn" };
        readonly string[] excludeList = new[] { "config.xml" };
        readonly string[] excludeExtensions = new[] { ".png", ".jpg", ".gif", ".bmp", ".psd" };

        private string BuildSourceTabs(string id, string wId, ExampleConfig cfg, DirectoryInfo dir)
        {
            List<string> files = cfg != null ? cfg.OuterFiles : new List<string>();

            FileInfo[] filesInfo = dir.GetFiles();
            List<FileInfo> fileList = new List<FileInfo>(filesInfo);

            int dIndex = 0;
            for (int ind = 0; ind < fileList.Count; ind++)
            {
                if (fileList[ind].Name.ToLower() == "default.aspx")
                {
                    dIndex = ind;
                }
            }

            if (dIndex>0)
            {
                FileInfo fi = fileList[dIndex];
                fileList.RemoveAt(dIndex);
                fileList.Insert(0, fi);
            }

            foreach (string file in files)
            {
                fileList.Add(new FileInfo(file));
            }

            DirectoryInfo[] resources = dir.GetDirectories("resources",SearchOption.TopDirectoryOnly);

            if (resources.Length > 0)
            {
                GetSubFiles(fileList, resources[0]); 
            }

            TabPanel tabs = new TabPanel
                                {
                                    ID = "tpw"+id,
                                    Border = false,
                                    ActiveTabIndex = 0
                                };

            int i = 0;
            foreach (FileInfo fileInfo in fileList)
            {
                if (excludeList.Contains(fileInfo.Name) || excludeExtensions.Contains(fileInfo.Extension.ToLower()))
                {
                    continue;
                }

                Panel panel = new Panel();
                panel.ID = "tptw" + id + i++;
                panel.Title = fileInfo.Name;
                panel.CustomConfig.Add(new ConfigItem("url", UIHelpers.PhysicalToVirtual(fileInfo.FullName), ParameterMode.Value));
                switch (fileInfo.Extension)
                {
                    case ".aspx":
                    case ".ascx":
                        panel.Icon = Icon.PageWhiteCode;
                        break;
                    case ".cs":
                        panel.Icon = Icon.PageWhiteCsharp;
                        break;
                    case ".xml":
                    case ".xsl":
                        panel.Icon = Icon.ScriptCodeRed;
                        break;
                    case ".js":
                        panel.Icon = Icon.Script;
                        break;
                    case ".css":
                        panel.Icon = Icon.Css;
                        break;
                }
                panel.Loader = new ComponentLoader();
                panel.Loader.Url = UIHelpers.ApplicationRoot + "/GenerateSource.ashx";
                panel.Loader.Mode = LoadMode.Frame;
                panel.Loader.Params.Add(new Parameter("f", UIHelpers.PhysicalToVirtual(fileInfo.FullName), ParameterMode.Value));
                panel.Loader.LoadMask.ShowMask = true;

                tabs.Items.Add(panel);
            }

            return tabs.ToScript(RenderMode.AddTo, wId);
        }

        private void GetSubFiles(List<FileInfo> fileList, DirectoryInfo dir)
        {
            FileInfo[] filesInfo = dir.GetFiles();

            foreach (FileInfo file in filesInfo)
            {
                if (excludeList.Contains(file.Name) || excludeExtensions.Contains(file.Extension.ToLower()))
                {
                    continue;
                }
                fileList.Add(file);
            }

            DirectoryInfo[] folders = dir.GetDirectories();
            foreach (DirectoryInfo folder in folders)
            {
                if (excludeFolders.Contains(folder.Name.ToLower()) || folder.Name.StartsWith("_"))
                {
                    continue;
                }

                GetSubFiles(fileList, folder);
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
