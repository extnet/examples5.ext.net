<%@ Page Language="C#" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Scatter Chart Renderer - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var ColorManager = {
            rgbToHsv: function (rgb) {
                var r = rgb[0] / 255,
                    g = rgb[1] / 255,
                    b = rgb[2] / 255,
                    rd = Math.round,
                    minVal = Math.min(r, g, b),
                    maxVal = Math.max(r, g, b),
                    delta = maxVal - minVal,
                    h = 0, s = 0, v = 0,
                    deltaRgb;

                v = maxVal;

                if (delta === 0) {
                    return [0, 0, v];
                } else {
                    s = delta / maxVal;
                    deltaRgb = {
                        r: (((maxVal - r) / 6) + (delta / 2)) / delta,
                        g: (((maxVal - g) / 6) + (delta / 2)) / delta,
                        b: (((maxVal - b) / 6) + (delta / 2)) / delta
                    };
                    if (r == maxVal) {
                        h = deltaRgb.b - deltaRgb.g;
                    } else if (g == maxVal) {
                        h = (1 / 3) + deltaRgb.r - deltaRgb.b;
                    } else if (b == maxVal) {
                        h = (2 / 3) + deltaRgb.g - deltaRgb.r;
                    }
                    //handle edge cases for hue
                    if (h < 0) {
                        h += 1;
                    }
                    if (h > 1) {
                        h -= 1;
                    }
                }

                h = rd(h * 360);
                s = rd(s * 100);
                v = rd(v * 100);

                return [h, s, v];
            },

            hsvToRgb: function (hsv) {
                var h = hsv[0] / 360,
                    s = hsv[1] / 100,
                    v = hsv[2] / 100,
                    r, g, b, rd = Math.round;

                if (s === 0) {
                    v *= 255;
                    return [v, v, v];
                } else {
                    var vh = h * 6,
                        vi = vh >> 0,
                        v1 = v * (1 - s),
                        v2 = v * (1 - s * (vh - vi)),
                        v3 = v * (1 - s * (1 - (vh - vi)));

                    switch (vi) {
                        case 0:
                            r = v; g = v3; b = v1;
                            break;
                        case 1:
                            r = v2; g = v; b = v1;
                            break;
                        case 2:
                            r = v1; g = v; b = v3;
                            break;
                        case 3:
                            r = v1; g = v2; b = v;
                            break;
                        case 4:
                            r = v3; g = v1; b = v;
                            break;
                        default:
                            r = v; g = v1; b = v2;
                    }

                    return [rd(r * 255),
                            rd(g * 255),
                            rd(b * 255)];
                }
            }
        };

        var rendererConfiguration = {
            xField: 'Data1',
            yField: 'Data2',
            color: false,
            colorFrom: 'rgb(250, 20, 20)',
            colorTo: 'rgb(127, 0, 240)',
            scale: false,
            scaleFrom: 'rgb(20, 20, 20)',
            scaleTo: 'rgb(220, 220, 220)',
            radius: false,
            radiusSize: 50
        },
        Renderers = {};

        var delta = function (x, y, a, b, theta) {
            return a + (b - a) * (y - theta) / (y - x);
        };

        //Add renderer methods.
        Ext.apply(Renderers, {
            color: function (fieldName, minColor, maxColor, minValue, maxValue) {
                var re = /rgb\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*\)\s*/,
                    minColorMatch = minColor.match(re),
                    maxColorMatch = maxColor.match(re),
                    interpolate = function (theta) {
                        return [delta(minValue, maxValue, minColor[0], maxColor[0], theta),
                                 delta(minValue, maxValue, minColor[1], maxColor[1], theta),
                                 delta(minValue, maxValue, minColor[2], maxColor[2], theta)];
                    };
                minColor = ColorManager.rgbToHsv([+minColorMatch[1], +minColorMatch[2], +minColorMatch[3]]);
                maxColor = ColorManager.rgbToHsv([+maxColorMatch[1], +maxColorMatch[2], +maxColorMatch[3]]);
                //Return the renderer
                return function (sprite, config, rendererData, index) {
                    var value = +rendererData.store.getAt(index).get(fieldName),
                        rgb = ColorManager.hsvToRgb(interpolate(value)),
                        rgbString = 'rgb(' + rgb[0] + ', ' + rgb[1] + ', ' + rgb[2] + ')';

                    return Ext.apply(config, {
                        fillStyle: rgbString
                    });
                };
            },

            grayscale: function (fieldName, minColor, maxColor, minValue, maxValue) {
                var re = /rgb\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*\)\s*/,
                minColorMatch = minColor.match(re),
                maxColorMatch = maxColor.match(re),
                interpolate = function (theta) {
                    var ans = delta(minValue, maxValue, +minColorMatch[1], +maxColorMatch[1], theta) >> 0;
                    return [ans, ans, ans];
                };
                //Return the renderer
                return function (sprite, config, rendererData, index) {
                    var value = +rendererData.store.getAt(index).get(fieldName),
                        rgb = interpolate(value),
                        rgbString = 'rgb(' + rgb[0] + ', ' + rgb[1] + ', ' + rgb[2] + ')';

                    return Ext.apply(config, {
                        fillStyle: rgbString,
                        strokeStyle: 'rgb(0, 0, 0)'
                    });
                };
            },

            radius: function (fieldName, minRadius, maxRadius, minValue, maxValue) {
                var interpolate = function (theta) {
                    return delta(minValue, maxValue, minRadius, maxRadius, theta);
                };
                //Return the renderer
                return function (sprite, config, rendererData, index) {
                    var value = +rendererData.store.getAt(index).get(fieldName),
                        radius = interpolate(value);

                    return Ext.apply(config, {
                        radius: radius
                    });
                };
            }
        });

        var refresh = function () {
            var chart = App.Chart1,
                series = chart.series,
                len = series.length,
                rc = rendererConfiguration,
                color, grayscale, radius, s, i,
                renderer;

            for (i = 0; i < len; i++) {
                s = series[i];
                s.setXField(rc.xField);
                s.setYField(rc.yField);
                color = rc.color ? Renderers.color(rc.color, rc.colorFrom, rc.colorTo, 0, 100) : function (a, b, attr) { return attr; };
                grayscale = rc.grayscale ? Renderers.grayscale(rc.grayscale, rc.scaleFrom, rc.scaleTo, 0, 100) : function (a, b, attr) { return attr; };
                radius = rc.radius ? Renderers.radius(rc.radius, 10, rc.radiusSize, 0, 100) : function (a, b, attr) { return attr; };

                renderer = function (sprite, config, rendererData, index) {
                    return radius(sprite, grayscale(sprite, color(sprite, config, rendererData, index), rendererData, index), rendererData, index);
                };

                chart.getItems().get("Chart1-series").getItems()[0].attr.renderer = renderer;

                s.setRenderer(renderer);
            }

            chart.store.load();
        }

        var xAxisHandler = function (elem) {
            var xField = elem.text;
            rendererConfiguration.xField = xField;
            refresh();
        };

        var yAxisHandler = function (elem) {
            var yField = elem.text;
            rendererConfiguration.yField = yField;
            refresh();
        };

        var colorVariableHandler = function (elem) {
            var color = elem.text;
            rendererConfiguration.color = color;
            rendererConfiguration.grayscale = false;
            refresh();
        };

        var grayscaleVariableHandler = function (elem) {
            var color = elem.text;
            rendererConfiguration.grayscale = color;
            rendererConfiguration.color = false;
            refresh();
        };

        var scaleFromHandler = function (elem) {
            var from = elem.text;
            rendererConfiguration.scaleFrom = from;
            refresh();
        };

        var scaleToHandler = function (elem) {
            var to = elem.text;
            rendererConfiguration.scaleTo = to;
            refresh();
        };

        var colorFromHandler = function (elem) {
            var from = elem.text;
            rendererConfiguration.colorFrom = from;
            refresh();
        };

        var colorToHandler = function (elem) {
            var to = elem.text;
            rendererConfiguration.colorTo = to;
            refresh();
        };

        var radiusHandler = function (elem) {
            var radius = elem.text;
            rendererConfiguration.radius = radius;
            refresh();
        };

        var radiusSizeHandler = function (elem) {
            var radius = elem.text;
            rendererConfiguration.radiusSize = parseInt(radius, 10);
            refresh();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Scatter Renderer Example</h1>

        <div style="margin: 10px;">
            <p>
                Display 2 sets of random data in a scatter series. A renderer has been set up on to dynamically change the size and color of the items based upon it's data. In addition contrast detection has been turned on to dynamically change the font color based on the color of the item it is on. Reload data will randomly generate a new set of data in the store.
            </p>
        </div>

        <ext:Window
            runat="server"
            Width="960"
            Height="600"
            MinHeight="400"
            MinWidth="650"
            Maximizable="true"
            Title="Scatter Chart Renderer"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Preview" Handler="this.up('window').down('cartesian').preview();" />

                        <ext:Button runat="server" Text="Reload Data">
                            <DirectEvents>
                                <Click OnEvent="ReloadData" Buffer="100" />
                            </DirectEvents>
                        </ext:Button>

                        <ext:Button runat="server" Text="Select X Axis">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data1"
                                            Handler="xAxisHandler"
                                            Checked="true"
                                            Group="x"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data2"
                                            Handler="xAxisHandler"
                                            Checked="false"
                                            Group="x"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data3"
                                            Handler="xAxisHandler"
                                            Checked="false"
                                            Group="x"
                                            />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>

                        <ext:Button runat="server" Text="Select Y Axis">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data1"
                                            Handler="yAxisHandler"
                                            Checked="false"
                                            Group="y"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data2"
                                            Handler="yAxisHandler"
                                            Checked="true"
                                            Group="y"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data3"
                                            Handler="yAxisHandler"
                                            Checked="false"
                                            Group="y"
                                            />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>

                        <ext:Button runat="server" Text="Select Color">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data1"
                                            Handler="colorVariableHandler"
                                            Checked="false"
                                            Group="color"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data2"
                                            Handler="colorVariableHandler"
                                            Checked="false"
                                            Group="color"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data3"
                                            Handler="colorVariableHandler"
                                            Checked="false"
                                            Group="color"
                                            />

                                        <ext:MenuItem runat="server" Text="Color From">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(250, 20, 20)"
                                                            Handler="colorToHandler"
                                                            Checked="true"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 250, 20)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 20, 250)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(127, 0, 240)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(213, 70, 121)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(44, 153, 201)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(146, 6, 157)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(49, 149, 0)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(249, 153, 0)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="colorrange"
                                                            />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>

                                        <ext:MenuItem runat="server" Text="Color To">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(250, 20, 20)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 250, 20)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 20, 250)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(127, 0, 240)"
                                                            Handler="colorToHandler"
                                                            Checked="true"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(213, 70, 121)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(44, 153, 201)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(146, 6, 157)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(49, 149, 0)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(249, 153, 0)"
                                                            Handler="colorToHandler"
                                                            Checked="false"
                                                            Group="tocolorrange"
                                                            />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>

                        <ext:Button runat="server" Text="Select Grayscale">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data1"
                                            Handler="grayscaleVariableHandler"
                                            Checked="false"
                                            Group="gs"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data2"
                                            Handler="grayscaleVariableHandler"
                                            Checked="false"
                                            Group="gs"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data3"
                                            Handler="grayscaleVariableHandler"
                                            Checked="false"
                                            Group="gs"
                                            />

                                        <ext:MenuItem runat="server" Text="Scale From">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 20, 20)"
                                                            Handler="scaleFromHandler"
                                                            Checked="true"
                                                            Group="gsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(80, 80, 80)"
                                                            Handler="scaleFromHandler"
                                                            Checked="false"
                                                            Group="gsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(120, 120, 120)"
                                                            Handler="scaleFromHandler"
                                                            Checked="false"
                                                            Group="gsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(180, 180, 180)"
                                                            Handler="scaleFromHandler"
                                                            Checked="false"
                                                            Group="gsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(220, 220, 220)"
                                                            Handler="scaleFromHandler"
                                                            Checked="false"
                                                            Group="gsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(250, 250, 250)"
                                                            Handler="scaleFromHandler"
                                                            Checked="false"
                                                            Group="gsrange"
                                                            />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>

                                        <ext:MenuItem runat="server" Text="Scale To">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(20, 20, 20)"
                                                            Handler="scaleToHandler"
                                                            Checked="false"
                                                            Group="togsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(80, 80, 80)"
                                                            Handler="scaleToHandler"
                                                            Checked="false"
                                                            Group="togsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(120, 120, 120)"
                                                            Handler="scaleToHandler"
                                                            Checked="false"
                                                            Group="togsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(180, 180, 180)"
                                                            Handler="scaleToHandler"
                                                            Checked="false"
                                                            Group="togsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(220, 220, 220)"
                                                            Handler="scaleToHandler"
                                                            Checked="true"
                                                            Group="togsrange"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="rgb(250, 250, 250)"
                                                            Handler="scaleToHandler"
                                                            Checked="false"
                                                            Group="togsrange"
                                                            />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>

                        <ext:Button runat="server" Text="Select Radius">
                            <Menu>
                                <ext:Menu runat="server" StyleSpec="overflow:visible;">
                                    <Items>
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data1"
                                            Handler="radiusHandler"
                                            Checked="false"
                                            Group="radius"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data2"
                                            Handler="radiusHandler"
                                            Checked="false"
                                            Group="radius"
                                            />

                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Data3"
                                            Handler="radiusHandler"
                                            Checked="false"
                                            Group="radius"
                                            />

                                        <ext:MenuItem runat="server" Text="Max Radius">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="20"
                                                            Handler="radiusSizeHandler"
                                                            Checked="false"
                                                            Group="sradius"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="30"
                                                            Handler="radiusSizeHandler"
                                                            Checked="false"
                                                            Group="sradius"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="40"
                                                            Handler="radiusSizeHandler"
                                                            Checked="false"
                                                            Group="sradius"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="50"
                                                            Handler="radiusSizeHandler"
                                                            Checked="true"
                                                            Group="sradius"
                                                            />

                                                        <ext:CheckMenuItem
                                                            runat="server"
                                                            Text="60"
                                                            Handler="radiusSizeHandler"
                                                            Checked="false"
                                                            Group="sradius"
                                                            />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    StyleSpec="background:#fff;"
                    InsetPadding="10">
                    <Store>
                        <ext:Store runat="server" Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                        <ext:ModelField Name="Data5" />
                                        <ext:ModelField Name="Data6" />
                                        <ext:ModelField Name="Data7" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Series>
                        <ext:ScatterSeries XField="Data1" YField="Data2">
                            <Marker>
                                <ext:CircleSprite Radius="20" />
                            </Marker>
                        </ext:ScatterSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
