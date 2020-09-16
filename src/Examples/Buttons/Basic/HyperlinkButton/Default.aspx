<%@ Page Language="C#" %>

<script runat="server">
    protected void Button_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Alert("Server Time", DateTime.Now.ToLongTimeString()).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HyperlinkButton Control Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>HyperlinkButton Control Variations</h1>

        <h2>Simple HyperlinkButton</h2>

        <ext:HyperlinkButton runat="server" Text="Click">
            <Listeners>
                <Click Handler="Ext.Msg.alert('Clicked', 'HyperlinkButton');" />
            </Listeners>
        </ext:HyperlinkButton>

        <h2>HyperlinkButton with Icon and Click DirectEvent</h2>

        <ext:HyperlinkButton runat="server" IconCls="x-md md-icon-check-circle-outline" Text="Click">
            <DirectEvents>
                <Click OnEvent="Button_Click" />
            </DirectEvents>
        </ext:HyperlinkButton>

        <h2>HyperlinkButton with Right Aligned Icon</h2>

        <ext:HyperlinkButton
            runat="server"
            IconCls="x-md md-icon-check-circle-outline"
            IconAlign="Right"
            Text="Click"
            />

        <h2>HyperlinkButton with Menu</h2>

        <ext:HyperlinkButton runat="server" IconCls="x-md md-icon-check-circle-outline" Text="Click">
            <Menu>
                <ext:Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Add" IconCls="x-md md-icon-add-circle-outline" />
                        <ext:MenuItem runat="server" Text="Remove" IconCls="x-md md-icon-remove-circle-outline" />
                    </Items>
                </ext:Menu>
            </Menu>
        </ext:HyperlinkButton>

        <h2>HyperlinkButton in a ToggleGroup</h2>

        <ext:HyperlinkButton
            runat="server"
            IconCls="x-md md-icon-add-circle-outline"
            Text="Add group"
            ToggleGroup="Group1"
            />&nbsp;&nbsp;
        <ext:HyperlinkButton
            runat="server"
            IconCls="x-md md-icon-remove-circle-outline"
            Text="Delete group"
            ToggleGroup="Group1"
            />&nbsp;&nbsp;
        <ext:HyperlinkButton
            runat="server"
            IconCls="x-md md-icon-edit"
            Text="Edit group"
            ToggleGroup="Group1"
            />
    </form>
</body>
</html>