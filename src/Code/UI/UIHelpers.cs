using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Xml;

namespace Ext.Net.Examples
{
    public class UIHelpers
    {
        public static NodeCollection BuildTreeNodes(bool refreshSiteMap)
        {
            XmlDocument map = null;
            XmlElement root = null;
            XmlElement examplesNode = null;

            if (refreshSiteMap)
            {
                map = new XmlDocument();
                XmlDeclaration dec = map.CreateXmlDeclaration("1.0", "utf-8", null);
                map.AppendChild(dec);

                root = map.CreateElement("siteMap");
                root.SetAttribute("xmlns", "http://schemas.microsoft.com/AspNet/SiteMap-File-1.0");
                map.AppendChild(root);

                examplesNode = map.CreateElement("siteMapNode");
                examplesNode.SetAttribute("title", "Examples");
                root.AppendChild(examplesNode);
            }

            string path = HttpContext.Current.Server.MapPath("~/Examples/");

            NodeCollection result = UIHelpers.BuildTreeLevel(new DirectoryInfo(path), 1, 3, examplesNode);

            if (root != null && root.ChildNodes.Count > 0)
            {
                map.Save(HttpContext.Current.Server.MapPath("Web.sitemap"));
            }

            return result;
        }

        public static string ApplicationRoot
        {
            get
            {
                string root = HttpContext.Current.Request.ApplicationPath;
                return root == "/" ? "" : root;
            }
        }

        private static readonly string[] excludeList = { ".svn", "_svn", "Shared" };

        public static NodeCollection BuildFirstLevel()
        {
            string path = HttpContext.Current.Server.MapPath("~/Examples/");
            DirectoryInfo root = new DirectoryInfo(path);
            DirectoryInfo[] folders = root.GetDirectories();
            folders = UIHelpers.SortFolders(root, folders);

            NodeCollection nodes = new NodeCollection(false);

            foreach (DirectoryInfo folder in folders)
            {
                if ((folder.Attributes & FileAttributes.Hidden) == FileAttributes.Hidden ||
                    excludeList.Contains(folder.Name) || folder.Name.StartsWith("_"))
                {
                    continue;
                }

                ExampleConfig cfg = new ExampleConfig(folder.FullName + "\\config.xml", false);

                string iconCls = string.IsNullOrEmpty(cfg.IconCls) ? "" : cfg.IconCls;
                Node node = new Node();

                node.Text = folder.Name.Replace("_", " ");

                if (UIHelpers.IsNew(folder.FullName))
                {
                    node.CustomAttributes.Add(new ConfigItem("isNew", "true", ParameterMode.Raw));
                }

                node.IconCls = iconCls;

                string url = UIHelpers.PhysicalToVirtual(folder.FullName + "/");
                node.NodeID = "e" + Math.Abs(url.ToLower().GetHashCode());

                nodes.Add(node);
            }

            return nodes;
        }

