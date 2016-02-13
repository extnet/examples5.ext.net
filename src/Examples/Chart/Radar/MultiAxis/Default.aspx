<%@ Page Language="C#" %>

<script runat="server">
    public class ClimateInfo
    {
        public string Month { get; set; }
        public double High { get; set; }
        public double Low { get; set; }
    }

    public List<ClimateInfo> TestData = new List<ClimateInfo>
    {
        new ClimateInfo { Month = "Jan", High = 14.7, Low = 5.6  },
        new ClimateInfo { Month = "Feb", High = 16.5, Low = 6.6  },
        new ClimateInfo { Month = "Mar", High = 18.6, Low = 7.3  },
        new ClimateInfo { Month = "Apr", High = 20.8, Low = 8.1  },
        new ClimateInfo { Month = "May", High = 23.3, Low = 9.9  },
        new ClimateInfo { Month = "Jun", High = 26.2, Low = 11.9 },
        new ClimateInfo { Month = "Jul", High = 27.7, Low = 13.3 },
        new ClimateInfo { Month = "Aug", High = 27.6, Low = 13.2 },
        new ClimateInfo { Month = "Sep", High = 26.4, Low = 12.1 },
        new ClimateInfo { Month = "Oct", High = 23.6, Low = 9.9  },
        new ClimateInfo { Month = "Nov", High = 17  , Low = 6.8  },
        new ClimateInfo { Month = "Dec", High = 14.7, Low = 5.8  }
    };

    public List<ClimateInfo> GenerateData()
    {
        List<ClimateInfo> data = this.TestData;
        List<ClimateInfo> result = new List<ClimateInfo>();
        Random random = new Random();
        int temp = 15;
        int counter = (int)this.Session["counter"];
        int min = counter % 2 == 1 ? 0 : temp;

        for (int i = 0; i < data.Count; i++)
        {
            result.Add(new ClimateInfo
            {
                Month = data[i].Month,
                High = min + temp + random.NextDouble() * temp,
                Low = min + random.NextDouble() * temp
            });
        }

        this.Session["counter"] = counter + 1;

        return result;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Session["counter"] = 0;
            this.Chart1.GetStore().Data = this.TestData;
        };
    }

    protected void Refresh(object sender, DirectEventArgs e)
    {
        Store store = this.Chart1.GetStore();
        store.Data = this.GenerateData();
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MultiAxis Radial Charts - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>MultiAxis Radial Charts</h1>

        <p>
            This example shows how to use multiple floating axes in a polar chart.
        <br>
            Similar to the Plot Line Chart example, floating axes don\'t have a fixed position, instead they track a specified value on another axis that is running in the opposite direction.
        <br>
            The example makes use of the 'rotate' interaction. To use it, click or tap and then drag anywhere on the chart.
        </p>

        <ext:Panel runat="server" Width="650">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" Pack="Center" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Refresh" OnDirectClick="Refresh" />
                        <ext:Button runat="server" Text="Preview" Handler="this.up('panel').down('polar').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    Height="500"
                    InsetPadding="20"
                    InnerPadding="40">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="High" />
                                        <ext:ModelField Name="Low" />
                                        <ext:ModelField Name="HighF">
                                            <Calculate Handler="return data.High * 1.8 + 32;" />
                                        </ext:ModelField>
                                        <ext:ModelField Name="LowF">
                                            <Calculate Handler="return data.Low * 1.8 + 32;" />
                                        </ext:ModelField>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Interactions>
                        <ext:RotateInteraction />
                    </Interactions>
                    <Axes>
                        <ext:CategoryAxis
                            AxisID="main-angular-axis"
                            Position="Angular"
                            Grid="true">
                            <Style MajorTickSize="20" StrokeStyle="rgb(73,112,142)" />
                        </ext:CategoryAxis>

                        <ext:CategoryAxis
                            Position="Angular"
                            LinkedToID="main-angular-axis">
                            <Renderer Handler="return label === 'Jan' ? '' : label;" />
                            <FloatingConfig ValueInt="20" AlongAxisID="radial-axis" />
                        </ext:CategoryAxis>

                        <ext:NumericAxis
                            AxisID="radial-axis"
                            Position="Radial">
                            <Label FontWeight="bold" />
                            <FloatingConfig ValueString="Jan" AlongAxisID="main-angular-axis" />
                        </ext:NumericAxis>
                    </Axes>
                    <Series>
                        <ext:RadarSeries AngleField="Month" RadiusField="High">
                            <StyleSpec>
                                <ext:SeriesSprite GlobalAlpha="0.7" />
                            </StyleSpec>
                        </ext:RadarSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
