<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Original Header - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" Layout="Border">
        <Items>
            <ext:Panel
                runat="server"
                Width="480"
                Border="false"
                Region="West"
                Layout="Fit"
                BodyPadding="18">
                <Items>
                    <ext:Panel runat="server" Layout="Accordion" MarginSpec="0 0 15 0">
                        <LayoutConfig>
                            <ext:AccordionLayoutConfig OriginalHeader="true" />
                        </LayoutConfig>
                        <Items>
                            <ext:Panel runat="server" Title="Item 1" Border="false" />
                            <ext:Panel runat="server" Title="Item 2" Border="false" />
                            <ext:Panel runat="server" Title="Item 3" Border="false" />
                            <ext:Panel runat="server" Title="Item 4" Border="false" />
                            <ext:Panel runat="server" Title="Item 5" Border="false" />
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>

            <ext:Panel
                runat="server"
                MarginSpec="5"
                Region="Center"
                BodyPadding="18">
                <Content>
                    <h1>Original header of the Accordion's item</h1>
                </Content>
            </ext:Panel>
        </Items>
    </ext:Viewport>
</body>
</html>