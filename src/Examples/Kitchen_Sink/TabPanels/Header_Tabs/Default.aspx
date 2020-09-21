<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Header Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Header Tabs</h1>

        <p>The example demonstrates the use of TabBarHeaderPostion.</p>
        <p>If specified the tabs are rendered into a TabPanel's header.</p>

        <ext:TabPanel
            runat="server"
            Title="Examples"
            Width="480"
            Height="480"
            TabBarHeaderPosition="2">
            <Defaults>
                <ext:Parameter Name="bodyPadding" Value="20" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Panel runat="server" Title="Ext.NET" Html="Ext.NET"  />
                <ext:Panel runat="server" Title="Sencha" Html="Sencha" />
                <ext:Panel runat="server" Title=".NET" Html=".NET Framework" />
            </Items>
        </ext:TabPanel>
    </form>
</body>
</html>
