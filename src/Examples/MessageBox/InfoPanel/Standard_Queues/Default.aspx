<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlUtils.FindControls<Ext.Net.Button>(this.Form).ForEach(item => {
                item.OnClientClick = "showInfo(this)";
                item.Flex = 1;
            });
        }
    }

    [DirectMethod]
    public void ShowInfo(string queue)
    {
        X.Msg.Info("Alignment", queue, (AnchorPoint)Enum.Parse(typeof(AnchorPoint), queue)).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Standard Alignment Queues - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script type="text/javascript">
        var showInfo = function (button) {
            App.direct.ShowInfo(button.text);
        };
    </script>
</head>
<body style="overflow: hidden;">
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            Title="Standard Alignment Queues"
            Layout="HBoxLayout"
            Width="500"
            Height="400"
            Closable="false">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch"  />
            </LayoutConfig>
            <Items>
                <ext:Container runat="server" Layout="VBoxLayout" Flex="1">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Flex="1" />
                        <ext:Button runat="server" Text="LeftTop" />
                        <ext:Button runat="server" Text="Left" />
                        <ext:Button runat="server" Text="LeftBottom" />
                        <ext:Container runat="server" Flex="1" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="VBoxLayout" Flex="1">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Button runat="server" Text="TopLeft" />
                        <ext:Container runat="server" Flex="3" />
                        <ext:Button runat="server" Text="BottomLeft" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="VBoxLayout" Flex="1">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Button runat="server" Text="Top" />
                        <ext:Container runat="server" Flex="1" />
                        <ext:Button runat="server" Text="Center" />
                        <ext:Container runat="server" Flex="1" />
                        <ext:Button runat="server" Text="Bottom" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="VBoxLayout" Flex="1">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Button runat="server" Text="TopRight" />
                        <ext:Container runat="server" Flex="3" />
                        <ext:Button runat="server" Text="BottomRight" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="VBoxLayout" Flex="1">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Flex="1" />
                        <ext:Button runat="server" Text="RightTop" />
                        <ext:Button runat="server" Text="Right" />
                        <ext:Button runat="server" Text="RightBottom" />
                        <ext:Container runat="server" Flex="1" />
                    </Items>
                </ext:Container>
            </Items>
        </ext:Window>
    </form>
</body>
</html>