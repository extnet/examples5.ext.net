<%@ Page Language="C#" %>

<script runat="server">
    public class DataItem
    {
        public DateTime Date
        {
            get;
            set;
        }

        public int Visits
        {
            get;
            set;
        }

        public int Views
        {
            get;
            set;
        }

        public int Users
        {
            get;
            set;
        }
    }

    public List<DataItem> List
    {
        get
        {
            if ((!this.IsPostBack && !X.IsAjaxRequest) || (this.Session["LiveAnimatedList"] == null))
            {
                this.Session["LiveAnimatedList"] = new List<DataItem>();
            }

            return (List<DataItem>)this.Session["LiveAnimatedList"];
        }
        set
        {
            this.Session["LiveAnimatedList"] = value;
        }
    }

    public List<DataItem> Data
    {
        get
        {
            List<DataItem> data = this.List;
            Random random = new Random();

            data.Add(new DataItem
            {
                Date = data.Count > 0 ? data.Last().Date.AddDays(1) : new DateTime(2014, 1, 1),
                Visits = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Visits + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0))),
                Views = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Views + (random.NextDouble() - 0.5) * 10) : random.NextDouble() * 100, 0))),
                Users = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Users + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0)))
            });

            if (data.Count > 10)
            {
                data = data.Skip(Math.Max(0, data.Count() - 10)).Take(10).ToList<DataItem>();
                this.List = data;
            }

            return data;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = this.Data;
        }
    }

    protected void GetNewData(object sender, DirectEventArgs e)
    {
        List<DataItem> data = this.Data;
        TimeAxis timeAxis = (TimeAxis)this.Chart1.Axes[1];

        if (new DateTime(2014, 1, 7) < data.Last().Date)
        {
            timeAxis.SetToDate(data.Last().Date);
            timeAxis.SetFromDate(DateUnit.Day, 1);
        }

        Store store = this.Chart1.GetStore();

        store.DataSource = data;
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Live Updated Chart - Animated - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Live Updated Chart - Animated</h1>

        <p>Display 3 sets of random data in a line series.</p>

        <p>In this example, random data is added to the store every 2000ms and a 500ms animation will occur to animate the change visually.</p>

        <p>The chart will scroll and the bottom axis will update once the line reaches the right side of the chart.</p>

        <ext:Panel
            runat="server"
            Title="Live Animated Chart"
            Width="960"
            Height="600"
            Layout="Fit">
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    StyleSpec="background:#fff;">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="Visits" />
                                        <ext:ModelField Name="Views" />
                                        <ext:ModelField Name="Users" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Views,Visits,Users"
                            Title="Number of Hits"
                            Minimum="0"
                            Maximum="100"
                            Grid="true">
                            <GridConfig>
                                <Odd Opacity="1" FillStyle="#dedede" StrokeStyle="#ddd" LineWidth="0.5" />
                            </GridConfig>
                        </ext:NumericAxis>

                        <ext:TimeAxis
                            Position="Bottom"
                            Fields="Date"
                            Title="Day"
                            DateFormat="MMM dd"
                            FromDate="<%# new DateTime(2014, 1, 1) %>"
                            ToDate="<%# new DateTime(2014, 1, 7) %>"
                            Grid="true"
                            AutoDataBind="true"
                            />
                    </Axes>
                    <Series>
                        <ext:LineSeries XField="Date" YField="Visits">
                            <Label Display="None" Field="Visits" TextAlign="Center" />
                            <Marker>
                                <ext:Sprite SpriteType="Cross" />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries XField="Date" YField="Views">
                            <Label Display="None" Field="Visits" TextAlign="Center" />
                            <Marker>
                                <ext:CircleSprite />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries XField="Date" YField="Users">
                            <Label Display="None" Field="Visits" TextAlign="Center" />
                            <Marker>
                                <ext:Sprite SpriteType="Diamond" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>

        <ext:TaskManager runat="server">
            <Tasks>
                <ext:Task TaskID="DataTask" AutoRun="true" Interval="2000">
                    <DirectEvents>
                        <Update OnEvent="GetNewData" />
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
