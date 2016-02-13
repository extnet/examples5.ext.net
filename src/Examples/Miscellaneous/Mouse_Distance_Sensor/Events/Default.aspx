<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Mouse Sensor Distance Events - Ext.NET Examples</title>

    <script>
        var near = function (el, sensorEl) {
            var bar = App.Toolbar1,
                win = App.Window1;

            bar.el.setZIndex(win.el.getZIndex() + 1);
            bar.show();
            bar.setWidth(win.body.getWidth() - 2);
            bar.el.alignTo(sensorEl, "t-t", [0, 44]);
        };

        var onAfterRender = function () {
            this.getEl().on("mousedown", function () {
                if (App.Toolbar1.isVisible()) {
                    App.Toolbar1.toFront();
                }
            });
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Window
        ID="Window1"
        runat="server"
        Title="Move Mouse to top of Window"
        Width="350"
        Height="215"
        Closable="false"
        Layout="FitLayout"
        PageX="100"
        PageY="100">
        <Items>
            <ext:TextArea runat="server" />
        </Items>
        <Plugins>
            <ext:MouseDistanceSensor
                runat="server"
                SensorElement="={App.Window1.header}"
                ConstrainElement="Window1"
                Opacity="false"
                Threshold="25">
                <Listeners>
                    <Near Fn="near" />
                    <Far Handler="App.Toolbar1.hide();" />
                </Listeners>
            </ext:MouseDistanceSensor>
        </Plugins>
        <Listeners>
            <Drag Handler="App.Toolbar1.hide();" />
            <AfterRender Fn="onAfterRender" />
        </Listeners>
    </ext:Window>

    <ext:Toolbar
        ID="Toolbar1"
        runat="server"
        Hidden="true"
        Floating="true">
        <Items>
            <ext:Button runat="server" Text="Paste" Icon="PastePlain" />
            <ext:Button runat="server" Text="Copy" Icon="ApplicationDouble" />
            <ext:Button runat="server" Text="Cut" Icon="Cut" />
        </Items>
    </ext:Toolbar>
</body>
</html>
