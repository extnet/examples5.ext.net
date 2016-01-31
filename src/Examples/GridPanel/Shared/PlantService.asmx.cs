using System.Collections;
using System.Collections.Generic;
using System.Web.Services;
using Ext.Net;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for PlantService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class PlantService : System.Web.Services.WebService
    {
        [WebMethod]
        public List<Plant> Plants()
        {
            return Plant.TestData;
        }

        [WebMethod]
        public Paging<Plant> PlantsPaging(int start, int limit, string sort, string filter)
        {
            List<Plant> plants = Plant.TestData;

            if (!string.IsNullOrEmpty(filter) && filter != "*")
            {
                plants.RemoveAll(plant => !plant.Common.ToLower().Contains(filter.ToLower()));
            }

            if (!string.IsNullOrEmpty(sort))
            {
                DataSorter ds = JSON.Deserialize<DataSorter[]>(sort)[0];
                sort = ds.Property;
                string dir = ds.Direction.ToString();
                plants.Sort(delegate(Plant x, Plant y)
                {
                    object a;
                    object b;

                    int direction = dir == "DESC" ? -1 : 1;

                    a = x.GetType().GetProperty(sort).GetValue(x,null);
                    b = y.GetType().GetProperty(sort).GetValue(y, null);

                    return CaseInsensitiveComparer.Default.Compare(a, b) * direction;
                });
            }

            if ((start + limit) > plants.Count)
            {
                limit = plants.Count - start;
            }

            List<Plant> rangePlants = (start < 0 || limit < 0) ? plants : plants.GetRange(start, limit);

            return new Paging<Plant>(rangePlants, plants.Count);
        }
    }
}
