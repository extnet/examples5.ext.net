<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="<%= "../resources/css/main.css?" + Ext.Net.Examples.ExtNetVersion.Full %>" />

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
    <ext:ResourceManager runat="server" Theme="Spotless" />

    <ext:Container runat="server">
        <Content>
            <div class="container">
                <h1>BUILD CROSS-BROWSER ENTERPRISE WEB APPS FASTER <span>WITH <span class="blue">115+ COMPONENTS AND 925+ EXAMPLES</span></span></h1>
                <div class="welcome-cards">

                    <div class="welcome-card">
                        <div class="welcome-card-icon">
                            <img src="../resources/icons/docs.svg" />
                        </div>
                        <div class="welcome-card-title">Getting Started</div>
                        <div class="welcome-card-body">
                            <p>
                                Learning Ext.NET is very easy. <a href="/#/Getting_Started/Introduction/Installation/">Watch these videos</a>
                                to learn how to install Ext.NET in minutes.</a>.
                            </p>
                        </div>
                    </div>

                    <div class="welcome-card">
                        <div class="welcome-card-icon">
                            <img src="../resources/icons/support.svg" />
                        </div>
                        <div class="welcome-card-title">Support</div>
                        <div class="welcome-card-body">
                            <p>
                                We are proud to have a large <a href="https://forums.ext.net/">developer community</a> for exchanging information as well
                                as <a href="https://ext.net/store/#benefits">Premium Support</a> with a maximum 24h response time.
                            </p>
                        </div>
                    </div>

                    <div class="welcome-card">
                        <div class="welcome-card-icon">
                            <img src="../resources/icons/download.svg" />
                        </div>
                        <div class="welcome-card-title">Download</div>
                        <div class="welcome-card-body">
                            <p>
                                You can <a href="https://ext.net/download/">download</a> Ext.NET and start testing it locally right away. In order to deploy and use it
                                for commercial projects, you will need to <a href="https://ext.net/pricing/">get a license</a>.
                            </p>
                        </div>
                    </div>

                </div>

                <h2>Popular Examples</h2>

                <ul class="popular-links">
                    <li><a href="/#/GridPanel/ArrayGrid/ArrayWithPaging/">GridPanel</a></li>
                    <li><a href="/#/Events/DirectEvents/Overview/">DirectEvents</a></li>
                    <li><a href="/#/Events/DirectMethods/Overview/">DirectMethods</a></li>
                    <li><a href="/#/Viewport/Basic/Built_in_Markup/">Viewport</a></li>
                    <li><a href="/#/XRender/Basic/Add_Items/">XRender</a></li>
                    <li><a href="/#/Chart/Area/Basic/">Chart</a></li>
                </ul>

            </div>
        </Content>
    </ext:Container>

</body>
</html>
