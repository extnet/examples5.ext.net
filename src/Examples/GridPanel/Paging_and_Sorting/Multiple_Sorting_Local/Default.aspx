<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.TestData;
        }
    }

    private object[] TestData
    {
        get
        {
            string[] firstNames = new string[] { "Russel", "Clark", "Steve", "Sam", "Lance", "Robert", "Sean", "David", "Justin" };
            string[] lastNames = new string[] { "Wood", "Lewis", "Scott", "Parker", "Ross", "Garcia", "Bell", "Kelly", "Powell" };
            int[] ratings = new int[] { 1, 2, 3, 4, 5 };
            int[] salaries = new int[] { 100, 400, 900, 1500, 1000000 };

            object[] data = new object[25];
            Random rnd = new Random();

            for (int i = 0; i < 25; i++)
            {
                int ratingId = rnd.Next(ratings.Length);
                int salaryId = rnd.Next(salaries.Length);
                int firstNameId = rnd.Next(firstNames.Length);
                int lastNameId = rnd.Next(lastNames.Length);

                int rating = ratings[ratingId];
                int salary = salaries[salaryId];
                string name = String.Format("{0} {1}", firstNames[firstNameId], lastNames[lastNameId]);

                data[i] = new object[] { name, rating, salary };
            }

            return data;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multiple Sorting- Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />    

    <script>        
        var doSort = function () {
            App.Store1.sort(getSorters());
        };

        var getSorters = function () {
            var sorters = [];
            
            Ext.each(App.Toolbar1.query('button'), function (button) {
                sorters.push(button.sortData);
            }, this);
            
            return sorters;
        };

        var changeSortDirection = function (button, changeDirection) {
            var sortData = button.sortData,
                iconCls  = button.iconCls;
        
            if (sortData) {
                if (changeDirection !== false) {
                    button.sortData.direction = Ext.String.toggle(button.sortData.direction, "ASC", "DESC");
                    button.setIconCls(Ext.String.toggle(iconCls, "icon-sortascending", "icon-sortdescending"));
                }
                App.Store1.clearFilter();
                doSort();
            }
        };

        var createItem = function (data) {
            var header = data.header,
                headerCt = header.ownerCt,
                reorderer = headerCt.reorderer;
            
            // Hide the drop indicators of the standard HeaderDropZone
            // in case user had a pending valid drop in 
            if (reorderer) {
                reorderer.dropZone.invalidateDrop();
            }

            return createSorterButtonConfig({
                text: header.text,
                sortData: {
                    property: header.dataIndex,
                    direction: "ASC"
                }
            });
        };
        
        var createSorterButtonConfig = function (config) {
            config = config || {};
                  
            Ext.applyIf(config, {
                listeners : {
                    click : function (button, e) {
                        changeSortDirection(button, true);             
                    }
                },
                iconCls     : config.sortData.direction.toLowerCase() == "asc" ? "icon-sortascending" : "icon-sortdescending",
                reorderable : true,
                xtype: 'splitbutton',
                menu : {
                    xtype: "menu",
                    items : [
                        {
                            text    : "Remove",
                            handler : remove
                        }
                    ]
                }
            });
            
            return config;
        };
        
        var canDrop = function (dragSource, event, data) {
            var sorters = getSorters(),
                header  = data.header,
                length = sorters.length,
                entryIndex = this.calculateEntryIndex(event),
                targetItem = this.toolbar.getComponent(entryIndex),
                i;

            // Group columns have no dataIndex and therefore cannot be sorted
            // If target isn't reorderable it could not be replaced
            if (!header.dataIndex || (targetItem && targetItem.reorderable === false)) {
                return false;
            }

            for (i = 0; i < length; i++) {
                if (sorters[i].property == header.dataIndex) {
                    return false;
                }
            }

            return true;
        };
        
        var remove = function (menu) {
            App.Toolbar1.remove(menu.up('button'));            
            App.Store1.clearFilter();
            doSort();
        };
    </script>

</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <h1>Multiple Grid Sorting Example</h1>
        
        <p>This example demontrates how to sort a grid by more than a single field.</p>
        
        <p>The store is initially sorted by Rating DESC then by Salary ASC, as indicated in the toolbar.</p>
        
        <p>Click a button to change sorting direction, drag buttons to reorder them.</p>
        
        <p>This example also uses the ToolbarDroppable plugin to allow column headers to be dropped onto the toolbar. Try it with 
          Name column header. Each column is only allowed one button, so Rating and Salary cannot be dropped in this example.</p>
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server" 
            Title="Array Grid" 
            Width="600" 
            Height="350">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="name" />
                                <ext:ModelField Name="rating" Type="Int" />
                                <ext:ModelField Name="salary" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>            
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Name" Flex="1" DataIndex="name" Sortable="false" /> 
                    <ext:Column runat="server" Text="Rating" Width="125" DataIndex="rating" Sortable="false"/>
                    <ext:Column runat="server" Text="Salary" Width="125" DataIndex="salary" Sortable="false" Align="Right">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                </Columns>
            </ColumnModel>            
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Sorting order:" Reorderable="false" />
                        <ext:ToolbarSeparator runat="server" Reorderable="false" />
                        <ext:SplitButton 
                            runat="server" 
                            Text="Rating" 
                            Icon="SortDescending"
                            OnClientClick="changeSortDirection(this, true);"
                            SortData="={{property:'rating',direction:'DESC'}}"
                            Reorderable="true">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Remove" OnClientClick="remove(this);" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                        <ext:SplitButton 
                            runat="server" 
                            Text="Salary" 
                            Icon="SortAscending"
                            OnClientClick="changeSortDirection(this, true);"
                            SortData="={{property:'salary',direction:'ASC'}}"
                            Reorderable="true">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Remove" OnClientClick="remove(this);" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                    </Items>
                    <Plugins>
                        <ext:BoxReorderer runat="server">
                            <Listeners>
                                <Drop Handler="changeSortDirection(dragCmp, false);" />
                            </Listeners>
                        </ext:BoxReorderer>
                        <ext:ToolbarDroppable ID="ToolbarDroppable1" runat="server">
                            <CreateItem Fn="createItem" />
                            <CanDrop Fn="canDrop" />
                            <Listeners>
                                <Drop Fn="doSort" />
                            </Listeners>
                        </ext:ToolbarDroppable>
                    </Plugins>
                </ext:Toolbar>
            </TopBar>
            <Listeners>
                <AfterLayout Handler="#{ToolbarDroppable1}.addDDGroup(this.child('headercontainer').reorderer.dragZone.ddGroup); doSort();" Single="true" />
            </Listeners>
        </ext:GridPanel> 
    </form>
</body>
</html>