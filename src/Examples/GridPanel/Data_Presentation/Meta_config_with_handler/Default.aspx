<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Meta config with handler - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Basic Meta Configuration</h1>

        <p>This example demonstrates reconfiguring a grid dynamically based on the metadata returned by the server.<br>
        Click the "Load Metadata 1" or "Load Metadata 2" buttons to see a new randomized column set and data in the grid.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Meta Grid"
            Width="960"
            Height="480">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server" Name="MetaModel" />
                    </Model>
                    <Proxy>
                        <ext:AjaxProxy Url="GetData.ashx">
                            <Reader>
                                <ext:JsonReader RootProperty="data" />
                            </Reader>
                        </ext:AjaxProxy>
                    </Proxy>
                    <Listeners>
                        <MetaChange Handler="#{GridPanel1}.reconfigure(null, meta.columns);" />
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" />
                </Columns>
            </ColumnModel>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Load Metadata 1" Handler="#{GridPanel1}.store.load({params: {meta: 1}});" />
                        <ext:Button runat="server" Text="Load Metadata 2" Handler="#{GridPanel1}.store.load({params: {meta: 2}});" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>

    <p style="margin-top:30px;">The server response is in this format:</p>
    <pre><code>{
  data: [{ ... }],
  msg: "...",
  total: 99,
  metaData: {
    fields: [{ ... }],
    columns: [{ ... }],
    idProperty: "id",
    messageProperty: "msg",
    root: "data"
  }
}
    </code></pre>
    <p>The store/model automatically read the <code>fields</code> config to reconfigure the data model, but you can add any
    additional custom data into the <code>metaData</code> that you need. In this example we've added a <code>columns</code>
    config that contains a grid-specific column configuration that can be passed to the <code>grid.reconfigure()</code> method
    in the store's load event handler. You could easily add other widget-specific configurations into the response as well.</p>

    </form>
</body>
</html>