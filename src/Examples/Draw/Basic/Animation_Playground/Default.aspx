<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Animation playground - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />


        <ext:Viewport runat="server">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:Panel runat="server" Border="false" PreventHeader="true" Width="640" Height="480" Layout="Fit" BodyStyle="background:transparent;" ButtonAlign="Center">
                    <Items>
                        <ext:DrawContainer ID="Canvas" runat="server">
                            <Items>
                                <ext:RectSprite
                                    X="0"
                                    Y="0"
                                    FillStyle="#CECECE"
                                    Radius="10"
                                    Width="640"
                                    Height="480">
                                </ext:RectSprite>
                                <ext:CircleSprite
                                    SpriteID="circle"
                                    CX="320"
                                    CY="240"
                                    FillStyle="#000"
                                    Radius="60">
                                </ext:CircleSprite>
                            </Items>
                        </ext:DrawContainer>
                    </Items>
                    <FooterBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:TextField ID="toConfig" runat="server" Width="400" Text="{fill: '#223fa3', stroke: '#000', 'stroke-width': 80, 'stroke-opacity': 0.5}" />
                                <ext:NumberField
                                    ID="duration"
                                    runat="server"
                                    Number="2000"
                                    Width="70"
                                    />
                                <ext:Button runat="server" Text="Run">
                                    <Listeners>
                                        <Click Handler="
                                            try {
                                                #{Canvas}.getSurface().get('circle').setAttributes(Ext.apply(Ext.decode(#{toConfig}.getValue()), {duration: #{duration}.getValue()}));
                                                #{Canvas}.getSurface().renderFrame();
                                            } catch (e) {
                                                alert(e.message || e);
                                            }" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </FooterBar>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>