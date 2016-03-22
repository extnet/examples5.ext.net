<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../resources/css/main.css?v=1.0.1" />

    <script>
        Ext.onReady(function () {
            if (top !== self) {
                Ext.select("a", true).on("click", function (e, el) {
                    if (!Ext.fly(el).hasCls("exclude")) {
                        parent.location = el.href;
                    }
                }, null, { preventDefault: true });
            }
        });
    </script>
</head>
<body class="welcome">
    <ext:ResourceManager runat="server" Theme="Crisp" />

    <ext:Container runat="server">
        <Content>
            <div id="welcome-title">
                Rapidly Build Your Vision with Ext.NET
            </div>

            <div class="ext4-notification">
                <div class="notification-container">
                    <div class="notification-img">
                        <img src="../resources/images/extdotnet4-rc.svg">
                    </div>
                    <div class="notification-text">
                        The Ext.NET 4 RC release is now available! <a href="https://github.com/extnet/Ext.NET/issues?utf8=%E2%9C%93&q=is%3Aissue+milestone%3A%22Release+4.0.0-rc%22+is%3Aclosed+-label%3Ainvalid">Several important defects</a> reported during the Beta release have been fixed, thanks to our great Community. Only one step left to the final release now.
                    </div>
                    <div class="notification-action">
                        <a href="http://ext.net/ext-net-4-rc-now-available/" class="btn-notification">Read More</a>
                    </div>
                </div>
            </div>

            <p class="welcome-text">
                Ext.NET boosts your productivity! We offer 100+ components and 600+ examples.<br />
                Browse the examples using the sidebar menu on the left, check their source code, open in a separate window if you like.<br />
                If you have any questions feel free to <a href="http://ext.net/contact/">get in touch with us</a> or check our <a href="http://forums.ext.net/">community forums</a>.
            </p>
        </Content>
    </ext:Container>

    <ext:Container runat="server">
        <Content>
            <div id="welcome-grid">
                <div id="screens"></div>
                <div class="popular-links">
                    <a class="button" href="/#/Getting_Started/Introduction/Overview/">Getting Started</a>
                    <a class="button" href="/#/Events/DirectEvents/Overview/">DirectEvents</a>
                    <a class="button" href="/#/Events/DirectMethods/Overview/">DirectMethods</a>
                    <a class="button" href="/#/GridPanel/ArrayGrid/ArrayWithPaging/">GridPanel</a>
                    <a class="button" href="/#/Viewport/Basic/Built_in_Markup/">Viewport</a>
                    <a class="button" href="/#/XRender/Basic/Add_Items/">XRender</a>
                </div>
            </div>
        </Content>
    </ext:Container>

</body>
</html>
