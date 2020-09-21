<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public void SendEmail()
    {
        string sendTo = this.Request["sendTo"];
        string subject = this.Request["subject"];
        string body = this.Request["body"];

        X.Msg.Alert("Email has been sent", string.Concat(
            "Send To: ", sendTo, "<br/>",
            "Subject: ", subject, "<br/>",
            "Body: ", body)).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Template Widget - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Template Widget</h1>

        <p>Please note that Content cannot be used inside template widget (if you are planning to create several instances) because the Content region cannot be clonned.</p>

        <ext:Button runat="server" Text="Send email (you can open several windows at one time)" Handler="App.getMessageWindow().show();" />

        <ext:Window
            runat="server"
            IDMode="Ignore"
            Title="Compose message"
            Collapsible="true"
            Maximizable="true"
            Width="640"
            Height="480"
            CloseAction="Destroy"
            Layout="Fit"
            Plain="true"
            BodyPadding="18"
            ButtonAlign="Center"
            TemplateWidget="true"
            TemplateWidgetFnName="getMessageWindow">
            <Items>
                <ext:FormPanel runat="server" BaseCls="x-plain" Layout="VBox">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:ComboBox
                            runat="server"
                            LabelWidth="55"
                            FieldLabel="Send To"
                            Name="sendTo">
                            <Items>
                                <ext:ListItem Text="test@example.com" />
                                <ext:ListItem Text="someone@example.com" />
                            </Items>
                        </ext:ComboBox>

                        <ext:TextField
                            runat="server"
                            LabelWidth="55"
                            FieldLabel="Subject"
                            Name="subject"
                            />
                        <ext:TextArea runat="server" Flex="1" Name="body" />
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Send" Handler="App.direct.SendEmail({formId : this.up('window').down('form').id});" />
                <ext:Button runat="server" Text="Cancel" Handler="this.up('window').close();" />
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>