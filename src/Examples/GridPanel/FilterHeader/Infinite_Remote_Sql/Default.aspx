<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Store_ReadData(object sender, StoreReadDataEventArgs e)
    {
        Store store = (Store)sender;
        List<object> data = new List<object>();

        var sqlHandle = new SqlConnection(
            ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString
        );
        sqlHandle.Open();

        #region FilterHeader handling
        FilterHeaderConditions fhc = new FilterHeaderConditions(e.Parameters["filterheader"]);

        var sql_constraints = new List<string>();

        foreach (FilterHeaderCondition condition in fhc.Conditions)
        {
            string dataIndex = condition.DataIndex;
            FilterType type = condition.Type;
            string op = condition.Operator;

            switch (condition.Type)
            {
                case FilterType.Number:
                    bool isInt = data.Count > 0 && data[0].GetType().GetProperty(dataIndex).PropertyType == typeof(int);
                    switch (condition.Operator)
                    {
                        case "=":
                            sql_constraints.Add(
                                fieldMap(dataIndex) + " = " +
                                (isInt ? condition.Value<int>() : condition.Value<double>())
                            );
                            break;
                        case "compare":
                            string compareOp = string.Empty;
                            if (isInt)
                            {
                                sql_constraints.Add(getSqlComparison(fieldMap(dataIndex), FilterHeaderComparator<int>.Parse(condition.JsonValue)));
                            }
                            else
                            {
                                sql_constraints.Add(getSqlComparison(fieldMap(dataIndex), FilterHeaderComparator<double>.Parse(condition.JsonValue)));
                            }

                            break;
                    }

                    break;
                case FilterType.String:
                    sql_constraints.Add(fieldMap(dataIndex) + " like '%" + sqlEscape(condition.Value<string>()) + "%'");
                    break;
                default:
                    throw new NotImplementedException("Server-side FilterHead " + condition.Type.ToString() + " filter not implemented.");
            }
        }

        var where_clause = string.Empty;
        if (sql_constraints.Count > 0)
        {
            where_clause = " and " + string.Join(" and ", sql_constraints);
        }
        #endregion FilterHeader handling

        #region remote partial data fetching (buffered store)
        int start = e.Start + 1,
            limit = e.Limit,
            end = start + limit - 1;

        e.Total = getTotalRows(sqlHandle, where_clause);
        #endregion remote partial data fetching (buffered store)

        var query = @"
            with resulting_view as (
                select
                    row_number() over (order by od.OrderId) as row, od.OrderId as ordernum, p.ProductName as item, c.CompanyName as customer_company, concat(e.FirstName, ' ', e.LastName) as seller, p.UnitPrice as original_price, od.UnitPrice as effective_price, od.Discount as discount
                from 
                    OrderDetails od, Orders o, Products p, Customers c, Employees e
                where
                    od.OrderID = o.OrderID and od.ProductID = p.ProductID and o.CustomerID = c.CustomerID and o.EmployeeID = e.EmployeeID" +
                    where_clause + @"
            )
            select * from resulting_view where row between " + start + " and " + end;

        var queryHandle = new SqlCommand(query, sqlHandle);

        var sqlReader = queryHandle.ExecuteReader();

        while (sqlReader.Read())
        {
            data.Add(new
            {
                RawRowNum = sqlReader.GetInt64(0),
                OrderNum = sqlReader.GetInt32(1),
                Item = sqlReader.GetString(2),
                CustomerCompany = sqlReader.GetString(3),
                Seller = sqlReader.GetString(4),
                OriginalPrice = sqlReader.GetDecimal(5),
                EffectivePrice = sqlReader.GetDecimal(6),
                Discount = sqlReader.GetFloat(7)
            });
        }
        store.Data = data;

        sqlReader.Close();
        sqlHandle.Close();

        X.Toast("Pulled from server rows " + start + " to " + end + ".");
    }

    private string sqlEscape(string what)
    {
        return what.Replace("'", "''");
    }

    private string fieldMap(string csharpRef)
    {
        switch (csharpRef)
        {
            case "RawRowNum": return "row";
            case "OrderNum": return "od.OrderId";
            case "Item": return "p.ProductName";
            case "CustomerCompany": return "c.CompanyName";
            case "Seller": return "concat(e.FirstName, ' ', e.LastName)";
            case "OriginalPrice": return "p.UnitPrice";
            case "EffectivePrice": return "od.UnitPrice";
            case "Discount": return "od.Discount";
            default: throw new Exception("Invalid SQL field name requested: '" + csharpRef + "'.");
        }
    }

    private int getTotalRows(System.Data.SqlClient.SqlConnection handle, string where_clause)
    {
        var query = @"
            select count(od.OrderId)
            from OrderDetails od, Orders o, Products p, Customers c, Employees e
            where od.OrderID = o.OrderID and od.ProductID = p.ProductID and o.CustomerID = c.CustomerID
                and o.EmployeeID = e.EmployeeID" + where_clause;

        var reader = new System.Data.SqlClient.SqlCommand(query, handle).ExecuteReader();

        if (!reader.Read())
        {
            throw new Exception("Unable to query data from server.");
        }

        var result = reader.GetInt32(0);

        reader.Close();

        return result;
    }

    private string getSqlComparison<T>(string prefix, FilterHeaderComparator<T> comp)
    {
        if (comp.HasEqual) return prefix + " = " + comp.Equal;
        if (comp.HasGreaterThan) return prefix + " > " + comp.GreaterThan;
        if (comp.HasGreaterThanOrEqual) return prefix + " >= " + comp.GreaterThanOrEqual;
        if (comp.HasLessThan) return prefix + " < " + comp.LessThan;
        if (comp.HasLessThanOrEqual) return prefix + " <= " + comp.LessThanOrEqual;

        throw new Exception("FilterHeader numeric comparator has no comparison operator.");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling + SQL Data Source + FilterHeader [Remote SQL data] - Ext.NET Examples</title>
    <script type="text/javascript">
        var fullName = function (value, metadata, record, rowIndex, colIndex, store) {
            return "<b>" + record.data.LastName + " " + record.data.FirstName + "</b>";
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Infinite Scrolling + Filter Header + Remote (buffered) SQL data</h1>

        <p>FilterHeader plugin allows use the following operators:</p>

        <ul>
            <li>String: =(equals), +(starts with), -(ends with), *(contains), !(doesn't contain)</li>
            <li>Date: >, <, >=, <= or a specific date for equals</li>
            <li>Number: >, <, >=, <= or a specific number for equals</li>
            <li>Boolean: 1, 0, true, false</li>
        </ul>

        <p>There are the following limitations in the server-side implementation here:</p>
        <ul>
            <li>String: ignores the string operators (=, +, -, *, !), always matching anywhere in the field.</li>
            <li>Date: Will throw NotImplementedException</li>
            <li>Number: none; the operator prefixes are fully implemented</li>
            <li>Boolen: Will throw NotImplementedException</li>
        </ul>

        <p>Column sorting is disabled here for simplicity</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Width="1000"
            Height="500"
            DisableSelection="true"
            SortableColumns="false"
            Title="Norwhtiwnd Data Sample">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    Buffered="true"
                    TrailingBufferZone="10"
                    LeadingBufferZone="10"
                    PageSize="200"
                    OnReadData="Store_ReadData">
                    <Proxy>
                        <ext:PageProxy>
                            <Reader>
                                <ext:JsonReader RootProperty="data" />
                            </Reader>
                        </ext:PageProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="EmployeeID">
                            <Fields>
                                <ext:ModelField Name="RawRowNum" Type="Int" />
                                <ext:ModelField Name="OrderNum" Type="Int" />
                                <ext:ModelField Name="Item" />
                                <ext:ModelField Name="CustomerCompany" />
                                <ext:ModelField Name="Seller" />
                                <ext:ModelField Name="OriginalPrice" Type="Float" />
                                <ext:ModelField Name="EffectivePrice" Type="Float" />
                                <ext:ModelField Name="Discount" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="40" />
                    <ext:Column runat="server" Text="DB row #" DataIndex="RawRowNum" Width="70" />
                    <ext:Column runat="server" Text="Order #" DataIndex="OrderNum" Width="70" />
                    <ext:Column runat="server" Text="Description" DataIndex="Item" Flex="5" />
                    <ext:Column runat="server" Text="Buying Company" DataIndex="CustomerCompany" Flex="4" />
                    <ext:Column runat="server" Text="Seller Representative" DataIndex="Seller" Flex="4" />
                    <ext:Column runat="server" Text="Price" DataIndex="OriginalPrice" Width="60" />
                    <ext:Column runat="server" Text="Paid" DataIndex="EffectivePrice" Width="60" />
                    <ext:Column runat="server" Text="Discount" DataIndex="Discount" Width="80" />
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:FilterHeader runat="server" Remote="true" />
            </Plugins>
            <ViewConfig TrackOver="false" />
        </ext:GridPanel>
    </form>
</body>
</html>