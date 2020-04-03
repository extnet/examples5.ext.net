<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { theta = 0, sin = 0.00 },
            new { theta = 10, sin = 0.17 },
            new { theta = 20, sin = 0.34 },
            new { theta = 30, sin = 0.50 },
            new { theta = 40, sin = 0.64 },
            new { theta = 50, sin = 0.77 },
            new { theta = 60, sin = 0.87 },
            new { theta = 70, sin = 0.94 },
            new { theta = 80, sin = 0.98 },
            new { theta = 90, sin = 1.00 },
            new { theta = 100, sin = 0.98 },
            new { theta = 110, sin = 0.94 },
            new { theta = 120, sin = 0.87 },
            new { theta = 130, sin = 0.77 },
            new { theta = 140, sin = 0.64 },
            new { theta = 150, sin = 0.50 },
            new { theta = 160, sin = 0.34 },
            new { theta = 170, sin = 0.17 },
            new { theta = 180, sin = 0.00 },
            new { theta = 190, sin = -0.17 },
            new { theta = 200, sin = -0.34 },
            new { theta = 210, sin = -0.50 },
            new { theta = 220, sin = -0.64 },
            new { theta = 230, sin = -0.77 },
            new { theta = 240, sin = -0.87 },
            new { theta = 250, sin = -0.94 },
            new { theta = 260, sin = -0.98 },
            new { theta = 270, sin = -1.00 },
            new { theta = 280, sin = -0.98 },
            new { theta = 290, sin = -0.94 },
            new { theta = 300, sin = -0.87 },
            new { theta = 310, sin = -0.77 },
            new { theta = 320, sin = -0.64 },
            new { theta = 330, sin = -0.50 },
            new { theta = 340, sin = -0.34 },
            new { theta = 350, sin = -0.17 },
            new { theta = 360, sin = 0.00 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Example</h1>

        <p>A spline chart is a specialized form of conventional line and area charts. Unlike</p>
        <p>conventional charts which connect data points with straight lines, a spline draws a</p>
        <p>fitted curve through the data points. They are used specifically for plotting data that</p>
        <p>requires the use of curve fittings e.g. impulse-response, product life cycle etc.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Preview"
                            Handler="this.up('panel').down('chart').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPaddingSpec="40 40 20 20">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="theta" />
                                        <ext:ModelField Name="sin" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Items>
                        <ext:TextSprite
                            Text="Line Charts - Spline"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20" />
                    </Items>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="sin"
                            Grid="true"
                            Title="Sin (Theta)">
                            <Renderer Handler="return Ext.util.Format.number(label, '0.00');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis
                            Position="Bottom"
                            Title="Theta"
                            Fields="theta"
                            Grid="true">
                            <Label RotationDegrees="-45" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            XField="theta"
                            YField="sin"
                            UseSmooth="true"
                            Highlight="true"
                            ShowMarkers="false">
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
