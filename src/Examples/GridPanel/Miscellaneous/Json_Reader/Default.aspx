<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AJAX Request to HttpHander returns Json - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Window
        runat="server"
        Collapsible="true"
        Title="Plant Summary"
        Height="500"
        Width="960"
        Layout="Fit">
        <Items>
            <ext:GridPanel
                ID="GridPanel1"
                runat="server"
                Title="Plants"
                Frame="false">
                <Store>
                    <ext:Store runat="server" ID="Store1">
                        <Proxy>
                            <ext:AjaxProxy Url="../../Shared/JsonHandler.ashx">
                                <ActionMethods Read="GET" />
                                <Reader>
                                    <ext:JsonReader RootProperty="plants" />
                                </Reader>
                            </ext:AjaxProxy>
                        </Proxy>
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Common" Type="String" />
                                    <ext:ModelField Name="Botanical" Type="String" />
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
                        <ext:Column
                            runat="server"
                            Text="Common Name"
                            DataIndex="Common"
                            Flex="1"
                            />
                        <ext:Column
                            runat="server"
                            Text="Light"
                            DataIndex="Light"
                            Width="130"
                            />
                        <ext:Column
                            runat="server"
                            Text="Price"
                            DataIndex="Price"
                            Width="70"
                            Align="End"
                            />
                        <ext:DateColumn
                            runat="server"
                            Text="Available"
                            DataIndex="Availability"
                            Width="95"
                            />
                        <ext:Column
                            runat="server"
                            Text="Indoor?"
                            DataIndex="Indoor"
                            Width="55"
                            />
                    </Columns>
                </ColumnModel>
            </ext:GridPanel>
        </Items>
    </ext:Window>
</body>
</html>