<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Image on Collapsed BorderLayout Region - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        #WestPanel-placeholder-innerCt {
            background : url(collapsed-west.png) no-repeat center;
        }

        #SouthPanel-placeholder-innerCt {
            background : url(collapsed-south.png) no-repeat center;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Image on Collapsed BorderLayout Region</h1>

    <ext:Window
        runat="server"
        Title="Collapsed Region Image"
        Icon="Application"
        Width="600"
        Height="350"
        Border="false"
        Closable="false"
        X="100"
        Y="100"
        Plain="true"
        Layout="Border">
        <Items>
            <ext:Panel
                ID="WestPanel"
                runat="server"
                Region="West"
                Collapsible="true"
                MinWidth="175"
                Split="true"
                Width="175"
                Title="Navigation"
                TitleCollapse="false"
                Floatable="false"
                Collapsed="true"
                BodyPadding="5"
                Html="Collapse Panel to see image.">
                <Listeners>
                    <AfterRender Handler="this.setTitle('');" />
                    <BeforeCollapse Handler="this.setTitle('');" />
                    <BeforeExpand Handler="this.setTitle(this.initialConfig.title);" />
                </Listeners>
            </ext:Panel>
            <ext:Panel runat="server" Region="Center" Title="Center region" />
            <ext:Panel
                ID="SouthPanel"
                runat="server"
                Region="South"
                Collapsible="true"
                MinHeight="100"
                Split="true"
                Height="100"
                Title="Footer"
                TitleCollapse="false"
                Floatable="false"
                Collapsed="true">
                <Listeners>
                    <AfterRender Handler="this.setTitle('');" />
                    <BeforeCollapse Handler="this.setTitle('');" />
                    <BeforeExpand Handler="this.setTitle(this.initialConfig.title);" />
                </Listeners>
             </ext:Panel>
        </Items>
    </ext:Window>
</body>
</html>