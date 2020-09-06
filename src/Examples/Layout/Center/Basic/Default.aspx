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

        <ext:Viewport runat="server" Layout="Center">
            <Items>
                <ext:Panel
                    runat="server"
                    Width="200"
                    Height="180"
                    BodyPadding="18"
                    Title="Panel"
                    Html="This panel is centered within its container." />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
