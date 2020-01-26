<%@ Control Language="C#" %>

<ext:FormPanel
    runat="server"
    Region="North"
    Split="true"
    Height="375"
    BodyPadding="5"
    Layout="AnchorLayout">
    <FieldDefaults LabelWidth="205" />
    <Defaults>
        <ext:Parameter Name="anchor" Value="100%" Mode="Value" />
    </Defaults>
    <Items>
        <ext:NumberField
            runat="server"
            FieldLabel="Ajax latency (ms)"
            ItemID="latency"
            Number="1000"
            MinValue="0"
            MaxValue="5000" />

        <ext:NumberField
            runat="server"
            FieldLabel="Dataset row count"
            ItemID="rowCount"
            Number="5000"
            MinValue="200" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.panel.Table.html#cfg-trailingBufferZone' target='docs' tabIndex='-1'>trailingBufferZone</a>"
            ItemID="scrollerTrailingBufferZone"
            Number="10"
            MaxValue="100" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.grid.plugin.BufferedRenderer.html#cfg-leadingBufferZone' target='docs' tabIndex='-1'>leadingBufferZone</a>"
            ItemID="scrollerLeadingBufferZone"
            Number="20"
            MaxValue="100">
            <Listeners>
                <Change Handler="var nfeField = this.up('form').down('#scrollerNumFromEdge'); nfeField.maxValue = newValue - 1; if (nfeField.getValue() >= newValue) {nfeField.setValue(newValue - 1);}" Buffer="500" />
            </Listeners>
        </ext:NumberField>

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.panel.Table.html#cfg-numFromEdge' target='docs' tabIndex='-1'>numFromEdge</a>"
            ItemID="scrollerNumFromEdge"
            Number="8"
            MaxValue="19" />

        <ext:NumberField
            runat="server"
            FieldLabel="Num columns"
            ItemID="numFields"
            Number="10"
            MinValue="1" />

        <ext:Checkbox runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.data.BufferedStore' target='docs' tabIndex='-1'>BufferedStore</a>"
            ItemID="buffered">
            <Listeners>
                <Change Fn="bufferedChange" />
            </Listeners>
        </ext:Checkbox>

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.data.BufferedStore.html#cfg-pageSize' target='docs' tabIndex='-1'>BufferedStore pageSize</a>"
            ItemID="pageSize"
            Number="150"
            Disabled="true" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.data.BufferedStore.html#cfg-trailingBufferZone' target='docs' tabIndex='-1'>BufferedStore trailingBufferZone</a>"
            ItemID="storeTrailingBufferZone"
            Number="25"
            Disabled="true" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.data.BufferedStore.html#cfg-leadingBufferZone' target='docs' tabIndex='-1'>BufferedStore leadingBufferZone</a>"
            ItemID="storeLeadingBufferZone"
            Number="200"
            Disabled="true" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.data.BufferedStore.html#cfg-purgePageCount' target='docs' tabIndex='-1'>BufferedStore purgePageCount</a>"
            ItemID="purgePageCount"
            Number="5"
            MinValue="0"
            Disabled="true" />

        <ext:NumberField
            runat="server"
            FieldLabel="<a href='http://docs.sencha.com/extjs/7.1.0/classic/Ext.grid.plugin.BufferedRenderer.html#cfg-scrollToLoadBuffer' target='docs' tabIndex='-1'>BufferedRenderer scrollToLoadBuffer</a>"
            ItemID="scrollToLoadBuffer"
            Number="200"
            MinValue="0"
            MaxValue="1000"
            Disabled="true">
            <Listeners>
                <Change Handler="App.TestGrid.verticalScroller.scrollToLoadBuffer = newValue;" />
            </Listeners>
        </ext:NumberField>
    </Items>

    <TopBar>
        <ext:Toolbar runat="server">
            <Items>
                <ext:Button
                    ID="ReloadButton"
                    runat="server"
                    IDMode="Static"
                    Text="Reload"
                    StandOut="true"
                    Icon="ArrowRefresh"
                    Handler="initializeGrid" />
            </Items>
        </ext:Toolbar>
    </TopBar>

    <Listeners>
        <BoxReady Handler="this.minHeight = height;" />
    </Listeners>

    <HtmlBin>
        <script>
            function bufferedChange(cb, checked) {
                var controls = this.up('form'),
                    pageSize = controls.down('#pageSize'),
                    storeTrailingBufferZone = controls.down('#storeTrailingBufferZone'),
                    storeLeadingBufferZone = controls.down('#storeLeadingBufferZone'),
                    purgePageCount = controls.down('#purgePageCount'),
                    scrollToLoadBuffer = controls.down('#scrollToLoadBuffer');

                if (checked) {
                    pageSize.enable();
                    storeTrailingBufferZone.enable();
                    storeLeadingBufferZone.enable();
                    purgePageCount.enable();
                    scrollToLoadBuffer.enable();
                } else {
                    pageSize.disable();
                    storeTrailingBufferZone.disable();
                    storeLeadingBufferZone.disable();
                    purgePageCount.disable();
                    scrollToLoadBuffer.disable();
                }
            }

            function createStore(numFields, buffered, groupSize) {
                var fields = [],
                    i, storeConfig,
                    result,
                    pageCache;

                for (i = 0; i < numFields; ++i) {
                    fields.push('field' + i);
                }

                simlet.numFields = numFields;
                storeConfig = {
                    storeId: 'infinite-scroll-store-' + (storeCount++),
                    remoteSort: buffered,

                    // allow the grid to interact with the paging scroller by buffering
                    buffered: buffered,
                    fields: fields,
                    proxy: {
                        // Simulating Ajax.
                        type: 'ajax',
                        url: 'localAjaxSimulator?groupSize=' + groupSize,
                        reader: {
                            rootProperty: 'topics',
                            totalProperty: 'totalCount'
                        }
                    }
                };

                if (groupSize) {
                    storeConfig.remoteGroup = buffered;
                    storeConfig.groupField = 'field0';
                }

                result = Ext.create(buffered ? 'Ext.data.BufferedStore' : 'Ext.data.Store', storeConfig);
                pageCache = result.getData();

                // Inject logging into the LruCache
                if (pageCache instanceof Ext.util.LruCache) {
                    pageCache.prune = Ext.Function.createSequence(pageCache.prune, function () {
                        App.LogPanel.log('Page cache contains pages ' + this.getKeys().join(',') + '<br>&#160;&#160;&#160;&#160;' + this.getCount() + ' records in cache');
                    });
                }

                return result;
            }

            function createGrid(extraCfg) {
                var gridConfig = Ext.apply({
                    id: "TestGrid",
                    title: 'Random data (' + simlet.numRecords + ' records)',
                    border: false,
                    loadMask: true,
                    selModel: {
                        pruneRemoved: false
                    },
                    columnLines: true,
                    multiSelect: true,
                    columns: [{
                        xtype: 'rownumberer',
                        width: 50,
                        sortable: false
                    }]
                }, extraCfg);

                if (extraCfg.store.groupField) {
                    gridConfig.features = [
                        Ext.create('Ext.grid.feature.Grouping', {
                            showSummaryRow: true,
                            groupHeaderTpl: [
                                '{columnName}: {name:this.groupName}',
                                '<tpl if="rows.length">',
                                    ' ({rows.length} Item{[values.rows.length > 1 ? "s" : ""]})',
                                '</tpl>',
                                {
                                    groupName: function (group) {
                                        var rowIdx = (group - 1) * simlet.groupSize;
                                        return groupColumnRenderer(rowIdx, null, null, rowIdx, 1);
                                    }
                                }],
                            id: 'field0Grouping'
                        })
                    ];
                }

                return Ext.create('Ext.grid.Panel', gridConfig);
            }

            function columnRenderer(v, metadata, record, rowIdx, colIdx, store, view) {
                return 'col' + colIdx + ', row ' + v + '0.00';
            }

            function groupColumnRenderer(v, metadata, record, rowIdx, colIdx, store, view) {
                var groupSize = simlet.groupSize,
                    group = Math.floor((rowIdx + groupSize) / groupSize),
                    groupStart = (group - 1) * groupSize + 1,
                    groupEnd = groupStart + (groupSize - 1);

                return 'rows ' + groupStart + ' to ' + groupEnd;
            }

            function initializeGrid(btn) {
                var controls = btn.up("form"),
                    grid = App.TestGrid,
                    logPanel = App.LogPanel,
                    numFields = controls.down('#numFields').getValue(),
                    columns = [{
                        xtype: 'rownumberer',
                        width: 50,
                        sortable: false
                    }],
                    i,
                    rowCount = controls.down('#rowCount').getValue(),
                    groupSize = grid.ownerCt.down('#groupSize').getValue() || 0,
                    buffered = controls.down('#buffered').getValue(),
                    columnSpec,
                    store = grid.store;

                //Ext.suspendLayouts();
                store.removeAll();
                grid.destroy();
                logPanel.body.update('');

                for (i = 0; i < numFields; ++i) {
                    columnSpec = {
                        text: 'Field ' + (i + 1),
                        dataIndex: 'field' + i,
                        renderer: columnRenderer,
                        summaryType: summaryTypes[i % 5],
                        align: 'end',
                        summaryRenderer: function (value, cellValues, record, recordIndex, colIdx, store, view) {
                            cellValues.style = 'text-align:right';
                            return summaryTypeNames[(colIdx - 1) % 5] + ': ' + Ext.util.Format.number(value, '0.00');
                        }
                    };
                    if (i == 0 && groupSize > 1) {
                        delete columnSpec.summaryType;
                        delete columnSpec.summaryRenderer;
                        columnSpec.width = 150;
                        columnSpec.renderer = groupColumnRenderer;
                    }
                    columns.push(columnSpec);
                }

                simlet.numRecords = rowCount;
                store = createStore(numFields, buffered, groupSize);

                store.pageSize = controls.down('#pageSize').getValue();
                store.trailingBufferZone = controls.down('#storeTrailingBufferZone').getValue();
                store.leadingBufferZone = controls.down('#storeLeadingBufferZone').getValue();
                store.data.maxSize = store.purgePageCount = controls.down('#purgePageCount').getValue();

                grid = createGrid({
                    title: 'Random data (' + simlet.numRecords + ' records)',
                    store: store,
                    columns: columns,
                    numFromEdge: controls.down('#scrollerNumFromEdge').getValue(),
                    trailingBufferZone: controls.down('#scrollerTrailingBufferZone').getValue(),
                    leadingBufferZone: controls.down('#scrollerLeadingBufferZone').getValue()
                });

                Ext.ux.ajax.SimManager.delay = controls.down('#latency').getValue();

                App.Center.add(grid);

                if (buffered) {
                    // Load the first page. It will be diverted through the prefetch buffer.
                    store.loadPage(1);
                } else {
                    store.load({
                        limit: rowCount
                    });
                }
                //Ext.resumeLayouts(true);
            }
        </script>
    </HtmlBin>
</ext:FormPanel>
