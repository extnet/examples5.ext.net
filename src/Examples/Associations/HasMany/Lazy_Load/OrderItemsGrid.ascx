<%@ Control Language="C#" %>

<ext:GridPanel runat="server">
    <ColumnModel>
        <Columns>
            <ext:Column runat="server" Text="Id" DataIndex="Id" />
            <ext:Column
                runat="server"
                Text="Product"
                DataIndex="Product"
                Flex="1"
                />
            <ext:Column runat="server" Text="Quantity" DataIndex="Quantity" />
            <ext:Column runat="server" Text="Price" DataIndex="Price">
                <Renderer Format="UsMoney" />
            </ext:Column>
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
                <ext:Button ItemID="btnLoad" runat="server" Disabled="true" Text="Parent association loader" ToolTip="Demonstrate loading parent relationships - A new record will be created so we ignore any previous associations setup">
                    <Listeners>
                        <Click Fn="loadItemLoader" />
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

            var loadItemLoader = function () {
                var grid = this.up("gridpanel"),                    
                    rec = grid.active,
                    id = rec.getId();
        
                App.direct.RenderItemLoader(id, {
                    success : function () {
                        App.ItemLoaderWindow.orderItem = rec;
                    }
                });
            };    
        </script>
    </HtmlBin>
</ext:GridPanel>