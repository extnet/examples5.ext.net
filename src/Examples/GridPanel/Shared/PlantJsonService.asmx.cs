using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Ext.Net.Examples;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for PlantJsonService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PlantJsonService : System.Web.Services.WebService
    {
        [WebMethod]
        public object PlantsPaging(int start, int limit, string sort, string filter)
        {
            List<Plant> plants = Plant.TestData;

            if (!string.IsNullOrEmpty(filter) && filter != "*")
            {
                plants.RemoveAll(plant => !plant.Common.ToLower().Contains(filter.ToLower()));
            }

            if (!string.IsNullOrEmpty(sort))
            {
                DataSorter[] dataSorter = DataSorter.From(sort);
                if (dataSorter.Length > 0)
                {
                    plants.Sort(delegate(Plant x, Plant y)
                    {
                        object a;
                        object b;

                        int direction = dataSorter[0].Direction == SortDirection.DESC ? -1 : 1;

                        a = x.GetType().GetProperty(dataSorter[0].Property).GetValue(x, null);
                        b = y.GetType().GetProperty(dataSorter[0].Property).GetValue(y, null);

                        return CaseInsensitiveComparer.Default.Compare(a, b) * direction;
                    });
                }
            }

            if ((start + limit) > plants.Count)
            {
                limit = plants.Count - start;
            }

            List<Plant> rangePlants = (start < 0 || limit < 0) ? plants : plants.GetRange(start, limit);

            return new Paging<Plant>(rangePlants, plants.Count).SerializationObject();
        }
    }
}
