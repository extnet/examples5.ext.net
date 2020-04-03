<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = CreateData(50);
        }
    }

    private static double seed = 1.3;
    private static double Random() {
        seed *= 7.3;
        seed -= Math.Floor(seed);
        return seed;
    }

    private static object CreateData(int count, bool allNull = false)
    {
        var data = new List<object>();
        double g0 = allNull ? 0 : 300;
        double g1 = allNull ? 0 : (700 * Random() + 100);
        double g2 = allNull ? 0 : (700 * Random() + 100);
        double g3 = allNull ? 0 : (700 * Random() + 100);

        data.Add(new
        {
            id = 0,
            g0,
            g1,
            g2,
            g3
        });

        for (int i = 1; i < count; i++) {
            g0 = allNull ? 0 : (g0 + 30 * Random());
            g1 = allNull ? 0 : (Math.Abs(g1 + 300 * Random() - 140));
            g2 = allNull ? 0 : (Math.Abs(g1 + 300 * Random() - 140));
            g3 = allNull ? 0 : (Math.Abs(g1 + 300 * Random() - 140));

            data.Add(new
            {
                id = i,
                g0,
                g1,
                g2,
                g3
            });
        }

        return data;
    }

    protected void OnRefresh(object sender, DirectEventArgs e)
    {
        this.Chart1.SetAnimation(true);
        // we want the maximum to be derived from the store (series data)
        this.Chart1.Axes[0].SetMaximum(double.NaN);
        this.Chart1.GetStore().DataSource = CreateData(50);
        this.Chart1.GetStore().DataBind();

    }

    protected void OnDrop(object sender, DirectEventArgs e)
    {
        this.Chart1.SetAnimation(new AnimConfig { Easing = Easing.BounceOut, Duration = 1000 });
        // fix the maximum for a nice bubble drop animation
        this.Chart1.Axes[0].SetMaximum(JSON.Deserialize<double>(e.ExtraParams["max"]));
        this.Chart1.GetStore().DataSource = CreateData(50, true);
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Scatter Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var fromHSL = Ext.draw.Color.fly('blue').getHSL(),
            toHSL = Ext.draw.Color.fly('red').getHSL();

        fromHSL[2] = 0.3;

        function interpolate(lambda, minSrc, maxSrc, minDst, maxDst) {
            return minDst + (maxDst - minDst) * Math.max(0, Math.min(1, (lambda - minSrc) / (maxSrc - minSrc)));
        }

        function interpolateColor(lambda, minSrc, maxSrc) {
            return Ext.draw.Color.fly(0, 0, 0, 0).setHSL(
                interpolate(lambda, minSrc, maxSrc, fromHSL[0], toHSL[0]),
                interpolate(lambda, minSrc, maxSrc, fromHSL[1], toHSL[1]),
                interpolate(lambda, minSrc, maxSrc, fromHSL[2], toHSL[2])
            ).toString();
        }

        function renderer(sprite, config, rendererData, index) {
            var store = rendererData.store,
                storeItem = store.getData().items[index];
            config.radius = interpolate(storeItem.data.g3, 0, 1000, 5, 30);
            config.fillOpacity = interpolate(storeItem.data.g3, 0, 1000, 1, 0.7);
            config.fill = interpolateColor(storeItem.data.g3, 0, 1000);
            config.stroke = config.fill;
            config.lineWidth = 3;
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Scatter Chart Example</h1>
        <p>
            Demonstrates how to make a bubble chart using Ext.chart.series.Scatter
         <br />
         <br /> Bubble charts, similarly to Line charts, allow to visualize the evolution of a
         <br /> parameter over time or the ratio between any two parameters, but in addition they
         <br /> can also display intrinsic values of these parameters by assigning them to the
         <br /> diameter or the color of the bubbles.
        </p>

        <ext:Panel
            runat="server"
            Layout="Fit"
            Width="650">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Refresh" Handler="fromHSL = Ext.draw.Color.fly('blue').getHSL();" OnDirectClick="OnRefresh" />
                        <ext:Button runat="server" Text="Drop all bubbles" Handler="fromHSL = Ext.draw.Color.fly('cyan').getHSL();">
                            <DirectEvents>
                                <Click OnEvent="OnDrop">
                                    <ExtraParams>
                                        <ext:Parameter Name="max" Value="this.up('panel').down('cartesian').getAxes()[0].getRange()[1]" Mode="Raw" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    Height="500"
                    InsetPadding="20">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="id" />
                                        <ext:ModelField Name="g0" />
                                        <ext:ModelField Name="g1" />
                                        <ext:ModelField Name="g2" />
                                        <ext:ModelField Name="g3" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Background Fill="#242021" />

                    <Interactions>
                        <ext:PanZoomInteraction />
                        <ext:ItemHighlightInteraction />
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis Position="Left" Fields="g2" Minimum="0">
                            <Style MajorTickSize="10" LineWidth="3" StrokeStyle="#888" EstStepSize="50" />
                            <Label Color="#888" FontFamily="Chalkboard, sans-serif" FontSize="20" />
                            <GridConfig Stroke="#444">
                                <Odd FillStyle="#333" />
                            </GridConfig>
                        </ext:NumericAxis>

                        <ext:NumericAxis Position="Bottom" Fields="id" Minimum="0" Maximum="50">
                            <Style MajorTickSize="10" LineWidth="3" StrokeStyle="#888" EstStepSize="100" />
                            <Label Color="#888" FontFamily="Chalkboard, sans-serif" FontSize="20" />
                            <GridConfig Stroke="#444" />
                        </ext:NumericAxis>
                    </Axes>

                    <Series>
                        <ext:ScatterSeries XField="id" YField="g2">
                            <Marker>
                                <ext:CircleSprite Radius="5" FillStyle="rgb(203,143,203)" MiterLimit="1" LineCap="Butt" LineWidth="1" Duration="200" />
                            </Marker>
                            <HighlightDefaults>
                                <ext:Sprite Scaling="1.3" />
                            </HighlightDefaults>
                            <Renderer Fn="renderer" />
                        </ext:ScatterSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>