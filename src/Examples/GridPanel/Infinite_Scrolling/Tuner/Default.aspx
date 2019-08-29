<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling Tuner - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script src="ajax/SimXhr.js"></script>
    <script src="ajax/Simlet.js"></script>
    <script src="ajax/DataSimlet.js"></script>
    <script src="ajax/JsonSimlet.js"></script>
    <script src="ajax/SimManager.js"></script>

    <script>
        Ext.define('BigDataSimlet', {
            extend: 'Ext.ux.ajax.JsonSimlet',

            data: [],
            numFields: 10,
            numRecords: 50 * 1000,
            groupSize: 1,

            getData: function (ctx) {
                var me = this,
                    data = me.data,
                    groupSize = ctx.params.groupSize || 1,
                    group;

                if (data.length != me.numRecords || me.lastNumColumns != me.numFields || groupSize !== me.groupSize) {
                    me.currentOrder = null;
                    me.lastNumColumns = me.numFields;
                    me.groupSize = groupSize;

                    data.length = 0;
                    for (var r = 0, k = me.numRecords; r < k; r++) {
                        group = Math.floor((r + groupSize) / groupSize);
                        var rec = {
                            id: 'rec-' + r
                        };
                        for (var i = 0; i < me.numFields; i++) {
                            if (groupSize > 1 && i === 0) {
                                rec['field' + i] = group;
                            } else {
                                rec['field' + i] = r;
                            }
                        }
                        data.push(rec);
                    }
                }

                return this.callParent(arguments);
            }
        });

        Ext.define('StoreInfo', {
            override: 'Ext.data.Store',
            prefetch: function (options) {
                var page = options.page;

                if (!this.pageCached(page) && !this.pagePending(page)) {
                    App.LogPanel.log('Prefetch rows ' + options.getStart() + '-' + (options.getStart() + options.getLimit()));
                }
                this.callParent(arguments);
            },

            onProxyPrefetch: function (operation) {
                this.callParent(arguments);
                App.LogPanel.log('Prefetch returned ' + operation.getStart() + '-' + (operation.getStart() + operation.getLimit()));
            }
        });

        Ext.define('BufferInfo', {
            override: 'Ext.grid.plugin.BufferedRenderer',

            setBodyTop: function (bodyTop) {
                this.callParent(arguments);
                App.LogPanel.log('Table moved to top: ' + bodyTop);
            }
        });

        var simlet = new BigDataSimlet(),
            center,
            storeCount = 0,
            summaryTypes = ['count', 'min', 'max', 'sum', 'average'],
            summaryTypeNames = ['count', 'min', 'max', 'sum', 'avg'];

        Ext.ux.ajax.SimManager.init({
            delay: 300
        }).register({
            localAjaxSimulator: simlet
        });

        function toggleLogging(btn, pressed) {
            var logPanel = btn.up('panel');
            if (pressed) {
                btn.setText('Logging on');
                logPanel.disabled = false;
            } else {
                btn.setText('Logging off');
                logPanel.disabled = true;
            }
        }

        function scrollTopToBottom(b, maxScroll) {
            var view = App.TestGrid.view,
                logPanel = App.LogPanel,
                el = view.el,
                br = view.bufferedRenderer,
                oldSynchronousRender = br.oldSynchronousRender,
                scrollQuantum = 30,
                start = new Date().getTime(),
                nextScroll = function () {
                    el.dom.scrollTop += scrollQuantum;
                    var newPos = el.dom.scrollTop;

                    // At min scroll - we're done
                    if (newPos >= maxScroll) {
                        delete br.handleViewScroll;
                        logPanel.disabled = false;
                        br.synchronousRender = oldSynchronousRender;
                        logPanel.log('Scroll took ' + (new Date().getTime() - start) + ' ms');
                        b.setText(b.initialConfig.text);
                    }
                };

            // Set up the onRange fetched to immediately scroll more
            logPanel.disabled = true;
            br.synchronousRender = true;
            br.handleViewScroll = Ext.Function.createSequence(br.handleViewScroll, nextScroll);
            nextScroll();
        }

        function scrollBottomToTop(b) {
            var view = App.TestGrid.view,
                logPanel = App.LogPanel,
                el = view.el,
                br = view.bufferedRenderer,
                oldSynchronousRender = br.oldSynchronousRender,
                scrollQuantum = 30,
                start = new Date().getTime(),
                nextScroll = function () {
                    var newPos = el.dom.scrollTop - scrollQuantum;
                    el.dom.scrollTop = newPos;

                    // At min scroll - we're done
                    if (newPos <= 0) {
                        delete br.handleViewScroll;
                        logPanel.disabled = false;
                        br.synchronousRender = oldSynchronousRender;
                        logPanel.log('Scroll took ' + (new Date().getTime() - start) + ' ms');
                        b.setText(b.initialConfig.text);
                    }
                };

            // Set up the onRange fetched to immediately scroll more
            logPanel.disabled = true;
            br.synchronousRender = true;
            br.handleViewScroll = Ext.Function.createSequence(br.handleViewScroll, nextScroll);
            nextScroll();
        }

        function scrollTopToBottomHandler(b) {
            var v = App.TestGrid.view;
            if (v.bufferedRenderer.hasOwnProperty('handleViewScroll')) {
                delete v.bufferedRenderer.handleViewScroll;
                b.setText(b.initialConfig.text);
            } else {
                b.setText('Stop scroll');
                v.el.dom.scrollTop = 0;
                Ext.defer(scrollTopToBottom, this.up('netviewport').down('#latency').getValue() + 200, null, [b, v.el.dom.scrollHeight - v.el.dom.clientHeight]);
            }
        }

        function scrollBottomToTopHandler(scrollButton) {
            var v = App.TestGrid.view,
                el = v.el;

            if (v.bufferedRenderer.hasOwnProperty('handleViewScroll')) {
                delete v.bufferedRenderer.handleViewScroll;
                scrollButton.setText(scrollButton.initialConfig.text);
            } else {
                scrollButton.setText('Stop scroll');
                v.el.dom.scrollTop = el.dom.scrollHeight;
                Ext.defer(scrollBottomToTop, this.up('netviewport').down('#latency').getValue() + 200, null, [scrollButton, el.dom.scrollHeight - el.dom.clientHeight]);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Handler="initializeGrid(App.ReloadButton);" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Viewport runat="server">
            <LayoutConfig>
                <ext:BorderLayoutConfig Padding="5" />
            </LayoutConfig>

            <Items>
                <ext:Panel
                    runat="server"
                    Region="West"
                    Title="Configuration"
                    Border="false"
                    BodyBorder="0"
                    Collapsible="true"
                    Split="true"
                    Width="375"
                    MinWidth="290"
                    Layout="BorderLayout">
                    <Items>
                        <ext:UserControlLoader runat="server" Path="Controls.ascx" />

                        <ext:Panel
                            ID="LogPanel"
                            runat="server"
                            Title="Log"
                            Region="Center"
                            Scrollable="Both">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Logging on"
                                            Pressed="true"
                                            EnableToggle="true"
                                            ToggleHandler="toggleLogging" />

                                        <ext:Button
                                            runat="server"
                                            Text="Clear"
                                            Handler="function(){ this.up('panel').body.update(''); }" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>

                            <CustomConfig>
                                <ext:ConfigItem
                                    Name="log"
                                    Value="function (m) { if (this.rendered && !this.disabled) { this.body.createChild({html: m}); this.body.dom.scrollTop = 1000000; }}"
                                    Mode="Raw" />
                            </CustomConfig>
                        </ext:Panel>
                    </Items>
                    <Listeners>
                        <Render Handler="Ext.on('idle', function() {item.header.removeCls('x-docked-noborder-left x-docked-noborder-right x-docked-noborder-top'); item.updateLayout({isRoot:true});  }, null, {single: true});" Single="true" />
                        <Collapse Handler="App.LogPanel.wasDisabled = App.LogPanel.disabled; App.LogPanel.disabled = true;" />
                        <Expand Handler="App.LogPanel.disabled = App.LogPanel.wasDisabled;" />
                    </Listeners>
                </ext:Panel>

                <ext:Panel runat="server"
                    ID="Center"
                    Region="Center"
                    Layout="FitLayout">
                    <Items>
                        <ext:GridPanel
                            ID="TestGrid"
                            runat="server"
                            Border="false"
                            ColumnLines="true"
                            Title="Random data (50000 records)">
                            <Store>
                                <ext:Store runat="server" Buffered="true">
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="dummy" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                    <ext:RowNumbererColumn runat="server" Width="50" Sortable="false" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel runat="server" PruneRemoved="false" Mode="Multi" />
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                    <BottomBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server"
                                    Text="Scroll top to bottom"
                                    Handler="scrollTopToBottomHandler"
                                    ToolTip="Time a full scroll of the grid from top to bottom"
                                    StandOut="true" />

                                <ext:Button runat="server"
                                    Text="Scroll bottom to top"
                                    Handler="scrollBottomToTopHandler"
                                    ToolTip="Time a full scroll of the grid bottom to top"
                                    StandOut="true" />

                                <ext:NumberField runat="server"
                                    ItemID="groupSize"
                                    FieldLabel="Group size"
                                    MinValue="0"
                                    MaxValue="10000"
                                    Width="140"
                                    LabelWidth="70"
                                    MarginSpec="0 0 0 10" />
                            </Items>
                        </ext:Toolbar>
                    </BottomBar>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
