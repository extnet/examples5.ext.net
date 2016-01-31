<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Center Layout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="CenterLayout">
            <Items>
                <ext:Panel
                    runat="server"
                    Width="200"
                    Height="200"
                    BodyPadding="15"
                    Title="Panel"
                    Html="This panel is centered within its container." />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
