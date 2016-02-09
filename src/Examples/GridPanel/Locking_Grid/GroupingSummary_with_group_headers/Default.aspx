<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
     {
         this.Store1.DataSource = new List<Project> 
         { 
            new Project(100, "Ext Forms: Field Anchoring", 112, "Integrate 2.0 Forms with 2.0 Layouts", 6, 150, 0, new DateTime(2007, 06, 24)),
            new Project(100, "Ext Forms: Field Anchoring", 113, "Implement AnchorLayout", 4, 150, 0, new DateTime(2007, 06, 25)),
            new Project(100, "Ext Forms: Field Anchoring", 114, "Add support for multiple<br> types of anchors", 4, 150, 0, new DateTime(2007, 06, 27)),
            new Project(100, "Ext Forms: Field Anchoring", 115, "Testing and debugging", 8, 0, 0, new DateTime(2007, 06, 29)),
            new Project(101, "Ext Grid: Single-level Grouping", 101, "Add required rendering \"hooks\" to GridView", 6, 100, 0, new DateTime(2007, 07, 01)),
            new Project(101, "Ext Grid: Single-level Grouping", 102, "Extend GridView and override rendering functions", 6, 100, 0, new DateTime(2007, 07, 03)),
            new Project(101, "Ext Grid: Single-level Grouping", 103, "Extend Store with grouping functionality", 4, 100, 0, new DateTime(2007, 07, 04)),
            new Project(101, "Ext Grid: Single-level Grouping", 121, "Default CSS Styling", 2, 100, 0, new DateTime(2007, 07, 05)),
            new Project(101, "Ext Grid: Single-level Grouping", 104, "Testing and debugging", 6, 100, 0, new DateTime(2007, 07, 06)),
            new Project(102, "Ext Grid: Summary Rows", 105, "Ext Grid plugin integration", 4, 125, 0, new DateTime(2007, 07, 01)),
            new Project(102, "Ext Grid: Summary Rows", 106, "Summary creation during rendering phase", 4, 125, 0, new DateTime(2007, 07, 02)),
            new Project(102, "Ext Grid: Summary Rows", 107, "Dynamic summary updates in editor grids", 6, 125, 0, new DateTime(2007, 07, 05)),
            new Project(102, "Ext Grid: Summary Rows", 108, "Remote summary integration", 4, 125, 0, new DateTime(2007, 07, 05)),
            new Project(102, "Ext Grid: Summary Rows", 109, "Summary renderers and calculators", 4, 125, 0, new DateTime(2007, 07, 06)),
            new Project(102, "Ext Grid: Summary Rows", 110, "Integrate summaries with GroupingView", 10, 125, 0, new DateTime(2007, 07, 11)),
            new Project(102, "Ext Grid: Summary Rows", 111, "Testing and debugging", 8, 125, 0, new DateTime(2007, 07, 15))
         };

        this.Store1.DataBind();
    }

    public class Project
    {
        public Project(int projectId, string name, int taskId, string description, int estimate, double rate, double cost, DateTime due)
        {
            this.ProjectID = projectId;
            this.Name = name;
            this.TaskID = taskId;
            this.Description = description;
            this.Estimate = estimate;
            this.Rate = rate;
            this.Due = due;
        }

        public int ProjectID { get; set; }
        public string Name { get;set; }
        public int TaskID { get; set; }
        public string Description { get;set; }
        public int Estimate { get;set; }
        public double Rate { get; set; }
        public double Cost { get; set; }
        public DateTime Due { get; set; }
    }
</script>

