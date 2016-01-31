<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>VBoxLayout Rows - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Viewport runat="server" Layout="VBoxLayout">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Items>
            <ext:Panel runat="server" Title="Initial Height = 25%" Flex="1" />
            <ext:Panel runat="server" Title="Initial Height = 100px" Height="100" />
            <ext:Panel runat="server" Title="Initial Height = 75%" Flex="3" />
        </Items>
    </ext:Viewport>
</body>
</html>