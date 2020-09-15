<%@ Page Language="C#" %>

<script runat="server">
    StoreReadDataEventArgs e;

    protected void Store1_RefreshData(object sender, StoreReadDataEventArgs e)
    {
        string tpl = "Start: {0}<br />Limit: {1}<br />Sort: {2}<br />Dir: {3}";

        this.Label1.Html = string.Format(tpl, e.Start, e.Limit, e.Sort[0].Property, e.Sort[0].Direction);

        //this.Label1.Text = e.Sort[0].Property + ":" + e.Sort[0].Direction.ToString();

        this.e = e;

        this.Store1.DataBind();
    }

    protected void EmployeeSelecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["start"] = this.e.Start;
        e.InputParameters["limit"] = this.e.Limit;
        e.InputParameters["sort"] = this.e.Sort[0];
    }

    protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        (this.Store1.Proxy[0] as PageProxy).Total = (int)e.OutputParameters["count"];
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

        <asp:ObjectDataSource
            ID="ObjectDataSource1"
            runat="server"
            OnSelecting="EmployeeSelecting"
            OnSelected="ObjectDataSource1_Selected"
            SelectMethod="GetEmployeesFilter"
            TypeName="Ext.Net.Examples.Northwind.Employee">
            <SelectParameters>
                <asp:Parameter Name="start" Type="Int32" />
                <asp:Parameter Name="limit" Type="Int32" />
                <asp:Parameter Name="sort" Type="Object" />
                <asp:Parameter Name="count" Direction="Output" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Employees"
            Frame="true"
            Height="480">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    RemoteSort="true"
                    DataSourceID="ObjectDataSource1"
                    OnReadData="Store1_RefreshData"
                    PageSize="3">
                    <Proxy>
                        <ext:PageProxy />
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
                        Handler="return {rowBodyColspan : record.getFields().length, rowBody : '<p>' + data.Notes + '</p>'};"
                        />
                </ext:RowBody>
            </Features>
            <BottomBar>
                <ext:PagingToolbar
                    runat="server"
                    DisplayInfo="true"
                    DisplayMsg="Displaying employees {0} - {1} of {2}"
                    EmptyMsg="No employees to display"
                    />
            </BottomBar>
        </ext:GridPanel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>