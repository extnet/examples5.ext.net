<%@ Page Language="C#" %>

<script runat="server">
    protected void btnChild_Click(object sender, DirectEventArgs e)
    {
        this.Label2.Text = "Child [DirectEvent]: " + DateTime.Now.ToLongTimeString();
        X.Msg.Alert("DirectEvent", "Child Button Clicked").Show();
    }

    [DirectMethod]
    public void ButtonClickChild()
    {
        this.Label2.Text = "Child [DirectMethod]: " + DateTime.Now.ToLongTimeString();
        X.Msg.Alert("DirectMethod", "Child Button Clicked").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Child Page</title>
</head>
<body>
    <%--ResourceManager ID must be the same as in parent page--%>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RenderScripts="None" />

    <ext:Panel
        ID="Panel2"
        runat="server"
        Title="Child"
        Width="480"
        Height="270"
        Frame="true">
        <Items>
            <ext:Label ID="Label2" runat="server" />
        </Items>
        <Buttons>
            <ext:Button ID="btnChild" runat="server" Text="Submit [DirectEvent]">
                <DirectEvents>
                    <Click OnEvent="btnChild_Click" Url="Child.aspx" />
                </DirectEvents>
            </ext:Button>
            <ext:Button IDMode="Ignore" runat="server" Text="Submit [DirectMethod]">
                <Listeners>
                    <Click Handler="App.direct.ButtonClickChild({ url: 'Child.aspx' });" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Panel>
</body>
</html>
