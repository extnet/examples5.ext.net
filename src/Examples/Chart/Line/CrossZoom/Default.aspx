<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().JsonData = System.IO.File.ReadAllText(Server.MapPath("usd2eur.json"));
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function undoZoom() {
            var chart = this.up("panel").down("cartesian"),
                interaction = chart && Ext.ComponentQuery.query('interaction', chart)[0],
                undoButton = interaction && interaction.getUndoButton(),
                handler = undoButton && undoButton.handler;
            if (handler) {
                handler();
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Example</h1>

        <p>This example shows how to create a line chart. Line charts allow to visualize the</p>
        <p>evolution of a value over time, or the ratio between any two values.</p>
        <p>This example also highlights data aggregation to effortlessly display over 1000 points.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button runat="server" Text="Undo Zoom" Handler="undoZoom" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPaddingSpec="20 20 10 10">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="time" Type="Date" DateFormat="time" />
                                        <ext:ModelField Name="value" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Interactions>
                        <ext:CrossZoomInteraction />
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="value"
                            Title="USD to Euro"
                            TitleMargin="12">
                            <Renderer Handler="return layoutContext.renderer(label) + '%';" />
                        </ext:NumericAxis>

                        <ext:TimeAxis
                            Position="Bottom"
                            DateFormat="yy-MMM-dd"
                            VisibleRange="0,1"
                            Fields="time"
                            TitleMargin="12"
                            Title="Date"
                            />
                    </Axes>
                    <Series>
                        <ext:LineSeries XField="time" YField="value">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" FillStyle="#115fa6" StrokeStyle="#115fa6" FillOpacity="0.6" MiterLimit="3" LineCap="Miter"  />
                            </StyleSpec>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
