<%@ Page Language="C#" %>

<script runat="server">
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

            for (i = 0; i < data.Count; i++) {
                data[i].High = min + temp + rand.NextDouble() * temp;
                data[i].Low = min + rand.NextDouble() * temp;
            }
        }
        this.Chart1.GetStore().DataSource = data;
        this.Chart1.GetStore().DataBind();

        var axis = this.Chart1.Axes[0] as NumericAxis;
        var value = data.Average(t => t.High);
        axis.Limits = new Limits
        {
            new AxisLimit
            {
                Value = value,
                Line = new LimitSprite
                {
                    LineDash = new int[] {2,2},
                    Title = new Sprite
                    {
                        Text = string.Format("Average high: {0:N2}°C", value)
                    }
                }
            }
        };

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
        var saveChart = function (btn) {
            var chart = btn.up('panel').down('chart');
            if (Ext.os.is.Desktop) {
                chart.download({
                    filename: 'Redwood City Climate Data Chart'
                });
            } else {
                chart.preview();
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>The Basic Column Chart displays a set of random data in a column series.</p>
        <p>The "Reload Data" button will randomly generate a new set of data in the store.</p>
        <p>Tapping or hovering a column will highlight it.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="500"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="={Ext.os.is.Desktop ? 'Download' : 'Preview'}"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart ID="Chart1" runat="server" InsetPaddingSpec="40 40 20 40">
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

                    <AnimationConfig Easing="BackOut" Duration="500" />

                    <Interactions>
                        <ext:ItemHighlightInteraction />
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Minimum="10"
                            TitleMargin="20"
                            Title="Temperature in °C">
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" />
                    </Axes>

                    <Series>
                        <ext:BarSeries Highlight="true" XField="Month" YField="High">
                            <StyleSpec>
                                <ext:SeriesSprite MinGapWidth="20" />
                            </StyleSpec>

                            <HighlightConfig>
                                <ext:Sprite StrokeStyle="black" FillStyle="#c1e30d" LineDash="5,3" />
                            </HighlightConfig>

                            <Label Field="High" Display="InsideEnd">
                                <Renderer Handler="return text.toFixed(1);" />
                            </Label>
                        </ext:BarSeries>
                    </Series>

                    <Items>
                        <ext:TextSprite
                            Text="Redwood City Climate Data"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20"
                            />
                    </Items>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
