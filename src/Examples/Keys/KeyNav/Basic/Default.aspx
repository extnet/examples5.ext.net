<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>KeyNav - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var isCenter = true;

        var move = function (win, dir) {
            var el = win.getEl();

            if (!isCenter) {
                el.alignTo(document, 'c-c', [0,0], true);
                isCenter = true;
                return;
            }

            switch (dir) {
                case "left":
                    el.alignTo(document, "l", [0, -el.getHeight() / 2], true);
                    isCenter = false;
                    break;

                case "right":
                    el.alignTo(document, "r", [-el.getWidth(), -el.getHeight() / 2], true);
                    isCenter = false;
                    break;

                case "up":
                    el.alignTo(document, "t", [-el.getWidth() / 2, 0], true);
                    isCenter = false;
                    break;

                case "down":
                    el.alignTo(document, "b", [-el.getWidth() / 2, -el.getHeight()], true);
                    isCenter = false;
                    break;

                case "home":
                    el.center();
                    isCenter = true;
                    break;
            }
        };

        var COLOUMN2 = function (value) {
            return Ext.String.format('<img src="article_image.aspx?id={0}" id="myID" />', value);
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Window
        ID="Window1"
        runat="server"
        Width="400"
        Height="480"
        Closable="false"
        Title="Move Window"
        BodyPadding="18">
        <Content>
            <ul>
                <li>Press:</li>
                <li>&nbsp;&nbsp;UP</li>
                <li>&nbsp;&nbsp;DOWN</li>
                <li>&nbsp;&nbsp;LEFT</li>
                <li>&nbsp;&nbsp;RIGHT</li>
                <li>&nbsp;&nbsp;HOME</li>
            </ul>
        </Content>
    </ext:Window>

    <ext:KeyNav runat="server" Target="={document.body}">
        <Left Handler="move(#{Window1}, 'left');" />
        <Right Handler="move(#{Window1}, 'right');" />
        <Up Handler="move(#{Window1}, 'up');" />
        <Down Handler="move(#{Window1}, 'down');" />
        <Home Handler="move(#{Window1}, 'home');" />
    </ext:KeyNav>
</body>
</html>