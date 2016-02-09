<%@ Control Language="C#" %>
<%@ Register Namespace="Ext.Net.Examples" Assembly="Ext.Net.Examples" TagPrefix="ee" %>

<ext:PolarChart runat="server" 
    AnchorHorizontal="100%" 
    Height="1375"
    Animation="false"
    InsetPaddingSpec="400 0 125 0"
    StoreID="Store1">
    <HtmlBin>
        <script>
            var highlightRenderer = (function () { // The immidiately executed closure
                // to create a scope with variables that will be used by the renderer function.

                // State regions.
                // A region line spans from the 'start' state through the 'end' state.
                var regions = [{
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
                    ln = regions.length,
                    regionIndex = 0,
                    linePadding = 5,
                    tickSize = 10,
                    startAngle, endAngle,
                    region;

                /**
                 * Adds ticks to the ends of a region line.
                 * @param surface The surface to put the ticks into.
                 * @param attr The style of the ticks.
                 * @param angles Array with angles to put the ticks at.
                 * @param sprites The array to add the created tick sprites to (for future reference).
                 */
                function addTicks(surface, attr, angles, sprites) {
                    var i, ln, angle;
                    for (i = 0, ln = angles.length; i < ln; i++) {
                        angle = angles[i];
                        sprites.push(surface.add({
                            type: 'line',
                            translationX: attr.translationX,
                            translationY: attr.translationY,
                            fromX: attr.centerX + (attr.endRho + linePadding) * Math.cos(angle),
                            fromY: attr.centerY + (attr.endRho + linePadding) * Math.sin(angle),
                            toX: attr.centerX + (attr.endRho + linePadding + tickSize) * Math.cos(angle),
                            toY: attr.centerY + (attr.endRho + linePadding + tickSize) * Math.sin(angle),
                            strokeStyle: 'gray'
                        }));
                    }
                }

                // The renderer function itself.
                // The renderer is executed only once for each pie sector sprite
                // to create the region sprites, then the renderer is removed.
                return function (sprite, config, data, index) {
                    // Please see the comments in the KitchenSink.store.Unemployment class
                    // for more info on the meaning of the record fields.
                    var record = data.store.getAt(index),
                        label = record.get('label'),
                        spriteSurface = sprite.getSurface(),
                        chart = spriteSurface.ownerCt,
                        overlaySurface = chart.getSurface('overlay'),
                        attr = sprite.attr;

                    // Because the regionIndex is declared and initialized in the closure
                    // that's only executed once (when the view is defined),
                    // we need to reset the regionIndex every time the example is shown.
                    if (chart.resetRegionIndex) {
                        regionIndex = 0;
                        delete chart.resetRegionIndex;
                    }

                    // If it's a sector that shows the change in unemployment with a color
                    if (label !== '' && label !== 'year') {

                        // If not all region sprites have been created yet.
                        if (regionIndex !== ln) {
                            // Since the renderer function is called for all the sectors
                            // of the 'pie' series sprite in the store record order,
                            // we can create region sprites on the first 'swipe' through the sectors
                            // when the pie series sprite is rendered for the first time,
                            // and ignore this block afterward.
                            region = regions[regionIndex];
                            if (label === region.start) {
                                startAngle = attr.startAngle;
                                region.startIndex = index;
                            } else if (label === region.end) {
                                endAngle = attr.endAngle;
                                region.endIndex = index;
                                region.sprites = [];
                                region.sprites.push(overlaySurface.add({
                                    type: 'arc',
                                    cx: attr.centerX,
                                    cy: attr.centerY,
                                    r: attr.endRho + linePadding,
                                    translationX: attr.translationX,
                                    translationY: attr.translationY,
                                    rotationRads: attr.rotationRads,
                                    strokeStyle: 'gray',
                                    startAngle: startAngle,
                                    endAngle: endAngle
                                }));
                                addTicks(overlaySurface, attr, [
                                        startAngle + attr.rotationRads,
                                        endAngle + attr.rotationRads
                                ], region.sprites);
                                // Label region lines with text sprites.
                                region.sprites.push(overlaySurface.add({
                                    type: 'arctext',
                                    text: region.name,
                                    spacing: 2,
                                    centerX: attr.centerX,
                                    centerY: attr.centerY,
                                    radius: attr.endRho + linePadding * 2,
                                    angle: ((startAngle + endAngle) * 0.5 + attr.rotationRads) / Math.PI * 180,
                                    translationX: attr.translationX,
                                    translationY: attr.translationY,
                                    template: {
                                        type: 'text',
                                        fontSize: 13,
                                        fillStyle: 'rgba(76, 76, 77, 1.0)'

                                    }
                                }));
                                regionIndex++;
                            }
                            if (regionIndex === ln) {
                                chart.$stateRegions = regions;
                            }
                        }
                    }
                    this.attr.renderer = null;
                    return;
                };
            })();

            function itemhighlight(item) {
                if (item.series.getXField() === 'dummy') {
                    return;
                }
                var regions = this.$stateRegions,
                    label = item.record.get('label'),
                    cartesianChart = this.ownerCt.down('cartesian'),
                    data = item.record.data,
                    i, j, ik, jk, region, sprite;
                if (!label) {
                    // Don't highlight the sectors that separate the regions.
                    item.series.setAttributesForItem(item, {
                        highlighted: false
                    });
                } else if (label !== 'year') {
                    this.getSurface('chart').get('stateName').setAttributes({
                        text: item.record.get('state')
                    });
                    // Display unemployment changes for the highlighted state inside the cartesian chart.
                    cartesianChart.setStore({
                        fields: ['year', 'percent'],
                        data: [
                            {year: '2007', percent: data.y2007},
                            {year: '2008', percent: data.y2008},
                            {year: '2009', percent: data.y2009},
                            {year: '2010', percent: data.y2010},
                            {year: '2011', percent: data.y2011},
                            {year: '2012', percent: data.y2012}
                        ]
                    });
                }
                if (!regions) {
                    return;
                }
                // Find the region the highlighted state sector belongs to and highlight its sprites,
                // while unhighlighting all other regions.
                for (i = 0, ik = regions.length; i < ik; i++) {
                    region = regions[i];
                    if (item.index >= region.startIndex && item.index <= region.endIndex) {
                        if (!region.highlighted) {
                            for (j = 0, jk = region.sprites.length; j < jk; j++) {
                                sprite = region.sprites[j];
                                if (sprite.type === 'arctext') {
                                    sprite.getTemplate().setAttributes({
                                        fillStyle: 'red'
                                    });
                                } else {
                                    sprite.setAttributes({
                                        strokeStyle: 'red',
                                        lineWidth: 1.5
                                    });
                                }
                            }
                            region.highlighted = true;
                        }
                    } else if (region.highlighted) {
                        for (j = 0, jk = region.sprites.length; j < jk; j++) {
                            sprite = region.sprites[j];
                            if (sprite.type === 'arctext') {
                                sprite.getTemplate().setAttributes({
                                    fillStyle: 'black'
                                });
                            } else {
                                sprite.setAttributes({
                                    strokeStyle: 'gray',
                                    lineWidth: 1
                                });
                            }
                        }
                        region.highlighted = false;
                    }
                }
            }
        </script>
    </HtmlBin>
    <Bin>
        <ext:Store ID="DummyStore" runat="server" JsonData="[{dummy: 1}]">
            <Fields>
                <ext:ModelField Name="span" />
            </Fields>            
        </ext:Store>
    </Bin>
    <Interactions>
        <ext:ItemHighlightInteraction />
    </Interactions>
    <Items>
        <ext:TextSprite SpriteID="stateName" Text="" TextBaseline="Top" TextAlign="Center" Font="bold 30px Charter" X="495" Y="650" />
    </Items>

    <Series>
        <ext:PieSeries 
            XField="span"
            Donut="57"
            RadiusFactor="100"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite FillStyle="none" StrokeStyle="none" LineWidth="1" />
            </SubStyle>
            <HighlightDefaults>
                <ext:Sprite FillStyle="rgba(0,0,0,0.2)" Margin="0" />
            </HighlightDefaults>
            <Renderer Fn="highlightRenderer" />
        </ext:PieSeries>

        <%--Dummy series used to render the white ring
        where the text "Recession December 2007" is shown.
        Displayed above all other series,
        including the series used for highlighting.--%>
        <ext:PieSeries 
            XField="dummy"
            Donut="63"
            RadiusFactor="67"
            Rotation="<%# -Math.PI/60 %>"
            StoreID="DummyStore"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite FillStyle="white" StrokeStyle="none" LineWidth="1" />
            </SubStyle>            
        </ext:PieSeries>
    </Series>    
    <Listeners>
        <ItemHighlight Fn="itemhighlight" />
        <Redraw Handler="var chart = this, series = chart.getSeries()[0]; chart.setHighlightItem(series.getItemByIndex(1)); chart.getSurface('overlay').renderFrame();" Single="true" Delay="1" />
    </Listeners>
</ext:PolarChart>