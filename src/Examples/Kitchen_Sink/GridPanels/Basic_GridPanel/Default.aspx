<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server"  MarginSpec="0 0 10 0">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:GridPanel
                runat="server"
                Title="Restaurants"
                Frame="true"
                Width="400"
                Height="295">
                <Store>
                    <ext:Store
                        runat="server"
                        Data="<%# Ext.Net.Examples.KitchenSink.Restaurants.GetAllRestaurants() %>">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="name" />
                                    <ext:ModelField Name="cuisine" />
                                    <ext:ModelField Name="description" />
                                    <ext:ModelField Name="rating" Type="Int" />
                                </Fields>
                            </ext:Model>
                        </Model>
                        <Sorters>
                            <ext:DataSorter Property="cuisine" Direction="DESC" />
                            <ext:DataSorter Property="name" />
                        </Sorters>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:Column runat="server" Text="Name" Flex="1" DataIndex="name" />
                        <ext:Column runat="server" Text="Cuisine" Flex="1" DataIndex="cuisine" />
                    </Columns>
                </ColumnModel>
            </ext:GridPanel>
        </Items>
    </ext:Viewport>
</body>
</html>