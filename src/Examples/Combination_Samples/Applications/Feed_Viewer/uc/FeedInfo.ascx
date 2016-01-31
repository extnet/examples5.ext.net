<%@ Control Language="C#" %>

<script runat="server">
    [DirectMethod(IDAlias = "FeedInfo", ShowMask = true)]
    public void AddFeed(string container, string title, string url)
    {
        UserControlRendererConfig config = new UserControlRendererConfig
        {
            UserControlPath = "uc/FeedDetail.ascx",
            SingleControl = true,
            Mode = RenderMode.AddTo,
            Element = container
        };
        
        config.BeforeRender += delegate(ComponentAddedEventArgs e)
        {
            Ext.Net.Panel panel = (Ext.Net.Panel)e.Control;
            panel.Title = title;
            panel.Closable = false;
            panel.CustomConfig.Add(new ConfigItem("url", url, ParameterMode.Value));
        };
        
        UserControlRenderer.Render(config);
    }

    [DirectMethod(IDAlias = "FeedInfo", ShowMask = true)]
    public void OpenTab(string container, string[] titles)
    {
        foreach (string title in titles)
        {
            UserControlRendererConfig config = new UserControlRendererConfig
            {
                UserControlPath = "uc/FeedPost.ascx",
                SingleControl = true,
                Mode = RenderMode.AddTo,
                Element = container
            };

            config.BeforeRender += delegate(ComponentAddedEventArgs e)
            {
                Ext.Net.Panel panel = (Ext.Net.Panel)e.Control;
                panel.Title = title;
                panel.Closable = true;
                
                panel.CustomConfig.Add(new ConfigItem("active", "FeedViewer.FeedDetail.getRecordByTitle('"+title+"')", ParameterMode.Raw));
                panel.CustomConfig.Add(new ConfigItem("data", "FeedViewer.FeedDetail.getRecordByTitle('" + title + "').data", ParameterMode.Raw));

                Toolbar toolbar = (Toolbar)panel.DockedItems[0];
                
                toolbar.Items[0].Visible = false;
                toolbar.Items[0].Visible = false;
                toolbar.Cls = "x-docked-noborder-top";
            };

            UserControlRenderer.Render(config);
        }
    }
</script>

<ext:TabPanel runat="server"
    MaxTabWidth="230"
    Cls="feed-info"
    Border="false">

</ext:TabPanel>