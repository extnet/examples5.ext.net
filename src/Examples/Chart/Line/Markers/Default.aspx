<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { Month = "Jan", Data1 = 20, Data2 = 37, Data3 = 35, Data4 = 4 },
            new { Month = "Feb", Data1 = 20, Data2 = 37, Data3 = 36, Data4 = 5 },
            new { Month = "Mar", Data1 = 19, Data2 = 36, Data3 = 37, Data4 = 4 },
            new { Month = "Apr", Data1 = 18, Data2 = 36, Data3 = 38, Data4 = 5 },
            new { Month = "May", Data1 = 18, Data2 = 35, Data3 = 39, Data4 = 4 },
            new { Month = "Jun", Data1 = 17, Data2 = 34, Data3 = 42, Data4 = 4 },
            new { Month = "Jul", Data1 = 16, Data2 = 34, Data3 = 43, Data4 = 4 },
            new { Month = "Aug", Data1 = 16, Data2 = 33, Data3 = 44, Data4 = 4 },
            new { Month = "Sep", Data1 = 16, Data2 = 32, Data3 = 44, Data4 = 4 },
            new { Month = "Oct", Data1 = 16, Data2 = 32, Data3 = 45, Data4 = 4 },
            new { Month = "Nov", Data1 = 15, Data2 = 31, Data3 = 46, Data4 = 4 },
            new { Month = "Dec", Data1 = 15, Data2 = 31, Data3 = 47, Data4 = 4 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Example</h1>

        <p>Marked lines are multi-series lines displaying trends across multiple categories.</p>
        <p>Markers are placed at each point to clearly depict their position on the chart.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Preview"
                            Handler="this.up('panel').down('chart').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPadding="40">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <LegendConfig Dock="Right" />

                    <Items>
                        <ext:TextSprite
                            Text="Line Charts - Marked Lines"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20" />

                        <ext:TextSprite
                            Text="Data: Browser Stats 2012"
                            FontSize="10"
                            X="12"
                            Y="480" />

                        <ext:TextSprite
                            Text="Source: http://www.w3schools.com/"
                            FontSize="10"
                            X="12"
                            Y="495" />
                    </Items>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Data1,Data2,Data3,Data4"
                            Grid="true"
                            Minimum="0">
                            <Renderer Handler="return label.toFixed(label < 10 ? 1: 0) + '%'" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="Month"
                            Grid="true">
                            <Label RotationDegrees="-45" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            Title="IE"
                            XField="Month"
                            YField="Data1">
                            <Marker>
                                <ext:Sprite SpriteType="Square" Duration="200" Easing="BackOut" />
                            </Marker>

                            <HighlightConfig>
                                <ext:Sprite Scaling="2"  />
                            </HighlightConfig>

                            <Tooltip TrackMouse="true">
                                <Renderer Handler="var title = context.series.getTitle(); toolTip.setHtml(title + ' for ' + record.get('Month') + ': ' + record.get(context.series.getYField()) + '%');" />
                            </Tooltip>
                        </ext:LineSeries>

                        <ext:LineSeries
                            Title="Firefox"
                            XField="Month"
                            YField="Data2">
                            <Marker>
                                <ext:Sprite SpriteType="Triangle" Duration="200" Easing="BackOut" />
                            </Marker>

                            <HighlightConfig>
                                <ext:Sprite Scaling="2"  />
                            </HighlightConfig>

                            <Tooltip TrackMouse="true">
                                <Renderer Handler="var title = context.series.getTitle(); toolTip.setHtml(title + ' for ' + record.get('Month') + ': ' + record.get(context.series.getYField()) + '%');" />
                            </Tooltip>
                        </ext:LineSeries>

                        <ext:LineSeries
                            Title="Chrome"
                            XField="Month"
                            YField="Data3">
                            <Marker>
                                <ext:Sprite SpriteType="Arrow" Duration="200" Easing="BackOut" />
                            </Marker>

                            <HighlightConfig>
                                <ext:Sprite Scaling="2"  />
                            </HighlightConfig>

                            <Tooltip TrackMouse="true">
                                <Renderer Handler="var title = context.series.getTitle(); toolTip.setHtml(title + ' for ' + record.get('Month') + ': ' + record.get(context.series.getYField()) + '%');" />
                            </Tooltip>
                        </ext:LineSeries>

                        <ext:LineSeries
                            Title="Safari"
                            XField="Month"
                            YField="Data4">
                            <Marker>
                                <ext:Sprite SpriteType="Cross" Duration="200" Easing="BackOut" />
                            </Marker>

                            <HighlightConfig>
                                <ext:Sprite Scaling="2"  />
                            </HighlightConfig>

                            <Tooltip TrackMouse="true">
                                <Renderer Handler="var title = context.series.getTitle(); toolTip.setHtml(title + ' for ' + record.get('Month') + ': ' + record.get(context.series.getYField()) + '%');" />
                            </Tooltip>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
