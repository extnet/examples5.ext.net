<%@ Page Language="C#" %>

<script runat="server">
    protected void btnLogin_Click(object sender, DirectEventArgs e)
    {
        this.Window1.Hide();

        string template = "<br /><b>LOGIN SUCCESS</b><br /><br />Username: {0}<br />Password: {1}";
        string username = this.txtUsername.Text;
        string password = this.txtPassword.Text;
        this.lblMessage.Html = string.Format(template, username, password);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple Login Form with Ajax Submit - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Simple Login Form with Ajax Submit</h1>

        <ext:Button
            ID="Button1"
            runat="server"
            Text="Logout"
            IconCls="x-md md-icon-lock-open">
            <Listeners>
                <Click Handler="#{Window1}.show();" />
            </Listeners>
        </ext:Button>

        <ext:Label ID="lblMessage" runat="server" />

        <ext:Window
            ID="Window1"
            runat="server"
            Closable="false"
            Resizable="false"
            Height="180"
            IconCls="x-md md-icon-lock"
            Title="Login"
            Draggable="false"
            Width="360"
            Modal="true"
            BodyPadding="18"
            Layout="Form">
            <Items>
                <ext:TextField
                    ID="txtUsername"
                    runat="server"
                    FieldLabel="Username"
                    AllowBlank="false"
                    BlankText="Your username is required."
                    Text="Demo" />
                <ext:TextField
                    ID="txtPassword"
                    runat="server"
                    InputType="Password"
                    FieldLabel="Password"
                    AllowBlank="false"
                    BlankText="Your password is required."
                    Text="Demo" />
            </Items>
            <Buttons>
                <ext:Button ID="btnLogin" runat="server" Text="Login" IconCls="x-md md-icon-check-circle-outline">
                    <Listeners>
                        <Click Handler="
                            if (!#{txtUsername}.validate() || !#{txtPassword}.validate()) {
                                Ext.Msg.alert('Error','The Username and Password fields are both required');
                                // return false to prevent the btnLogin_Click Ajax Click event from firing.
                                return false;
                            }" />
                    </Listeners>
                    <DirectEvents>
                        <Click OnEvent="btnLogin_Click">
                            <EventMask ShowMask="true" Msg="Verifying..." MinDelay="500" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnCancel" runat="server" Text="Cancel" IconCls="x-md md-icon-cancel">
                    <Listeners>
                        <Click Handler="#{Window1}.hide();#{lblMessage}.setText('LOGIN CANCELED')" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>