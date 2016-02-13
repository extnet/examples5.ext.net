<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

 <script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<object> data = new List<object>();

        for (int i = 0; i < 10; i++)
        {
            data.Add(new
            {
                Name = "Rec " + i,
                Column1 = i.ToString(),
                Column2 = i.ToString()
            });
        }

        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop from GridPanel to GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var getDragDropText = function () {
            var buf = [];

            buf.push("<ul>");

            Ext.each(this.view.panel.getSelectionModel().getSelection(), function (record) {
                buf.push("<li>"+record.data.Name+"</li>");
            });

            buf.push("</ul>");

            return buf.join("");
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Drag and Drop from GridPanel to GridPanel</h1>

        <p>This example shows how to setup two way drag and drop from one GridPanel to another.</p>

        <ext:Panel runat="server" Width="650" Height="300">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" Padding="5" />
            </LayoutConfig>
            <Items>
                <ext:GridPanel
                    ID="GridPanel1"
                    runat="server"
                    MultiSelect="true"
                    Flex="1"
                    Title="Left"
                    MarginSpec="0 2 0 0">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Column1" />
                                        <ext:ModelField Name="Column2" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel>
                        <Columns>
                            <ext:Column runat="server" Text="Record Name" Width="160" DataIndex="Name" Flex="1" />
                            <ext:Column runat="server" Text="Column 1" Width="60" DataIndex="Column1" />
                            <ext:Column runat="server" Text="Column 2" Width="60" DataIndex="Column2" />
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView runat="server">
                            <Plugins>
                                <ext:GridDragDrop runat="server" DragGroup="firstGridDDGroup" DropGroup="secondGridDDGroup"/>
                            </Plugins>
                            <Listeners>
                                <AfterRender Handler="this.plugins[0].dragZone.getDragText = getDragDropText;" Delay="1" />
                                <Drop Handler="var dropOn = overModel ? ' ' + dropPosition + ' ' + overModel.get('Name') : ' on empty view';
                                               Ext.net.Notification.show({title:'Drag from right to left', html:'Dropped ' + data.records[0].get('Name') + dropOn});" />
                            </Listeners>
                        </ext:GridView>
                    </View>
                </ext:GridPanel>
                <ext:GridPanel
                    ID="GridPanel2"
                    runat="server"
                    MultiSelect="true"
                    Title="Right"
                    Flex="1"
                    MarginSpec="0 0 0 3">
                    <Store>
                        <ext:Store ID="Store2" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Column1" />
                                        <ext:ModelField Name="Column2" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel>
                        <Columns>
                            <ext:Column runat="server" Text="Record Name" Width="160" DataIndex="Name" Flex="1" />
                            <ext:Column runat="server" Text="Column 1" Width="60" DataIndex="Column1" />
                            <ext:Column runat="server" Text="Column 2" Width="60" DataIndex="Column2" />
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView runat="server">
                            <Plugins>
                                <ext:GridDragDrop runat="server" DragGroup="secondGridDDGroup" DropGroup="firstGridDDGroup"/>
                            </Plugins>
                            <Listeners>
                                <AfterRender Handler="this.plugins[0].dragZone.getDragText = getDragDropText;" Delay="1" />
                                <Drop Handler="var dropOn = overModel ? ' ' + dropPosition + ' ' + overModel.get('Name') : ' on empty view';
                                               Ext.net.Notification.show({title:'Drag from left to right', html:'Dropped ' + data.records[0].get('Name') + dropOn});" />
                            </Listeners>
                        </ext:GridView>
                    </View>
                </ext:GridPanel>
            </Items>
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Reset both grids">
                            <Listeners>
                                <Click Handler="#{Store1}.loadData(#{Store1}.proxy.data); #{Store2}.removeAll();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:Panel>
    </form>
</body>
</html>