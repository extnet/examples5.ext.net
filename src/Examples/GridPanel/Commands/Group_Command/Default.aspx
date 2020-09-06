<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Group Commands - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var prepareGroupToolbar = function (grid, toolbar, groupId, records) {
            // you can prepare ready toolbar
        };

        var onGroupCommand = function (column, command, group) {
            if (command === 'SelectGroup') {
                column.gridRef.getSelectionModel().select(group.items, true);
                return;
            }

            Ext.Msg.alert(command, 'Group name: ' + group.getGroupKey() + '<br/>Count - ' + group.items.length);
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

        <ext:GridPanel
            runat="server"
            Collapsible="true"
            Width="960"
            Height="480"
            RowLines="false"
            Title="Plants"
            Frame="true"
            ForceFit="true">
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
                        Width="220"
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
                    <ext:CommandColumn runat="server" Hidden="true">
                        <GroupCommands>
                            <ext:GridCommand Icon="TableRow" CommandName="SelectGroup">
                                <ToolTip Title="Select" Text="Select all rows of the group" />
                            </ext:GridCommand>
                            <ext:CommandFill />
                            <ext:GridCommand Text="Menu" StandOut="true">
                                <Menu>
                                    <Items>
                                        <ext:MenuCommand CommandName="ItemCommand" Text="Item" />
                                        <ext:MenuCommand CommandName="ItemCommand" Text="Item" />
                                    </Items>
                                </Menu>
                            </ext:GridCommand>
                        </GroupCommands>
                        <PrepareGroupToolbar Fn="prepareGroupToolbar" />
                        <Listeners>
                            <GroupCommand Fn="onGroupCommand" />
                        </Listeners>
                    </ext:CommandColumn>
                </Columns>
            </ColumnModel>

            <View>
                <ext:GridView runat="server" TrackOver="false" StripeRows="false" />
            </View>

            <SelectionModel>
                <ext:CheckboxSelectionModel runat="server" RowSpan="2" />
            </SelectionModel>

            <Features>
                <ext:Grouping
                    runat="server"
                    HideGroupedHeader="true"
                    GroupHeaderTplString='{columnName}: {name} ({[values.rows.length]} {[values.rows.length > 1 ? "Items" : "Item"]})' />

                <ext:RowBody runat="server">
                    <GetAdditionalData Fn="getAdditionalData" />
                </ext:RowBody>
            </Features>
        </ext:GridPanel>
    </form>
</body>
</html>