using System;
using System.Linq;
using System.Data.Linq;
using System.Web;
using System.Web.Services;
using Ext.Net.Examples.Northwind;
using System.Collections.Generic;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SuppliersSave : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request["action"];

            if (string.IsNullOrEmpty(action) || Store.Action(action) == StoreAction.Read)
            {
                this.ReturnData(context);
                return;
            }

            StoreResponseData sr = new StoreResponseData();

            try
            {
                NorthwindDataContext db = new NorthwindDataContext();
                StoreDataHandler dataHandler = new StoreDataHandler(context);
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
                    sr.Data = JSON.Serialize(dataList);
                    sr.Return();
                    return;
                }
            }
            catch (Exception e)
            {
                sr.Success = false;
                sr.Message = e.Message;
            }

            sr.Return();
        }

        private void ReturnData(HttpContext context)
        {
            NorthwindDataContext db = new NorthwindDataContext();
            StoreResponseData sr = new StoreResponseData();
            sr.Data = JSON.Serialize(db.Suppliers.ToList());
            sr.Return();
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
