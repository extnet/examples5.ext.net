<%@ Page Language="C#" %>

<script runat="server">
    protected void FeedPanelAdded(object sender, ComponentAddedEventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            return;
        }

        Ext.Net.Panel panel = (Ext.Net.Panel)e.Control;
        panel.Region = Region.West;
        panel.Collapsible = true;
        panel.Width = 225;
        panel.Split = true;
        panel.MinWidth = 175;

        panel.Listeners.Render.Handler = "this.on('feedselect', FeedViewer.FeedViewport.onFeedSelect);";
    }

    protected void FeedInfoAdded(object sender, ComponentAddedEventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            return;
        }

        TabPanel tab = (TabPanel)e.Control;
        tab.Region = Region.Center;
        tab.MinWidth = 300;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FeedViewer - Ext.NET Examples</title>

    <link href="resources/FeedViewer.css" rel="stylesheet" />

    <script src="resources/FeedViewer.js"></script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" InitScriptMode="Inline" Locale="en-US">
          <%--  <Listeners>
                <BeforeAjaxRequest Handler="Ext.fly('direct_indicator').removeCls('x-hidden');" Delay="1" />
                <AjaxRequestComplete Handler="Ext.fly('direct_indicator').addCls('x-hidden');" />
                <AjaxRequestException Handler="Ext.fly('direct_indicator').addCls('x-hidden');
                                               Ext.Msg.alert('Error', result.errorMessage);" />
            </Listeners>--%>
        </ext:ResourceManager>

        <ext:Viewport runat="server">
            <LayoutConfig>
                <ext:BorderLayoutConfig Padding="5" />
            </LayoutConfig>

            <Items>
                <ext:UserControlLoader runat="server" Path="uc/FeedPanel.ascx" OnComponentAdded="FeedPanelAdded" />
                <ext:UserControlLoader runat="server" Path="uc/FeedInfo.ascx" OnComponentAdded="FeedInfoAdded" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>