        private static NodeCollection BuildTreeLevel(DirectoryInfo root, int level, int maxLevel, XmlElement siteMap)
        {
            DirectoryInfo[] folders = root.GetDirectories();

            folders = SortFolders(root, folders);

            NodeCollection nodes = new NodeCollection(false);

            foreach (DirectoryInfo folder in folders)
            {
                if ((folder.Attributes & FileAttributes.Hidden) == FileAttributes.Hidden ||
                    excludeList.Contains(folder.Name) || folder.Name.StartsWith("_"))
                {
                    continue;
                }

#if !PREEXTENSIONS
                if (level == 1 && (folder.Name == "Gantt" || folder.Name == "Scheduler"))
                {
                    continue;
                }
#endif

                ExampleConfig cfg = new ExampleConfig(folder.FullName + "\\config.xml", false);

                string iconCls = string.IsNullOrEmpty(cfg.IconCls) ? "" : cfg.IconCls;
                Node node = new Node();
                XmlElement siteNode = null;

                string folderName = folder.Name.Replace("_", " ");

                if (level < maxLevel)
                {
                    node.Text = folderName;

                    if (UIHelpers.IsNew(folder.FullName))
                    {
                        node.CustomAttributes.Add(new ConfigItem("isNew", "true", ParameterMode.Raw));
                    }

                    node.IconCls = iconCls;
                    node.NodeID = BaseControl.GenerateID();
                    //node.SingleClickExpand = true;

                    if (siteMap != null)
                    {
                        siteNode = siteMap.OwnerDocument.CreateElement("siteMapNode");
                        siteNode.SetAttribute("title", folderName);
                        siteMap.AppendChild(siteNode);
                    }

                    node.Children.AddRange(UIHelpers.BuildTreeLevel(folder, level + 1, maxLevel, siteNode));
                }
                else
                {
                    node.Text = folderName;

                    if (UIHelpers.IsNew(folder.FullName))
                    {
                        node.CustomAttributes.Add(new ConfigItem("isNew", "true", ParameterMode.Raw));
                    }

                    node.IconCls = iconCls;
                    string url = PhysicalToVirtual(folder.FullName + "/");
                    node.NodeID = "e" + Math.Abs(url.ToLower().GetHashCode());
                    //node.Href = Regex.Replace(url, "^/Examples","");
                    node.CustomAttributes.Add(new ConfigItem("url", Regex.Replace(url, "^/Examples", "")));

                    node.Leaf = true;

                    if (siteMap != null)
                    {
                        siteNode = siteMap.OwnerDocument.CreateElement("siteMapNode");
                        siteNode.SetAttribute("title", folderName);
                        siteNode.SetAttribute("description", string.IsNullOrEmpty(cfg.Description) ? "No description" : cfg.Description);
                        siteNode.SetAttribute("url", "~" + UIHelpers.PhysicalToVirtual(folder.FullName + "/"));
                        siteMap.AppendChild(siteNode);
                    }
                }

                node.CustomAttributes.Add(new { tags = cfg.Tags.Select( item => item.ToLower()) });

                nodes.Add(node);
            }

            return nodes;
        }

        private static ExampleConfig rootCfg;

