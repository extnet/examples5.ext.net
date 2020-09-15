<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public object GetOrders(string action, Dictionary<string, object> extraParams)
    {
        StoreRequestParameters prms = new StoreRequestParameters(extraParams);

        var data = JSON.Deserialize<Dictionary<string, object>[]>(System.IO.File.ReadAllText(Server.MapPath("orders.json")));

        if (prms.Filter.Length > 0)
        {
            var key = prms.Filter[0].Property;
            var searchValue = Convert.ToInt32(prms.Filter[0].Value); //customerId is int

            return new
            {
                data = data.Where(item =>
                    {
                        var value = item[key];
                        if (value != null)
                        {
                            return Convert.ToInt32(value) == searchValue;
                        }

                        return false;
                    })
            };
        }

        return new { data };
    }

    public class MyModel
    {
        public static object Model = new
        {
            stores = new
            {
                customers = new
                {
                    model = "Customer",
                    autoLoad = true
                }
            }

            /*stores = JRawValue.From(new Store
            {
                ModelName = "Customer"
            }.ToConfig())*/
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Associations - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Associations</h1>

        <p>This example shows simple association binding. The orders grid is bound to the orders <br />
           of the selected customer. The binding statement is able to interpret that orders is an <br />
           association and can show the orders for our customer.
        </p>

        <ext:Model runat="server" Name="Customer">
            <Fields>
                <ext:ModelField Name="name" />
                <ext:ModelField Name="phone" />
            </Fields>
            <Proxy>
                <ext:AjaxProxy Url="customers.json" />
            </Proxy>
        </ext:Model>

        <ext:Model runat="server" Name="Order">
            <Fields>
                <ext:ModelField Name="date" Type="Date" DateFormat="yyyy-MM-dd" />
                <ext:ModelField Name="shipped" />
                <ext:ModelField Name="customerId">
                    <Reference Parent="Customer" />
                </ext:ModelField>
            </Fields>
            <Proxy>
                <ext:PageProxy DirectFn="App.direct.GetOrders" />
            </Proxy>
        </ext:Model>

        <ext:Panel
            runat="server"
            Width="500"
            Height="480"
            ReferenceHolder="true"
            Layout="HBox"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
           <Items>
               <ext:GridPanel
                   runat="server"
                   Title="All Customers"
                   BindString="{customers}"
                   Reference="customerGrid"
                   Flex="1">
                   <ColumnModel>
                       <Columns>
                           <ext:Column
                               runat="server"
                               Text="Name"
                               DataIndex="name"
                               Flex="1"
                               />
                           <ext:Column
                               runat="server"
                               Text="Phone"
                               DataIndex="phone"
                               Width="115"
                               />
                       </Columns>
                   </ColumnModel>
               </ext:GridPanel>

                <ext:GridPanel
                    runat="server"
                    Title="Orders"
                    BindString="{customerGrid.selection.orders}"
                    MarginSpec="0 0 0 10"
                    Flex="1">
                    <ColumnModel>
                        <Columns>
                            <ext:DateColumn
                                runat="server"
                                Text="Date"
                                DataIndex="date"
                                Flex="1"
                                Format="yyyy-MM-dd"
                                />
                            <ext:BooleanColumn
                                runat="server"
                                Text="Shipped"
                                DataIndex="shipped"
                                Align="Center"
                                TrueText="&#x2713;"
                                FalseText="-"
                                />
                        </Columns>
                    </ColumnModel>
                    <ViewConfig EmptyText="No orders" DeferEmptyText="false" />
                </ext:GridPanel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>