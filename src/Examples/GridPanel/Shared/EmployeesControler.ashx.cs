using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Ext.Net.Examples.Northwind
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class EmployeesControler : IHttpHandler
    {
        private HttpContext context;

        public void ProcessRequest(HttpContext context)
        {
            this.context = context;
            context.Response.ContentType = "text/json";

            int count;
            List<Employee> result = Employee.GetEmployeesFilter(this.Start, this.Limit, this.Sort, out count);
            Paging<Employee> pagingEmployees = new Paging<Employee>(result, count);
            
            StoreResponseData sr = new StoreResponseData();
            sr.Total = pagingEmployees.TotalRecords;

            sr.Data = JSON.Serialize(from e in pagingEmployees.Data select new 
            {
                  e.Address,
                  e.BirthDate,
                  e.City,
                  e.Country,
                  e.EmployeeID,
                  e.Extension,
                  e.FirstName,
                  e.HireDate,
                  e.HomePhone,
                  e.LastName,
                  e.Notes,
                  e.PhotoPath,
                  e.PostalCode,
                  e.Region,
                  e.ReportsTo,
                  e.Title,
                  e.TitleOfCourtesy
            });

            sr.Return();
        }

        int Start
        {
            get
            {
                string startStr = context.Request["start"];

                if (string.IsNullOrEmpty(startStr))
                {
                    throw new NullReferenceException("Start is absent");
                }

                return int.Parse(startStr);
            }
        }

        int Limit
        {
            get
            {
                string limitStr = context.Request["limit"];

                if (string.IsNullOrEmpty(limitStr))
                {
                    throw new NullReferenceException("Limit is absent");
                }

                return int.Parse(limitStr);
            }
        }

        DataSorter Sort
        {
            get
            {
                string sort = context.Request["sort"];
                if (string.IsNullOrEmpty(sort))
                {
                    return null;
                }
                DataSorter[] sorters = JSON.Deserialize<DataSorter[]>(sort, new Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver());
                return sorters.Length > 0 ? sorters[0] : null;
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
