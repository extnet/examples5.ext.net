<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Advanced Color Picker components' Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Advanced Color Picker components' Overview</h1>

        <h2>1. Button</h2>
        <h3>This is a simple color button. When the color is changed, a client-side event is triggered filling an (initially empty) label just below the button with a descriptive text of the change.</h3>

        <script type="text/javascript">
            var handleColorButtonChange = function (item, color, previousColor) {
                // Only try to fill the label contents when the label is registered.
                if (App.Label1) {
                    App.Label1.setText('From client-side handler (listener): Changed color from ' + previousColor + ' to ' + color + '.');
                }
            }
        </script>
        <ext:ColorButton ID="ColorButton1" runat="server">
            <Listeners>
                <Change Fn="handleColorButtonChange" />
            </Listeners>
        </ext:ColorButton>

        <ext:Label ID="Label1" runat="server" />

        <hr />
        <h2>2. Field</h2>
        <h3>A simple ColorField that will trigger a server-side direct event to fill an (initially empty) label just below the field with a descriptive text of the change.</h3>

        <script runat="server">
            protected void HandleFieldChange(object sender, DirectEventArgs dea)
            {
                var previousColor = dea.ExtraParams["previousColor"];
                var color = dea.ExtraParams["color"];
                Label2.Text = "From server-side handler (direct event): Changed color from " + previousColor + " to " + color + ".";
            }
        </script>

        <ext:ColorField ID="ColorField1" runat="server">
            <DirectEvents>
                <Change OnEvent="HandleFieldChange">
                    <ExtraParams>
                        <ext:Parameter Name="previousColor" Value="previousColor" Mode="Raw" />
                        <ext:Parameter Name="color" Value="color" Mode="Raw" />
                    </ExtraParams>
                </Change>
            </DirectEvents>
        </ext:ColorField>

        <ext:Label ID="Label2" runat="server" />

        <hr />
        <h2>3. Selector</h2>
        <h3>
            The color selector itself, with 'ok' and 'cancel' buttons enabled directly, as well as
            custom client-side JavaScript handlers for either buttons, updating a text label below
            on click.
            <br />
            The selector is set up to return colors with the sharp symbol and also alpha byte, i.e.
            following the format #rrggbbaa (lowercase hexadecimal characters).
        </h3>

        <script type="text/javascript">
            var handleSomethingElse = new function (item, color, previousColor) {
                // Only try to fill the label contents when the label is registered.
                if (App.Label1) {
                    App.Label1.setText('Changed color from ' + previousColor + ' to ' + color);
                }
            }
        </script>

        <ext:ColorSelector ID="ColorSelector1" runat="server" ShowOkCancelButtons="true" Format="sharplchex8">
            <Listeners>
                <Ok Handler="App.Label3.setText('Clicked OK. Color chosen: ' + color);" />
                <Cancel Handler="App.Label3.setText('Clicked Cancel. Current color: ' + item.value);" />
            </Listeners>
        </ext:ColorSelector>

        <ext:Label ID="Label3" runat="server" />
    </form>
</body>
</html>