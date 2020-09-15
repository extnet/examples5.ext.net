<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with XmlDataSource - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:XmlDataSource
            ID="XmlDataSource1"
            runat="server"
            DataFile="../../Shared/Plants.xml"
            TransformFile="../../Shared/Plants.xsl"
            />

        <ext:GridPanel
            runat="server"
            Width="960"
            Height="480"
            Title="Plants"
            Frame="true">
            <Store>
                <ext:Store runat="server" DataSourceID="XmlDataSource1" PageSize="10">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Common" />
                                <ext:ModelField Name="Botanical" />
                                <ext:ModelField Name="Light" />
                                <ext:ModelField Name="Price" Type="Float" />
                                <ext:ModelField Name="Availability" Type="Date" DateFormat="m/d/Y" />
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
                    <ext:Column runat="server" Text="Common Name" DataIndex="Common" Width="220" Sortable="true" Flex="1" />
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
                    <ext:DateColumn runat="server" Text="Available" DataIndex="Availability" Width="95" Format="yyyy-MM-dd" />
                    <ext:Column runat="server" Text="Indoor?" DataIndex="Indoor" Width="55" />
                </Columns>
            </ColumnModel>
            <BottomBar>
                <ext:PagingToolbar runat="server" HideRefresh="true" />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>