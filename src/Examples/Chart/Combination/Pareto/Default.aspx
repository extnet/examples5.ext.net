<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { complaint = "Overpriced", count = 543, cumnumber = 543, cumpercent = 31 },
            new { complaint = "Small Portions", count = 412, cumnumber = 955, cumpercent = 55 },
            new { complaint = "High Wait Time", count = 245, cumnumber = 1200, cumpercent = 69 },
            new { complaint = "Tasteless Food", count = 187, cumnumber = 1387, cumpercent = 80 },
            new { complaint = "Bad Ambiance", count = 134, cumnumber = 1521, cumpercent = 88 },
            new { complaint = "Not Clean", count = 98, cumnumber = 1619, cumpercent = 93 },
            new { complaint = "Too Noisy", count = 65, cumnumber = 1684, cumpercent = 97 },
            new { complaint = "Salty Food", count = 41, cumnumber = 1725, cumpercent = 99 },
            new { complaint = "Unfriendly Staff", count = 12, cumnumber = 1737, cumpercent = 100 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Pareto Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function download() {
            var chart = App.Chart1;

            if (Ext.os.is.Desktop) {
                chart.download({
                    filename: 'Redwood City Climate Data Chart'
                });
            } else {
                chart.preview();
            }
        }

        function renderer(toolTip, record, context) {
            var store = record.store,
                i, complaints = [];

            for (i = 0; i <= context.index; i++) {
                complaints.push(store.getAt(i).get('complaint'));
            }

            toolTip.setHtml('<div style="text-align: center; font-weight: bold">' + record.get('cumpercent') + '%</div>' + complaints.join('<br>'));
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Container runat="server" Region="North" Height="125" PaddingSpec="20 0 0 20">
                    <Content>
                        <h1>Pareto Chart Example</h1>

                        <p>Pareto chart, named after Vilfredo Pareto, is a chart that contains both column and line chart.</p>
                        <p>Individual values are represented in descending order by bars, and the cumulative total is represented by the line.</p>
                    </Content>
                </ext:Container>

                <ext:Container runat="server" Region="Center" OverflowY="Auto">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Center" Align="Center" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel
                            runat="server"
                            Width="650"
                            BodyStyle="background: transparent !important">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Pack="Center" Align="Center" />
                            </LayoutConfig>
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarFill />

                                        <ext:Button
                                            runat="server"
                                            Text="={Ext.os.is.Desktop ? 'Download' : 'Preview'}"
                                            Handler="download" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:CartesianChart
                                    ID="Chart1"
                                    runat="server"
                                    StandardTheme="Category2"
                                    Height="500"
                                    Width="650"
                                    InsetPaddingSpec="40 40 20 40">
                                    <Store>
                                        <ext:Store
                                            ID="Store1"
                                            runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="complaint" />
                                                        <ext:ModelField Name="count" />
                                                        <ext:ModelField Name="cumnumber" />
                                                        <ext:ModelField Name="cumpercent" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <LegendConfig Dock="Bottom" />
                                    <Items>
                                        <ext:TextSprite
                                            Text="Restaurant Complaints by Reported Cause"
                                            FontSize="22"
                                            Width="100"
                                            Height="30"
                                            X="40"
                                            Y="20" />

                                        <ext:TextSprite
                                            Text="Data: Restaurant Complaints"
                                            FontSize="10"
                                            FontFamily="Helvetica"
                                            X="12"
                                            Y="480" />
                                    </Items>
                                    <Axes>
                                        <ext:NumericAxis
                                            Fields="count"
                                            Position="Left"
                                            Grid="true"
                                            Minimum="0"
                                            MajorTickSteps="10"
                                            ReconcileRange="true">
                                        </ext:NumericAxis>

                                        <ext:CategoryAxis
                                            Position="Bottom"
                                            Fields="complaint">
                                            <Label RotationDegrees="-45" />
                                        </ext:CategoryAxis>

                                        <ext:NumericAxis
                                            Fields="cumnumber"
                                            Position="Right"
                                            MajorTickSteps="10"
                                            ReconcileRange="true">
                                            <Renderer Handler="var total = axis.getRange()[1]; return (label / total * 100).toFixed(0) + '%';" />
                                        </ext:NumericAxis>
                                    </Axes>
                                    <Series>
                                        <ext:BarSeries
                                            Title="Causes"
                                            XField="complaint"
                                            YField="count">
                                            <StyleSpec>
                                                <ext:Sprite GlobalAlpha="0.8" />
                                            </StyleSpec>
                                            <HighlightConfig>
                                                <ext:Sprite FillStyle="rgba(204, 230, 73, 1.0)" StrokeStyle="black" />
                                            </HighlightConfig>
                                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff">
                                                <Renderer Handler="toolTip.setHtml(record.get('complaint') + ': ' + record.get('count') + ' responses.');" />
                                            </Tooltip>
                                        </ext:BarSeries>

                                        <ext:LineSeries
                                            Title="Cumulative %"
                                            XField="complaint"
                                            YField="cumnumber">
                                            <StyleSpec>
                                                <ext:Sprite LineWidth="2" GlobalAlpha="0.8" />
                                            </StyleSpec>
                                            <Marker>
                                                <ext:Sprite SpriteType="Cross" Duration="200" />
                                            </Marker>
                                            <HighlightDefaults>
                                                <ext:Sprite Scaling="2" RotationRads="<%# Math.PI / 4 %>" AutoDataBind="true" />
                                            </HighlightDefaults>
                                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff">
                                                <Renderer Fn="renderer" />
                                            </Tooltip>
                                        </ext:LineSeries>
                                    </Series>
                                </ext:CartesianChart>

                                <ext:GridPanel runat="server" StoreID="Store1" StyleSpec="margin-top: 10px;padding-left:40px;" Width="600">
                                    <ColumnModel>
                                        <Columns>
                                            <ext:Column runat="server" Text="Complaint" DataIndex="complaint" Width="175" Sortable="false" MenuDisabled="true" />
                                            <ext:Column runat="server" Text="Count" DataIndex="count" Sortable="false" MenuDisabled="true" />
                                            <ext:Column runat="server" Text="Cumulative" DataIndex="cumnumber" Sortable="false" MenuDisabled="true" />
                                            <ext:Column runat="server" Text="Cumulative %" DataIndex="cumpercent" Width="175" Sortable="false" MenuDisabled="true">
                                                <Renderer Handler="return value + '%';" />
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
