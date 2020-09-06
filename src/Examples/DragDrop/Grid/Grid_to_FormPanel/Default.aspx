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
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop from GridPanel to FormPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var notifyEnter = function (ddSource, e, data) {
            App.FormPanel1.body.stopAnimation();
            App.FormPanel1.body.highlight();
        };

        var notifyDrop = function (ddSource, e, data) {
            var selectedRecord = ddSource.dragData.records[0];
            App.FormPanel1.getForm().loadRecord(selectedRecord);

            // Delete record from the grid.  not really required.
            ddSource.view.store.remove(selectedRecord);
            return true;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Drag and Drop from a Data Grid to a Form Panel</h1>

        <p>This example shows how to setup a one way drag and drop from a grid to an instance of a FormPanel.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="480"
            Layout="Border">
            <Items>
                <ext:GridPanel
                    ID="GridPanel1"
                    runat="server"
                    Region="West"
                    Width="325"
                    Title="Left"
                    MarginSpec="5 5 5 5">
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
                            <ext:Column runat="server" Text="Record Name" DataIndex="Name" Flex="1" />
                            <ext:Column runat="server" Text="Column 1" Width="60" DataIndex="Column1" />
                            <ext:Column runat="server" Text="Column 2" Width="60" DataIndex="Column2" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Single" />
                    </SelectionModel>
                    <View>
                        <ext:GridView runat="server">
                            <Plugins>
                                <ext:GridDragDrop runat="server" EnableDrop="false" DDGroup="gridDDGroup" />
                            </Plugins>
                        </ext:GridView>
                    </View>
                </ext:GridPanel>
                <ext:FormPanel
                    ID="FormPanel1"
                    runat="server"
                    Region="Center"
                    Title="Generic Form Panel"
                    BodyStyle="background-color: #DFE8F6"
                    BodyPadding="18"
                    MarginSpec="5 5 5 0">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Record Name" Name="Name" />
                        <ext:TextField runat="server" FieldLabel="Column 1" Name="Column1" />
                        <ext:TextField runat="server" FieldLabel="Column 2" Name="Column2" />
                    </Items>
                </ext:FormPanel>
            </Items>

            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Reset">
                            <Listeners>
                                <Click Handler="#{Store1}.loadData(#{Store1}.proxy.data); #{FormPanel1}.getForm().reset();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:Panel>

        <ext:DropTarget runat="server" Target="={#{FormPanel1}.body}" Group="gridDDGroup">
            <NotifyEnter Fn="notifyEnter" />
            <NotifyDrop Fn="notifyDrop" />
        </ext:DropTarget>
    </form>
</body>
</html>