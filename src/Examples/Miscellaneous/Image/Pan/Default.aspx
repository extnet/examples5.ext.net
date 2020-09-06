<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Pan Image - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            ID="Window1"
            runat="server"
            Title="The Universe Map"
            Icon="Map"
            Width="960"
            Height="600"
            Shadow="false"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Scroll to Top Left">
                            <Listeners>
                                <Click Handler="#{Image1}.scrollTo(0,0);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="Scroll to Bottom Right">
                            <Listeners>
                                <Click Handler="#{Image1}.scrollTo(#{Image1}.getOriginalSize().width, #{Image1}.getOriginalSize().height);" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Label ID="LabelStatus" runat="server" Text="Status: " Width="100" />
                        <ext:ProgressBar ID="Progress1" runat="server" Width="200">
                            <Listeners>
                                <AfterRender Handler="this.wait({interval: 200, increment: 15, text: 'Loading...'});" />
                            </Listeners>
                        </ext:ProgressBar>
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <BottomBar>
                <ext:StatusBar ID="DeltaStatus" runat="server" />
            </BottomBar>

            <Items>
                <ext:Image
                    ID="Image1"
                    runat="server"
                    AllowPan="true"
                    XDelta="-4555"
                    YDelta="-3286"
                    ImageUrl="../Shared/TheUniverseMap.jpg">
                    <Listeners>
                        <Complete Handler="#{Progress1}.reset(true);#{LabelStatus}.setText('Status: Loaded');" />
                        <Pan Handler="#{DeltaStatus}.setStatus({text: 'X: '+x+'  Y: '+y});" Buffer="100" />
                    </Listeners>
                </ext:Image>
            </Items>
        </ext:Window>
    </form>
</body>
</html>