<html>
<head runat="server">
    <title>Locking, Cell Editing Summary Grid - Ext.NET Examples</title>
    
    <link href="/resources/css/examples.css" rel="stylesheet" />
   
    <style>
        .x-grid-body .x-grid-cell-Cost {
            background-color : #f1f2f4;
        }
         
        .x-grid-row-summary .x-grid-cell-Cost .x-grid-cell-inner{
            background-color : #e1e2e4;
        }    

        .task .x-grid-cell-inner {
            padding-left: 15px;
        }

        .x-grid-row-summary .x-grid-cell-inner {
            font-weight: bold;
            font-size: 11px;
            background-color : #f1f2f4;
        } 
    </style>

    <script>
        var showSummary = true;

        var totalCost = function (records) {
            var i = 0,
                length = records.length,
                total = 0,
                record;

            for (; i < length; ++i) {
                record = records[i];
                total += record.get('Estimate') * record.get('Rate');
            }
            return total;
        };

        var toggleSummary = function (b) {
            showSummary = !showSummary;
            var grid = b.up('gridpanel'),
                view = grid.lockedGrid.getView();
            view.getFeature('group').toggleSummaryRow(showSummary);
            view.refresh();
            view = grid.normalGrid.getView();
            view.getFeature('group').toggleSummaryRow(showSummary);
            view.refresh();
        };

        var beforeShowTip = function (grid, tip, data) {
            var cellNode = tip.triggerEvent.getTarget(tip.view.getCellSelector());
            if (cellNode) {
                data.colName = tip.view.headerCt.getHeaderAtIndex(cellNode.cellIndex).text;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <h1>Locking, Group Summary Grid Example with grouped headers and docked summary</h1>
        
        <p>It is not possible to lock or unlock <i>all</i> columns using the user interface. Each side, locked or unlocked must always contain at least one column.</p>

        <ext:ResourceManager runat="server"/>        
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server" 
            Frame="true"            
            Title="Sponsored Projects"                         
            Icon="ApplicationViewColumns"
            Width="800"
            Height="450">
            <Store>
                <ext:Store ID="Store1" runat="server" GroupField="Name">
                    <Sorters>
                        <ext:DataSorter Property="Due" Direction="ASC" />
                    </Sorters>
                    <Model>
                        <ext:Model runat="server" IDProperty="TaskID">
                            <Fields>
                                <ext:ModelField Name="ProjectID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="TaskID" Type="Int" />
                                <ext:ModelField Name="Description" />
                                <ext:ModelField Name="Estimate" Type="Int" />
                                <ext:ModelField Name="Rate" Type="Float" />
                                <ext:ModelField Name="Cost" Type="Float" />
                                <ext:ModelField Name="Due" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <Plugins>
                <ext:CellEditing runat="server" ClicksToEdit="1" />
                <ext:DataTip runat="server">
                    <Tpl>
                        <Html>
                            Click to edit {colName}
                        </Html>
                    </Tpl>          
                    <BeforeShowTip Fn="beforeShowTip" />
                </ext:DataTip>
            </Plugins>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column                        
                        runat="server"
                        Locked="true"
                        TdCls="task"
                        Text="Task"                       
                        Sortable="true"
                        DataIndex="Description"
                        Hideable="false"
                        SummaryType="Count"
                        Width="300">
                        <SummaryRenderer Handler="return ((value === 0 || value > 1) ? '(' + value +' Tasks)' : '(1 Task)');" />     
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>                       
                    </ext:Column>
                     
                    <ext:Column runat="server" Text="Project" DataIndex="Name" Width="180" />

                    <ext:Column runat="server" Text="Schedule">
                        <Columns>
                            <ext:DateColumn
                                runat="server"
                                Width="125"
                                Text="Due Date"
                                Sortable="true"
                                DataIndex="Due"
                                SummaryType="Max"
                                Format="MM/dd/yyyy">
                                <Editor>
                                    <ext:DateField runat="server" Format="MM/dd/yyyy" />
                                </Editor>
                                <%-- Remove after fixing #563 --%>
                                <SummaryRenderer Format="Date" FormatArgs="'m/d/Y'" />
                            </ext:DateColumn>
 
                            <ext:Column
                                runat="server"  
                                Width="125"
                                Text="Estimate"
                                Sortable="true"
                                DataIndex="Estimate"
                                SummaryType="Sum">
                                <Renderer Handler="return value +' hours';" />
                                <%-- Remove after fixing #563 --%>
                                <SummaryRenderer Handler="return value + ' hours';" />
                                <Editor>
                                    <ext:NumberField runat="server" AllowBlank="false" MinValue="0" StyleSpec="text-align:left" />
                                </Editor>
                            </ext:Column>
                     
                            <ext:Column
                                runat="server"
                                Width="125"
                                Text="Rate"
                                Sortable="true"
                                DataIndex="Rate"
                                SummaryType="Average">
                                <Renderer Format="UsMoney" />
                                <%-- Remove after fixing #563 --%>
                                <SummaryRenderer Format="UsMoney" />
                                <Editor>
                                    <ext:NumberField runat="server" AllowBlank="false" MinValue="0" StyleSpec="text-align:left" />
                                </Editor>
                            </ext:Column>
                     
                            <ext:Column
                                runat="server"
                                Width="114"
                                ID="Cost"
                                Text="Cost"
                                Sortable="false"
                                Groupable="false"
                                DataIndex="Cost"
                                CustomSummaryType="totalCost">
                                <Renderer Handler="return Ext.util.Format.usMoney(record.data.Estimate * record.data.Rate);" />
                                <%-- Remove after fixing #563 --%>
                                <SummaryRenderer Format="UsMoney" />
                            </ext:Column>
                        </Columns>
                    </ext:Column>                    
                </Columns>                
            </ColumnModel>           
            <Features>               
                <ext:GroupingSummary 
                    ID="group" 
                    runat="server" 
                    GroupHeaderTplString="{name}" 
                    HideGroupedHeader="true" 
                    EnableGroupingMenu="false" />

                <ext:Summary runat="server" Dock="Bottom" />
            </Features>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button 
                            runat="server" 
                            Text="Toggle" 
                            ToolTip="Toggle the visibility of summary row" 
                            EnableToggle="true" 
                            Pressed="true">
                            <Listeners>
                                <Click Fn="toggleSummary" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <SelectionModel>
                <ext:CellSelectionModel runat="server" />
            </SelectionModel>
        </ext:GridPanel>
    </form>
  </body>
</html>