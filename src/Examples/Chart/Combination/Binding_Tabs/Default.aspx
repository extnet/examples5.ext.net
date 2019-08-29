<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.TabPanel1.ViewModel = new
        {
            stores = new
            {
                priceData = new
                {
                    fields = new string[]{"month", "price"},
                    data = new object[]
                    {
                        new { month = "Jan", price = 28 },
                        new { month = "Feb", price = 25 },
                        new { month = "Mar", price = 21 },
                        new { month = "Apr", price = 18 },
                        new { month = "May", price = 18 },
                        new { month = "Jun", price = 17 },
                        new { month = "Jul", price = 16 },
                        new { month = "Aug", price = 16 },
                        new { month = "Sep", price = 16 },
                        new { month = "Oct", price = 16 },
                        new { month = "Nov", price = 15 },
                        new { month = "Dec", price = 15 }
                    }
                }
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Binding & Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Binding & Tabs</h1>
        <p>This example shows how to use data binding to attach stores to charts. Each tab uses the same dataset from the ViewModel.</p>

        <ext:TabPanel ID="TabPanel1" runat="server" Width="650" Height="500">
            <Items>
                <ext:Panel runat="server" Title="Line Chart" Layout="FitLayout">
                    <Items>
                        <ext:CartesianChart runat="server"
                            Animation="false"
                            BindString="{priceData}"
                            InsetPadding="40"
                            InnerPadding="0 40">
                            <Interactions>
                                <ext:ItemHighlightInteraction />
                                <ext:PanZoomInteraction ZoomOnPan="true" />
                            </Interactions>
                            <Axes>
                                <ext:NumericAxis
                                    Fields="price"
                                    Position="Left"
                                    Grid="true"
                                    Minimum="0"
                                    Maximum="30"
                                    Title="Price">
                                    <Renderer Fn="Ext.util.Format.usMoney" />
                                </ext:NumericAxis>

                                <ext:CategoryAxis
                                    Fields="month"
                                    Position="Bottom"
                                    Grid="true">
                                    <Label RotationDegrees="-45" />
                                </ext:CategoryAxis>
                            </Axes>

                            <Series>
                                <ext:LineSeries
                                    XField="month"
                                    YField="price">
                                    <Marker>
                                        <ext:Sprite Radius="4" />
                                    </Marker>
                                    <Label Field="price" Display="Over" />
                                    <Tooltip
                                        TrackMouse="true"
                                        StyleSpec="background: #fff;"
                                        ShowDelay="0"
                                        DismissDelay="0"
                                        HideDelay="0">
                                        <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + Ext.util.Format.usMoney(record.get('price')));" />
                                    </Tooltip>
                                </ext:LineSeries>
                            </Series>
                        </ext:CartesianChart>
                    </Items>
                </ext:Panel>

                <ext:Panel runat="server" Title="Bar Chart" Layout="FitLayout">
                    <Items>
                        <ext:CartesianChart runat="server"
                            Animation="false"
                            BindString="{priceData}"
                            InsetPadding="40">
                            <Interactions>
                                <ext:PanZoomInteraction ZoomOnPan="true" />
                            </Interactions>
                            <Axes>
                                <ext:NumericAxis
                                    Position="Left"
                                    Minimum="0"
                                    Maximum="30"
                                    Title="Price">
                                    <Renderer Fn="Ext.util.Format.usMoney" />
                                </ext:NumericAxis>

                                <ext:CategoryAxis
                                    Position="Bottom">
                                    <Label RotationDegrees="-45" />
                                </ext:CategoryAxis>
                            </Axes>

                            <Series>
                                <ext:BarSeries
                                    XField="month"
                                    YField="price">
                                    <StyleSpec>
                                        <ext:SeriesSprite MinGapWidth="20" />
                                    </StyleSpec>

                                    <HighlightConfig>
                                        <ext:Sprite StrokeStyle="black" FillStyle="#c1e30d" LineDash="5,3" />
                                    </HighlightConfig>

                                    <Label Field="price" Display="InsideEnd">
                                        <Renderer Fn="Ext.util.Format.usMoney" />
                                    </Label>
                                </ext:BarSeries>
                            </Series>
                        </ext:CartesianChart>
                    </Items>
                </ext:Panel>

                <ext:Panel runat="server" Title="Radial" Layout="FitLayout">
                    <Items>
                        <ext:PolarChart runat="server"
                            Animation="false"
                            BindString="{priceData}"
                            InsetPadding="40">
                            <Interactions>
                                <ext:RotateInteraction />
                                <ext:ItemHighlightInteraction />
                            </Interactions>
                            <Axes>
                                <ext:NumericAxis
                                    Position="Radial"
                                    Fields="price"
                                    Grid="true"
                                    Minimum="0"
                                    Maximum="30"
                                    MajorTickSteps="4">
                                    <Renderer Fn="Ext.util.Format.usMoney" />
                                </ext:NumericAxis>

                                <ext:CategoryAxis
                                    Position="Angular"
                                    Grid="true" />
                            </Axes>

                            <Series>
                                <ext:RadarSeries
                                    AngleField="month"
                                    RadiusField="price">
                                    <StyleSpec>
                                        <ext:Sprite Opacity="0.8" />
                                    </StyleSpec>

                                    <Marker>
                                        <ext:CircleSprite Radius="4" />
                                    </Marker>
                                </ext:RadarSeries>
                            </Series>
                        </ext:PolarChart>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:TabPanel>
     </form>
</body>
</html>
