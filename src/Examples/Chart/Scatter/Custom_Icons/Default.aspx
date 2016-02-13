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

    public static object GenerateData(int count = 25)
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
    <title>Scatter Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function switchTheme() {
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
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Scatter Chart Sample</h1>
        <p>
            This example shows how to create a scatter chart with custom icons.
        </p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Refresh" OnDirectClick="ReloadData" />
                        <ext:Button runat="server" Text="Switch Theme" Handler="switchTheme" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPadding="40">
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
                    <Interactions>
                        <ext:ItemHighlightInteraction />
                    </Interactions>
                    <Axes>
                        <ext:CategoryAxis Position="Bottom" Fields="ID" />
                        <ext:NumericAxis Position="Left" Fields="G1,G2,G3,G4" Minimum="0">
                            <Label RotationDegrees="-30" />
                        </ext:NumericAxis>
                    </Axes>

                    <Series>
                        <ext:ScatterSeries XField="ID" YField="G1" Highlight="true">
                            <Marker>
                                <ext:PathSprite Scaling="10" LineWidth="2" Path="={[['M' , 0, 1],['L', 1, 0],['L', 0, -1],['L', -1, 0],['Z']]}" />
                            </Marker>
                        </ext:ScatterSeries>

                        <ext:ScatterSeries XField="ID" YField="G2" Highlight="true">
                            <Marker>
                                <ext:PathSprite ScalingX="0.1" ScalingY="-0.1" Path="={[['M',0,-145],['L',48,-50],['L',153,-36],['L',76,39],['L',93,143],['L',0,95],['L',-93,143],['L',-76,39],['L',-153,-36],['L',-48,-50],['Z']]}" />
                            </Marker>
                        </ext:ScatterSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>