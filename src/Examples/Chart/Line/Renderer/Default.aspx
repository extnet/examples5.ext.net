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
        function renderer(sprite, config, rendererData, index) {
            var store = rendererData.store,
                storeItems = store.getData().items,
                currentRecord = storeItems[index],
                previousRecord = (index > 0 ? storeItems[index-1] : currentRecord),
                current = currentRecord && currentRecord.data['G1'],
                previous = previousRecord && previousRecord.data['G1'],
                isUp = current >= previous,
                changes = {};
            switch (config.type) {
                case 'marker':
                    changes.strokeStyle = (isUp ? 'cornflowerblue' : 'tomato');
                    changes.fillStyle = (isUp ? 'aliceblue' : 'lightpink');
                    break;
                case 'line':
                    changes.strokeStyle = (isUp ? 'cornflowerblue' : 'tomato');
                    changes.fillStyle = (isUp ? 'aliceblue' : 'rgba(211, 211, 211, 1.0)');
                    break;
            }
            return changes;
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Sample</h1>

        <p>This example shows how to create a line chart with a renderer function that changes the stroke and fill colors when the line goes down.</p>
        <p>Line charts allow to visualize the evolution of a value over time, or the ratio between any two values.</p>

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
                            Text="Refresh"
                            Icon="ArrowRefresh"
                            OnDirectClick="ReloadData" />
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
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="G1,G2"
                            Minimum="0">
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name">
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            XField="Name"
                            YField="G1"
                            Fill="true"
                            UseSmooth="true">
                            <StyleSpec>
                                <ext:Sprite LineWidth="4" />
                            </StyleSpec>
                            <Marker>
                                <ext:Sprite SpriteType="Circle" Radius="10" LineWidth="2" />
                            </Marker>
                            <Renderer Fn="renderer" />
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
