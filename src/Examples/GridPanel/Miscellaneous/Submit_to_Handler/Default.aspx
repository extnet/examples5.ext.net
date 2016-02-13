<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>

    <script>
        var CountrySelector = {
            add : function (source, destination) {
                source = source || App.GridPanel1;
                destination = destination || App.GridPanel2;

                if (source.selModel.hasSelection()) {
                    var records = source.selModel.getSelection();
                    //source.deleteSelected();
                    source.store.remove(records);
                    destination.store.add(records);
                }
            },
            addAll : function (source, destination) {
                source = source || App.GridPanel1;
                destination = destination || App.GridPanel2;
                var records = source.store.getRange();
                source.store.removeAll();
                destination.store.add(records);
            },
            addByName : function (name) {
                if (!Ext.isEmpty(name)) {
                    var result = App.Store1.queryBy(function (r) {
                        return r.get("Name") === name;
                    });

                    if (!Ext.isEmpty(result.items)) {
                        App.GridPanel1.store.remove(result.items[0]);
                        App.GridPanel2.store.add(result.items[0]);
                    }
                }
            },
            addByNames : function (name) {
                for (var i = 0; i < name.length; i++) {
                    this.addByName(name[i]);
                }
            },
            remove : function (source, destination) {
                this.add(destination, source);
            },
            removeAll : function (source, destination) {
                this.addAll(destination, source);
            },

            submitData : function (source) {
                source.submitData( null, {
                    url : "SubmitHandler.ashx",
                    method : "POST",
                    success : function () {
                        Ext.Msg.alert("Submit", "Operation was successful");
                    },

                    failure : function (response) {
                        Ext.Msg.alert("Error", response.responseText);
                    }
                });
            }
        };
    </script>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:XmlDataSource
            ID="XmlDataSource1"
            runat="server"
            DataFile="Countries.xml"
            TransformFile="Countries.xsl"
            />

        <ext:Window
            runat="server"
            Closable="false"
            Height="553"
            Width="700"
            Icon="WorldAdd"
            Title="Country Selector"
            BodyPadding="5"
            BodyBorder="0"
            Layout="HBoxLayout">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Options">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Select All">
                                            <Listeners>
                                                <Click Handler="CountrySelector.addAll(#{GridPanel1}, #{GridPanel2});" />
                                            </Listeners>
                                        </ext:MenuItem>
                                        <ext:MenuItem runat="server" Text="Deselect All">
                                            <Listeners>
                                                <Click Handler="CountrySelector.removeAll(#{GridPanel1}, #{GridPanel2});" />
                                            </Listeners>
                                        </ext:MenuItem>
                                        <ext:MenuItem runat="server" Text="Regions">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Asia">
                                                            <Listeners>
                                                                <Click Handler="CountrySelector.addByNames(['China', 'Japan', 'Taiwan', 'South Korea']);" />
                                                            </Listeners>
                                                        </ext:MenuItem>
                                                        <ext:MenuItem runat="server" Text="Europe">
                                                            <Listeners>
                                                                <Click Handler="CountrySelector.addByNames(['United Kingdom', 'France', 'Germany', 'Spain', 'Switzerland', 'Italy', 'Austria', 'Belgium']);" />
                                                            </Listeners>
                                                        </ext:MenuItem>
                                                        <ext:MenuItem runat="server" Text="North America">
                                                            <Listeners>
                                                                <Click Handler="CountrySelector.addByNames(['Canada', 'United States', 'Mexico']);" />
                                                            </Listeners>
                                                        </ext:MenuItem>
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                            <Listeners>
                                                <Click Handler="CountrySelector.removeAll(#{GridPanel1}, #{GridPanel2});" />
                                            </Listeners>
                                        </ext:MenuItem>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:GridPanel
                    ID="GridPanel1"
                    runat="server"
                    EnableDragDrop="false"
                    Flex="1">
                    <Store>
                        <ext:Store ID="Store1" runat="server" DataSourceID="XmlDataSource1">
                            <Sorters>
                                <ext:DataSorter Property="Name" Direction="ASC" />
                            </Sorters>
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="Available Countries" DataIndex="Name" Flex="1">
                                <Filter>
                                    <ext:StringFilter />
                                </Filter>
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>
                    <Plugins>
                        <ext:GridFilters runat="server" />
                    </Plugins>
                </ext:GridPanel>
                <ext:Panel
                    runat="server"
                    Width="35"
                    BodyStyle="background-color: transparent;"
                    Border="false"
                    Layout="Anchor">
                    <Items>
                        <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" AnchorVertical="40%" />
                        <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" BodyPadding="5">
                            <Items>
                                <ext:Button runat="server" Icon="ResultsetNext" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.add();" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Add" Html="Add selected rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetLast" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.addAll();" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Add all" Html="Add all rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetPrevious" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.remove(#{GridPanel1}, #{GridPanel2});" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Remove" Html="Remove selected rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetFirst" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.removeAll(#{GridPanel1}, #{GridPanel2});" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Remove all" Html="Remove all rows" />
                                    </ToolTips>
                                </ext:Button>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel
                    ID="GridPanel2"
                    runat="server"
                    EnableDragDrop="false"
                    Flex="1">
                    <Store>
                        <ext:Store ID="Store2" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Listeners>
                                <Exception Handler="Ext.Msg.alert('Submit','Submit failure: ' + e.message);" />
                            </Listeners>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="Selected Countries" DataIndex="Name" Flex="1" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>
                </ext:GridPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save Selected Countries" Icon="Disk">
                    <Listeners>
                        <Click Handler="CountrySelector.submitData(#{Store2});" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Cancel" Icon="Cancel">
                    <Listeners>
                        <Click Handler="CountrySelector.removeAll(#{GridPanel1}, #{GridPanel2});" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>