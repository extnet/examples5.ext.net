<%@ Page Language="C#" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Bar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice === 'yes') {
                    btn.up('panel').down('chart').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Bar Chart Sample</h1>

        <p>
            A basic bar chart is a chart with horizontal bars of lengths proportional to the
           magnitudes of the data it represents. Basic bars can be used in the same manner as the
           column charts. Categories are typically organized along the vertical axis and values
           along the horizontal axis. Tapping or hovering a bar will highlight it.
        </p>

        <ext:Panel
            runat="server"
            Width="960"
            Height="600">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Center" Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData" />
                        <ext:Button
                            runat="server"
                            Text="Save Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart" />
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    FlipXY="true"
                    InsetPadding="40"
                    Height="500">
                    <AnimationConfig Duration="500" Easing="EaseOut" />
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>"
                            AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Items>
                        <ext:TextSprite
                            Text="Bar Charts - Basic Bar"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20" />

                        <ext:TextSprite
                            Text="Data: Browser Stats 2012 - Internet Explorer"
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
                            Fields="Data1"
                            Position="Bottom"
                            Grid="true"
                            Maximum="100">
                            <Renderer Handler="return label.toFixed(0) + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis
                            Fields="Name"
                            Position="Left"
                            Grid="true" />
                    </Axes>

                    <Series>
                        <ext:BarSeries
                            XField="Name"
                            YField="Data1">
                            <StyleSpec>
                                <ext:SeriesSprite Opacity="0.8" MinGapWidth="10" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite FillStyle="rgba(249, 204, 157, 1.0)" StrokeStyle="black" LineWidth="2" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="toolTip.setHtml(record.get('Name') + ': ' + record.get('Data1') + '%');" />
                            </Tooltip>
                            <Label
                                Display="InsideEnd"
                                Field="Data1" />
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
