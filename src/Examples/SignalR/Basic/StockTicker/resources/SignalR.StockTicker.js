/// <reference path="~/Scripts/jquery-3.1.1.js" />
/// <reference path="~/Scripts/jquery.signalR-2.2.2.js" />

Ext.define('ExtNetSignalRDemo.SignalRGridPanel', {
    extend : 'Ext.grid.Panel',
    alias  : 'widget.signalrgridpanel',

    // the SignalR generated client-side hub proxy
    ticker : $.connection.stockTicker,

    arrowUp     : '▲',
    arrowDown   : '▼',
    upBgColor   : '#55dd55',
    downBgColor : '#dd5555',

    initComponent: function (config) {
        this.callParent(config);

        this.on('afterrender', this.onAfterRender, null, { single: true });
    },

    open: function () {
        this.ticker.server.openMarket();
    },

    close: function () {
        this.ticker.server.closeMarket();
    },

    reset: function () {
        this.ticker.server.reset();
    },

    renderDirection: function (val, cell, data) {
        var isUp = data.data.Change >= 0,
            className = isUp ? 'up' : 'down';

        return data.data.Change === 0 ? '' : Ext.String.format('<span class="{0}">{1}</span>', className, (isUp ? this.arrowUp : this.arrowDown));
    },

    convertPercentChange: function (value) {
        return (value * 100).toFixed(2) + '%';
    },

    convertPrice: function (value) {
        return value.toFixed(2);
    },

    onAfterRender: function () {
        var gridInstance = this,
            store = gridInstance.getStore(),
            ticker = gridInstance.ticker;

        function init() {
            return ticker.server.getAllStocks().done(function (stocks) {
                $.each(stocks, function () {
                    store.load(stocks);
                });
            });
        }

        // Client-side hub methods that the server will call
        $.extend(ticker.client, {
            updateStockPrice: function (stock) {
                var rowIndexOfStockItem = store.indexOfId(stock.Symbol),
                    highlightRow = rowIndexOfStockItem,
                    row, el, bgColor;

                if (rowIndexOfStockItem === -1) {
                    store.loadData([stock], true);
                    highlightRow = store.getCount();
                } else {
                    store.getAt(rowIndexOfStockItem).set(stock);
                }

                row = gridInstance.getView().getNode(highlightRow);
                el = Ext.get(row);
                bgColor = stock.Change >= 0 ? gridInstance.upBgColor : gridInstance.downBgColor;

                if (el != null) {
                    el.highlight(bgColor, { attr: 'backgroundColor', duration: 750 });
                }
            },

            marketOpened: function () {
                gridInstance.down("#btnOpen").setDisabled(true);
                gridInstance.down("#btnClose").setDisabled(false);
                gridInstance.down("#btnReset").setDisabled(true);
            },

            marketClosed: function () {
                gridInstance.down("#btnOpen").setDisabled(false);
                gridInstance.down("#btnClose").setDisabled(true);
                gridInstance.down("#btnReset").setDisabled(false);
            },

            marketReset: function () {
                return init();
            }
        });

        // Start the connection
        $.connection.hub.start()
            .pipe(init)
            .pipe(function () {
                return ticker.server.getMarketState();
            })
            .done(function (state) {
                if (state === 'Open') {
                    ticker.client.marketOpened();
                } else {
                    ticker.client.marketClosed();
                }
            });
    }
});
