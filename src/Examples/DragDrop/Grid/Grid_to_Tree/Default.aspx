<%@ Page Language="C#" %>

<script runat="server">
    private object[] TestData
    {
        get
        {
            DateTime now = DateTime.Now;

            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, now },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, now },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, now },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, now },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, now },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, now },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, now },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, now },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, now },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, now },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, now },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, now },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, now },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, now },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, now },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, now },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, now },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, now },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, now },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, now },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, now },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, now },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, now },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, now },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, now },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, now },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, now },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, now },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, now }
            };
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.TestData;
            this.Store1.DataBind(); 
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop from GridPanel to TreePanel - Ext.NET Examples</title>
    
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
         var beforerecorddrop = function (node, data, overModel, dropPosition, dropFn) { 
            if (Ext.isArray(data.records)) {                
                var records = data.records,
                    rec;

                data.records = [];
                
                for (var i = 0; i < records.length; i++) {
                    rec = records[i];
                    
                    data.records.push({
                        text   : rec.get("company"),
                        leaf   : true,
                        price  : rec.get("price"),
                        change : rec.get("change"),
                        pctChange : rec.get("pctChange"),                        
                        qtip   : rec.get("lastChange")
                    });

                    rec.store.remove(rec);
                }
                
                return true;
            }
        };

        var beforenodedrop = function (node, data, overModel, dropPosition, dropFn) { 
            if (Ext.isArray(data.records)) {                
                var records = data.records,
                    rec;

                data.records = [];
                
                for (var i = 0; i < records.length; i++) {
                    rec = records[i];
                    
                    data.records.push(this.store.createModel({
                        company   : rec.get("text"),
                        price  : rec.get("price"),
                        change : rec.get("change"),
                        pctChange : rec.get("pctChange"),
                        lastChange   : rec.get("qtip")
                    }));

                    rec.remove(true);
                }
                
                return true;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:Panel 
            runat="server"
            Width="700" 
            Height="400"
            Layout="BorderLayout">
            <Items>
                <ext:GridPanel 
                    runat="server"
                    Region="Center"
                    Title="Grid" 
                    MultiSelect="true"
                    MarginSpec="5 0 5 5">
                    <Store>
                        <ext:Store 
                            ID="Store1" 
                            runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="company" />
                                        <ext:ModelField Name="price" Type="Float" />
                                        <ext:ModelField Name="change" Type="Float" />
                                        <ext:ModelField Name="pctChange" Type="Float" />
                                        <ext:ModelField Name="lastChange" Type="Date"/>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>                    
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column 
                                runat="server" 
                                Text="Company" 
                                Sortable="true" 
                                DataIndex="company"
                                Flex="1" 
                                />
                            <ext:Column 
                                runat="server" 
                                Text="Price" 
                                Width="75" 
                                Sortable="true" 
                                DataIndex="price">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                        </Columns>
                    </ColumnModel>                    
                    <View>
                        <ext:GridView runat="server">
                            <Plugins>
                                <ext:GridDragDrop runat="server" DragGroup="grid2tree" DropGroup="tree2grid" />
                            </Plugins>
                            <Listeners>
                                <BeforeDrop Fn="beforenodedrop" />
                            </Listeners>
                        </ext:GridView>
                    </View>
                </ext:GridPanel>
                    
                <ext:TreePanel 
                    runat="server" 
                    Region="East"                    
                    Width="300"
                    Title="Tree"
                    AutoScroll="true"                    
                    MarginSpec="5 5 5 0"
                    Split="true">
                    <Root>
                        <ext:Node Text="Root" Expanded="true" AllowDrag="false">                        
                            <Children>
                                <ext:Node Text="Folder 1" Qtip="Rows dropped here will be appended to the folder" AllowDrag="false">
                                    <Children>
                                        <ext:Node Text="Subleaf 1" Qtip="Subleaf 1 Quick Tip" Leaf="true"  AllowDrag="false"/>
                                    </Children>
                                </ext:Node>
                                        
                                <ext:Node Text="Folder 2" Qtip="Rows dropped here will be appended to the folder" AllowDrag="false">
                                    <Children>
                                        <ext:Node Text="Subleaf 2" Qtip="Subleaf 2 Quick Tip" Leaf="true"  AllowDrag="false"/>
                                    </Children>
                                </ext:Node>
                                        
                                <ext:Node Text="Leaf 1" Qtip="Leaf 1 Quick Tip" Leaf="true" AllowDrag="false" />
                            </Children>
                        </ext:Node>
                    </Root>
                    <View>
                        <ext:TreeView runat="server">
                            <Plugins>
                                <ext:TreeViewDragDrop runat="server" DragGroup="tree2grid" DropGroup="grid2tree" />
                            </Plugins>
                            <Listeners>
                                <BeforeDrop Fn="beforerecorddrop" />
                            </Listeners>
                        </ext:TreeView>
                    </View>              
                </ext:TreePanel>
            </Items>
        </ext:Panel> 
    </form>
</body>
</html>