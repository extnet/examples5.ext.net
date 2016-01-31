using System;
using System.Data.Linq;
using System.Web;
using System.Web.Services;

using Ext.Net.Examples.Northwind;

namespace Ext.Net.Examples
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SuppliersSaveWithConfirmation : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            Response sr = new Response(true);
            
            try
            {
                NorthwindDataContext db = new NorthwindDataContext();
                StoreDataHandler dataHandler = new StoreDataHandler(context);
                ChangeRecords<Supplier> data = dataHandler.BatchObjectData<Supplier>();
                //ConfirmationList confirmationList = dataHandler.BuildConfirmationList("SupplierID");

                foreach (Supplier supplier in data.Deleted)
                {
                    db.Suppliers.Attach(supplier);
                    db.Suppliers.DeleteOnSubmit(supplier);
                    //confirmationList[supplier.SupplierID.ToString()].ConfirmRecord();
                }

                foreach (Supplier supplier in data.Updated)
                {
                    db.Suppliers.Attach(supplier);
                    db.Refresh(RefreshMode.KeepCurrentValues, supplier);
                    //confirmationList[supplier.SupplierID.ToString()].ConfirmRecord();
                }

                foreach (Supplier supplier in data.Created)
                {
                    db.Suppliers.InsertOnSubmit(supplier);
                }

                db.SubmitChanges();

                //ideally we should confirm after each operation
                //but LINQ make batch submit of changes

                foreach (Supplier supplier in data.Deleted)
                {
                    //confirmationList[supplier.SupplierID.ToString()].ConfirmRecord();
                }

                foreach (Supplier supplier in data.Updated)
                {
                    //confirmationList[supplier.SupplierID.ToString()].ConfirmRecord();
                }

                foreach (Supplier supplier in data.Created)
                {
                    //confirmationList[supplier.TemporaryID.ToString()].ConfirmRecord(supplier.SupplierID.ToString());
                }

                
                StoreResponseData response = new StoreResponseData();
                //response.Confirmation = confirmationList;

                sr.Data = response.ToString();
            }
            catch (Exception e)
            {
                sr.Success = false;
                sr.Message = e.Message;
            }

            sr.Write();
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
