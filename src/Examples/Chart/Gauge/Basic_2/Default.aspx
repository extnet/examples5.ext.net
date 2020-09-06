<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.Data = new object[]
            {
                new
                {
                    mph = 65,
                    fuel = 50,
                    temp = 150,
                    rpm = 6000
                }
            };
        }
    }

    protected void Refresh(object sender, DirectEventArgs e)
    {
        Random r = new Random();

        this.Store1.Data = new object[]
        {
            new
            {
                mph  = r.NextDouble() * 100,
                fuel = r.NextDouble() * 100,
                temp = r.NextDouble() * 250,
                rpm  = r.NextDouble() * 8000
            }
        };

        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Gauge Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var fuelRenderer = function (v) {
            if (v === 0) return 'E';
            if (v === 25) return '1/4';
            if (v === 50) return '1/2';
            if (v === 75) return '3/4';
            if (v === 100) return 'F';
            return ' ';
        };

        var tempRenderer = function (v) {
            if (v === 0) return 'Cold';
            if (v === 125) return 'Comfortable';
            if (v === 250) return 'Hot';
            return ' ';
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Gauge</h1>

        <p>A sample set of gauges displaying different configurations bound to data in a store.</p>

        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="mph" />
                        <ext:ModelField Name="fuel" />
                        <ext:ModelField Name="temp" />
                        <ext:ModelField Name="rpm" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Panel
            runat="server"
            BodyStyle="background: transparent !important"
            Width="650">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Center" Align="Stretch" />
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
                <ext:Container runat="server" Flex="1">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Pack="Center" />
                    </LayoutConfig>
                    <Items>
                        <ext:PolarChart
                            runat="server"
                            Height="240"
                            Width="480"
                            StoreID="Store1"
                            InsetPadding="30">
                            <Items>
                                <ext:TextSprite
                                    Text="Basic"
                                    X="30"
                                    Y="30"
                                    FontSize="17" />
                            </Items>
                            <Series>
                                <ext:GaugeSeries AngleField="mph" Needle="true" Donut="30" />
                            </Series>
                        </ext:PolarChart>

                        <ext:PolarChart
                            runat="server"
                            Height="240"
                            Width="480"
                            InsetPadding="30"
                            StoreID="Store1">
                            <Items>
                                <ext:PathSprite
                                    Scaling="0.25"
                                    TranslationX="112"
                                    TranslationY="130"
                                    FillStyle="black"
                                    StrokeStyle="black"
                                    Path="m9.21399,0c-5.07404,0 -9.21399,3.43396 -9.21399,7.62198l0,80.2005l44.935,0.6257l0.05701,-46.8692l8.47498,0c1.94702,0 3.526,1.29001 3.526,2.901l0,35.32199c0,4.7373 5.383,8.87372 11.48999,8.87372c5.76801,0 12.172,-3.78342 12.172,-8.87372c-0.08801,-1.18399 -4.664,-22.23999 -4.664,-22.23999c0,-0.048 -0.96698,-5.91501 -0.96698,-5.91501l0,-26.90399c0,-2.88098 -1.16602,-5.258 -3.526,-7.224l-15.01703,-12.40002c-1.03198,0 -3.92395,2.38904 -3.92395,2.38904c0,0.867 7.45099,6.996 7.45099,6.996l-0.22803,10.46597c0,3.70001 3.63501,6.71201 8.13403,6.71201l2.04797,0l-0.73999,19.965l1.02399,6.88202l4.55103,20.19299c0.17596,3.28369 -3.45203,5.2327 -6.31403,5.2327c-2.64099,0 -5.745,-1.82098 -5.745,-4.15271l0.05701,-35.379c0,-4.30899 -4.25,-7.79199 -9.44202,-7.79199l-9.04401,0c0.63403,-0.03699 0.62604,-23.23599 0.62604,-28.15601l0,-0.853c0,-4.18802 -4.09802,-7.62198 -9.15802,-7.62198l-26.56299,0l0,0zm0,5.517l26.56299,0c1.41602,0 2.50299,0.94498 2.50299,2.10498l0,18.48599c0,1.172 -1.08698,2.048 -2.50299,2.048l-26.56299,0c-1.43103,0 -2.50201,-0.87601 -2.50201,-2.048l0,-18.48599c0,-1.16 1.07098,-2.10498 2.50201,-2.10498zm55.401,14.84598c0,0 2.25598,0.39001 2.78699,0.51202c1.09198,0.23196 1.79102,1.59097 1.82001,2.78699c0.02997,1.20901 0,4.83499 0,4.83499c-3.34802,-0.61099 -4.60699,-2.03799 -4.60699,-3.35602l0,-4.77798z" />
                            </Items>
                            <Axes>
                                <ext:NumericAxis
                                    Position="Gauge"
                                    Title="Fuel"
                                    MajorTickSteps="4">
                                    <Renderer Fn="fuelRenderer" />
                                </ext:NumericAxis>
                            </Axes>
                            <Series>
                                <ext:GaugeSeries AngleField="fuel" Donut="50" />
                            </Series>
                        </ext:PolarChart>
                    </Items>
                </ext:Container>

                <ext:Container runat="server" Flex="1">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Pack="Center" />
                    </LayoutConfig>
                    <Items>
                        <ext:PolarChart
                            runat="server"
                            Height="240"
                            Width="480"
                            PaddingSpec="10 0 0 0"
                            StoreID="Store1"
                            InsetPadding="30">
                            <Axes>
                                <ext:NumericAxis
                                    Position="Gauge"
                                    Title="Temp"
                                    Maximum="250"
                                    MajorTickSteps="2">
                                    <Renderer Fn="tempRenderer" />
                                </ext:NumericAxis>
                            </Axes>
                            <Series>
                                <ext:GaugeSeries AngleField="temp" Donut="50" />
                            </Series>
                        </ext:PolarChart>

                        <ext:PolarChart
                            runat="server"
                            Height="240"
                            Width="480"
                            PaddingSpec="10 0 0 0"
                            StoreID="Store1"
                            InsetPadding="30">
                            <Axes>
                                <ext:NumericAxis
                                    Position="Gauge"
                                    Title="RPM"
                                    Maximum="8000"
                                    MajorTickSteps="8">
                                    <Renderer Handler="return (label / 1000) + 'k';" />
                                </ext:NumericAxis>
                            </Axes>
                            <Series>
                                <ext:GaugeSeries AngleField="rpm" Donut="30" Needle="true" />
                            </Series>
                        </ext:PolarChart>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>