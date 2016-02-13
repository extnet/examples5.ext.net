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

        <ext:HyperlinkButton runat="server" Icon="Accept" Text="Click">
            <DirectEvents>
                <Click OnEvent="Button_Click" />
            </DirectEvents>
        </ext:HyperlinkButton>

        <h2>HyperlinkButton with Right Aligned Icon</h2>

        <ext:HyperlinkButton runat="server" Icon="Accept" IconAlign="Right" Text="Click" />

        <h2>HyperlinkButton with Menu</h2>

        <ext:HyperlinkButton runat="server" Icon="Accept" Text="Click">
            <Menu>
                <ext:Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Add" Icon="Add" />
                        <ext:MenuItem runat="server" Text="Remove" Icon="Delete" />
                    </Items>
                </ext:Menu>
            </Menu>
        </ext:HyperlinkButton>

        <h2>HyperlinkButton in a ToggleGroup</h2>

        <ext:HyperlinkButton runat="server" Icon="GroupAdd" Text="Add group" ToggleGroup="Group1" />&nbsp;&nbsp;
        <ext:HyperlinkButton runat="server" Icon="GroupDelete" Text="Delete group" ToggleGroup="Group1" />&nbsp;&nbsp;
        <ext:HyperlinkButton runat="server" Icon="GroupEdit" Text="Edit group" ToggleGroup="Group1" />
    </form>
</body>
</html>