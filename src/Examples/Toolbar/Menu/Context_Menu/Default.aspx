<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var setColor = function (menu, color) {
            var cmp;

            if (menu.lastTargetIn(App.Panel1)) {
                cmp = App.Panel1;
            } else if (menu.lastTargetIn(App.Panel2)) {
                cmp = App.Panel2;
            }

            cmp.body.applyStyles(Ext.String.format('background-color:#{0}', color));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ColorMenu ID="ColorMenu1" runat="server">
            <Listeners>
                <Select Handler="setColor(#{ColorMenu1}, color);" />
            </Listeners>
        </ext:ColorMenu>

        <ext:Panel
            ID="Panel1"
            runat="server"
            Height="180"
            Title="Right-Click on this Panel"
            ContextMenuID="ColorMenu1"
            />

        <ext:Panel
            ID="Panel2"
            runat="server"
            Height="180"
            Title="Right-Click on this Panel too!"
            ContextMenuID="ColorMenu1"
            />
    </form>
</body>
</html>