<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        // Do some Authentication...
        if (e.ExtraParams["user"] != "Ext.NET" || e.ExtraParams["pass"] != "extnet")
        {
            e.Success = false;
            e.ErrorMessage = "Invalid username or password.";
            return;
        }

        // Then redirect user to application
        Response.Redirect("../../../Desktop/Introduction/Overview/Desktop.aspx");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Login - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        // Invalidate the login fields with the given reason.
        var invalidateLogin = function (reason) {
            App.txtUsername.setValidation(reason);
            App.txtPassword.setValidation(reason);
            App.txtUsername.validate();
            App.txtPassword.validate();

            Ext.MessageBox.show({
                title: 'Authentication error',
                msg: reason,
                buttons: Ext.MessageBox.OK,
                animateTarget: 'Window1',
                icon: 'Error'
            });
        };
    </script>
</head>
<body>
    <form runat="server" target="submitTarget" method="post">
        <ext:ResourceManager runat="server" />

        <h1>Logging with browser saving functionality</h1>

        <p>The valid login/password combination here would be:</p>

        <p>
            Username: Ext.NET<br>
            Password: extnet
        </p>

        <p>On successful authentication, you will be redirected to the Desktop example.</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Closable="false"
            Resizable="false"
            Height="150"
            Icon="Lock"
            Title="Login"
            Draggable="true"
            Width="350"
            Modal="false"
            BodyPadding="5"
            Layout="Form">
            <Items>
                <ext:TextField
                    ID="txtUsername"
                    runat="server"
                    Name="username"
                    FieldLabel="Username"
                    AllowBlank="false"
                    BlankText="Your username is required.">
                    <CustomConfig>
                        <ext:ConfigItem
                            Name="inputAttrTpl"
                            Value="['autocomplete=&quot;on&quot;']"
                            Mode="Raw" />
                    </CustomConfig>
                </ext:TextField>

                <ext:TextField
                    ID="txtPassword"
                    runat="server"
                    Name="password"
                    InputType="Password"
                    FieldLabel="Password"
                    AllowBlank="false"
                    BlankText="Your password is required.">
                    <CustomConfig>
                        <ext:ConfigItem
                            Name="inputAttrTpl"
                            Value="['autocomplete=&quot;on&quot;']"
                            Mode="Raw" />
                    </CustomConfig>
                </ext:TextField>
                <ext:Component runat="server" Html="<iframe id='submitTarget' name='submitTarget' style='display:none'></iframe>" />
                <ext:Component runat="server" Html="<input type='submit' id='submitButton' style='display:none' />" />
            </Items>
            <Buttons>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Login"
                    Icon="Accept"
                    FormBind="true"
                    Handler="Ext.getElementById('submitButton').click();">
                    <DirectEvents>
                        <Click
                            OnEvent="Button1_Click"
                            Success="App.Window1.close();"
                            Failure="invalidateLogin(result.errorMessage);"
                            ShowWarningOnFailure="false">
                            <EventMask ShowMask="true" Msg="Verifying..." MinDelay="1000" />
                            <ExtraParams>
                                <ext:Parameter Name="user" Value="App.txtUsername.value" Mode="Raw" />
                                <ext:Parameter Name="pass" Value="App.txtPassword.value" Mode="Raw" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>