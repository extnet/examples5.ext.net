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
        Height="180"
        Title="HBox Window With Splitters">
        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Defaults>
            <ext:Parameter Name="margin" Value="2 0" Mode="Value" />
        </Defaults>
        <Items>
            <ext:Panel
                runat="server"
                Flex="1"
                Title="Panel 1"
                CollapseDirection="Left"
                />

            <ext:BoxSplitter runat="server" Collapsible="true" CollapseTarget="Prev" />

            <ext:Panel
                runat="server"
                Flex="1"
                Title="Panel 2"
                CollapseDirection="Left"
                />

            <ext:BoxSplitter runat="server" Collapsible="true" CollapseTarget="Prev" />

            <ext:Panel runat="server" Flex="1" Title="Panel 3" />

            <ext:BoxSplitter runat="server" Collapsible="true" />

            <ext:Panel
                runat="server"
                Flex="1"
                Title="Panel 4"
                CollapseDirection="Right"
                />

            <ext:BoxSplitter runat="server" Collapsible="true" />

            <ext:Panel
                ID="Panel5"
                runat="server"
                Flex="1"
                Title="Panel 5"
                CollapseDirection="Right"
                />
        </Items>
    </ext:Window>
</body>
</html>