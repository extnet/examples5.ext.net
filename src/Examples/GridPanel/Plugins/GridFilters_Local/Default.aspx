<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = FiltersTestData.Data;
        }
    }

    protected void SetFilter(object sender, DirectEventArgs e)
    {
        StringFilter sf = (StringFilter)CompanyColumn.Filter[0];
        sf.SetValue("3m Co");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with Local Filtering, Sorting and Paging - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var getFilters = function () {
            var out = [],
                filters = this.up('grid').store.getFilters().items,
                length = filters.length,
                i;

            for (i = 0; i < length; i++) {
                out[i] = filters[i].serialize();
            }

            Ext.Msg.alert('Filters', Ext.encode(out));
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>GridPanel with Local Filtering, Sorting and Paging</h1>

    <p>Please see column header menu for applying filters</p>

    <ext:Window
        runat="server"
        Width="950"
        Height="480"
        Closable="false"
        Collapsible="true"
        Title="Example"
        Maximizable="true"
        Layout="Fit">
        <Items>
            <ext:GridPanel ID="GridPanel1" runat="server" Border="false">
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
                        <ext:Column runat="server" Text="ID" DataIndex="Id">
                            <Filter>
                                <ext:NumberFilter />
                            </Filter>
                        </ext:Column>
                        <ext:Column ID="CompanyColumn" runat="server" Text="Company" DataIndex="Company" Flex="1">
                            <Filter>
                                <ext:StringFilter />
                            </Filter>
                        </ext:Column>
                        <ext:Column runat="server" Text="Price" DataIndex="Price">
                            <Renderer Format="UsMoney" />
                            <Filter>
                                <ext:NumberFilter />
                            </Filter>
                        </ext:Column>
                        <ext:DateColumn runat="server" Text="Date" DataIndex="Date" Align="Center" Format="yyyy-MM-dd">
                            <Filter>
                                <ext:DateFilter>
                                    <DatePickerOptions runat="server" TodayText="Now" />
                                </ext:DateFilter>
                            </Filter>
                        </ext:DateColumn>
                        <ext:Column runat="server" Text="Size" DataIndex="Size">
                            <Filter>
                                <ext:ListFilter Options="extra small,small,medium,large,extra large" />
                            </Filter>
                        </ext:Column>
                        <ext:Column runat="server" Text="Visible" DataIndex="Visible" Align="Center">
                            <Renderer Handler="return (value) ? 'Yes':'No';" />
                            <Filter>
                                <ext:BooleanFilter />
                            </Filter>
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <Plugins>
                    <ext:GridFilters runat="server" />
                </Plugins>
                <BottomBar>
                    <ext:PagingToolbar runat="server" HideRefresh="True">
                        <Items>
                            <ext:Button runat="server" Text="Find '3m Co'" OnDirectClick="SetFilter" />

                            <ext:Button
                                runat="server"
                                Text="All Filters"
                                ToolTip="Get Filters of Grid"
                                Handler="getFilters" />

                            <ext:Button runat="server" Text="Clear Filters" Handler="this.up('grid').filters.clearFilters();" />
                        </Items>
                    </ext:PagingToolbar>
                </BottomBar>
            </ext:GridPanel>
        </Items>
    </ext:Window>
</body>
</html>
