<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel GroupingView with EnableRowBody - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        // this "setGroupStyle" function is called when the GroupingView is refreshed.
        var setGroupStyle = function (view) {
            // get an instance of the Groups
            var groups = view.el.query(App.Grouping1.eventSelector);

            for (var i = 0; i < groups.length; i++) {
                var groupId = Ext.fly(groups[i]).getAttribute("data-groupname"),
                    records = view.panel.store.getGroups().get(groupId).items,
                    color = "#" + records[0].data.ColorCode;

                // Set the "background-color" of the original Group node.
                Ext.get(groups[i]).parent().select('.x-grid-group-hd').setStyle("background-color", color);
            }
        };

        var fillMenu = function (menu, store) {
            var groups = store.getGroups();

            groups.each(function (g) {
                menu.add({
                    xtype: 'menucheckitem',
                    text: g.getGroupKey(),
                    handler: toggleGroup
                });
            });

            App.Grouping1.collapseAll();
            App.Grouping1.expanded = false;
        };

        var toggleGroup = function (item) {
            var groupName = item.text;

            if (App.Grouping1.getGroupField() === "Light") {
                if (item.checked) {
                    App.Grouping1.expand(groupName, true);
                } else {
                    App.Grouping1.collapse(groupName, true);
                }
            }
        };

        var groupcollapse = function (view, node, groupName) {
            var grid = view.panel;

            if (!node) { // StartCollapsed="true" causes the groupcollapse event firing on initial load that should be ignored.
                return;
            }

            if (!App.Grouping1.disabled && App.Grouping1.getGroupField() === "Light") {
                grid.down('menucheckitem[text=' + groupName + ']').setChecked(false, true);
            }
        };

        var groupexpand = function (view, node, groupName) {
            var grid = view.panel;

            if (!App.Grouping1.disabled && App.Grouping1.getGroupField() === "Light") {
                grid.down('menucheckitem[text=' + groupName + ']').setChecked(true, true);
            }
        };

        var clearGrouping = function () {
            var groupingFeature = App.GridPanel1.groupingFeature,
                currentGroupedHeader;

            currentGroupedHeader = groupingFeature.hideGroupedHeader && groupingFeature.getGroupedHeader();
            App.GridPanel1.getStore().clearGrouping();

            if (currentGroupedHeader) {
                currentGroupedHeader.show();
            }

            App.btnToggleGroups.disable();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Grouping Grid Example</h1>

        <p>This example illustrates how to use the grouping feature of the Grid.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Collapsible="true"
            Width="960"
            Height="480"
            Title="Plants"
            Frame="true">
            <Store>
                <ext:Store runat="server" GroupField="Light" PageSize="5">
                    <Proxy>
                        <ext:AjaxProxy Url="../../Shared/PlantService.asmx/Plants">
                            <ActionMethods Read="GET" />
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
                    <Listeners>
                        <Load Handler="fillMenu(#{Menu1}, this);" />
                        <GroupChange Handler="var isGrouped = this.isGrouped();

                                              #{btnClearGrouping}.setDisabled(!isGrouped);
                                              #{btnToggleGroups}.setDisabled(!isGrouped);

                                              #{btnMenuGroups}.setDisabled(this.getGroupField() !== 'Light');"
                                     Delay="100"
                                     />
                    </Listeners>
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
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <Listeners>
                        <Refresh Fn="setGroupStyle" />
                        <GroupExpand Fn="groupexpand" />
                        <GroupCollapse Fn="groupcollapse" />
                    </Listeners>
                </ext:GridView>
            </View>
            <Features>
                <ext:Grouping
                    ID="Grouping1"
                    runat="server"
                    HideGroupedHeader="true"
                    StartCollapsed="true"
                    GroupHeaderTplString='{columnName}: {name} ({rows.length} Item{[values.rows.length > 1 ? "s" : ""]})' />

                <ext:RowBody runat="server">
                    <GetAdditionalData
                        Handler="var d = data;
                                 orig.rowBodyColspan = record.getFields().length;
                                 orig.rowBody = Ext.String.format('<div style=\'padding:0 5px 5px 5px;\'>The {0} [{1}] requires light conditions of <i>{2}</i>.<br /><b>Price: {3}</b></div>', d.Common, d.Botanical, d.Light, Ext.util.Format.usMoney(d.Price));"
                        />
                </ext:RowBody>
            </Features>
            <Buttons>
                <ext:Button
                    runat="server"
                    Text="Print"
                    IconCls="x-md md-icon-print"
                    Handler="this.up('grid').print();"
                    />

                <ext:Button
                    ID="btnToggleGroups"
                    runat="server"
                    Text="Expand/Collapse Groups"
                    Style="margin-left: 6px;">
                    <Listeners>
                        <Click Handler="#{Grouping1}[#{Grouping1}.expanded ? 'collapseAll' : 'expandAll'](); #{Grouping1}.expanded = !#{Grouping1}.expanded;" />
                    </Listeners>
                </ext:Button>

                <ext:Button
                    ID="btnClearGrouping"
                    runat="server"
                    Text="Clear Grouping"
                    Handler="clearGrouping"
                    />
            </Buttons>

            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill />
                        <ext:Button ID="btnMenuGroups" runat="server" Text="Toggle groups...">
                            <Menu>
                                <ext:Menu ID="Menu1" runat="server" />
                            </Menu>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>
    </form>
</body>
</html>