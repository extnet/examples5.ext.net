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

    public DataItem LastDataItem
    {
        get
        {
            if ((!this.IsPostBack && !X.IsAjaxRequest))
            {
                this.Session["LiveUpdatesDataItem"] = null;
            }

            return this.Session["LiveUpdatesDataItem"] as DataItem;
        }
        set
        {
            this.Session["LiveUpdatesDataItem"] = value;
        }
    }

    public DataItem Data
    {
        get
        {
            DataItem dataItem = this.LastDataItem;
            Random random = new Random();

            DataItem di = new DataItem
            {
                Date = dataItem != null ? dataItem.Date.AddDays(1) : new DateTime(2011, 1, 1),
                Visits = Convert.ToInt32(Math.Min(100, Math.Max(dataItem != null ? (dataItem.Visits + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0))),
                Views = Convert.ToInt32(Math.Min(100, Math.Max(dataItem != null ? (dataItem.Views + (random.NextDouble() - 0.5) * 10) : random.NextDouble() * 100, 0))),
                Users = Convert.ToInt32(Math.Min(100, Math.Max(dataItem != null ? (dataItem.Users + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0)))
            };

            this.LastDataItem = di;

            return di;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = new List<DataItem> { this.Data };
        }
    }

    protected void GetNewData(object sender, DirectEventArgs e)
    {
        DataItem data = this.Data;
        TimeAxis timeAxis = (TimeAxis)Chart1.Axes[1];

        if (new DateTime(2011, 1, 7) < data.Date)
        {
            timeAxis.SetToDate(data.Date);
            timeAxis.SetFromDate(DateUnit.Day, 1);
        }

        this.Chart1.GetStore().LoadData(new DataItem[] { data }, true);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Live Updated Chart</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Live Updated Chart</h1>

        <p>Display 3 sets of random data in a line series.</p>

        <p>In this example, random data point is added to the store every 2000ms (only new point is appended from the server) and a 500ms animation will occur to animate the change visually.</p>

        <p>The chart will scroll and the bottom axis will update once the line reaches the right side of the chart.</p>

        <ext:Panel
            runat="server"
            Title="Live Animated Chart"
            Width="800"
            Height="600"
            Layout="FitLayout">
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
                            <Listeners>
                                <%-- Remove old (time) data --%>
                                <DataChanged Handler="if(this.getCount() > 10) {this.suspendEvents(); this.removeAt(0);this.resumeEvents();}" />
                            </Listeners>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Views,Visits,Users"
                            Title="Number of Hits"
                            Minimum="0"
                            Maximum="100">
                            <GridConfig>
                                <Odd Opacity="1" FillStyle="#dedede" StrokeStyle="#ddd" LineWidth="0.5" />
                            </GridConfig>
                        </ext:NumericAxis>

                        <ext:TimeAxis
                            Position="Bottom"
                            Fields="Date"
                            Title="Day"
                            DateFormat="MMM dd"
                            FromDate="<%# new DateTime(2011, 1, 1) %>"
                            ToDate="<%# new DateTime(2011, 1, 7) %>"
                            Grid="true"
                            AutoDataBind="true" />
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
