<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            // Fixes some theme-specific settings
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

            switch (curTheme.Theme)
            {
                case Ext.Net.Theme.Aria:
                case Ext.Net.Theme.Crisp:
                case Ext.Net.Theme.CrispTouch:
                case Ext.Net.Theme.Classic:
                case Ext.Net.Theme.Gray:
                case Ext.Net.Theme.Neptune:
                case Ext.Net.Theme.NeptuneTouch:
                case Ext.Net.Theme.Triton:
                    break;
                case Ext.Net.Theme.Graphite:
                case Ext.Net.Theme.Material:
                    Window1.Height = 253;
                    break;
            }
        }
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        // Do some Authentication...

        // Then user send to application
        Response.Redirect("Desktop.aspx");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Desktop - Ext.NET Examples</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            ID="Window1"
            runat="server"
            Closable="false"
            Resizable="false"
            Height="200"
            Icon="Lock"
            Title="Login"
            Draggable="false"
            Width="350"
            Modal="true"
            BodyPadding="5"
            Layout="Form">
            <Items>
                <ext:TextField
                    ID="txtUsername"
                    runat="server"
                    ReadOnly="true"
                    FieldLabel="Username"
                    AllowBlank="false"
                    BlankText="Your username is required."
                    Text="Demo"
                    />
                <ext:TextField
                    ID="txtPassword"
                    runat="server"
                    ReadOnly="true"
                    InputType="Password"
                    FieldLabel="Password"
                    AllowBlank="false"
                    BlankText="Your password is required."
                    Text="Demo"
                    />
            </Items>
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="Login" Icon="Accept">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" Success="#{Window1}.close();">
                            <EventMask ShowMask="true" Msg="Verifying..." MinDelay="1000" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>