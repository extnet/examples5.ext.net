<%@ Control Language="C#" %>

<script runat="server">
    public List<object> feeds = new List<object> 
    { 
        new {title = "Ext.NET Forums", url = "http://feeds.feedburner.com/ExtNetForums"},
        new {title = "Ext.NET Blog", url = "http://ext.net/feed"},
        new {title = "Bridge.NET Blog", url = "http://bridge.net/feed"}
    };

    protected void AddFeedClick(object sender, DirectEventArgs e)
    {
        UserControlRenderer.Render(new UserControlRendererConfig 
        { 
            UserControlPath = "uc/FeedWindow.ascx",
            SingleControl = true,
            Mode = RenderMode.RenderTo
        });
    }
</script>

<ext:Panel runat="server"
    Cls="feed-panel"
    AnimCollapse="true"
    Layout="FitLayout"
    Title="Feeds">
    <Bin>
        <ext:Menu runat="server">
            <Items>
                <ext:MenuItem runat="server" Text="Load feed" IconCls="feed-load">
                    <Listeners>
                        <Click Handler="FeedViewer.FeedPanel.loadFeed(this.up().activeFeed);" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Add feed" IconCls="feed-add">
                    <DirectEvents>
                        <Click OnEvent="AddFeedClick"/>
                    </DirectEvents>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Remove feed" IconCls="feed-remove">
                    <Listeners>
                        <Click Fn="FeedViewer.FeedPanel.removeFeed" />
                    </Listeners>
                </ext:MenuItem>
            </Items>
            <Listeners>
                <Hide Handler="this.activeFeed = null;" />
            </Listeners>
        </ext:Menu>
    </Bin>
    <TopBar>
        <ext:Toolbar runat="server">
            <Items>
                <ext:Button runat="server" Text="Add feed" IconCls="feed-add" OnDirectClick="AddFeedClick">
                </ext:Button>

                <ext:Button runat="server" ItemID="remove" Text="Remove feed" IconCls="feed-remove">
                    <Listeners>
                        <Click Fn="FeedViewer.FeedPanel.removeFeed" />
                    </Listeners>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </TopBar>
    <Items>        
        <ext:DataView runat="server" 
            SingleSelect="true"
            TrackOver="true"
            Cls="feed-list"
            ItemSelector=".feed-list-item"
            OverItemCls="feed-list-item-hover">
            <Store>
                <ext:Store runat="server" Data="<%# feeds %>" AutoDataBind="true">
                    <Model>
                        <ext:Model runat="server" Name="Feed">
                            <Fields>
                                <ext:ModelField Name="title" />
                                <ext:ModelField Name="url" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>

            <Tpl>
                <Html>
                    <tpl for=".">
                        <div class="feed-list-item">
                            {title}
                        </div>
                    </tpl>
                </html>            </Tpl>

            <Listeners>
                <SelectionChange Fn="FeedViewer.FeedPanel.onSelectionChange" />
                <ItemContextMenu Fn="FeedViewer.FeedPanel.onContextMenu" />
                <ViewReady Handler="Ext.suspendLayouts(); this.getSelectionModel().select(this.store.first()); Ext.resumeLayouts(true);" />
            </Listeners>
        </ext:DataView>
    </Items>
</ext:Panel>