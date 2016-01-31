using System.Web.Services;
using Ext.Net;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for TreeLoaderService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class TreeXmlService : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetNodes(string node)
        {
            NodeCollection nodes = new NodeCollection(false);

            if (!string.IsNullOrEmpty(node))
            {
                for (int i = 1; i < 6; i++)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = node + i;
                    asyncNode.NodeID = node + i;
                    nodes.Add(asyncNode);
                }

                for (int i = 6; i < 11; i++)
                {
                    Node treeNode = new Node();
                    treeNode.Text = node + i;
                    treeNode.NodeID = node + i;
                    treeNode.Leaf = true;
                    nodes.Add(treeNode);
                }
            }

            return nodes.ToJson();
        }
    }
}
