<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">
    public class Country
    {
        public string Name { get; set; }
    }

    protected void SaveSelection(object sender, BeforeStoreChangedEventArgs e)
    {
        List<Country> records = e.DataHandler.ObjectData<Country>();
        e.Cancel = true;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    
    <script>
        var CountrySelector = {
            swapRecords : function (source, destination, records) {
                for (var i = 0; i < records.length; i++) {
                    destination.store.add(records[i].data);
                }
            },

            add : function (source, destination) {
                source = source || GridPanel1;
                destination = destination || GridPanel2;
                
                if (source.selModel.hasSelection()) {
                    var records = source.selModel.getSelection();
                    source.store.remove(records);
					this.swapRecords(source, destination, records);                    
                }
            },
            addAll : function (source, destination) {
                source = source || GridPanel1;
                destination = destination || GridPanel2;
                source.store.removeAll();
				this.swapRecords(source, destination, source.store.getRange());                
            },

            remove : function (source, destination) {
                this.add(destination, source);
            },

            removeAll : function (source, destination) {
                this.addAll(destination, source);
            }
        };
    </script>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
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
        
        <ext:Store runat="server" ID="Store2" OnBeforeStoreChanged="SaveSelection">
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
            Width="700"
            Icon="WorldAdd"
            Title="Country Selector"
            BodyPadding="5"
            BodyBorder="false"
            Layout="HBoxLayout"> 
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>           
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
                <ext:Panel ID="Panel2" runat="server" Width="35" BodyStyle="background-color: transparent;" Border="false" Layout="Anchor">
                    <Items>
                        <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" AnchorVertical="40%" />
                        <ext:Panel ID="Panel1" runat="server" Border="false" BodyStyle="background-color: transparent;" BodyPadding="5">
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
                    <Listeners>
                    </Listeners>
                    <ColumnModel runat="server">
	                    <Columns>
                            <ext:Column runat="server" Text="Selected Countries" DataIndex="Name" Flex="1" />                   
	                    </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" Mode="Multi" />
                    </SelectionModel>  
                </ext:GridPanel>
            </Items>  
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="Save Selected Countries" Icon="Disk">
                    <Listeners>
                        <Click Handler="#{GridPanel2}.store.sync();" />
                    </Listeners>
                </ext:Button>
                <ext:Button ID="Button2" runat="server" Text="Cancel" Icon="Cancel">
                    <Listeners>
                        <Click Handler="CountrySelector.removeAll(GridPanel1, GridPanel2);" />
                    </Listeners>
                </ext:Button>
            </Buttons>      
        </ext:Window>
    </form>
</body>
</html>