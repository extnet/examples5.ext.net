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
            // This renderer is called for each pie slice of the series only once
            // on initial chart render. The renderer doesn't actually change
            // the style of the series sprites. Its only job is to create
            // and position the region sprites in the chart.
            function onDummySliceRender(sprite, config, data, index) {
                // Please see the comments in the KitchenSink.store.Unemployment class
                // for more info on the meaning of the record fields.
                var me = this,
                    ln = InfographicApp.regions.length,
                    record = data.store.getAt(index),
                    label = record.get('label'),
                    spriteSurface = sprite.getSurface(), // 'series' surface
                    chart = spriteSurface.ownerCt,
                    overlaySurface = chart.getSurface('overlay'),
                    attr = sprite.attr,
                    region;

                // Because the regionIndex is declared and initialized in the closure
                // that's only executed once (when the view is defined),
                // we need to reset the regionIndex every time the example is shown.
                if (chart.resetRegionIndex) {
                    InfographicApp.regionIndex = 0;
                    delete chart.resetRegionIndex;
                }

                // If it's a sector that shows the change in unemployment with a color
                if (label !== '' && label !== 'year') {

                    // If not all region sprites have been created yet.
                    if (InfographicApp.regionIndex !== ln) {
                        // Since the renderer function is called for all the sectors
                        // of the 'pie' series sprite in the store record order,
                        // we can create region sprites on the first 'swipe' through the sectors
                        // when the pie series sprite is rendered for the first time,
                        // and remove the renderer afterwards.
                        InfographicApp.region = region = InfographicApp.regions[InfographicApp.regionIndex];

                        if (label === region.start) {

                            InfographicApp.startAngle = attr.startAngle;
                            region.startIndex = index;

                        } else if (label === region.end) {

                            InfographicApp.endAngle = attr.endAngle;
                            region.endIndex = index;

                            region.sprites = [];

                            region.sprites.push(overlaySurface.add({
                                type: 'arc',
                                strokeStyle: 'gray',

                                cx: attr.centerX,
                                cy: attr.centerY,

                                r: attr.endRho + InfographicApp.linePadding,

                                translationX: attr.translationX,
                                translationY: attr.translationY,
                                rotationRads: attr.rotationRads,

                                startAngle: InfographicApp.startAngle,
                                endAngle: InfographicApp.endAngle
                            }));

                            InfographicApp.addTicks(overlaySurface, attr, [InfographicApp.startAngle, InfographicApp.endAngle], region.sprites);

                            // Label region lines with text sprites.
                            region.sprites.push(overlaySurface.add({
                                type: 'arctext',
                                text: region.name,
                                spacing: 2,
                                centerX: attr.centerX,
                                centerY: attr.centerY,
                                radius: attr.endRho + InfographicApp.linePadding * 2,
                                angle: ((InfographicApp.startAngle + InfographicApp.endAngle) * 0.5 + attr.rotationRads) / Math.PI * 180,
                                translationX: attr.translationX,
                                translationY: attr.translationY,
                                template: {
                                    type: 'text',
                                    fontSize: 13,
                                    fontWeight: 'normal',
                                    fillStyle: 'gray'

                                }
                            }));
                            InfographicApp.regionIndex++;
                        }

                    }
                }

                sprite.attr.renderer = null;
            }

            function onItemHighlight(chart, item) {
                // The 'item' parameter here is an object that holds information
                // about the highlighted item, like its 'index', the 'series' it belongs to,
                // the associated store 'record' and its 'field'.

                var regions = InfographicApp.regions,
                    label = item.record.get('label'),
                    cartesianChart = this.ownerCt.down('cartesian'),
                    data = item.record.data,
                    i, j, ik, jk, region, sprite;

                if (!label || label === 'year') {
                    // Don't highlight the sectors that separate the regions
                    // and the sector that shows the year.
                    item.series.setAttributesForItem(item, {
                        highlighted: false
                    });
                } else {
                    chart.getSurface('chart').get('stateName').setAttributes({
                        text: item.record.get('state')
                    });
                    // Display unemployment changes for the highlighted state inside the cartesian chart.
                    cartesianChart.setStore({
                        fields: ['year', 'percent'],
                        data: [
                            { year: '2007', percent: data.y2007 },
                            { year: '2008', percent: data.y2008 },
                            { year: '2009', percent: data.y2009 },
                            { year: '2010', percent: data.y2010 },
                            { year: '2011', percent: data.y2011 },
                            { year: '2012', percent: data.y2012 }
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

                if (!Ext.is.Desktop) {
                    chart.redraw();
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
            AngleField="span"
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
            <Renderer Fn="onDummySliceRender" />
        </ext:PieSeries>

        <%--Dummy series used to render the white ring
        where the text "Recession December 2007" is shown.
        Displayed above all other series,
        including the series used for highlighting.--%>
        <ext:PieSeries
            AngleField="dummy"
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
        <ItemHighlight Fn="onItemHighlight" />
        <Redraw Handler="var chart = this, series = chart.getSeries()[0]; chart.setHighlightItem(series.getItemByIndex(1)); chart.getSurface('overlay').renderFrame();" Single="true" Delay="1" />
    </Listeners>
</ext:PolarChart>
