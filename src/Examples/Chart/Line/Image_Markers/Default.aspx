<%@ Page Language="C#" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }

    private static double seed = 1.42;

    private static int Random()
    {
        // Controllable random.
        seed *= 7.3;
        seed -= Math.Floor(seed);
        return Convert.ToInt32(seed);
    }

    public static object GenerateData(int count = 9)
    {
        var data = new List<Item>();
        int i;
        Item record = new Item
        {
            ID = 0,
            G0 = 200,
            G1 = 500 * Random() + 100,
            G2 = 500 * Random() + 100,
            G3 = 500 * Random() + 100,
            G4 = 500 * Random() + 100,
            G5 = 500 * Random() + 100,
            G6 = 500 * Random() + 100,
            Name = "Item-0"
        };

        data.Add(record);
        for (i = 1; i < count; i++)
        {
            record = new Item
            {
                ID = i,
                G0 = record.G0 + 30 * Random(),
                G1 = Math.Abs(record.G1 + 300 * Random() - 140),
                G2 = Math.Abs(record.G2 + 300 * Random() - 140),
                G3 = Math.Abs(record.G3 + 300 * Random() - 140),
                G4 = Math.Abs(record.G4 + 300 * Random() - 140),
                G5 = Math.Abs(record.G5 + 300 * Random() - 140),
                G6 = Math.Abs(record.G6 + 300 * Random() - 140),
                Name = "Item-" + i
            };
            data.Add(record);
        }

        return data;
    }

    public class Item
    {
        public int ID
        {
            get;
            set;
        }

        public int G0
        {
            get;
            set;
        }

        public int G1
        {
            get;
            set;
        }

        public int G2
        {
            get;
            set;
        }

        public int G3
        {
            get;
            set;
        }

        public int G4
        {
            get;
            set;
        }

        public int G5
        {
            get;
            set;
        }

        public int G6
        {
            get;
            set;
        }

        public string Name
        {
            get;
            set;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function switchTheme() {
            var panel = this.up().up(),
                chart = panel.down('cartesian'),
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
        }

        function resetPan() {
            var panel = this.up('panel'),
                chart = panel.down('cartesian'),
                axes = chart.getAxes();

            axes[0].setVisibleRange([0, 1]);
            axes[1].setVisibleRange([0, 1]);
            chart.redraw();
        }

        function rangeChange(range) {
            if (!range) {
                return;
            }
            // expand the range slightly to make sure markers aren't clipped
            var max = range[1];
            if (max >= 1000) {
                range[1] = max - max % 100 + 100;
            } else {
                range[1] = max - max % 50 + 50;
            }
        }

        // just to avoid a 404 error on load
        Ext.define('Ext.draw.sprite.Image', {
            override: 'Ext.draw.sprite.Image',
            updateSurface: function (surface) {
                if (surface) {
                    if (Ext.isString(this.attr.src) && this.attr.src.length > 1 ) {
                        this.updateSource(this.attr);
                    }
                }
            }
        });
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Sample</h1>

        <p>This example shows how to create a line chart with images as markers. Line charts allow</p>
        <p>to visualize the evolution of a value over time, or the ratio between any two values.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="Fit">
            <Listeners>
                <AfterRender Handler="this.down('toolbar').add(this.down('cartesian').getInteractions()[0].getModeToggleButton());" />
            </Listeners>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Refresh"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button runat="server" Text="Switch Theme" Handler="switchTheme" />

                        <ext:Button runat="server" Text="Reset pan/zoom" Handler="resetPan" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server">
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# GenerateData() %>"
                            AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="ID" />
                                        <ext:ModelField Name="G0" />
                                        <ext:ModelField Name="G1" />
                                        <ext:ModelField Name="G2" />
                                        <ext:ModelField Name="G3" />
                                        <ext:ModelField Name="G4" />
                                        <ext:ModelField Name="G5" />
                                        <ext:ModelField Name="G6" />
                                        <ext:ModelField Name="Name" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Background Fill="white" />

                    <Interactions>
                        <ext:PanZoomInteraction ZoomOnPan="false" />
                        <ext:ItemHighlightInteraction />
                    </Interactions>

                    <LegendConfig runat="server" Dock="Bottom" />

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="G1,G2,G3"
                            Minimum="0">
                            <Listeners>
                                <RangeChange Fn="rangeChange" />
                            </Listeners>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" VisibleRange="0,0.75">
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            XField="Name"
                            YField="G1"
                            Title="Square"
                            Fill="true">
                            <StyleSpec>
                                <ext:SeriesSprite Smooth="true" MiterLimit="3" LineCap="Miter" StrokeOpacity="1" FillOpacity="0.7" LineWidth="8" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite Scaling="0.9" />
                            </HighlightConfig>
                            <Marker>
                                <ext:ImageSprite
                                    Src="square.png"
                                    Width="48"
                                    Height="48"
                                    X="-24"
                                    Y="-24"
                                    Scaling="0.7"
                                    Duration="200"
                                    />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries
                            XField="Name"
                            YField="G2"
                            Title="Circle">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.7" LineWidth="8"  />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite Scaling="0.9" />
                            </HighlightConfig>
                            <Marker>
                                <ext:ImageSprite
                                    Src="circle.png"
                                    Width="48"
                                    Height="48"
                                    X="-24"
                                    Y="-24"
                                    Scaling="0.7"
                                    Duration="200"
                                    />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries
                            XField="Name"
                            YField="G3"
                            Title="Pentagon">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.7" LineWidth="8"  />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite Scaling="0.9" />
                            </HighlightConfig>
                            <Marker>
                                <ext:ImageSprite
                                    Src="pentagon.png"
                                    Width="48"
                                    Height="48"
                                    X="-24"
                                    Y="-24"
                                    Scaling="0.7"
                                    Duration="200"
                                    />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
