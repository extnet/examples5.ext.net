<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Grouped GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onToggleButtonBeforeRender = function () {
            App.GridPanel1.getStore().getGroups().each(function(group) {
                App.ButtonToggleMenu.menu.add({
                    xtype: 'menucheckitem',
                    text: group.getGroupKey(),
                    handler: toggleGroup
                });
            });
        };

        var onClearGroupingClick = function () {
            var groupingFeature = App.GridPanel1.groupingFeature,
                currentGroupedHeader;

            currentGroupedHeader = groupingFeature.hideGroupedHeader && groupingFeature.getGroupedHeader();
            App.GridPanel1.getStore().clearGrouping();

            if (currentGroupedHeader) {
                currentGroupedHeader.show();
            }
        };

        var toggleGroup = function (item) {
            var groupName = item.text;
            if (item.checked) {
                App.GridPanel1.groupingFeature.expand(groupName, true);
            } else {
                App.GridPanel1.groupingFeature.collapse(groupName, true);
            }
        };

        var onGroupChange = function (store, grouper) {
            var grouped = store.isGrouped(),
                groupBy = grouper ? grouper.getProperty() : '',
                toggleMenuItems, len, i = 0;

            // Clear grouping button only valid if the store is grouped
            App.GridPanel1.down('[text=Clear Grouping]').setDisabled(!grouped);

            // Sync state of group toggle checkboxes
            if (grouped && groupBy === 'cuisine') {
                toggleMenuItems = App.GridPanel1.down('button[text=Toggle groups...]').menu.items.items;
                for (len = toggleMenuItems.length; i < len; i++) {
                    toggleMenuItems[i].setChecked(
                        App.GridPanel1.groupingFeature.isExpanded(toggleMenuItems[i].text)
                    );
                }
                App.GridPanel1.down('[text=Toggle groups...]').enable();
            } else {
                App.GridPanel1.down('[text=Toggle groups...]').disable();
            }
        };

        var onGroupCollapse = function (v, n, groupName) {
            if (!App.GridPanel1.down('[text=Toggle groups...]').disabled) {
                App.GridPanel1.down('menucheckitem[text=' + groupName + ']').setChecked(false, true);
            }
        };

        var onGroupExpand = function (v, n, groupName) {
            if (!App.GridPanel1.down('[text=Toggle groups...]').disabled) {
                App.GridPanel1.down('menucheckitem[text=' + groupName + ']').setChecked(true, true);
            }
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" MarginSpec="0 0 10 0">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:GridPanel
                ID="GridPanel1"
                runat="server"
                Title="Restaurants"
                IconCls="x-md md-icon-grid-on"
                Frame="true"
                Width="960"
                Height="480"
                MinHeight="200"
                Resizable="true"
                Collapsible="true">
                <Store>
                    <ext:Store
                        runat="server"
                        Data="<%# Ext.Net.Examples.KitchenSink.Restaurants.GetAllRestaurants() %>"
                        GroupField="cuisine">
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
                            <ext:DataSorter Property="cuisine" />
                            <ext:DataSorter Property="name" />
                        </Sorters>
                        <Listeners>
                            <GroupChange Fn="onGroupChange" Buffer="10" />
                        </Listeners>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:Column runat="server" Text="Name" Flex="1" DataIndex="name" />
                        <ext:Column runat="server" Text="Cuisine" Flex="1" DataIndex="cuisine" />
                    </Columns>
                </ColumnModel>
                <Features>
                    <ext:Grouping
                        runat="server"
                        HideGroupedHeader="true"
                        GroupHeaderTplString="Cuisine: {name} ({rows.length} Item{[values.rows.length > 1 ? 's' : '']})"
                        StartCollapsed="true"
                        />
                </Features>
                <TopBar>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:ToolbarFill runat="server" />
                            <ext:Button ID="ButtonToggleMenu" runat="server" Text="Toggle groups..." DestroyMenu="true">
                                <Menu>
                                    <ext:Menu runat="server" />
                                </Menu>
                                <Listeners>
                                    <BeforeRender Fn="onToggleButtonBeforeRender" />
                                </Listeners>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <FooterBar>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:ToolbarFill runat="server" />
                            <ext:Button
                                runat="server"
                                Text="Clear Grouping"
                                IconCls="x-md md-icon-clear"
                                Handler="onClearGroupingClick"
                                />
                        </Items>
                    </ext:Toolbar>
                </FooterBar>
                <View>
                    <ext:GridView runat="server">
                        <Listeners>
                            <GroupCollapse Fn="onGroupCollapse" />
                            <GroupExpand Fn="onGroupExpand" />
                        </Listeners>
                    </ext:GridView>
                </View>
            </ext:GridPanel>
        </Items>
    </ext:Viewport>
</body>
</html>
