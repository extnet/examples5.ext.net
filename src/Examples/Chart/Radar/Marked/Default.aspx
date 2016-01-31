<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = new object[]
            {
                new { month = "Jan", data1 = 20, data2 = 37, data3 = 35, data4 = 4 },
                new { month = "Feb", data1 = 20, data2 = 37, data3 = 36, data4 = 5 },
                new { month = "Mar", data1 = 19, data2 = 36, data3 = 37, data4 = 4 },
                new { month = "Apr", data1 = 18, data2 = 36, data3 = 38, data4 = 5 },
                new { month = "May", data1 = 18, data2 = 35, data3 = 39, data4 = 4 },
                new { month = "Jun", data1 = 17, data2 = 34, data3 = 42, data4 = 4 },
                new { month = "Jul", data1 = 16, data2 = 34, data3 = 43, data4 = 4 },
                new { month = "Aug", data1 = 16, data2 = 33, data3 = 44, data4 = 4 },
                new { month = "Sep", data1 = 16, data2 = 32, data3 = 44, data4 = 4 },
                new { month = "Oct", data1 = 16, data2 = 32, data3 = 45, data4 = 4 },
                new { month = "Nov", data1 = 15, data2 = 31, data3 = 46, data4 = 4 },
                new { month = "Dec", data1 = 15, data2 = 31, data3 = 47, data4 = 4 }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Marked Radial Charts - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel runat="server" BodyStyle="background: transparent !important" Width="700">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Center" Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Preview" Handler="this.up('panel').down('polar').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    Height="500"
                    InsetPaddingSpec="40 40 60 40">
                    <LegendConfig runat="server" Dock="Right" />
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="month" />
                                        <ext:ModelField Name="data1" />
                                        <ext:ModelField Name="data2" />
                                        <ext:ModelField Name="data3" />
                                        <ext:ModelField Name="data4" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Interactions>
                        <ext:RotateInteraction />
                    </Interactions>
                    <Items>
                        <ext:TextSprite
                            Text="Radial Charts - Marked"
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
                            Position="Radial"
                            Grid="true"
                            Minimum="0"
                            Maximum="50"
                            MajorTickSteps="9" />

                        <ext:CategoryAxis Position="Angular" Grid="true" />
                    </Axes>
                    <Series>
                        <ext:RadarSeries Title="IE" AngleField="month" RadiusField="data1">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" FillStyle="none" />
                            </StyleSpec>
                            <Marker>
                                <ext:Sprite Radius="4" />
                            </Marker>
                            <HighlightConfig>
                                <ext:Sprite Radius="8" FillStyle="#000" LineWidth="1" StrokeStyle="#888" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff;">
                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data1') + '%');" />
                            </Tooltip>
                        </ext:RadarSeries>

                        <ext:RadarSeries Title="Firefox" AngleField="month" RadiusField="data2">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" FillStyle="none" />
                            </StyleSpec>
                            <Marker>
                                <ext:Sprite Radius="4" />
                            </Marker>
                            <HighlightConfig>
                                <ext:Sprite Radius="5" FillStyle="#000" LineWidth="1" StrokeStyle="#888" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff;">
                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data2') + '%');" />
                            </Tooltip>
                        </ext:RadarSeries>

                        <ext:RadarSeries Title="Chrome" AngleField="month" RadiusField="data3">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" FillStyle="none" />
                            </StyleSpec>
                            <Marker>
                                <ext:Sprite Radius="4" />
                            </Marker>
                            <HighlightConfig>
                                <ext:Sprite Radius="5" FillStyle="#000" LineWidth="1" StrokeStyle="#888" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff;">
                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data3') + '%');" />
                            </Tooltip>
                        </ext:RadarSeries>

                        <ext:RadarSeries Title="Safari" AngleField="month" RadiusField="data4">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" FillStyle="none" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite Radius="5" FillStyle="#000" LineWidth="1" StrokeStyle="#888" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true" StyleSpec="background: #fff;">
                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data4') + '%');" />
                            </Tooltip>
                        </ext:RadarSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
