<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AccordionLayout in Markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Accordion Layout in Markup</h1>

    <ext:Window
        runat="server"
        Title="Accordion"
        Width="360"
        Height="600"
        Maximizable="true"
        Layout="Accordion">
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Button runat="server" IconCls="x-md md-icon-add-circle-outline">
                        <ToolTips>
                            <ext:ToolTip runat="server" Title="Rich ToolTips" Html="Let your users know what they can do!" />
                        </ToolTips>
                    </ext:Button>
                    <ext:Button runat="server" IconCls="x-md md-icon-person-add" />
                    <ext:Button runat="server" IconCls="x-md md-icon-person-remove" />
                </Items>
            </ext:Toolbar>
        </TopBar>
        <Items>
            <ext:Panel runat="server" Title="Users" />
            <ext:Panel runat="server" Title="Settings" />
            <ext:Panel runat="server" Title="Security" />
            <ext:Panel runat="server" Title="Documents" />
        </Items>
    </ext:Window>
</body>
</html>