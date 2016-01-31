<%@ Control Language="C#" %>

<ext:GridPanel runat="server">
    <ColumnModel>
        <Columns>
            <ext:Column runat="server" Text="Id" DataIndex="Id" />
            <ext:DateColumn runat="server" Text="Date" DataIndex="Date" Flex="1" Format="yyyy-MM-dd" />
        </Columns>
    </ColumnModel>
    <DockedItems>
        <ext:Toolbar runat="server">
            <Items>
                <ext:Button runat="server" Text="Back">
                    <Listeners>
                        <Click Fn="onBackClick" />
                    </Listeners>
                </ext:Button>
                <ext:Button ItemID="btnLoad" runat="server" Text="Load Order Items" Disabled="true">
                    <Listeners>
                        <Click Fn="loadItems" />
                    </Listeners>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </DockedItems>
    <Listeners>
        <SelectionChange Handler="this.active = selected[0]; this.down('#btnLoad').setDisabled(!this.active);" />
    </Listeners>
    <HtmlBin>
        <script>
            var onBackClick = function () {
                var grid = this.up("gridpanel");

                grid.ownerCt.getLayout().prev();
                grid.destroy();
            };

            var loadItems = function () {
                var grid = this.up("gridpanel"),
                    rec = grid.active,
                    owner = grid.ownerCt,
                    orderitems;

                orderitems = rec.orderItems();
                if (orderitems.isLoading()) {
                    Ext.net.Bus.publish('App.Log', { msg: 'Begin loading order items: ' + rec.getId(), isStart: true });
                }
                orderitems.on('load', function () {
                    Ext.net.Bus.publish('App.Log', { msg: 'Order items loaded - ' + rec.getId(), isStart: false });
                });

                App.direct.RenderOrderItems(rec.getId(), owner.id, {
                    success: function () {
                        owner.getComponent(owner.items.getCount() - 1).bindStore(orderitems);
                        owner.getLayout().next();
                    }
                });
            };
        </script>
    </HtmlBin>
</ext:GridPanel>
