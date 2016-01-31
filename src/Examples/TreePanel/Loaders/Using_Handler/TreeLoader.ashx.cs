using System.Web;
using System.Web.Services;
using Ext.Net;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class TreeLoader : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/json";
            string nodeId = context.Request["node"];

            if (!string.IsNullOrEmpty(nodeId))
            {
                NodeCollection nodes = new NodeCollection(false);

                for (int i = 1; i < 6; i++)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = nodeId + i;
                    asyncNode.NodeID = nodeId + i;
                    nodes.Add(asyncNode);
                }

                for (int i = 6; i < 11; i++)
                {
                    Node node = new Node();
                    node.Text = nodeId + i;
                    node.NodeID = nodeId + i;
                    node.Leaf = true;
                    nodes.Add(node);
                }

                context.Response.Write(nodes.ToJson());
                context.Response.End();
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
