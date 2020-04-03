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
    <title>Pie 3D Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var refresh = function() {
            var chart = this.up('panel').down('polar'),
                store = chart.getStore();

            chart.setAnimation({
                duration: 500,
                easing: 'easeInOut'
            });
            store.reload();
        };

        var switchTheme = function () {
            var panel = this.up().up(),
                chart = panel.down('polar'),
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

        <h1>Pie 3D Chart Example</h1>

        <p>This example shows how to create a 3D Pie chart.</p>

        <p>
            The example makes use of the 'rotate' interaction. To use it, click or tap and then
            drag anywhere on the chart.
        </p>

        <ext:Panel runat="server" Width="650" Height="500" Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Refresh" OnDirectClick="Refresh" />
                        <ext:Button runat="server" Text="Switch Theme" Handler="switchTheme" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    StandardTheme="Category1">
                    <Background Fill="white" />
                    <AnimationConfig Duration="500" Easing="EaseIn" />
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(6) %>"
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
                    <Interactions>
                        <ext:RotateInteraction />
                    </Interactions>
                    <Series>
                        <ext:Pie3DSeries
                            AngleField="Data1"
                            Donut="30"
                            Distortion="0.6">
                            <StyleSpec>
                                <ext:SeriesSprite StrokeStyle="white" Opacity="0.9" />
                            </StyleSpec>
                        </ext:Pie3DSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
