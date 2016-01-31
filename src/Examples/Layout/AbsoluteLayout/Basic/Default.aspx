<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AbsoluteLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" Layout="Absolute">
        <Items>
            <ext:Panel 
                runat="server" 
                BodyPadding="15" 
                Width="200" 
                Height="100" 
                Frame="true" 
                Title="Panel 1" 
                X="50" 
                Y="50" 
                Html="Positioned at x:50, y:50"
                />
            <ext:Panel 
                runat="server" 
                BodyPadding="15" 
                Width="200" 
                Height="100" 
                Frame="true" 
                Title="Panel 2" 
                X="125" 
                Y="125" 
                Html="Positioned at x:125, y:125"
                />
        </Items>
    </ext:Viewport>
</body>
</html>