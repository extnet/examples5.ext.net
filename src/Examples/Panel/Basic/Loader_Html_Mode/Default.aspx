<%@ Page Language="C#" %>

<script runat="server">
    protected void btnParent_Click(object sender, DirectEventArgs e)
    {
        this.Label1.Text = "Parent [DirectEvent]: " + DateTime.Now.ToLongTimeString();
        X.Msg.Alert("DirectEvent", "Parent Button Clicked").Show();
    }

    [DirectMethod]
    public void ButtonClickParent()
    {
        this.Label1.Text = "Parent [DirectMethod]: " + DateTime.Now.ToLongTimeString();
        X.Msg.Alert("DirectMethod", "Parent Button Clicked").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
</head>
<body>
    <br />
    <b>An experimental example, it will not work in all cases.</b>
    <br />
    <br />

    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Panel
            runat="server"
            Title="Parent"
            Height="300"
            Width="500"
            BodyPadding="6">
            <Loader runat="server" Url="Child.aspx" Mode="Html" Scripts="true" />
            <Buttons>
                <ext:Button
                    ID="btnParent"
                    runat="server"
                    Text="Submit [DirectEvent]"
                    OnDirectClick="btnParent_Click"
                    />
                <ext:Button runat="server" Text="Submit [DirectMethod]">
                    <Listeners>
                        <Click Handler="App.direct.ButtonClickParent();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Panel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>
