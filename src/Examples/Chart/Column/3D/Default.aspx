<%@ Page Language="C#" %>

<script runat="server">
    public partial class ColumnSeries3D : BarSeries
    {
        /// <summary>
        /// The JavaScript class name
        /// </summary>
        [System.ComponentModel.DefaultValue(null)]
        public override string InstanceOf
        {
            get
            {
                return "Ext.net.ColumnSeries3D";
            }
        }

        /// <summary>
        /// The constructor
        /// </summary>
        public ColumnSeries3D()
        {
        }

        /// <summary>
        /// The alias
        /// </summary>
        [ConfigOption]
        protected override string Type
        {
            get
            {
                return "column3d";
            }
        }

        /// <summary>
        ///
        /// </summary>
        [System.Xml.Serialization.XmlIgnore]
        [Newtonsoft.Json.JsonIgnore]
        public override ConfigOptionsCollection ConfigOptions
        {
            get
            {
                ConfigOptionsCollection list = base.ConfigOptions;

                list.Add("type", new ConfigOption("type", null, null, this.Type));

                return list;
            }
        }
    }

    public class Temperature
    {
        public string Month
        {
            get;
            set;
        }

        public double High
        {
            get;
            set;
        }

        public double Low
        {
            get;
            set;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Chart1.Series.Add(new ColumnSeries3D
            {
                XField = "Month",
                YField = new string[] { "High" },

                StyleSpec =
                {
                    new SeriesSprite { MaxBarWidth = 50 }
                }
            });

            this.BindData();
        }
    }

    private void BindData(int counter = -1)
    {
        var data = new List<Temperature>
        {
            new Temperature { Month = "Jan", High = 14.7, Low = 5.6  },
            new Temperature { Month = "Feb", High = 16.5, Low = 6.6  },
            new Temperature { Month = "Mar", High = 18.6, Low = 7.3  },
            new Temperature { Month = "Apr", High = 20.8, Low = 8.1  },
            new Temperature { Month = "May", High = 23.3, Low = 9.9  },
            new Temperature { Month = "Jun", High = 26.2, Low = 11.9 },
            new Temperature { Month = "Jul", High = 27.7, Low = 13.3 },
            new Temperature { Month = "Aug", High = 27.6, Low = 13.2 },
            new Temperature { Month = "Sep", High = 26.4, Low = 12.1 },
            new Temperature { Month = "Oct", High = 23.6, Low = 9.9  },
            new Temperature { Month = "Nov", High = 17  , Low = 6.8  },
            new Temperature { Month = "Dec", High = 14.7, Low = 5.8  }
        };

        if (counter >= 0)
        {
            int i;
            int temp = 15;
            int min = counter % 2 == 1 ? 0 : temp;
            var rand = new Random();

            for (i = 0; i < data.Count; i++)
            {
                data[i].High = min + temp + rand.NextDouble() * temp;
                data[i].Low = min + rand.NextDouble() * temp;
            }
        }

        this.Chart1.GetStore().DataSource = data;
        this.Chart1.GetStore().DataBind();
    }

    static int counter;
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.BindData(counter++);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function switchTheme () {
            var panel = this.up('panel'),
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

        function rangeChange(range) {
            if (!range) {
                return;
            }
            // expand the range slightly to make sure markers aren't clipped
            var max = range[1];
            if (max >= 35) {
                range[1] = max - max % 5 + 5;
            } else {
                range[1] = max - max % 2 + 2;
            }
        }
    </script>

    <script>
        /*
         *  3D Column Sprite
         */

        Ext.define('Ext.net.ColumnSprite3D', {
            alias: 'sprite.columnSeries3d',
            extend: 'Ext.chart.series.sprite.Bar',
            inheritableStatics: {
                def: {
                    defaults: {
                        transformFillStroke: true,
                        lineJoin: 'bevel'
                    }
                }
            },
            lastClip: null,

            drawBar: function (ctx, surface, clip, left, top, right, bottom, itemId) {
                var me = this,
                    attr = me.attr,
                    center = (left + right) / 2,
                    barWidth = (right - left) * 0.33333,
                    depthWidth = barWidth * 0.5,
                    fill = attr.fillStyle,
                    color, darkerColor, lighterColor;

                color = Ext.draw.Color.create(fill.isGradient ? fill.getStops()[0].color : fill),
                darkerColor = color.createDarker(0.05),
                lighterColor = color.createLighter(0.25);

                // top
                ctx.beginPath();
                ctx.moveTo(center - barWidth, top);
                ctx.lineTo(center - barWidth + depthWidth, top + depthWidth);
                ctx.lineTo(center + barWidth + depthWidth, top + depthWidth);
                ctx.lineTo(center + barWidth, top);
                ctx.lineTo(center - barWidth, top);
                ctx.fillStyle = lighterColor.toString();
                ctx.fillStroke(attr);

                // right side
                ctx.beginPath();
                ctx.moveTo(center + barWidth, top);
                ctx.lineTo(center + barWidth + depthWidth, top + depthWidth);
                ctx.lineTo(center + barWidth + depthWidth, bottom + depthWidth);
                ctx.lineTo(center + barWidth, bottom);
                ctx.lineTo(center + barWidth, top);
                ctx.fillStyle = darkerColor.toString();
                ctx.fillStroke(attr);

                // front
                ctx.beginPath();
                ctx.moveTo(center - barWidth, bottom);
                ctx.lineTo(center - barWidth, top);
                ctx.lineTo(center + barWidth, top);
                ctx.lineTo(center + barWidth, bottom);
                ctx.lineTo(center - barWidth, bottom);
                ctx.fillStyle = fill.isGradient ? fill : color.toString();
                ctx.fillStroke(attr);
            }
        });

        /*
         *  3D Column Series
         */

        Ext.define('Ext.net.ColumnSeries3D', {
            extend: 'Ext.chart.series.Bar',
            requires: ['Ext.net.ColumnSprite3D'],
            seriesType: 'columnSeries3d',
            alias: 'series.column3d',
            type: 'column3d',
            config: {
                itemInstancing: null
            }
        });
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>This example shows how to use custom sprites to create a 3D Column Chart. Click and drag to zoom the chart.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="500"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            Icon="ArrowRefresh"
                            OnDirectClick="ReloadData" />

                        <ext:Button
                            runat="server"
                            Text="Switch Theme"
                            Handler="switchTheme" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    StandardTheme="Category5"
                    InsetPadding="20">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="High" />
                                        <ext:ModelField Name="Low" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Interactions>
                        <ext:PanZoomInteraction ZoomOnPanGesture="true" />
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Grid="true">
                            <Label RotationDegrees="-30" />
                            <Listeners>
                                <RangeChange Fn="rangeChange" />
                            </Listeners>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" />
                    </Axes>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
