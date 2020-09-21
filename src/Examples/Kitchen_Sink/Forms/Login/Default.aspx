<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Login Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:FormPanel
                runat="server"
                Title="Login"
                Width="480"
                Frame="true"
                BodyPadding="18"
                DefaultAnchor="100%">
                <Items>
                    <ext:TextField
                        runat="server"
                        AllowBlank="false"
                        FieldLabel="User ID"
                        Name="user"
                        EmptyText="user id"
                        />

                    <ext:TextField
                        runat="server"
                        AllowBlank="false"
                        FieldLabel="Password"
                        Name="pass"
                        EmptyText="password"
                        InputType="Password"
                        />

                    <ext:Checkbox runat="server" FieldLabel="Remember me" Name="remember" />
                </Items>
                <Buttons>
                    <ext:Button runat="server" Text="Register" />
                    <ext:Button runat="server" Text="Login" />
                </Buttons>
            </ext:FormPanel>
        </Items>
    </ext:Viewport>
</body>
</html>