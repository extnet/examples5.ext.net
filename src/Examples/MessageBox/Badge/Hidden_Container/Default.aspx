<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Badge - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <p>If Badge's component is located inside hidden area (or will be located) then it is required to set
        RenderToBody="false" for Badge because Badge doesn't track visibility of parent elements</p>

    <ext:Window
        runat="server"
        Width="480"
        Height="480"
        Layout="Fit">
        <Items>
            <ext:TabPanel runat="server" >
                <Items>
                    <ext:Panel runat="server" Title="Tab 1" BodyPadding="18">
                        <Items>
                            <ext:Button runat="server" Text="Button in Tab1">
                                <Plugins>
                                    <ext:Badge
                                        runat="server"
                                        Text="Tab1"
                                        Scale="Medium"
                                        RenderToBody="false"
                                        />
                                </Plugins>
                            </ext:Button>
                        </Items>
                    </ext:Panel>

                    <ext:Panel runat="server" Title="Tab 2" BodyPadding="18">
                        <Items>
                            <ext:Button runat="server" Text="----------Button in Tab2">
                                <Plugins>
                                    <ext:Badge
                                        runat="server"
                                        Text="Tab2"
                                        Scale="Medium"
                                        RenderToBody="false"
                                        />
                                </Plugins>
                            </ext:Button>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:TabPanel>
        </Items>
    </ext:Window>
</body>
</html>