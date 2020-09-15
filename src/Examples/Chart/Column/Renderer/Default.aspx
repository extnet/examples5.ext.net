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

    public static object GenerateData(int count = 7)
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
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function renderer1(sprite, config, rendererData, index) {
            var store = rendererData.store,
                storeItems = store.getData().items,
                record = storeItems[index],
                // diff = record && (record.data['G2'] - record.data['G1']),
                last = storeItems.length - 1,
                surface = sprite.getSurface(),
                isRtl = surface.getInherited().rtl,
                changes = {},
                lineSprites, firstColumnConfig, firstData, lastData, growth, string;
            if (!record) {
                return;
            }
            // Make the first and last columns larger and painted blue.
            if (index == 0 || index == last) {
                changes.fillStyle = 'powderblue';
                changes.x = config.x - config.width * 0.4;
                changes.y = config.y;
                changes.width = config.width * 1.8;
                changes.lineWidth = 4;
                // Draw a line between the first and last columns
                lineSprites = surface.myLineSprites;
                if (!lineSprites) {
                    lineSprites = surface.myLineSprites = [];
                    lineSprites[0] = surface.add({type:'path'});
                    lineSprites[1] = surface.add({type:'text'});
                }
                if (index == 0) {
                    surface.myFirstColumnConfig = Ext.clone(changes);
                } else if (index == last) {
                    firstData = storeItems[0].data['G1'];
                    lastData = storeItems[last].data['G1'];

                    firstColumnConfig = surface.myFirstColumnConfig;
                    var x1 = firstColumnConfig.x + firstColumnConfig.width,
                        y1 = firstColumnConfig.y,
                        x2 = changes.x,
                        y2 = changes.y;
                    lineSprites[0].setAttributes({
                        lineWidth: 1,
                        stroke: 'blue',
                        zIndex: 10000,
                        opacity: 0.4,
                        path: "M" + x2 + " " + y2 + " L" + x1 + " " + y1 + " L" + x2 + " " + y1 + (lastData < firstData ? " L" : " M") + x2 + " " + y2 + " Z"
                    });

                    growth = Math.round(100 * (lastData - firstData) / (firstData || 1));
                    string = (growth > 0 ? "+ " : "- ") + Math.abs(growth) + " %";
                    lineSprites[1].setAttributes({
                        text: string,
                        x: changes.x + (isRtl ? 12 : -12),
                        y: firstColumnConfig.y + (changes.y - firstColumnConfig.y)/2 + 10,
                        fill: '#00c',
                        fontSize: 20,
                        zIndex: 10000,
                        opacity: 0.6,
                        scalingY: -1,
                        textAlign: "center",
                        rotate: -90
                    });
                }
            } else {
                changes.fillStyle = 'lightgray';
                changes.lineWidth = 2;
            }
            return changes;
        }

        function renderer2(sprite, config, rendererData, index) {
            var store = rendererData.store,
                storeItems = store.getData().items,
                last = storeItems.length - 1,
                record = storeItems[index],
                diff = record && Math.round(record.data['G2'] - record.data['G1']),
                changes = {},
                surface = sprite.getParent(),
                isRtl = this.getSurface().getInherited().rtl,
                textSprites, textSprite, rectSprite;
            if (!record) {
                return;
            }
            // This renderer function draws a red label if series #2 is greater than series #1.
            // The label displays the difference between the values of series #1 and series #2.
            //
            // Note: The two renderer functions in this test case cannot be consolidated. The red labels
            // are rendered here because they are positioned relatively to the series #2 columns.
            if (diff > 0) {
                changes.strokeStyle = 'tomato';
                changes.fillStyle = 'mistyrose';
                changes.opacity = 1.0;

                textSprites = surface.myTextSprites;
                if (!textSprites) {
                    textSprites = surface.myTextSprites = [];
                }
                textSprite = textSprites[index];
                if (!textSprite) {
                    textSprite = textSprites[index] = surface.add({type:'text'});
                    rectSprite = textSprite.rectSprite = surface.add({type:'rect'});
                } else {
                    rectSprite = textSprite.rectSprite;
                    textSprite.show();
                    rectSprite.show();
                }

                rectSprite.setAttributes({
                    x: config.x + (index == last ? -17 : (isRtl ? -50 : 16)),
                    y: config.y - 36,
                    width: 30 + (diff >= 10 ? (diff >= 100 ? (diff >= 1000 ? 18 : 12) : 6) : 0),
                    height: 18,
                    stroke: 'tomato',
                    fill: 'mistyrose',
                    lineWidth: 1,
                    radius: 4,
                    zIndex: 10000
                });

                textSprite.setAttributes({
                    text: "+ " + diff,
                    x: config.x + (index == last ? -11 : (isRtl ? -46 : 20)),
                    y: config.y - 23,
                    fill: 'red',
                    fontSize: 12,
                    zIndex: 10001,
                    scalingY: -1
                });
            } else {
                changes.strokeStyle = 'dodgerblue';
                changes.fillStyle = 'palegreen';
                changes.opacity = 0.6;

                textSprites = surface.myTextSprites;
                if (textSprites) {
                    textSprite = textSprites[index];
                    if (textSprite) {
                        textSprite.rectSprite.hide();
                        textSprite.hide();
                    }
                }
            }
            return changes;
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>This example shows how to create a column chart with a renderer to customize colors and use sprites to draw lines and labels.</p>

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
                            Text="Refresh"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />
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
                        <ext:ItemHighlightInteraction />
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
                        <ext:BarSeries
                            XField="Name"
                            YField="G1">
                            <StyleSpec>
                                <ext:SeriesSprite LineWidth="2" MaxBarWidth="30" StrokeStyle="dodgerblue" Opacity="0.6" />
                            </StyleSpec>
                            <Renderer Fn="renderer1" />
                        </ext:BarSeries>

                        <ext:BarSeries
                            XField="Name"
                            YField="G2">
                            <StyleSpec>
                                <ext:SeriesSprite
                                    LineWidth="2"
                                    MaxBarWidth="12"
                                    StrokeStyle="tomato"
                                    FillStyle="mistyrose"
                                    Radius="20"
                                    />
                            </StyleSpec>
                            <Renderer Fn="renderer2" />
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
