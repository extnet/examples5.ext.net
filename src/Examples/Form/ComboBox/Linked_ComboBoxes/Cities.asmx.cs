using System.Collections.Generic;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Xml;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for Cities
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Cities : System.Web.Services.WebService
    {
        [WebMethod]
        public List<City> GetCities(string countryCode)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(HttpContext.Current.Server.MapPath("Cities.xml"));
            List<City> data = new List<City>();

            foreach (XmlNode cityNode in xmlDoc.SelectNodes(string.Concat("countries/country[@code='", countryCode, "']/city")))
            {
                string id = cityNode.SelectSingleNode("id").InnerText;
                string name = cityNode.SelectSingleNode("name").InnerText;

                data.Add(new City(id, name));
            }

            //emulate net's delay
            Thread.Sleep(1500);

            return data;
        }
    }

    public class City
    {
        public City()
        {
        }

        public City(string id, string name)
        {
            this.Id = id;
            this.Name = name;
        }

        public string Id { get; set; }

        public string Name { get; set; }
    }
}
