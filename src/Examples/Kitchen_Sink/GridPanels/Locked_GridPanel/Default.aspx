<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Locked GridPanel - Ext.NET Examples</title>
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
                Title="Restaurant Reviews" 
                Frame="true"
                Width="800"
                Height="400">
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
                        <ext:Column 
                            runat="server" 
                            Text="Name" 
                            Width="150" 
                            DataIndex="name" 
                            Locked="true" />

                        <ext:RatingColumn
                            runat="server"
                            Text="Rating"
                            DataIndex="rating"
                            Width="90"
                            Sortable="false" />

                        <ext:Column 
                            runat="server" 
                            Text="Cuisine" 
                            Width="90" 
                            DataIndex="cuisine" />

                        <ext:Column 
                            runat="server" 
                            Text="Review" 
                            Width="1000"
                            DataIndex="description"
                            Sortable="false" />
                    </Columns>
                </ColumnModel>
            </ext:GridPanel>
        </Items>
    </ext:Viewport>
</body>
</html>