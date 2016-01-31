using System.Web.Services;
using Ext.Net;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for TestService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class TestService : System.Web.Services.WebService
    {
        [WebMethod]
        public DirectResponse SayHello1(string name)
        {
            X.Js.Alert("Hello, " + name);
            return new DirectResponse();
        }

        [WebMethod]
        public DirectResponse SayHello2(string name)
        {
            DirectResponse response = new DirectResponse();
            
            ParameterCollection parameters = new ParameterCollection();

            parameters["Greeting"] = "Hello, " + name;
            
            response.ExtraParamsResponse = parameters.ToJson();

            return response;
        }
    }
}