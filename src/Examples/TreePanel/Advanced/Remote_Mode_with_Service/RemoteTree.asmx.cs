using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

namespace Ext.Net.Examples.Examples.TreePanel.Advanced.Remote_Mode_with_Service
{
    /// <summary>
    /// Summary description for RemoteTree
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class RemoteTree : System.Web.Services.WebService
    {
        [WebMethod]        
        public string GetNodes(string node)
        {
            NodeCollection nodes = new NodeCollection(false);

            string prefix = DateTime.Now.Second + "_";
            for (int i = 0; i < 10; i++)
            {
                Node newNode = new Node();
                newNode.NodeID = i.ToString();
                newNode.Text = prefix + i;
                newNode.Leaf = true;
                nodes.Add(newNode);
            }

            return nodes.ToJson();
        }

        [WebMethod]        
        public object RemoteEdit(string id, string field, string newValue, string oldValue)
        {
            //return new { actionSuccess = true };
            //return new { actionSuccess = false, message = "Renaming is disabled" };
            return new { actionSuccess = true, response = new { value = newValue + "_echo" } };
        }

        [WebMethod]
        public object RemoteEdit_RowEditing(Dictionary<string, object> newValues, Dictionary<string, object> oldValues)
        {
            //return new { actionSuccess = true };
            //return new { actionSuccess = false, message = "Renaming is disabled" };
            return new { actionSuccess = true, response = new { value = new { text = newValues["text"]+"_echo" } } };
        }

        [WebMethod]        
        public object RemoteRemove(string id)
        {
            return new { actionSuccess = true };
        }

        [WebMethod]
        public object RemoteAppend(string parentId, string text)
        {
            //return new { actionSuccess = true, response = new { id = "newId", text = text + "_new" } };
            return new { actionSuccess = true, response = new { id = "newId", attributes = new { text = text + "_new" } } };
        }

        [WebMethod]
        public object RemoteInsert(string parentId, string text)
        {
            return new { actionSuccess = true, response = new { attributes = new { text = text + "_new" } } };
        }

        [WebMethod]
        public object RemoteMove(string[] ids, string targetId, string point)
        {
            return new { actionSuccess = true };
        }
    }
}
