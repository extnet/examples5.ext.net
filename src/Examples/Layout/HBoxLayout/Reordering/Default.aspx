<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>VBoxLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Window
        runat="server"
        Width="960"
        Height="150"
        Title="HBox window (drag below panels)">
        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Defaults>
            <ext:Parameter Name="margin" Value="2" Mode="Raw" />
        </Defaults>
        <Items>
            <ext:Panel runat="server" Frame="true" Flex="1" Title="Panel 1" />
            <ext:Panel runat="server" Frame="true" Flex="1" Title="Panel 2" />
            <ext:Panel runat="server" Frame="true" Flex="1" Title="Panel 3" />
            <ext:Panel runat="server" Frame="true" Flex="1" Title="Panel 4" />
            <ext:Panel runat="server" Frame="true" Flex="1" Title="Panel 5" />
        </Items>
        <Plugins>
            <ext:BoxReorderer runat="server" />
        </Plugins>
    </ext:Window>
</body>
</html>
