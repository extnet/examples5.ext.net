<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FlashComponent - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            ID="Window1"
            runat="server"
            Title="Flash Movie"
            Layout="FitLayout"
            Height="320"
            Width="400"
            Maximizable="true">
            <Items>
                <ext:FlashComponent
                    ID="VideoPlayer"
                    runat="server"
                    Url="http://vimeo.com/moogaloop.swf?clip_id=3911557&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1&js_api=1">
                    <FlashParams>
                        <ext:Parameter Name="allowfullscreen" Value="true" Mode="Raw" />
                    </FlashParams>
                </ext:FlashComponent>
            </Items>
        </ext:Window>
    </form>
</body>
</html>