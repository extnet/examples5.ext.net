using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Сводное описание для JsonService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class TreeJsonService : System.Web.Services.WebService
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
