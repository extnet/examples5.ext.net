<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">
    protected void Store1_Refresh(object sender, StoreReadDataEventArgs e)
    {
        int start = int.Parse(e.Parameters["startRemote"]);
        int limit = int.Parse(e.Parameters["limitRemote"]);

        List<object> data = new List<object>(limit);

        for (int i = start; i < start + limit; i++)
        {
            data.Add(new {field = "Value" + (i + 1)});
        }

        e.Total = 8000;

        Store store = this.GridPanel1.GetStore();
        store.DataSource = data;
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Local Paging for Remote Data - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Local Paging for Remote Data</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Grid"
            Width="600"
            Height="330">
            <Store>
                <ext:Store
                    runat="server"
                    AutoLoad="true"
                    RemotePaging="false"
                    OnReadData="Store1_Refresh"
                    PageSize="10">
                    <Proxy>
                        <ext:PageProxy />
                    </Proxy>
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="field" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Parameters>
                        <ext:StoreParameter Name="startRemote" Value="#{Slider1}.getValue()[0]" Mode="Raw" />
                        <ext:StoreParameter Name="limitRemote" Value="1000" Mode="Raw" />
                        <ext:StoreParameter Name="start" Value="0" Mode="Raw" />
                        <ext:StoreParameter Name="limit" Value="10" Mode="Raw" />
                    </Parameters>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server"
                        Text="Field"
                        Sortable="true"
                        DataIndex="field"
                        Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" LoadingText="Loading Data..." />
            </View>
            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
            <BottomBar>
                <ext:PagingToolbar runat="server" />
            </BottomBar>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Remote Pager:" />
                        <ext:ToolbarSpacer runat="server" Width="20" />
                        <ext:Slider
                            ID="Slider1"
                            runat="server"
                            MinValue="0"
                            MaxValue="7000"
                            Increment="1000"
                            Width="250">
                            <Plugins>
                                <ext:SliderTip runat="server" />
                            </Plugins>
                            <Listeners>
                                <Change Handler="if (#{RangeText}) #{RangeText}.setText((newValue+1) + '-' + (newValue + 1000));" />
                                <ChangeComplete Handler="#{GridPanel1}.store.load();" />
                            </Listeners>
                        </ext:Slider>
                        <ext:ToolbarSpacer runat="server" Width="20" />
                        <ext:ToolbarTextItem ID="RangeText" runat="server" Text="(1-1000)" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>
    </form>
</body>
</html>