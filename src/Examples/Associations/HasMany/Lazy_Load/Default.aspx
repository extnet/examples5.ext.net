<%@ Page Language="C#" %>

<%@ Register Src="~/Examples/Associations/HasMany/Lazy_Load/Models.ascx" TagPrefix="uc" TagName="Models" %>

<script runat="server">
    [DirectMethod]
    public static void RenderOrders(int id, string containerId)
    {
        UserControlRendererConfig cfg = new UserControlRendererConfig
        {
            UserControlPath = "OrderGrid.ascx",
            Element = containerId,
            SingleControl=true,
            Mode = RenderMode.AddTo
        };

        cfg.BeforeRender += delegate(ComponentAddedEventArgs e)
        {
            GridPanel grid = ((GridPanel)e.Control);
            grid.Title = "Orders - " + id;
            grid.CustomConfig.Add(new ConfigItem("customerId", id.ToString()));
        };

        UserControlRenderer.Render(cfg);
    }

    [DirectMethod]
    public static void RenderOrderItems(int id, string containerId)
    {
        UserControlRendererConfig cfg = new UserControlRendererConfig
        {
            UserControlPath = "OrderItemsGrid.ascx",
            Element = containerId,
            SingleControl = true,
            Mode = RenderMode.AddTo
        };

        cfg.BeforeRender += delegate(ComponentAddedEventArgs e)
        {
            GridPanel grid = ((GridPanel)e.Control);
            grid.Title = "Order Items - " + id;
        };

        UserControlRenderer.Render(cfg);
    }

    [DirectMethod]
    public static void RenderItemLoader(int id)
    {
        UserControlRendererConfig cfg = new UserControlRendererConfig
        {
            UserControlPath = "ItemLoader.ascx",
            SingleControl = true
        };

        cfg.BeforeRender += delegate(ComponentAddedEventArgs e)
        {
            Window window = ((Window)e.Control);
            window.Title = "Order Item " + id;
        };

        UserControlRenderer.Render(cfg);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Lazy Loading Data Associations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Lazy Loading Data Associations</h1>

    <p>This example demonstrates the ability to lazy load associative data. For loading nested data in a single request, see the <a href="../Simple/">Simple</a> example.</p>

    <p>We look at a fictional company that sells furniture to their retail customers.</p>

    <p>Note that each time you navigate down to a new level a separate request is sent to retrieve the appropriate data.</p>

    <p>Once you reach the last level, we also demonstrate the ability to load back up the hierarchy. Note that this creates a new Model instance so no previous association data is present when we begin.</p>

    <uc:Models runat="server" />

    <ext:Panel
        runat="server"
        Width="700"
        Height="400"
        Border="false">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Items>
            <ext:Container
                runat="server"
                Height="200"
                Layout="Card"
                MarginSpec="0 0 5 0">
                <Items>
                    <ext:UserControlLoader runat="server" Path="CustomerGrid.ascx" />
                </Items>
            </ext:Container>

            <ext:UserControlLoader runat="server" Path="Logger.ascx" />
        </Items>
        <Listeners>
            <AfterLayout Handler="Ext.net.Bus.publish('App.Log', {msg:'Begin loading customer store', isStart: true});" Single="true" />
        </Listeners>
    </ext:Panel>
</body>
</html>