        private static bool IsNew(string folder)
        {
            if (rootCfg == null)
            {
                rootCfg = new ExampleConfig(new DirectoryInfo(HttpContext.Current.Server.MapPath("~/Examples/")) + "\\config.xml", false);
            }

            foreach (string newFolder in rootCfg.NewFolders)
            {
                string newPath = string.Concat(HttpContext.Current.Server.MapPath("~/Examples/"), newFolder);

                if (newPath.StartsWith(folder, StringComparison.CurrentCultureIgnoreCase))
                {
                    string end = newPath.Substring(folder.Length);

                    if ((end.StartsWith("\\") || end.Equals("")))
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        private static DirectoryInfo[] SortFolders(DirectoryInfo root, DirectoryInfo[] folders)
        {
            string cfgPath = root.FullName + "\\config.xml";

            if (File.Exists(root.FullName + "\\config.xml"))
            {
                ExampleConfig rootCfg = new ExampleConfig(cfgPath, false);

                if (rootCfg.OrderFolders.Count > 0)
                {
                    List<DirectoryInfo> list = new List<DirectoryInfo>(folders);
                    int pasteIndex = 0;

                    foreach (string orderFolder in rootCfg.OrderFolders)
                    {
                        int dIndex = 0;

                        for (int ind = 0; ind < list.Count; ind++)
                        {
                            if (list[ind].Name.ToLower() == orderFolder)
                            {
                                dIndex = ind;
                            }
                        }

                        if (dIndex > 0)
                        {
                            DirectoryInfo di = list[dIndex];
                            list.RemoveAt(dIndex);
                            list.Insert(pasteIndex++, di);
                        }
                    }

                    folders = list.ToArray();
                }
            }

            return folders;
        }

        public static void FindExamples(DirectoryInfo root, int level, int maxLevel, List<ExampleGroup> examples)
        {
            DirectoryInfo[] folders = root.GetDirectories();
            folders = SortFolders(root, folders);

            foreach (DirectoryInfo folder in folders)
            {
                if ((folder.Attributes & FileAttributes.Hidden) == FileAttributes.Hidden ||
                    excludeList.Contains(folder.Name) || folder.Name.StartsWith("_"))
                {
                    continue;
                }

                if (level < maxLevel)
                {
                    if (level == 1)
                    {
                        examples.Add(new ExampleGroup { id = folder.Name, title = folder.Name });
                    }

                    UIHelpers.FindExamples(folder, level + 1, maxLevel, examples);
                }
                else
                {
                    string imgUrl = UIHelpers.ApplicationRoot+"/resources/images/noimage.gif";
                    string descr = "No description";
                    string name = folder.Name.Replace("_", " ");

                    if (UIHelpers.IsNew(folder.FullName))
                    {
                        name += "<span>&nbsp;</span>";
                    }

                    if (File.Exists(folder.FullName + "\\config.xml"))
                    {
                        ExampleConfig cfg = new ExampleConfig(folder.FullName + "\\config.xml", false);
                        descr = cfg.Description;
                    }

                    if (File.Exists(folder.FullName + "\\thumbnail.png"))
                    {
                        imgUrl = PhysicalToVirtual(folder.FullName + "\\thumbnail.png");
                    }
                    else if (File.Exists(folder.FullName + "\\thumbnail.gif"))
                    {
                        imgUrl = PhysicalToVirtual(folder.FullName + "\\thumbnail.gif");
                    }

                    string url = PhysicalToVirtual(folder.FullName + "/");

                    ExampleGroup group = examples[examples.Count - 1];
                    group.samples.Add(new { id = "e" + Math.Abs(url.ToLower().GetHashCode()), name, url, imgUrl, descr, sub = folder.Parent.Name.Replace("_", " ") });
                }
            }
        }

        public static string PhysicalToVirtual(string physicalPath)
        {
            string pathOfWebRoot = HttpContext.Current.Server.MapPath("~/").ToLower();

            int index = physicalPath.IndexOf(pathOfWebRoot,StringComparison.InvariantCultureIgnoreCase);

            if (index == -1)
                throw new Exception("Physical path can't be mapped to the current application.");

            string relUrl = Path.DirectorySeparatorChar.ToString();

            index += pathOfWebRoot.Length;
            relUrl += physicalPath.Substring(index);

            relUrl = relUrl.Replace("\\", "/");

            return UIHelpers.ApplicationRoot + relUrl;
        }

        public static string PhysicalToAbsolute(string physicalPath)
        {
            HttpRequest r = HttpContext.Current.Request;

            return r.Url.Scheme + "://" + r.Url.Authority + PhysicalToVirtual(physicalPath);
        }
    }

    public class ExampleConfig
    {
        private string path;
        private bool includeDescriptors;

        public ExampleConfig(string path, bool includeDescriptors)
        {
            this.path = path;
            this.includeDescriptors = includeDescriptors;
            this.Load();
        }

        private void Load()
        {
            this.Description = "No description";
            XmlDocument xml = new XmlDocument();

            if (File.Exists(path))
            {
                try
                {
                    xml.Load(path);
                }
                catch (FileNotFoundException)
                {
                    return;
                }
            }

            XmlNode root = xml.SelectSingleNode("example");

            if (root == null)
            {
                return;
            }

            XmlAttribute iconCls = root.Attributes["iconCls"];

            if (iconCls != null)
            {
                this.IconCls = iconCls.Value;
            }

            XmlNode desc = root.SelectSingleNode("description");

            if (desc != null)
            {
                this.Description = desc.InnerText;
            }

            XmlNodeList files = root.SelectNodes("include/file");

            if (files != null)
            {
                string url = UIHelpers.PhysicalToAbsolute(path);
                foreach (XmlNode file in files)
                {
                    XmlAttribute urlAttr = file.Attributes["url"];
                    XmlAttribute zipAttr = file.Attributes["zip"];

                    if (includeDescriptors && zipAttr != null && zipAttr.InnerText.ToLower() == "false")
                    {
                        continue;
                    }

                    if (urlAttr != null && !string.IsNullOrEmpty(urlAttr.InnerText))
                    {
                        string fileUrl = urlAttr.InnerText;
                        Uri uri = new Uri(new Uri(url, UriKind.Absolute), fileUrl);
                        this.OuterFiles.Add(HttpContext.Current.Server.MapPath(uri.AbsolutePath));

                        if (includeDescriptors && (fileUrl.EndsWith("ashx.cs") || fileUrl.EndsWith("asmx.cs")))
                        {
                            uri = new Uri(new Uri(url, UriKind.Absolute), fileUrl.Remove(fileUrl.Length - 3, 3));
                            this.OuterFiles.Add(HttpContext.Current.Server.MapPath(uri.AbsolutePath));
                        }
                    }
                }
            }

            XmlNodeList folders = root.SelectNodes("zip-folders/folder");

            if (folders != null)
            {
                string url = UIHelpers.PhysicalToAbsolute(path);

                foreach (XmlNode folder in folders)
                {
                    XmlAttribute urlAttr = folder.Attributes["url"];

                    if (urlAttr != null && !string.IsNullOrEmpty(urlAttr.InnerText))
                    {
                        string folderUrl = urlAttr.InnerText;
                        Uri uri = new Uri(new Uri(url, UriKind.Absolute), folderUrl);
                        this.ZipFolders.Add(HttpContext.Current.Server.MapPath(uri.AbsolutePath));
                    }
                }
            }

            folders = root.SelectNodes("order/folder");

            if (folders != null)
            {
                foreach (XmlNode folder in folders)
                {
                    XmlAttribute urlAttr = folder.Attributes["name"];

                    if (urlAttr != null && !string.IsNullOrEmpty(urlAttr.InnerText))
                    {
                        string folderName = urlAttr.InnerText;
                        this.OrderFolders.Add(folderName.ToLower());
                    }
                }
            }

            folders = root.SelectNodes("new/folder");

            if (folders != null)
            {
                foreach (XmlNode folder in folders)
                {
                    XmlAttribute urlAttr = folder.Attributes["name"];

                    if (urlAttr != null && !string.IsNullOrEmpty(urlAttr.InnerText))
                    {
                        string folderName = urlAttr.InnerText;
                        this.NewFolders.Add(folderName.ToLower());
                    }
                }
            }

            XmlNodeList xmlComments = root.SelectNodes("comments/comment");

            if (xmlComments != null)
            {
                foreach (XmlNode xmlComment in xmlComments)
                {
                    try
                    {
                        ExampleComment comment = new ExampleComment();

                        XmlAttribute attr = xmlComment.Attributes["name"];
                        if (attr != null && !string.IsNullOrEmpty(attr.InnerText))
                        {
                            comment.Name = HttpContext.Current.Server.HtmlEncode(attr.InnerText);
                        }

                        attr = xmlComment.Attributes["title"];
                        if (attr != null && !string.IsNullOrEmpty(attr.InnerText))
                        {
                            comment.Title = HttpContext.Current.Server.HtmlEncode(attr.InnerText);
                        }

                        attr = xmlComment.Attributes["time"];
                        if (attr != null && !string.IsNullOrEmpty(attr.InnerText))
                        {
                            comment.Time = DateTime.Parse(attr.InnerText, new CultureInfo("en-US"));
                        }

                        XmlNode message = xmlComment.SelectSingleNode("message");
                        if (message != null && !string.IsNullOrEmpty(message.InnerText))
                        {
                            comment.Message = HttpContext.Current.Server.HtmlEncode(message.InnerText);
                        }

                        this.Comments.Add(comment);
                    }
                    catch {  }
                }
            }

            XmlNode tagsNode = root.SelectSingleNode("tags");

            if (tagsNode != null)
            {
                this.Tags.AddRange(tagsNode.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
            }
        }

        public string IconCls { get; private set; }

        public string Title { get; private set; }

        public string Description { get; private set; }

        private List<string> outerFiles;

        public List<string> OuterFiles
        {
            get
            {
                if (this.outerFiles == null)
                {
                    this.outerFiles = new List<string>();
                }
                return outerFiles;
            }
        }

        private List<string> zipFolders;

        public List<string> ZipFolders
        {
            get
            {
                if (this.zipFolders == null)
                {
                    this.zipFolders = new List<string>();
                }
                return zipFolders;
            }
        }

        private List<string> orderFolders;
        public List<string> OrderFolders
        {
            get
            {
                if (this.orderFolders == null)
                {
                    this.orderFolders = new List<string>();
                }
                return this.orderFolders;
            }
        }

        private List<string> newFolders;
        public List<string> NewFolders
        {
            get
            {
                if (this.newFolders == null)
                {
                    this.newFolders = new List<string>();
                }
                return this.newFolders;
            }
        }

        private List<ExampleComment> comments;
        public List<ExampleComment> Comments
        {
            get
            {
                if (this.comments == null)
                {
                    this.comments = new List<ExampleComment>();
                }
                return this.comments;
            }
        }

        private List<string> tags;
        public List<string> Tags
        {
            get
            {
                if (this.tags == null)
                {
                    this.tags = new List<string>();
                }
                return this.tags;
            }
        }

        public void AddTag(string tag)
        {
            XmlDocument xml = new XmlDocument();

            if (File.Exists(path))
            {
                try
                {
                    xml.Load(path);
                }
                catch (FileNotFoundException)
                {
                    return;
                }
            }

            XmlNode root = xml.SelectSingleNode("example");

            if (root == null)
            {
                return;
            }

            XmlElement elem;
            XmlNode tagsNode = root.SelectSingleNode("tags");
            if (tagsNode == null)
            {
                elem = xml.CreateElement("tags");
                root.AppendChild(elem);
                tagsNode = root.SelectSingleNode("tags");
            }

            string[] tagsArr = (tagsNode.InnerText??"").Split(',');

            if (!tagsArr.Contains(tag))
            {
                string sTags = String.Join(",", tagsArr);
                if (sTags.Length>0)
                {
                    sTags += ",";
                }

                sTags += tag;

                tagsNode.InnerText = sTags;

                xml.Save(path);
            }
        }

        public void AddComment(ExampleComment comment)
        {
            XmlDocument xml = new XmlDocument();

            if (File.Exists(path))
            {
                try
                {
                    xml.Load(path);
                }
                catch (FileNotFoundException)
                {
                    return;
                }
            }

            XmlNode root = xml.SelectSingleNode("example");

            if (root == null)
            {
                return;
            }

            XmlElement elem;
            XmlNode commentsNode = root.SelectSingleNode("comments");

            if (commentsNode == null)
            {
                elem = xml.CreateElement("comments");
                root.AppendChild(elem);
                commentsNode = root.SelectSingleNode("comments");
            }

            elem = xml.CreateElement("comment");

            XmlAttribute attr = xml.CreateAttribute("name");
            attr.Value = comment.Name;
            elem.Attributes.Append(attr);

            attr = xml.CreateAttribute("title");
            attr.Value = comment.Title;
            elem.Attributes.Append(attr);

            attr = xml.CreateAttribute("time");
            attr.Value = DateTime.Now.ToString(new CultureInfo("en-US"));
            elem.Attributes.Append(attr);

            XmlElement message = xml.CreateElement("message");
            message.InnerXml = comment.Message;
            elem.AppendChild(message);

            commentsNode.AppendChild(elem);

            xml.Save(path);
        }
    }

    public class ExampleComment
    {
        public string Name
        {
            get; set;
        }

        public string Title
        {
            get;
            set;
        }

        public DateTime Time
        {
            get;
            set;
        }

        public string Message
        {
            get;
            set;
        }
    }

    public class ExampleGroup
    {
        private List<object> examples;

        public string id { get; set; }

        public string title { get; set; }

        public List<object> samples
        {
            get
            {
                if (this.examples == null)
                {
                    this.examples = new List<object>();
                }
                return examples;
            }
        }
    }
}