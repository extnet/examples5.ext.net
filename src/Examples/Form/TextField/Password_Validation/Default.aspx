<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Password Validation - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Password Validation</h1>

        <p>This example shows a password verification, the second value must be equivalent to the first to validate.</p>

        <ext:Window
            runat="server"
            Width="350"
            Title="Password Verification"
            Icon="Textfield"
            Closable="false"
            BodyPadding="5"
            Layout="Form">
            <Defaults>
                <ext:Parameter Name="LabelWidth" Value="125" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:TextField
                    ID="PasswordField"
                    runat="server"
                    FieldLabel="Password"
                    InputType="Password"
                    AllowBlank="false"
                    AnchorHorizontal="100%">
                        <Listeners>
                            <ValidityChange Handler="this.next().validate();" />
                            <Blur Handler="this.next().validate();" />
                        </Listeners>
                    </ext:TextField>
                <ext:TextField
                    runat="server"
                    Vtype="password"
                    FieldLabel="Confirm Password"
                    InputType="Password"
                    MsgTarget="Side"
                    AnchorHorizontal="100%">
                    <CustomConfig>
                        <ext:ConfigItem Name="initialPassField" Value="PasswordField" Mode="Value" />
                    </CustomConfig>
                </ext:TextField>
            </Items>
        </ext:Window>
   </form>
</body>
</html>
