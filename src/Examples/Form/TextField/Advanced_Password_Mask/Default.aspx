<%@ Page Language="C#" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Advanced Password Mask - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Advanced Password Mask</h1>

        <p>PasswordMask allows :</p>
        <ul>
            <li>Generate a strong password by pattern</li>
            <li>Calculate strength of the entered password and mark the field as invalid if the strength is not enough</li>
            <li>Check that the password is not in the black list (for passwords like "qwerty")</li>
            <li>Show/Hide password</li>
            <li>Check that password doesn't equal the login</li>
        </ul>

        <ext:Window
            runat="server"
            Width="400"
            Title="Password Mask"
            Closable="false"
            BodyPadding="5"
            Layout="AnchorLayout"
            DefaultAnchor="100%">
            <Items>
               <ext:TextField
                    ID="txtUsername"
                    runat="server"
                    FieldLabel="Username"
                    AllowBlank="false"
                    BlankText="Your username is required."
                    />

                <ext:TextField
                    ID="txtPassword"
                    runat="server"
                    FieldLabel="Password"
                    AllowBlank="false"
                    RemoveClearTrigger="true"
                    BlankText="Your password is required."
                    RightButtonsShowMode="MouseOverOrFocus"
                    MsgTarget="Under">
                    <RightButtons>
                        <ext:Button runat="server"
                            Icon="ArrowSwitch"
                            ToolTip="Generate password"
                            Handler="this.up('textfield').passwordMask.generatePassword(); #{PassMode}.toggle(true, true);" />

                        <ext:Button runat="server"
                            ID="PassMode"
                            Icon="TextAb"
                            AllowDepress="true"
                            EnableToggle="true"
                            ToolTip="Show password">
                            <Listeners>
                                <Toggle Handler="this.up('textfield').passwordMask.setMode(pressed ? 'showall' : 'hideall'); this.setTooltip((pressed ? 'Hide' : 'Show') + ' password');" />
                            </Listeners>
                        </ext:Button>
                    </RightButtons>
                    <Plugins>
                        <ext:PasswordMask runat="server" LoginField="#{txtUsername}" Mode="HideAll" />
                    </Plugins>
                </ext:TextField>
            </Items>
        </ext:Window>
   </form>
</body>
</html>
