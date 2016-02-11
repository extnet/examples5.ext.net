<%@ Control Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            List<object> data = new List<object>();
            double last_djia = 10000.0;
            double last_sp500 = 1100.0;
            Random random = new Random();

            data.Add(new { name = 0, djia = last_djia, sp500 = last_sp500 });

            for (int i = 0; i < 50; i++)
            {
                last_djia = last_djia + ((Math.Floor(random.NextDouble() * 2) % 2) > 0 ? -1 : 1) * Math.Floor(random.NextDouble() * 7);
                last_sp500 = last_sp500 + ((Math.Floor(random.NextDouble() * 2) % 2) > 0 ? -1 : 1) * Math.Floor(random.NextDouble() * 7);

                data.Add(new
                {
                    name = i,
                    sp500 = last_sp500,
                    djia = last_djia
                });
            }

            Store1.DataSource = data;
            Store1.DataBind();
        }
    }
</script>

<ext:CartesianChart runat="server" Legend="true" Shadow="false">
    <store>
        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="name" />
                        <ext:ModelField Name="sp500" />
                        <ext:ModelField Name="djia" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
    </store>
    <axes>
        <ext:NumericAxis Position="Left" Fields="djia" Title="Dow Jones Average">
            <Label Font="11px Arial" />
        </ext:NumericAxis>

        <ext:NumericAxis Position="Right" Grid="false" Fields="sp500" Title="S&P 500">
            <Label Font="11px Arial" />
        </ext:NumericAxis>
    </axes>

    <series>
        <ext:LineSeries ShowMarkers="false" Fill="true" XField="name" YField="djia">
            <StyleSpec>
                <ext:SeriesSprite LineWidth="1" FillStyle="rgb(148, 174, 10)" />
            </StyleSpec>
        </ext:LineSeries>

        <ext:LineSeries ShowMarkers="false" XField="name" YField="sp500">
            <StyleSpec>
                <ext:SeriesSprite LineWidth="1" FillStyle="rgb(17, 95, 166)" />
            </StyleSpec>
        </ext:LineSeries>
    </series>
</ext:CartesianChart>