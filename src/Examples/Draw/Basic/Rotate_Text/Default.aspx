<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Rotate Text - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <ext:XScript runat="server">
        <script>
            var handleSliderChange = function (slider, newValue, thumb, type) {
                if (#{Draw1}) {
                    #{Draw1}.getSurface().get('Sprite1').setAttributes({ rotationRads: newValue * Math.PI / 180 });
                    #{Draw1}.getSurface().renderFrame();
                }
            }
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <h1>Rotating Text with a Draw Component</h1>
        <p>
            In this example, you can see how easy it is to create text in a Draw Component which can be rotated easily in any browser. Use the slider to spin the text 360 degrees.
        </p>

        <p>
            See the Drawing guide&nbsp;<a href="http://docs.sencha.com/extjs/7.2.0/guides/core_concepts/draw/drawing.html">here</a>.
        </p>

        <ext:Slider
            runat="server"
            Width="400"
            MinValue="0"
            MaxValue="360"
            Number="0">
            <Listeners>
                <Change Fn="handleSliderChange" />
            </Listeners>
        </ext:Slider>

        <ext:DrawContainer ID="Draw1" runat="server" Height="480">
            <Items>
                <ext:TextSprite
                    SpriteID="Sprite1"
                    Text="Rotate me"
                    FillStyle="#0F0"
                    FontSize="18px"
                    FontFamily="Arial"
                    TranslationY="50"
                    TranslationX="150">
                </ext:TextSprite>
            </Items>
        </ext:DrawContainer>
    </form>
</body>
</html>