Ext.ns("FeedViewer");

FeedViewer.FeedGrid = {
    formatDate: function (date) {
        if (!date) {
            return '';
        }

        var now = new Date(), d = Ext.Date.clearTime(now, true), notime = Ext.Date.clearTime(date, true).getTime();

        if (notime === d.getTime()) {
            return 'Today ' + Ext.Date.format(date, 'g:i a');
        }

        d = Ext.Date.add(d, 'd', -6);
        if (d.getTime() <= notime) {
            return Ext.Date.format(date, 'D g:i a');
        }
        return Ext.Date.format(date, 'Y/m/d g:i a');
    },

    loadFeed: function (grid, url) {
        var store = grid.store || grid;
        store.getProxy().setExtraParam('feed', url);
        store.load();
    }
};

FeedViewer.FeedDetail = {
    readingPaneChange: function (cycle, activeItem) {
        var detail = this.up('[cls=feed-detail]'),
            east = detail.down('[region=east]'),
            south = detail.down('[region=south]'),
            post = detail.down('[cls=preview]');
        switch (activeItem.text) {
            case 'Bottom':
                east.hide();
                south.show();
                south.add(post);
                break;
            case 'Right':
                south.hide();
                east.show();
                east.add(post);
                break;
            default:
                south.hide();
                east.hide();
                break;
        }
    },

    getRecordByTitle : function (title) {
        var grid = Ext.ComponentQuery.query("[cls=feed-detail]")[0].down("gridpanel");

        return grid.store.getAt(grid.store.find("title", title));
    }
};

FeedViewer.FeedPanel = {
    getPanel : function () {
        var me = FeedViewer.FeedPanel;
        if(!me._panel) {
            me._panel = Ext.ComponentQuery.query("[cls=feed-panel]")[0];
        }
        return me._panel;
    },

    getSelectedItem: function () {
        var me = FeedViewer.FeedPanel;
        return me.getPanel().down('dataview').getSelectionModel().getSelection()[0] || false;
    },

    onSelectionChange: function () {
        var me = FeedViewer.FeedPanel,
            selected = me.getSelectedItem();

        me.getPanel().down('#remove').setDisabled(!selected);
        me.loadFeed(selected);
    },

    onContextMenu: function (view, record, item, index, e) {
        var me = FeedViewer.FeedPanel,
            menu = me.getPanel().bin[0];

        e.stopEvent();
        menu.activeFeed = record;
        menu.showAt(e.getXY());
    },

    loadFeed: function (rec) {
        var me = FeedViewer.FeedPanel;
        if (rec) {
            var panel = me.getPanel();
            panel.fireEvent('feedselect', panel, rec.get('title'), rec.get('url'));
        }
    },

    addFeed: function (title, url) {
        var me = FeedViewer.FeedPanel,
            panel = me.getPanel(),
            view = panel.down("dataview"),
            store = view.store,
            rec;

        rec = store.add({
            url: url,
            title: title
        })[0];
    },

    removeFeed: function () {
        var me = FeedViewer.FeedPanel,
            panel = me.getPanel(),
            menu = panel.bin[0],
            view = panel.down("dataview"),
            active = menu.activeFeed || me.getSelectedItem();

        view.store.remove(active);
        delete menu.activeFeed;
    }
};

FeedViewer.FeedWindow = {
    onAddClick: function () {
        var form = this.up("window").down("form"),
            url = form.getComponent('feed').getValue();

        form.setLoading({
            msg: 'Validating feed...'
        });
        Ext.Ajax.request({
            url: 'FeedProxy.ashx',
            params: {
                feed: url
            },
            success: FeedViewer.FeedWindow.validateFeed,
            failure: FeedViewer.FeedWindow.markInvalid,
            scope: this
        });
    },

    validateFeed: function (response) {
        var wnd = this.up("window"),
            form = wnd.down("form");

        form.setLoading(false);
        
        var dq = Ext.DomQuery,
            url = form.getComponent('feed').getValue(),
            xml,
            channel,
            title;

        try {
            xml = response.responseXML;
            channel = xml.getElementsByTagName('channel')[0];
            if (channel) {
                title = dq.selectValue('title', channel, url);
                FeedViewer.FeedPanel.addFeed(title, url);
                wnd.destroy();
                return;
            }
        } catch(e) {
        }

        FeedViewer.FeedWindow.markInvalid.call(this);        
    },
    
    markInvalid: function () {
        var form = this.up("window").down("form");

        form.setLoading(false);
        form.getComponent('feed').markInvalid('The URL specified is not a valid RSS2 feed.');
    }
};

FeedViewer.FeedInfo = {
     getPanel : function () {
        var me = FeedViewer.FeedInfo;
        if(!me._panel) {
            me._panel = Ext.ComponentQuery.query("[cls=feed-info]")[0];
        }
        return me._panel;
    },

    addFeed: function (title, url) {
        var me = FeedViewer.FeedInfo,
            tab = me.getPanel(),
            active = tab.items.first();

        if (!active) {
            App.direct.FeedInfo.AddFeed(tab.id, title, url, {
                success : function () {
                    Ext.Function.defer(function () {
                        tab.setActiveTab(tab.items.first());
                    }, 1);
                }
            });

            return;
        } else {
            FeedViewer.FeedGrid.loadFeed(active.down("grid"), url);
            active.tab.setText(title);
        }
        tab.setActiveTab(active);
    },

    getTabByTitle: function (title) {
        var items = FeedViewer.FeedInfo.getPanel().items,
            index = items.findIndex('title', title);
        return (index < 0) ? null : items.getAt(index); 
    },

    tabOpen: function (rec) {
        var items = [],
            item,
            title,
            me = FeedViewer.FeedInfo,
            tab = me.getPanel();            

        Ext.each(rec, function (rec) {
            title = rec.get('title');
            if (!me.getTabByTitle(title)) {
                items.push(title);
            }
        }, me);

        App.direct.FeedInfo.OpenTab(tab.id, items, {
            success : function () {
                Ext.Function.defer(function () {
                    tab.setActiveTab(tab.items.last());
                }, 1);
            }
        });
        
            
         /*item = this.add({
                    inTab: true,
                    xtype: 'feedpost',
                    title: title,
                    closable: true,
                    data: rec.data,
                    active: rec
                });*/
    }
};

FeedViewer.FeedViewport = {
    onFeedSelect: function (feed, title, url) {
        FeedViewer.FeedInfo.addFeed(title, url);
    }
};