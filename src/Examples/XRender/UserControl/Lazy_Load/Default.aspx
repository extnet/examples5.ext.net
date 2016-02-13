<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>
<%@ Import Namespace="Ext.Net.Examples"%>

<script runat="server">
    protected void LoadRegion(object sender, DirectEventArgs e)
    {
        Ext.Net.Panel panel = (Ext.Net.Panel)sender;

        UserControlRendererConfig cfg = new UserControlRendererConfig
        {
            UserControlPath = "RegionUserControl.ascx",
            SingleControl = true,
            Mode = RenderMode.AddTo,
            Element = panel.ClientID
        };

        cfg.BeforeRender += delegate(ComponentAddedEventArgs eCmp)
        {
            Ext.Net.Label label = Ext.Net.Utilities.ControlUtils.FindControl<Ext.Net.Label>(eCmp.Control);
            label.Text = panel.Region.ToString();
        };

        UserControlRenderer.Render(cfg);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Lazy Load of UserControl - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server"
                    Region="North"
                    Height="200"
                    Title="North"
                    Layout="FitLayout"
                    Floatable="false"
                    Collapsed="true"
                    Collapsible="true">
                    <DirectEvents>
                        <Expand OnEvent="LoadRegion" Single="true">
                            <EventMask ShowMask="true" Target="Body" />
                        </Expand>
                    </DirectEvents>
                </ext:Panel>

                <ext:Panel runat="server"
                    Region="South"
                    Height="200"
                    Title="South"
                    Floatable="false"
                    Layout="FitLayout"
                    Collapsed="true"
                    Collapsible="true">
                    <DirectEvents>
                        <Expand OnEvent="LoadRegion" Single="true">
                            <EventMask ShowMask="true" Target="Body" />
                        </Expand>
                    </DirectEvents>
                </ext:Panel>

                <ext:Panel runat="server"
                    Region="West"
                    Width="200"
                    Title="West"
                    Floatable="false"
                    Layout="FitLayout"
                    Collapsed="true"
                    Collapsible="true">
                    <DirectEvents>
                        <Expand OnEvent="LoadRegion" Single="true">
                            <EventMask ShowMask="true" Target="Body" />
                        </Expand>
                    </DirectEvents>
                </ext:Panel>

                <ext:Panel runat="server"
                    Region="East"
                    Width="200"
                    Title="East"
                    Floatable="false"
                    Layout="FitLayout"
                    Collapsed="true"
                    Collapsible="true">
                    <DirectEvents>
                        <Expand OnEvent="LoadRegion" Single="true">
                            <EventMask ShowMask="true" Target="Body" />
                        </Expand>
                    </DirectEvents>
                </ext:Panel>

                <ext:Container runat="server" Region="Center" StyleSpec="padding:20px">
                    <Content>
                        <h1>Lazy Load of UserControl</h1>
                        <p>Load regions children controls after first expand</p>
                    </Content>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>