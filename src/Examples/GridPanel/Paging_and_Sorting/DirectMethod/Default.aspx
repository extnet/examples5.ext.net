<%@ Page Language="C#" %>
<%@ Import Namespace="Ext.Net.Examples.Northwind" %>

<script runat="server">
    [DirectMethod]
    public object BindData(string action, Dictionary<string, object> extraParams)
    {
        int total;
        DataSorter sorter;

        StoreRequestParameters prms = new StoreRequestParameters(extraParams);

        if (prms.Sort.Length < 1)
        {
            X.Msg.Alert("Default Server Sorting", "When no sorting column is provided, server will sort the entries by the <b>HireDate</b> column.").Show();
            sorter = new DataSorter(new DataSorter.Config() { Property = "HireDate" });
        }
        else
        {
            sorter = prms.Sort[0];
        }

        List<Employee> data = Employee.GetEmployeesFilter(prms.Start, prms.Limit, sorter, out total);

        return new { data, total };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with ObjectDataSource - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-grid-td-fullName .x-grid-cell-inner {
            font-family : tahoma, verdana;
            display     : block;
            font-weight : normal;
            font-style  : normal;
            color       : #385F95;
            white-space : normal;
        }

        .x-grid-rowbody p {
            margin : 5px 5px 10px 5px !important;
            width  : 99%;
            color  : Gray;
            font-size: 11px !important;
            line-height: 13px;
        }
    </style>

    <script>
        var fullName = function (value, metadata, record, rowIndex, colIndex, store) {
            return "<b>" + record.data.LastName + " " + record.data.FirstName + "</b>";
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Remote Sorting and Paging with PageProxy</h1>

        <p>
            The <b>Clear Sort</b> button in the paging toolbar below will trigger
            a store reload as a side effect of clearing the sort information, so
            that data is acquired without sorting information, using the store's
            <a href="http://docs.sencha.com/extjs/7.0.0/classic/Ext.data.AbstractStore.html#cfg-reloadOnClearSorters">ReloadOnClearSorters</a>
            property.
        </p>

        <ext:GridPanel
            runat="server"
            ID="GridPanel1"
            Title="Employees"
            Frame="true"
            Height="300">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    RemoteSort="true"
                    ReloadOnClearSorters="true"
                    PageSize="3">
                    <Proxy>
                        <ext:PageProxy DirectFn="App.direct.BindData" />
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="EmployeeID">
                            <Fields>
                                <ext:ModelField Name="FirstName" />
                                <ext:ModelField Name="LastName" />
                                <ext:ModelField Name="Title" />
                                <ext:ModelField Name="TitleOfCourtesy" />
                                <ext:ModelField Name="BirthDate" Type="Date" />
                                <ext:ModelField Name="HireDate" Type="Date" />
                                <ext:ModelField Name="Address" />
                                <ext:ModelField Name="City" />
                                <ext:ModelField Name="Region" />
                                <ext:ModelField Name="PostalCode" />
                                <ext:ModelField Name="Country" />
                                <ext:ModelField Name="HomePhone" />
                                <ext:ModelField Name="Extension" />
                                <ext:ModelField Name="Notes" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="LastName" Direction="ASC" />
                    </Sorters>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Full Name" Width="150" DataIndex="LastName">
                        <Renderer Fn="fullName" />
                    </ext:Column>
                    <ext:Column runat="server" DataIndex="Title" Text="Title" Width="150" />
                    <ext:Column runat="server" DataIndex="TitleOfCourtesy" Text="Title Of Courtesy" Width="150" />
                    <ext:DateColumn runat="server" DataIndex="BirthDate" Text="BirthDate" Width="110" Format="yyyy-MM-dd" />
                    <ext:DateColumn runat="server" DataIndex="HireDate" Text="HireDate" Width="110" Format="yyyy-MM-dd" />
                    <ext:Column runat="server" DataIndex="Address" Text="Address" Width="150" />
                    <ext:Column runat="server" DataIndex="City" Text="City" Width="100" />
                    <ext:Column runat="server" DataIndex="Region" Text="Region" Width="100" />
                    <ext:Column runat="server" DataIndex="PostalCode" Text="PostalCode" Width="100" />
                    <ext:Column runat="server" DataIndex="Country" Text="Country" Width="100" />
                    <ext:Column runat="server" DataIndex="HomePhone" Text="HomePhone" Width="150" />
                    <ext:Column runat="server" DataIndex="Extension" Text="Extension" Width="100" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <GetRowClass Handler="return 'x-grid-row-expanded';" />
                </ext:GridView>
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <Features>
                <ext:RowBody runat="server">
                    <GetAdditionalData
                        Handler="return { rowBodyColspan : record.getFields().length, rowBody : '<p>' + data.Notes + '</p>' };" />
                </ext:RowBody>
            </Features>
            <BottomBar>
                <ext:PagingToolbar
                    runat="server"
                    DisplayInfo="true"
                    DisplayMsg="Displaying employees {0} - {1} of {2}"
                    EmptyMsg="No employees to display"
                    >
                    <Items>
                        <ext:Button runat="server" Text="Clear Sort" Handler="#{Store1}.sorters.clear();" />
                    </Items>
                </ext:PagingToolbar>
            </BottomBar>
        </ext:GridPanel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>