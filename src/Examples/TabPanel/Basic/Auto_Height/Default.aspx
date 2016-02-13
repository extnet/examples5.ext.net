<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Auto height TabPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:TabPanel runat="server" Width="450">
        <Items>
            <ext:Panel
                runat="server"
                Title="Short Text"
                BodyPadding="6">
                <Content>
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales
                    a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis,
                    interdum non, sodales non, iaculis ac, lacus.<br />
                    <br />
                    Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus,
                    sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse
                    nunc sem, pretium eget, cursus a, fringilla vel, urna.
                </Content>
            </ext:Panel>
            <ext:Panel
                runat="server"
                Title="Long Text"
                BodyPadding="6">
                <Content>
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales
                    a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis,
                    interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis
                    malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus.
                    In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla
                    vel, urna.<br />
                    <br />
                    Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean
                    lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim
                    non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec
                    urna. Curabitur velit.
                </Content>
            </ext:Panel>
        </Items>
    </ext:TabPanel>
</body>
</html>