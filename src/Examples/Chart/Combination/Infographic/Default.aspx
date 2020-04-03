<%@ Page Language="C#" %>

<%@ Register Src="~/Examples/Chart/Combination/Infographic/Store.ascx" TagName="UnemploymentStore" TagPrefix="uc" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>The US Unemployment Infographic - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script src="ArcText.js"></script>
    <script>
        var InfographicApp = {
            // State regions.
            // A region line spans from the 'start' state through the 'end' state.
            regions: [{
                name: 'Northeast Region',
                start: 'CT',
                end: 'VT'
            }, {
                name: 'Southeast Region',
                start: 'AL',
                end: 'VA'
            }, {
                name: 'Midwest Region',
                start: 'WI',
                end: 'AR'
            }, {
                name: 'Southwest Region',
                start: 'AZ',
                end: 'UT'
            }, {
                name: 'Northwest Region',
                start: 'AK',
                end: 'WY'
            }],

            regionIndex: 0,
            linePadding: 5,
            tickSize: 10,
            startAngle: 0,
            endAngle: 0,
            region: null,

            /**
             * Adds ticks to the ends of a region line.
             * @param surface The surface to put the ticks into.
             * @param attr The style of the ticks.
             * @param angles Array with angles to put the ticks at.
             * @param sprites The array to add the created tick sprites to (for future reference).
             */
            addTicks: function (surface, attr, angles, sprites) {
                var linePadding = InfographicApp.linePadding,
                    tickSize = InfographicApp.tickSize,
                    i, ln, angle;

                for (i = 0, ln = angles.length; i < ln; i++) {
                    angle = angles[i] + attr.rotationRads;
                    sprites.push(surface.add({
                        type: 'line',
                        strokeStyle: 'gray',

                        translationX: attr.translationX,
                        translationY: attr.translationY,

                        fromX: attr.centerX + (attr.endRho + linePadding) * Math.cos(angle),
                        fromY: attr.centerY + (attr.endRho + linePadding) * Math.sin(angle),

                        toX: attr.centerX + (attr.endRho + linePadding + tickSize) * Math.cos(angle),
                        toY: attr.centerY + (attr.endRho + linePadding + tickSize) * Math.sin(angle)
                    }));
                }
            }
        };

        function onBeforeRender() {
            // Make Ext.draw.TextMeasurer use the Ext.util.TextMetrics to measure text,
            // which is a more precise but much slower solution.
            // For this example it shouldn't be a noticable performace hit,
            // since we made optimizations elsewhere.
            Ext.draw.TextMeasurer.precise = true;
        }

        function onDestroy() {
            var regions = InfographicApp.regions,
                i, region;

            for (i = 0; i < regions.length; i++) {
                region = regions[i];
                delete region.sprites;
            }

            InfographicApp.regionIndex = 0;

            Ext.draw.TextMeasurer.precise = false;
        }

        // Returns color based on percentage change in unemployment.
        function getStateColor(unemployment) {
            if (unemployment < -1.5) {
                return 'rgba(114, 166, 185, 1.0)';
            } else if (unemployment < -0.5) {
                return 'rgba(194, 212, 221, 1.0)';
            } else if (unemployment < 0.5) {
                return 'rgba(126, 135, 142, 1.0)';
            } else if (unemployment < 1.5) {
                return 'rgba(179, 113, 114, 1.0)';
            } else {
                return 'rgba(146, 50, 51, 1.0)';
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <%--<h2>The US Unemployment Infographic</h2>

        <p>The US Unemployment Infographic shows how to create what might seem like a distinct</p>
        <p>type of chart, but in fact is only a fancy combination of standard features:</p>
        <p>polar chart with multiple 'pie' series and a cartesian chart.</p>
        <p>The unique look is achieved by a heavy use of sprites and renderers</p>
        <p>to style the chart, and the only custom component is the 'arctext' sprite that</p>
        <p>is used to put a text along a curve.</p>--%>

        <uc:UnemploymentStore runat="server" />

        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:Container runat="server" OverflowY="Auto">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Pack="Center" />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Width="990" Layout="Absolute">
                            <Items>
                                <ext:UserControlLoader runat="server" Path="Polar1.ascx" />
                                <ext:UserControlLoader runat="server" Path="Polar2.ascx" />
                                <ext:UserControlLoader runat="server" Path="Cartesian.ascx" />
                            </Items>
                            <Listeners>
                                <BeforeRender Fn="onBeforeRender" />
                                <Destroy Fn="onDestroy" />
                            </Listeners>
                        </ext:Container>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
