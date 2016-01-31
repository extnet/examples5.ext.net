using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;

namespace Ext.Net.Examples
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    [ScriptService]
    public class JsonService : WebService
    {
        [WebMethod]
        public string SayHello(string name)
        {
            return "Hello, " + name;
        }
    }
}
