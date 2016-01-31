using System.Collections;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using Ext.Net.Examples;
using ICSharpCode.SharpZipLib.Zip;
using Wilco.SyntaxHighlighting;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class GenerateSource : IHttpHandler
    {
        private readonly string[] excludeFiles = new[] { "config.xml", "thumbnail.png", "thumbnail.gif" };
        private readonly string[] excludeFolders = new[] { ".svn", "_svn" };

        private string CutFromTo(string str, string start, string end)
        {
            var startPos = str.IndexOf(start);

            if (startPos < 0)
            {
                return string.Empty;
            }

            var endPos = str.IndexOf(end, startPos);

            if (endPos < 0)
            {
                return string.Empty;
            }

            return str.Substring(startPos + start.Length, endPos - startPos - start.Length);
        }

        public void ProcessRequest(HttpContext context)
        {
            string examplesRoot = context.Server.MapPath(UIHelpers.ApplicationRoot + "/Examples/");
            string codeRoot = context.Server.MapPath(UIHelpers.ApplicationRoot + "/Code/");
            string path;
            string url;

            string transmit = context.Request["t"];

            if (!string.IsNullOrEmpty(transmit))
            {
                url = context.Request["e"];
                if (string.IsNullOrEmpty(url))
                {
                    return;
                }
                url = "/Examples" + url;
                path = context.Server.MapPath(url);

                if (!path.StartsWith(examplesRoot, true, CultureInfo.CurrentCulture) &&
                    !path.StartsWith(codeRoot, true, CultureInfo.CurrentCulture))
                {
                    return;
                }

                context.Response.ContentType = "application/octet-stream";
                context.Response.AppendHeader("Connection", "keep-alive");
                context.Response.AppendHeader("Content-Disposition",
                                              string.Concat(" attachment; filename = ", new DirectoryInfo(path).Name,
                                                            ".zip"));

                ZipFiles(path);
                context.Response.End();
                return;
            }

            context.Response.ContentType = "text/html";

            url = context.Request["f"];
            path = context.Server.MapPath(url);
            FileInfo fi = new FileInfo(path);

            if (!path.StartsWith(examplesRoot, true, CultureInfo.CurrentCulture) &&
                    !path.StartsWith(codeRoot, true, CultureInfo.CurrentCulture))
            {
                return;
            }

            HighlighterBase hb = null;
            bool markup = false;

            switch (fi.Extension.ToLowerInvariant())
            {
                case ".aspx":
                case ".ascx":
                case ".master":
                    hb = new ASPXHighlighter();
                    markup = true;
                    break;
                case ".cs":
                    hb = new CSharpHighlighter();
                    break;
                case ".xml":
                case ".xsl":
                    hb = new XMLHighlighter();
                    break;
                case ".js":
                    hb = new JavaScriptHighlighter();
                    break;
                case ".css":
                    hb = new CSSHighlighter();
                    break;
                default:
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(File.ReadAllText(fi.FullName));
                    return;
            }

            string fileText = File.ReadAllText(fi.FullName);

            if (markup)
            {
                string origCSScriptStart = @"<script runat=""server"">";
                string origCSScriptEnd = @"</script>";
                string origJSScriptStart = @"<script>";
                string origJSScriptEnd = @"</script>";
                string origCSScriptText = CutFromTo(fileText, origCSScriptStart, origCSScriptEnd);
                string origJSScriptText = CutFromTo(fileText, origJSScriptStart, origJSScriptEnd);

                fileText = HighLighterUtils.SourceToHtml(fileText, hb);

                if (!string.IsNullOrEmpty(origCSScriptText))
                {
                    string strCSScriptStart = CutFromTo(HighLighterUtils.SourceToHtml(origCSScriptStart, hb), ">", "</pre>");
                    string strCSScriptEnd = CutFromTo(HighLighterUtils.SourceToHtml(origCSScriptEnd, hb), ">", "</pre>");
                    string csText = CutFromTo(fileText, strCSScriptStart, strCSScriptEnd);

                    fileText = fileText.Replace(csText, CutFromTo(HighLighterUtils.CSharpToHtml(origCSScriptText), ">", "</pre>"));
                }

                if (!string.IsNullOrEmpty(origJSScriptText))
                {
                    string strJSScriptStart = CutFromTo(HighLighterUtils.SourceToHtml(origJSScriptStart, hb), ">", "</pre>");
                    string strJSScriptEnd = CutFromTo(HighLighterUtils.SourceToHtml(origJSScriptEnd, hb), ">", "</pre>");
                    string jsText = CutFromTo(fileText, strJSScriptStart, strJSScriptEnd);

                    fileText = fileText.Replace(jsText, CutFromTo(HighLighterUtils.JsToHtml(origJSScriptText), ">", "</pre>"));
                }

                context.Response.Write(fileText);
            }
            else
            {
                context.Response.Write(HighLighterUtils.SourceToHtml(fileText, hb));
            }
        }

        public bool IsReusable
        {
            get { return false; }
        }

        public void ZipFiles(string inputFolderPath)
        {
            ArrayList ar = GenerateFileList(inputFolderPath);
            int trimLength = (Directory.GetParent(inputFolderPath)).ToString().Length;
            trimLength += 1;
            FileStream ostream;
            byte[] obuffer;

            ZipOutputStream oZipStream = new ZipOutputStream(HttpContext.Current.Response.OutputStream);

            oZipStream.SetLevel(6);
            ZipEntry oZipEntry;
            foreach (string file in ar)
            {
                oZipEntry = new ZipEntry(file.Remove(0, trimLength));
                oZipStream.PutNextEntry(oZipEntry);

                if (!file.EndsWith(@"/")) // if a file ends with '/' its a directory
                {
                    ostream = File.OpenRead(file);
                    obuffer = new byte[ostream.Length];
                    ostream.Read(obuffer, 0, obuffer.Length);
                    oZipStream.Write(obuffer, 0, obuffer.Length);
                }
            }

            if (File.Exists(inputFolderPath + "config.xml"))
            {
                ExampleConfig cfg = new ExampleConfig(inputFolderPath + "config.xml", true);
                foreach (string file in cfg.OuterFiles)
                {
                    oZipEntry = new ZipEntry(new FileInfo(file).Name);
                    oZipStream.PutNextEntry(oZipEntry);
                    ostream = File.OpenRead(file);
                    obuffer = new byte[ostream.Length];
                    ostream.Read(obuffer, 0, obuffer.Length);
                    oZipStream.Write(obuffer, 0, obuffer.Length);
                }

                foreach (string folder in cfg.ZipFolders)
                {
                    ar = GenerateFileList(folder);
                    DirectoryInfo dir = new DirectoryInfo(folder);
                    trimLength = dir.Parent.FullName.Length;
                    trimLength += 1;

                    //oZipEntry = new ZipEntry(dir.Name);
                    //oZipStream.PutNextEntry(oZipEntry);

                    foreach (string file in ar)
                    {
                        oZipEntry = new ZipEntry(file.Remove(0, trimLength));
                        oZipStream.PutNextEntry(oZipEntry);

                        if (!file.EndsWith(@"/")) // if a file ends with '/' its a directory
                        {
                            ostream = File.OpenRead(file);
                            obuffer = new byte[ostream.Length];
                            ostream.Read(obuffer, 0, obuffer.Length);
                            oZipStream.Write(obuffer, 0, obuffer.Length);
                        }
                    }
                }
            }

            oZipStream.Finish();
            oZipStream.Close();
        }

        private ArrayList GenerateFileList(string dir)
        {
            DirectoryInfo dirInfo = new DirectoryInfo(dir);
            ArrayList fils = new ArrayList();

            if (excludeFolders.Contains(dirInfo.Name.ToLower()) || dirInfo.Name.StartsWith("_"))
            {
                return fils;
            }

            bool empty = true;
            foreach (string file in Directory.GetFiles(dir))
            {
                if (excludeFiles.Contains(new FileInfo(file).Name))
                {
                    continue;
                }
                fils.Add(file);
                empty = false;
            }

            if (empty)
            {
                if (Directory.GetDirectories(dir).Length == 0)
                {
                    fils.Add(dir + @"/");
                }
            }

            foreach (string dirs in Directory.GetDirectories(dir))
            {
                foreach (object obj in GenerateFileList(dirs))
                {
                    fils.Add(obj);
                }
            }

            return fils; // return file list
        }
    }
}