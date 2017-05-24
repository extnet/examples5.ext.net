<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { Month = "Jan", Data1 = 20 },
            new { Month = "Feb", Data1 = 20 },
            new { Month = "Mar", Data1 = 19 },
            new { Month = "Apr", Data1 = 18 },
            new { Month = "May", Data1 = 18 },
            new { Month = "Jun", Data1 = 17 },
            new { Month = "Jul", Data1 = 16 },
            new { Month = "Aug", Data1 = 16 },
            new { Month = "Sep", Data1 = 16 },
            new { Month = "Oct", Data1 = 16 },
            new { Month = "Nov", Data1 = 15 },
            new { Month = "Dec", Data1 = 15 }
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

        <p>A basic line chart displays information as a series of data points connected through</p>
        <p>straight lines. It is similar to scatter plot, except that the points are connected.</p>
        <p>Line charts are often used to visualize trends in data over a period.</p>

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
                    InsetPadding="40"
                    InnerPadding="0 40 0 40">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Interactions>
                        <ext:PanZoomInteraction ZoomOnPanGesture="true" />
                    </Interactions>

                    <Items>
                        <ext:TextSprite
                            Text="Line Charts - Basic Line"
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
                            Fields="Data1"
                            Grid="true"
                            Minimum="0"
                            Maximum="24">
                            <Renderer Handler="return layoutContext.renderer(label) + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="Month"
                            Grid="true">
                            <Label RotationDegrees="-45" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries XField="Month" YField="Data1">
                            <StyleSpec>
                                <ext:Sprite LineWidth="4" />
                            </StyleSpec>

                            <HighlightConfig>
                                <ext:Sprite FillStyle="#000" Radius="5" LineWidth="2" StrokeStyle="#fff" />
                            </HighlightConfig>

                            <Marker>
                                <ext:Sprite Radius="4" />
                            </Marker>

                            <Label Field="Data1" Display="Over" />

                            <Tooltip TrackMouse="true" ShowDelay="0" DismissDelay="0" HideDelay="0">
                                <Renderer Handler="toolTip.setHtml(record.get('Month') + ': ' + record.get('Data1') + '%');" />
                            </Tooltip>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
