<%@ Page Language="C#" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo ci = new CultureInfo("en-US");

        Store store = this.GridPanel1.GetStore();

        store.DataSource = new List<Project>
        {
            new Project(100, "Ext Forms: Field Anchoring", 112, "Integrate 2.0 Forms with 2.0 Layouts", 6, 150, 0, ParseExact("06/24/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring", 113, "Implement AnchorLayout", 4, 150, 0, ParseExact("06/25/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring", 114, "Add support for multiple types of anchors", 4, 150, 0, ParseExact("06/27/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring", 115, "Testing and debugging", 8, 0, 0, ParseExact("06/29/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 101, "Add required rendering \"hooks\" to GridView", 6, 100, 0, ParseExact("07/01/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 102, "Extend GridView and override rendering functions", 6, 100, 0, ParseExact("07/03/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 103, "Extend Store with grouping functionality", 4, 100, 0, ParseExact("07/04/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 121, "Default CSS Styling", 2, 100, 0, ParseExact("07/05/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 104, "Testing and debugging", 6, 100, 0, ParseExact("07/06/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows", 105, "Ext Grid plugin integration", 4, 125, 0, ParseExact("07/01/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows", 106, "Summary creation during rendering phase", 4, 125, 0, ParseExact("07/02/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows", 107, "Dynamic summary updates in editor grids", 6, 125, 0, ParseExact("07/05/2007", ref ci)),
         };
    }

    private DateTime ParseExact(string dateString, ref CultureInfo culture)
    {
        return DateTime.ParseExact(dateString, "MM/dd/yyyy", culture);
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

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Summary Plugin - Ext.NET Examples</title>

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
            font-weight      : bold;
            font-size        : 11px;
            background-color : #f1f2f4;
        }
    </style>

    <script>
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
    </script>
</head>
<body>
    <form runat="server">
        <h1>Summary Plugin</h1>

        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Sponsored Projects"
            Frame="true"
            Collapsible="true"
            Width="960"
            Height="480">
            <Store>
                <ext:Store runat="server">
                    <Sorters>
                        <ext:DataSorter Property="Due" Direction="ASC" />
                    </Sorters>
                    <Model>
                        <ext:Model runat="server" IDProperty="TaskID">
                            <Fields>
                                <ext:ModelField Name="ProjectID" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="TaskID" />
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
            </Plugins>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        TdCls="task"
                        Text="Task"
                        Sortable="true"
                        DataIndex="Description"
                        Hideable="false"
                        SummaryType="Count"
                        Flex="1">
                        <SummaryRenderer Handler="return ((value === 0 || value > 1) ? '(' + value +' Tasks)' : '(1 Task)');" />
                    </ext:Column>

                    <ext:Column runat="server" Text="Project" DataIndex="Name" Flex="1">
                        <SummaryRenderer Handler="return '&nbsp;';" />
                    </ext:Column>

                    <ext:DateColumn
                        runat="server"
                        Text="Due Date"
                        Sortable="true"
                        DataIndex="Due"
                        SummaryType="Max"
                        Format="MM/dd/yyyy"
                        Width="120">
                        <Editor>
                            <ext:DateField runat="server" Format="MM/dd/yyyy" />
                        </Editor>
                        <%-- Remove after fixing #563 --%>
                        <SummaryRenderer Format="Date" FormatArgs="'m/d/Y'" />
                    </ext:DateColumn>

                    <ext:Column
                        runat="server"
                        Width="75"
                        Text="Estimate"
                        Sortable="true"
                        DataIndex="Estimate"
                        SummaryType="Sum">
                        <Renderer Handler="return value + ' hours';" />
                        <%-- Remove after fixing #563 --%>
                        <SummaryRenderer Handler="return value + ' hours';" />
                        <Editor>
                            <ext:NumberField
                                runat="server"
                                AllowBlank="false"
                                AllowNegative="false"
                                StyleSpec="text-align:left" />
                        </Editor>
                    </ext:Column>

                    <ext:Column
                        runat="server"
                        Width="75"
                        Text="Rate"
                        Sortable="true"
                        DataIndex="Rate"
                        SummaryType="Average">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:NumberField
                                runat="server"
                                AllowBlank="false"
                                AllowNegative="false"
                                StyleSpec="text-align:left" />
                        </Editor>
                        <%-- Remove after fixing #563 --%>
                        <SummaryRenderer Format="UsMoney" />
                    </ext:Column>

                    <ext:Column
                        runat="server"
                        Width="75"
                        ID="Cost"
                        Text="Cost"
                        Sortable="false"
                        Groupable="false"
                        DataIndex="Cost"
                        CustomSummaryType="totalCost">
                        <Renderer Handler="return Ext.util.Format.usMoney(record.data.Estimate * record.data.Rate);" />
                        <SummaryRenderer Format="UsMoney" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <Features>
                <ext:Summary ID="Summary1" runat="server" />
            </Features>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Toggle" ToolTip="Toggle the visibility of summary row">
                            <Listeners>
                                <Click Handler="#{Summary1}.toggleSummaryRow(!#{Summary1}.showSummaryRow);
                                                #{Summary1}.view.refresh();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>
    </form>
  </body>
</html>