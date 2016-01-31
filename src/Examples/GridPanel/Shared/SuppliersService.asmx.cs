using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Web.Services;

using Ext.Net.Examples.Northwind;
using XResponse = Ext.Net.Response;
using System.Xml.Serialization;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for SuppliersService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SuppliersService : System.Web.Services.WebService
    {
        [WebMethod]
        public List<SerializableEntity<Supplier>> GetAllSuppliers()
        {
            NorthwindDataContext db = new NorthwindDataContext();

            return db.Suppliers.ToList<Supplier, SerializableEntity<Supplier>>();
        }

        [WebMethod]
        [XmlInclude(typeof(Ext.Net.Response))]
        public object SaveSuppliers(string data, string action)
        {
            Response sr = new Response(true);

            try
            {
                NorthwindDataContext db = new NorthwindDataContext();
                StoreDataHandler dataHandler = new StoreDataHandler(data);
                List<Supplier> dataList = dataHandler.ObjectData<Supplier>();
                StoreAction storeAction = Store.Action(action);

                foreach (Supplier supplier in dataList)
                {
                    if (storeAction == StoreAction.Destroy)
                    {
                        db.Suppliers.Attach(supplier);
                        db.Suppliers.DeleteOnSubmit(supplier);
                    }
                    else if (storeAction == StoreAction.Update)
                    {
                        db.Suppliers.Attach(supplier);
                        db.Refresh(RefreshMode.KeepCurrentValues, supplier);
                    }
                    else if (storeAction == StoreAction.Create)
                    {
                        db.Suppliers.InsertOnSubmit(supplier); 
                    }
                }

                db.SubmitChanges();

                if (storeAction != StoreAction.Destroy)
                {
                    return dataList.ToList<Supplier, SerializableEntity<Supplier>>();
                }
            }
            catch (Exception e)
            {
                sr.Success = false;
                sr.Message = e.Message;
            }

            return sr;
        }
    }
}
