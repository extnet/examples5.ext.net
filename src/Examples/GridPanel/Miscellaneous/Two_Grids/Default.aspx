<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">
    public class Country
    {
        public string Name { get; set; }
    }

    protected void SubmitData(object sender, StoreSubmitDataEventArgs e)
    {
        string json = e.Json;
        XmlNode xml = e.Xml;
        List<Country> countries = e.Object<Country>();

        StringBuilder sb = new StringBuilder(255);

        sb.Append("<h3>Selected Countries</h3>");

        foreach (Country country in countries)
        {
            sb.AppendFormat("{0}<br />", country.Name);
        }

        this.Label1.Html = sb.ToString();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Two GridPanels - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var CountrySelector = {
            add : function (source, destination) {
                source = source || GridPanel1;
                destination = destination || GridPanel2;
                if (source.selModel.hasSelection()) {
                    var records = source.selModel.getSelection();
                    source.store.remove(records);
                    destination.store.add(records);
                }
            },
            addAll : function (source, destination) {
                source = source || GridPanel1;
                destination = destination || GridPanel2;
                var records = source.store.getRange();
                source.store.removeAll();
                destination.store.add(records);
            },
            addByName : function (name) {
                if (!Ext.isEmpty(name)) {
                    var result = Store1.queryBy(function (r) {
                        return r.get("Name") === name;
                    });
                    if (!Ext.isEmpty(result.items)) {
                        GridPanel1.store.remove(result.items[0]);
                        GridPanel2.store.add(result.items[0]);
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
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server"  Namespace="" />

        <ext:Label ID="Label1" runat="server" />

        <asp:XmlDataSource
            ID="XmlDataSource1"
            runat="server"
            DataFile="Countries.xml"
            TransformFile="Countries.xsl"
            />

        <ext:Store runat="server" ID="Store1" DataSourceID="XmlDataSource1">
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

        <ext:Store runat="server" ID="Store2" OnSubmitData="SubmitData">
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

        <ext:Window
            ID="Window1"
            runat="server"
            Closable="false"
            Height="553"
            Width="720"
            Icon="WorldAdd"
            Title="Country Selector"
            BodyPadding="18"
            BodyBorder="0"
            Layout="HBox">
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
                                                <Click Handler="CountrySelector.addAll(GridPanel1, GridPanel2);" />
                                            </Listeners>
                                        </ext:MenuItem>
                                        <ext:MenuItem runat="server" Text="Deselect All">
                                            <Listeners>
                                                <Click Handler="CountrySelector.removeAll(GridPanel1, GridPanel2);" />
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
                                                <Click Handler="CountrySelector.removeAll(GridPanel1, GridPanel2);" />
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
                    runat="server"
                    ID="GridPanel1"
                    EnableDragDrop="true"
                    StoreID="Store1"
                    Flex="1">
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
                        <ext:RowSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>
                    <Plugins>
                        <ext:GridFilters ID="GridFilters1" runat="server" />
                    </Plugins>
                </ext:GridPanel>
                <ext:Panel
                    ID="Panel2"
                    runat="server"
                    Width="35"
                    BodyStyle="background-color: transparent;"
                    Border="false"
                    Layout="Anchor">
                    <Items>
                        <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" AnchorVertical="40%" />
                        <ext:Panel ID="Panel1" runat="server" Border="false" BodyStyle="background-color: transparent;" BodyPadding="18">
                            <Items>
                                <ext:Button runat="server" Icon="ResultsetNext" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.add();" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Add" Html="Add Selected Rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetLast" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.addAll();" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Add all" Html="Add All Rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetPrevious" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.remove(GridPanel1, GridPanel2);" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Remove" Html="Remove Selected Rows" />
                                    </ToolTips>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ResultsetFirst" StyleSpec="margin-bottom:2px;">
                                    <Listeners>
                                        <Click Handler="CountrySelector.removeAll(GridPanel1, GridPanel2);" />
                                    </Listeners>
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Remove all" Html="Remove All Rows" />
                                    </ToolTips>
                                </ext:Button>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel
                    runat="server"
                    ID="GridPanel2"
                    EnableDragDrop="false"
                    StoreID="Store2"
                    Flex="1">
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
                <ext:Button ID="Button1" runat="server" Text="Save Selected Countries" IconCls="x-md md-icon-save">
                    <Listeners>
                        <Click Handler="#{GridPanel2}.submitData();" />
                    </Listeners>
                </ext:Button>
                <ext:Button ID="Button2" runat="server" Text="Cancel" IconCls="x-md md-icon-cancel">
                    <Listeners>
                        <Click Handler="CountrySelector.removeAll(GridPanel1, GridPanel2);" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>