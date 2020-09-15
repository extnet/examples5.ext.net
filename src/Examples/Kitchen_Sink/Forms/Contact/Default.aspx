<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Contact Form - Ext.NET Examples</title>
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
                Title="Contact Us"
                Frame="true"
                Height="480"
                Width="400"
                Border="false"
                BodyPadding="18"
                DefaultAnchor="100%">
                <FieldDefaults
                    LabelAlign="Top"
                    LabelWidth="100"
                    LabelStyle="font-weight:bold;"
                    />
                <Defaults>
                    <ext:Parameter Name="margin" Value="0 0 10 0" Mode="Value" />
                </Defaults>
                <Items>
                    <ext:FieldContainer
                        runat="server"
                        FieldLabel="Your Name"
                        LabelStyle="font-weight:bold;padding:0;"
                        Layout="HBox">
                        <FieldDefaults LabelAlign="Top" />
                        <Items>
                            <ext:TextField
                                runat="server"
                                Name="firstName"
                                Flex="1"
                                FieldLabel="First"
                                AllowBlank="false"
                                />

                            <ext:TextField
                                runat="server"
                                Width="30"
                                Name="middleInitial"
                                FieldLabel="MI"
                                MarginSpec="0 0 0 5"
                                />

                            <ext:TextField
                                runat="server"
                                Flex="2"
                                Name="lastName"
                                FieldLabel="Last"
                                AllowBlank="false"
                                MarginSpec="0 0 0 5"
                                />
                        </Items>
                    </ext:FieldContainer>

                    <ext:TextField
                        runat="server"
                        FieldLabel="Your Email Address"
                        Vtype="email"
                        AllowBlank="false"
                        />

                    <ext:TextField runat="server" FieldLabel="Subject" AllowBlank="false" />

                    <ext:TextArea
                        runat="server"
                        FieldLabel="Message"
                        Flex="1"
                        MarginSpec="0"
                        AllowBlank="false"
                        />
                </Items>
                <Buttons>
                    <ext:Button runat="server" Text="Cancel" />
                    <ext:Button runat="server" Text="Send" />
                </Buttons>
            </ext:FormPanel>
        </Items>
    </ext:Viewport>
</body>
</html>