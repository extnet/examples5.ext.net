<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Group Image Commands - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var prepareCommand = function (grid, command, record, row) {
            // you can prepare group command
            if (command.command == 'Delete' && record.data.Price < 5) {
                command.hidden = true;
                command.hideMode = 'visibility'; //you can try 'display' also
            }
        };

        var prepareGroupCommand = function (grid, command, groupId, group) {
            // you can prepare group command
        };

        var getAdditionalData = function (data, idx, record, orig) {
            return {
                rowBodyColspan : record.self.fields.length,
                rowBody: Ext.String.format('<div style=\'padding:0 5px 5px 5px;\'>The {0} [{1}] requires light conditions of <i>{2}</i>.<br /><b>Price: {3}</b></div>', data.Common, data.Botanical, data.Light, Ext.util.Format.usMoney(data.Price))
            };
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ImageCommandColumn is a simpler and faster version of CommandColumn</h1>

        <ext:GridPanel
            runat="server"
            Collapsible="true"
            Width="600"
            Height="350"
            Title="Plants"
            Frame="true">
            <Store>
                <ext:Store runat="server" GroupField="Light">
                    <Proxy>
                        <ext:AjaxProxy Url="../../Shared/PlantService.asmx/Plants">
                            <ActionMethods Read="POST" />
                            <Reader>
                                <ext:XmlReader Record="Plant" />
                            </Reader>
                        </ext:AjaxProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Common" />
                                <ext:ModelField Name="Botanical" />
                                <ext:ModelField Name="Zone" Type="Int" />
                                <ext:ModelField Name="ColorCode" />
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
                        Groupable="false">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                    <ext:DateColumn
                        runat="server"
                        Text="Available"
                        DataIndex="Availability"
                        Width="95"
                        Groupable="false"
                        Format="yyyy-MM-dd"
                        />
                    <ext:Column
                        runat="server"
                        Text="Indoor?"
                        DataIndex="Indoor"
                        Width="55"
                        />
                    <ext:ImageCommandColumn runat="server" Width="200">
                        <Commands>
                            <ext:ImageCommand CommandName="Delete" Icon="Delete" Text="Delete">
                                <ToolTip Text="Delete" />
                            </ext:ImageCommand>
                            <ext:ImageCommand CommandName="Edit" Icon="TableEdit" Text="Edit">
                                <ToolTip Text="Edit" />
                            </ext:ImageCommand>
                            <ext:ImageCommand CommandName="Disabled" Icon="PageWhiteEdit" Text="Disabled" Disabled="true">
                                <ToolTip Text="Edit" />
                            </ext:ImageCommand>
                        </Commands>

                        <GroupCommands>
                            <ext:GroupImageCommand CommandName="Delete" Icon="Delete" Text="Delete">
                                <ToolTip Text="Delete" />
                            </ext:GroupImageCommand>
                            <ext:GroupImageCommand CommandName="Edit" Icon="TableEdit" Text="Edit">
                                <ToolTip Text="Edit" />
                            </ext:GroupImageCommand>
                            <ext:GroupImageCommand CommandName="Chart" Icon="ChartBar" RightAlign="true">
                                <ToolTip Text="Chart" />
                            </ext:GroupImageCommand>
                        </GroupCommands>

                        <PrepareCommand Fn="prepareCommand" />
                        <PrepareGroupCommand Fn="prepareGroupCommand" />

                        <Listeners>
                            <Command Handler="Ext.Msg.alert(command, record.data.Common);" />
                            <GroupCommand Handler="Ext.Msg.alert(command, 'Group name: '+ group.getGroupKey() +'<br/>Count - ' + group.items.length);" />
                        </Listeners>
                    </ext:ImageCommandColumn>
                </Columns>
            </ColumnModel>

            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>

            <View>
                <ext:GridView runat="server" StripeRows="false" TrackOver="false" />
            </View>

            <Features>
                <ext:Grouping
                    runat="server"
                    HideGroupedHeader="true"
                    GroupHeaderTplString='{columnName}: {name} ({[values.rows.length]} {[values.rows.length > 1 ? "Items" : "Item"]})'
                    />

                <ext:RowBody runat="server">
                    <GetAdditionalData Fn="getAdditionalData" />
                </ext:RowBody>
            </Features>
        </ext:GridPanel>
    </form>
</body>
</html>