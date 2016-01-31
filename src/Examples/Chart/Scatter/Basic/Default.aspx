<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object> 
        {
            new { x = 5,   y = 20 },
            new { x = 480, y = 90 },
            new { x = 250, y = 50 },
            new { x = 100, y = 33 },
            new { x = 330, y = 95 },
            new { x = 410, y = 12 },
            new { x = 475, y = 44 },
            new { x = 25,  y = 67 },
            new { x = 85,  y = 21 },
            new { x = 220, y = 88 },
            new { x = 320, y = 79 },
            new { x = 270, y = 32 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Scatter Chart Basic - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var resetPanZoom = function () {
            var panel = this.up('panel'),
                chart = panel.down('cartesian'),
                axes = chart.getAxes();

            axes[0].setVisibleRange([0, 1]);
            axes[1].setVisibleRange([0, 1]);
            chart.redraw();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <p>
              A basic scatter chart or scatter plot uses Cartesian coordinates to display values for
        <br/> two variables for a set of data. The data is displayed as a collection of points, each
        <br/> having the value of one variable on the horizontal axis and the value of the other
        <br/> variable vertical axis.

        </p>

        <ext:Panel 
            runat="server" 
            BodyStyle="background: transparent !important;" 
            Width="650">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Center" Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Preview" Handler="this.up('panel').down('cartesian').preview();" />
                        <ext:Button runat="server" Text="Reset pan/zoom" Handler="resetPanZoom" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart 
                    ID="Chart1" 
                    runat="server" 
                    Height="500" 
                    InsetPadding="40">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="x" />
                                        <ext:ModelField Name="y" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Interactions>
                        <ext:PanZoomInteraction ZoomOnPanGesture="true" />
                        <ext:ItemHighlightInteraction />
                    </Interactions>
                    <Axes>
                        <ext:NumericAxis Position="Bottom" Fields="x" Grid="true" />
                        <ext:NumericAxis Position="Left" Fields="y" Grid="true" />
                    </Axes>
                    <Items>
                        <ext:TextSprite 
                            Text="Scatter Charts - Basic" 
                            FontSize="22"
                            Width="100"
                            Height="10"
                            X="40"
                            Y="20" />
                    </Items>
                    <Series>
                        <ext:ScatterSeries XField="x" YField="y">
                            <Marker>
                                <ext:CircleSprite Radius="4" />
                            </Marker>
                            <HighlightDefaults>
                                <ext:CircleSprite FillStyle="yellow" Radius="7" LineWidth="2" />
                            </HighlightDefaults>
                            <Label Field="x" Display="Over">
                                <Renderer Fn="function(text, label, labelCfg, data, index) {
                                                  var record = data.store.getAt(index);
                                                  return record.get('x') + ',' + record.get('y');
                                              }" />
                            </Label>
                        </ext:ScatterSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
            <Listeners>
                <BeforeRender Handler="var panzoom = this.down('cartesian').getInteractions()[0];
                                       this.down('toolbar').add(panzoom.getModeToggleButton());" />
            </Listeners>
        </ext:Panel>
    </form>    
</body>
</html>