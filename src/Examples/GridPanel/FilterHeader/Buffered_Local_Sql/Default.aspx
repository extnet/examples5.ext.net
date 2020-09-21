<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Buffered Scrolling + SQL Data Source + FilterHeader [Local SQL data] - Ext.NET Examples</title>
    <script type="text/javascript">
        var fullName = function (value, metadata, record, rowIndex, colIndex, store) {
            return "<b>" + record.data.LastName + " " + record.data.FirstName + "</b>";
        };
    </script>
</head>
<body>
    <asp:SqlDataSource
        ID="SqlDataSource1"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        SelectCommand="
        select
            od.OrderId as ordernum, p.ProductName as item, c.CompanyName as customer_company, concat(e.FirstName, ' ', e.LastName) as seller, p.UnitPrice as original_price, od.UnitPrice as effective_price, od.Discount as discount
        from 
            OrderDetails od, Orders o, Products p, Customers c, Employees e
        where
            od.OrderID = o.OrderID and od.ProductID = p.ProductID and o.CustomerID = c.CustomerID and o.EmployeeID = e.EmployeeID"
        />
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Buffered Scrolling + Filter Header + Local SQL data</h1>

        <p>FilterHeader plugin allows use the following operators:</p>

        <ul>
            <li>String: =(equals), +(starts with), -(ends with), *(contains), !(doesn't contain)</li>
            <li>Date: >, &lt;, >=, &lt;= or a specific date for equals</li>
            <li>Number: >, &lt;, >=, &lt;= or a specific number for equals</li>
            <li>Boolean: 1, 0, true, false</li>
        </ul>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Width="960"
            Height="500"
            DisableSelection="true"
            Title="Northwind Data Sample">
            <Store>
                <ext:Store ID="Store1" runat="server" DataSourceID="SqlDataSource1">
                    <Model>
                        <ext:Model runat="server" IDProperty="EmployeeID">
                            <Fields>
                                <ext:ModelField Name="ordernum" Type="Int" />
                                <ext:ModelField Name="item" />
                                <ext:ModelField Name="customer_company" />
                                <ext:ModelField Name="seller" />
                                <ext:ModelField Name="original_price" Type="Float" />
                                <ext:ModelField Name="effective_price" Type="Float" />
                                <ext:ModelField Name="discount" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="40" />
                    <ext:Column
                        runat="server"
                        Text="Order #"
                        DataIndex="ordernum"
                        Width="70"
                        />
                    <ext:Column
                        runat="server"
                        Text="Description"
                        DataIndex="item"
                        Flex="5"
                        />
                    <ext:Column
                        runat="server"
                        Text="Buying Company"
                        DataIndex="customer_company"
                        Flex="4"
                        />
                    <ext:Column
                        runat="server"
                        Text="Seller Representative"
                        DataIndex="seller"
                        Flex="4"
                        />
                    <ext:Column
                        runat="server"
                        Text="Price"
                        DataIndex="original_price"
                        Width="60"
                        />
                    <ext:Column
                        runat="server"
                        Text="Paid"
                        DataIndex="effective_price"
                        Width="60"
                        />
                    <ext:Column
                        runat="server"
                        Text="Discount"
                        DataIndex="discount"
                        Width="80"
                        />
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:FilterHeader runat="server" />
            </Plugins>
            <ViewConfig TrackOver="false" />
        </ext:GridPanel>
    </form>
</body>
</html>