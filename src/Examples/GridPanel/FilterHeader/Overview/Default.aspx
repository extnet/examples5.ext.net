<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = FiltersTestData.Data;
            this.Store1.DataBind();
        }
    }

    protected Field OnCreateFilterableField(object sender, ColumnBase column, Field defaultField)
    {
        if (column.DataIndex == "Id")
        {
            ((TextField)defaultField).IconCls = "x-md md-icon-search";
        }

        return defaultField;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FilterHeader plugin overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var loadFilter = function (plugin) {
            plugin.setValue({
                Id : ">5",
                Company: "!Inc.",
                Price: ">50<70",
                Visible: 1
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>FilterHeader plugin overview</h1>

        <p>FilterHeader plugin allows use the following operators:</p>

        <ul>
            <li>String: =(equals), +(starts with), -(ends with), *(contains), !(doesn't contain)</li>
            <li>Date: >, &lt;, >=, &lt;= or a specific date for equals</li>
            <li>Number: >, &lt;, >=, &lt;= or a specific number for equals</li>
            <li>Boolean: 1, 0, true, false</li>
        </ul>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="960"
            Height="480"
            Closable="false"
            Title="Example"
            Maximizable="true"
            Layout="Fit">
            <Items>
                <ext:GridPanel runat="server">
                    <Store>
                        <ext:Store ID="Store1" runat="server" PageSize="10">
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
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="ID" DataIndex="Id" />
                            <ext:Column
                                runat="server"
                                Text="Company"
                                DataIndex="Company"
                                Flex="1"
                                />
                            <ext:Column runat="server" Text="Price" DataIndex="Price">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:DateColumn
                                runat="server"
                                Text="Date"
                                DataIndex="Date"
                                Align="Center"
                                Format="yyyy-MM-dd"
                                />
                            <ext:Column runat="server" Text="Size" DataIndex="Size" />
                            <ext:Column
                                runat="server"
                                Text="Visible"
                                DataIndex="Visible"
                                Align="Center">
                                <Renderer Handler="return (value) ? 'Yes':'No';" />
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <Plugins>
                        <ext:FilterHeader runat="server" OnCreateFilterableField="OnCreateFilterableField" />
                    </Plugins>
                    <BottomBar>
                        <ext:PagingToolbar runat="server" HideRefresh="True">
                        </ext:PagingToolbar>
                    </BottomBar>
                    <DockedItems>
                        <ext:Toolbar runat="server" Dock="Bottom">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Case Sensitive"
                                    EnableToggle="true"
                                    AllowDepress="true"
                                    ToggleHandler="var plugin = this.up('grid').filterHeader; plugin.caseSensitive = this.pressed; plugin.applyFilter();"
                                    />
                                <ext:Button runat="server" Text="Load Filters" Handler="loadFilter(this.up('grid').filterHeader);" />
                                <ext:Button
                                    runat="server"
                                    Text="Get Fields Values"
                                    ToolTip="Get Values of Fields"
                                    Handler="var values = Ext.encode(this.up('grid').filterHeader.getValue()); Ext.Msg.alert('Fields Values', values);"
                                    />
                                <ext:Button
                                    runat="server"
                                    Text="Get Filter Values"
                                    ToolTip="Get Filter Values of Grid"
                                    Handler="var filters = Ext.encode(this.up('grid').filterHeader.getFilterValues()); Ext.Msg.alert('Filter Values', filters);"
                                    />
                                <ext:Button runat="server" Text="Clear Filters" Handler="this.up('grid').filterHeader.clearFilter();" />
                            </Items>
                        </ext:Toolbar>
                    </DockedItems>
                </ext:GridPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>