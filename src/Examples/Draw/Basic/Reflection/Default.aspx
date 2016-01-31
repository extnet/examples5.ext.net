<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Animation playground - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body style="background: white;">
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:DrawContainer runat="server" Width="320" Height="400">
                    <Items>
                        <ext:ImageSprite Src="bd.jpg" X="0" Y="0" Width="320" Height="240" />
                        <ext:ImageSprite Src="bd.jpg" X="0" Y="200" Width="320" Height="240" ScalingX="1" ScalingY="-0.7" Opacity="0.5" />
                        <ext:RectSprite X="0" Y="210" Width="320" Height="200" FillStyle="url(#reflectGrd)" />
                    </Items>
                    <Gradients>
                        <ext:LinearGradient GradientID="reflectGrd" Degrees="90">
                            <Stops>
                                <ext:GradientStop Offset="0.35" Color="white" />
                                <ext:GradientStop Offset="1.0" />
                            </Stops>
                        </ext:LinearGradient>
                    </Gradients>
                </ext:DrawContainer>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>