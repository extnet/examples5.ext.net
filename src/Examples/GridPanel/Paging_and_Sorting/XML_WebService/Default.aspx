<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with XML WebService - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            runat="server"
            ID="GridPanel1"
            Title="Employees"
            Frame="true"
            Height="480">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    RemoteSort="true"
                    PageSize="5">
                    <Proxy>
                        <ext:AjaxProxy Url="../../Shared/PlantService.asmx/PlantsPaging">
                            <ActionMethods Read="GET" />
                            <Reader>
                                <ext:XmlReader Record="Plant" TotalProperty="TotalRecords" />
                            </Reader>
                        </ext:AjaxProxy>
                    </Proxy>
                    <Parameters>
                        <ext:StoreParameter Name="filter" Value="" Mode="Value" />
                    </Parameters>
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Common" />
                                <ext:ModelField Name="Botanical" />
                                <ext:ModelField Name="Light" />
                                <ext:ModelField Name="Price" Type="Float" />
                                <ext:ModelField Name="Availability" Type="Date" />
                                <ext:ModelField Name="Indoor" Type="Boolean" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="Common" Direction="ASC" />
                    </Sorters>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Common Name" DataIndex="Common" Sortable="true" Flex="1" />
                    <ext:Column runat="server" Text="Botanical" DataIndex="Botanical" Width="230" />
                    <ext:Column runat="server" Text="Light" DataIndex="Light" Width="130" />
                    <ext:Column runat="server" Text="Price" DataIndex="Price" Width="70" Align="End" />
                    <ext:DateColumn runat="server" Text="Available" DataIndex="Availability" Width="95" Format="yyyy-MM-dd" />
                    <ext:Column runat="server" Text="Indoor?" DataIndex="Indoor" Width="55" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" LoadingText="Loading XML..." />
            </View>
            <BottomBar>
                <ext:PagingToolbar
                    runat="server"
                    DisplayInfo="true"
                    DisplayMsg="Displaying plants {0} - {1} of {2}"
                    EmptyMsg="No plants to display"
                    />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>