<%@ Page Language="C#" %>

<script runat="server">
    protected void Store_ReadData(object sender, StoreReadDataEventArgs e)
    {
        var data = FiltersTestData.Data;

        //-- start filtering -----------------------------------------------------------
        FilterHeaderConditions fhc = new FilterHeaderConditions(e.Parameters["filterheader"]);

        foreach (FilterHeaderCondition condition in fhc.Conditions)
        {
            string dataIndex = condition.DataIndex;
            FilterType type = condition.Type;
            string op = condition.Operator;
            object value = null;

            switch (condition.Type)
            {
                case FilterType.Boolean:
                    value = condition.Value<bool>();
                    break;

                case FilterType.Date:
                    switch (condition.Operator)
                    {
                        case "=":
                            value = condition.Value<DateTime>();
                            break;

                        case "compare":
                            value = FilterHeaderComparator<DateTime>.Parse(condition.JsonValue);
                            break;
                    }
                    break;

                case FilterType.Number:
                    bool isInt = data.Count > 0 && data[0].GetType().GetProperty(dataIndex).PropertyType == typeof(int);
                    switch (condition.Operator)
                    {
                        case "=":
                            if (isInt)
                            {
                                value = condition.Value<int>();
                            }
                            else
                            {
                                value = condition.Value<double>();
                            }
                            break;

                        case "compare":
                            if (isInt)
                            {
                                value = FilterHeaderComparator<int>.Parse(condition.JsonValue);
                            }
                            else
                            {
                                value = FilterHeaderComparator<double>.Parse(condition.JsonValue);
                            }

                            break;
                    }

                    break;
                case FilterType.String:
                    value = condition.Value<string>();
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            data.RemoveAll(item =>
            {
                object oValue = item.GetType().GetProperty(dataIndex).GetValue(item, null);
                string matchValue = null;
                string itemValue = null;

                if (type == FilterType.String)
                {
                    matchValue = (string)value;
                    itemValue = oValue as string;
                }

                switch (op)
                {
                    case "=":
                        return oValue == null || !oValue.Equals(value);
                    case "compare":
                        return !((IEquatable<IComparable>)value).Equals((IComparable)oValue);
                    case "+":
                        return itemValue == null || !itemValue.StartsWith(matchValue);
                    case "-":
                        return itemValue == null || !itemValue.EndsWith(matchValue);
                    case "!":
                        return itemValue == null || itemValue.IndexOf(matchValue) >= 0;
                    case "*":
                        return itemValue == null || itemValue.IndexOf(matchValue) < 0;
                    default:
                        throw new Exception("Not supported operator");
                }
            });
        }
        //-- end filtering ------------------------------------------------------------


        //-- start sorting ------------------------------------------------------------
        if (e.Sort.Length > 0)
        {
            data.Sort(delegate(object x, object y)
            {
                object a;
                object b;

                int direction = e.Sort[0].Direction == Ext.Net.SortDirection.DESC ? -1 : 1;

                a = x.GetType().GetProperty(e.Sort[0].Property).GetValue(x, null);
                b = y.GetType().GetProperty(e.Sort[0].Property).GetValue(y, null);
                return CaseInsensitiveComparer.Default.Compare(a, b) * direction;
            });
        }
        //-- end sorting ------------------------------------------------------------


        //-- start paging ------------------------------------------------------------
        int limit = e.Limit;

        if ((e.Start + e.Limit) > data.Count)
        {
            limit = data.Count - e.Start;
        }

        List<object> rangeData = (e.Start < 0 || limit < 0) ? data : data.GetRange(e.Start, limit);
        //-- end paging ------------------------------------------------------------

        e.Total = data.Count;
        Store1.DataSource = rangeData;
        Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FilterHeader plugin overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>FilterHeader plugin</h1>

        <p>FilterHeader plugin allows use of the following operators:</p>

        <ul>
            <li>String: =(equals), +(starts with), -(ends with), *(contains), !(doesn't contain)</li>
            <li>Date: >, <, >=, <= or date for equals</li>
            <li>Number: >, <, >=, <= or number for equals</li>
            <li>Boolean: 1, 0, true, false</li>
        </ul>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="800"
            Height="400"
            Closable="false"
            Title="Example"
            Maximizable="true"
            Layout="Fit">
            <Items>
                <ext:GridPanel runat="server">
                    <Store>
                        <ext:Store
                            ID="Store1"
                            runat="server"
                            PageSize="10"
                            RemoteSort="true"
                            OnReadData="Store_ReadData" >
                            <Model>
                                <ext:Model runat="server" IDProperty="Id">
                                    <Fields>
                                        <ext:ModelField Name="Id" Type="Int" />
                                        <ext:ModelField Name="Company" Type="String" />
                                        <ext:ModelField Name="Price" Type="Float" />
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="Size" Type="String" />
                                        <ext:ModelField Name="Visible" Type="Boolean" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="Company" Direction="ASC" />
                            </Sorters>
                            <Proxy>
                                <ext:PageProxy />
                            </Proxy>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="ID" DataIndex="Id" />
                            <ext:Column runat="server" Text="Company" DataIndex="Company" Flex="1" />
                            <ext:Column runat="server" Text="Price" DataIndex="Price">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:DateColumn runat="server" Text="Date" DataIndex="Date" Align="Center" Format="yyyy-MM-dd" />
                            <ext:Column runat="server" Text="Size" DataIndex="Size" />
                            <ext:Column runat="server" Text="Visible" DataIndex="Visible" Align="Center">
                                <Renderer Handler="return (value) ? 'Yes':'No';" />
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <Plugins>
                        <ext:FilterHeader runat="server" Remote="true" />
                    </Plugins>
                    <BottomBar>
                        <ext:PagingToolbar runat="server" HideRefresh="True" />
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>