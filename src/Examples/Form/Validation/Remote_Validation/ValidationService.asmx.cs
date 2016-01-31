using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;

namespace Ext.Net.Examples.Examples.Form.Miscellaneous.Remote_Validation
{
    /// <summary>
    /// Summary description for ValidationService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    [ScriptService]
    public class ValidationService : System.Web.Services.WebService
    {
        [WebMethod]
        public object CheckField(string id, string value)
        {
            bool success = value == "Valid";
            System.Threading.Thread.Sleep(1000);          
            return new { valid=success, message = success ? "" : "'Valid' is valid value only" };
        }
    }
}
