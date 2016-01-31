using System.ComponentModel;
using System.Web.Services;

namespace Ext.Net.Examples
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    public class XmlService : WebService
    {
        [WebMethod]
        public string SayHello(string name)
        {
            return "Hello, " + name;
        }
    }
}
