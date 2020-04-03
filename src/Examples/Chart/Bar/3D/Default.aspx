<%@ Page Language="C#" %>

<script runat="server">
    protected void Refresh(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>3D Bar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var refresh = function() {
            var chart = App.Chart1,
                store = chart.getStore();

            chart.setAnimation({
                duration: 500,
                easing: 'easeInOut'
            });

            store.reload();
        };

        var switchTheme = function() {
            var chart = App.Chart1,
                currentThemeClass = Ext.getClassName(chart.getTheme()),
                themes = Ext.chart.theme,
                themeNames = [],
                currentIndex = 0,
                name;

            for (name in themes) {
                if (Ext.getClassName(themes[name]) === currentThemeClass) {
                    currentIndex = themeNames.length;
                }

                if (name !== 'Base' && name.indexOf('Gradients') < 0) {
                    themeNames.push(name);
                }
            }

            chart.setTheme(themes[themeNames[++currentIndex % themeNames.length]]);
            chart.redraw();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>3D Bar Chart Example</h1>

        <p>This example shows how to create a 3D Bar chart much like the regular bar chart.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="500"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Refresh" OnDirectClick="Refresh" />
                        <ext:Button runat="server" Text="Switch Theme" Handler="switchTheme" />
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
                            Text="3D Bar Charts - Basic"
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

                        <ext:Category3DAxis
                            Fields="Name"
                            Position="Left"
                            Grid="true" />
                    </Axes>
                    <Series>
                        <ext:Bar3DSeries
                            XField="Name"
                            YField="Data1">
                            <StyleSpec>
                                <ext:SeriesSprite Opacity="0.8" MinGapWidth="5" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite
                                    FillStyle="rgba(249, 204, 157, 1.0)"
                                    StrokeStyle="black"
                                    LineWidth="2" />
                            </HighlightConfig>

                            <Tooltip
                                runat="server"
                                TrackMouse="true"
                                StyleSpec="background: #fff">
                                <Renderer Handler="toolTip.setHtml(record.get('Name') + ': ' + record.get('Data1') + '%');" />
                            </Tooltip>

                            <Label
                                Display="InsideEnd"
                                Field="Data1" />
                        </ext:Bar3DSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
