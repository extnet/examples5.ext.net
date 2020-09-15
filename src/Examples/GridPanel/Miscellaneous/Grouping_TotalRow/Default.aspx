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
            new Project(100, "Ext Forms: Field Anchoring",      112, "Integrate 2.0 Forms with 2.0 Layouts", 6, 150, 0, ParseExact("06/24/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring",      113, "Implement AnchorLayout", 4, 150, 0, ParseExact("06/25/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring",      114, "Add support for multiple types of anchors", 4, 150, 0, ParseExact("06/27/2007", ref ci)),
            new Project(100, "Ext Forms: Field Anchoring",      115, "Testing and debugging", 8, 0, 0, ParseExact("06/29/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 101, "Add required rendering \"hooks\" to GridView", 6, 100, 0, ParseExact("07/01/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 102, "Extend GridView and override rendering functions", 6, 100, 0, ParseExact("07/03/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 103, "Extend Store with grouping functionality", 4, 100, 0, ParseExact("07/04/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 121, "Default CSS Styling", 2, 100, 0, ParseExact("07/05/2007", ref ci)),
            new Project(101, "Ext Grid: Single-level Grouping", 104, "Testing and debugging", 6, 100, 0, ParseExact("07/06/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          105, "Ext Grid plugin integration", 4, 125, 0, ParseExact("07/01/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          106, "Summary creation during rendering phase", 4, 125, 0, ParseExact("07/02/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          107, "Dynamic summary updates in editor grids", 6, 125, 0, ParseExact("07/05/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          108, "Remote summary integration", 4, 125, 0, ParseExact("07/05/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          109, "Summary renderers and calculators", 4, 125, 0, ParseExact("07/06/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          110, "Integrate summaries with GroupingView", 10, 125, 0, ParseExact("07/11/2007", ref ci)),
            new Project(102, "Ext Grid: Summary Rows",          111, "Testing and debugging", 8, 125, 0, ParseExact("07/15/2007", ref ci))
        };

        store.DataBind();
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
    <title>Grouping Total Row - Ext.NET Examples</title>

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

        .total-field{
            background-color : #fff;
            padding          : 0px 1px 1px 1px;
            margin-right     : 1px;
            position: absolute;
        }

        .total-field .x-form-display-field{
            font-weight      : bold !important;
            border           : solid 1px silver;
            font-size        : 11px;
            font-family      : tahoma, arial, verdana, sans-serif;
            color            : #000;
            padding          : 0px 0px 0px 5px;
            height           : 22px;
            margin-top       : 0px;
            padding-top      : 3px;
        }
    </style>

    <script>
        var updateTotal = function (grid, container) {
            if (!grid.view.rendered) {
                return;
            }

            var field,
                value,
                width,
                c,
                cs = grid.headerCt.getVisibleGridColumns();

            container.suspendLayout = true;

            for (var i = 0; i < cs.length; i++) {
                c = cs[i];

                if (c.summaryType) {
                    value = App.Group1.getSummary(grid.store, c.summaryType, c.dataIndex);
                } else {
                    value = "-";
                }

                field = container.down('component[name="'+c.dataIndex+'"]');

                container.remove(field, false);
                container.insert(i, field);
                width = c.getWidth();
                field.setWidth(width - 1);

                var r = c.summaryRenderer || simpleRenderer;
                field.setValue(r(value, {}, c.dataIndex));
            }

            container.items.each(function (field) {
                var column = grid.headerCt.down('component[dataIndex="'+field.name+'"]');
                field.setVisible(column.isVisible());
            });

            container.suspendLayout = false;
            container.updateLayout();
        };

        var simpleRenderer = function (v) {
            return v;
        };

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
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Frame="true"
            Title="Sponsored Projects"
            Width="960"
            Height="480">
            <Store>
                <ext:Store ID="Store1" runat="server" GroupField="Name">
                    <Sorters>
                        <ext:DataSorter Property="Due" Direction="DESC" />
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
                                <ext:ModelField Name="Due" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <Plugins>
                <ext:CellEditing runat="server" ClicksToEdit="1">
                    <Listeners>
                        <Edit Handler="this.view.refresh();" />
                    </Listeners>
                </ext:CellEditing>
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

                    <ext:Column
                        runat="server"
                        Text="Project"
                        DataIndex="Name"
                        Width="20"
                        />

                    <ext:Column
                        runat="server"
                        Width="100"
                        Text="Due Date"
                        Sortable="true"
                        DataIndex="Due"
                        SummaryType="Max">
                        <Renderer Format="Date" FormatArgs="'m/d/Y'" />
                        <SummaryRenderer Fn="Ext.util.Format.dateRenderer('m/d/Y')" />
                        <Editor>
                            <ext:DateField runat="server" Format="MM/dd/yyyy" />
                        </Editor>
                    </ext:Column>

                    <ext:Column
                        runat="server"
                        Width="75"
                        Text="Estimate"
                        Sortable="true"
                        DataIndex="Estimate"
                        SummaryType="Sum">
                        <Renderer Handler="return value +' hours';" />
                        <SummaryRenderer Handler="return value +' hours';" />
                        <Editor>
                            <ext:NumberField
                                runat="server"
                                AllowBlank="false"
                                AllowNegative="false"
                                StyleSpec="text-align:left"
                                />
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
                        <SummaryRenderer Fn="Ext.util.Format.usMoney" />
                         <Editor>
                            <ext:NumberField
                                runat="server"
                                AllowBlank="false"
                                AllowNegative="false"
                                StyleSpec="text-align:left"
                                />
                        </Editor>
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
                        <SummaryRenderer Fn="Ext.util.Format.usMoney" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <Listeners>
                <ColumnResize Handler="updateTotal(this, #{Container1});" />
                <ColumnMove Handler="updateTotal(this, #{Container1});" />
                <ColumnHide Handler="updateTotal(this, #{Container1});" />
            </Listeners>
            <View>
                 <ext:GridView runat="server">
                    <Listeners>
                        <Refresh Handler="updateTotal(this.panel, #{Container1});" Delay="100" />
                    </Listeners>
                </ext:GridView>
            </View>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Toggle Summary" ToolTip="Toggle the visibility of summary row">
                            <Listeners>
                                <Click Handler="#{Group1}.toggleSummaryRow(!#{Group1}.showSummaryRow);#{Group1}.view.refresh();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Features>
                <ext:GroupingSummary
                    ID="Group1"
                    runat="server"
                    GroupHeaderTplString="{name}"
                    HideGroupedHeader="true"
                    EnableGroupingMenu="false"
                    />
            </Features>
            <DockedItems>
                <ext:Container
                    ID="Container1"
                    runat="server"
                    Layout="HBox"
                    Dock="Bottom"
                    StyleSpec="margin-top:2px;">
                    <Defaults>
                        <ext:Parameter Name="height" Value="24" />
                    </Defaults>
                    <Items>
                        <ext:DisplayField ID="ColumnField1" runat="server" Name="Description" Cls="total-field" Text="-" />
                        <ext:DisplayField ID="ColumnField2" runat="server" Name="Due" Cls="total-field" Text="-" />
                        <ext:DisplayField ID="ColumnField3" runat="server" Name="Estimate" Cls="total-field" Text="-" />
                        <ext:DisplayField ID="ColumnField4" runat="server" Name="Rate" Cls="total-field" Text="-" />
                        <ext:DisplayField ID="ColumnField5" runat="server" Name="Cost" Cls="total-field" Text="-" />
                    </Items>
                </ext:Container>
            </DockedItems>
        </ext:GridPanel>
    </form>
  </body>
</html>