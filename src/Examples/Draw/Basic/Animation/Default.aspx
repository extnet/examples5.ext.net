<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Animation with a Draw Component - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void AnimateRect(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("rectangles").SetAttributes(new Sprite
            {
                Duration = 1000,
                TranslationX = 150
            });

            Draw1.RenderFrame();
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <h1>Animation with a Draw Component</h1>

        <ext:Button runat="server" Text="Animate circles (client side)">
            <Listeners>
                <Click Handler="#{Draw1}.getSurface().get('circles').setAttributes({translationX: 150}); #{Draw1}.getSurface().renderFrame();" />
            </Listeners>
        </ext:Button>

        <ext:Button runat="server" Text="Animate rectangles (server side)" OnDirectClick="AnimateRect" />

        <br />

        <ext:DrawContainer ID="Draw1" runat="server"
            Width="960"
            Height="600">
            <Items>
                <ext:CompositeSprite SpriteID="circles" Duration="1000">
                    <Items>
                        <ext:CircleSprite Radius="10" FillStyle="#f00" CX="10" CY="10" />
                        <ext:CircleSprite Radius="10" FillStyle="#0f0" CX="50" CY="50" />
                        <ext:CircleSprite Radius="10" FillStyle="#00f" CX="100" CY="100" />
                    </Items>
                </ext:CompositeSprite>

                <ext:CompositeSprite SpriteID="rectangles">
                    <Items>
                        <ext:RectSprite Width="20" Height="20" FillStyle="#f00" X="10" Y="10" />
                        <ext:RectSprite Width="20" Height="20" FillStyle="#0f0" X="50" Y="50" />
                        <ext:RectSprite Width="20" Height="20" FillStyle="#00f" X="100" Y="100" />
                    </Items>
                </ext:CompositeSprite>
            </Items>
        </ext:DrawContainer>
    </form>
</body>
</html>