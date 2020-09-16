<%@ Page Language="C#" %>

<script runat="server">
    protected void HandleFieldChange(object sender, DirectEventArgs dea)
    {
        var previousColor = dea.ExtraParams["previousColor"];
        var color = dea.ExtraParams["color"];
        Label2.Text = "From server-side handler (direct event): Changed color from " + previousColor + " to " + color + ".";
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Advanced Color Picker Components Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style type="text/css">
        /* This was extracted from Ext.JS Examples for Ext.NET 6.2.1 (from KitchenSink-all_2.css)
            url: http://examples.sencha.com/extjs/6.2.1/examples/kitchensink/?classic#form-color-picker
        */
        .x-colorpicker-draghandle-container .x-autocontainer-outerCt {
            height: 100%;
        }
        .x-colorpicker-alpha .x-colorpicker-draghandle-container {
            background-image: url(/ux/resources/images/colorpick/checkerboard-png/ext.axd)
        }
    </style>

    <script type="text/javascript">
        var handleColorButtonChange = function (item, color, previousColor) {
            // Only try to fill the label contents when the label is registered.
            if (App.Label1) {
                App.Label1.setText('From client-side handler (listener): Changed color from ' + previousColor + ' to ' + color + '.');
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Advanced Color Picker Components Overview</h1>

        <h2>1. Button</h2>
        <h3>This is a simple color button. When the color is changed, a client-side event is triggered filling an (initially empty) label just below the button with a descriptive text of the change.</h3>

        <ext:ColorButton ID="ColorButton1" runat="server">
            <Listeners>
                <Change Fn="handleColorButtonChange" />
            </Listeners>
        </ext:ColorButton>

        <ext:Label ID="Label1" runat="server" />

        <hr />
        <h2>2. Field</h2>
        <h3>A simple ColorField that will trigger a server-side direct event to fill an (initially empty) label just below the field with a descriptive text of the change.</h3>

        <ext:ColorField ID="ColorField1" runat="server">
            <DirectEvents>
                <Change OnEvent="HandleFieldChange">
                    <ExtraParams>
                        <ext:Parameter Name="previousColor" Value="oldValue" Mode="Raw" />
                        <ext:Parameter Name="color" Value="newValue" Mode="Raw" />
                    </ExtraParams>
                </Change>
            </DirectEvents>
        </ext:ColorField>

        <ext:Label ID="Label2" runat="server" />

        <hr />
        <h2>3. Selector</h2>
        <h3>The color selector itself, with 'ok' and 'cancel' buttons enabled directly, as well as
            custom client-side JavaScript handlers for either buttons, updating a text label below
            on click.
           
            <br />
            The selector is set up to return colors with the sharp symbol and also alpha byte, i.e.
            following the format #rrggbbaa (lowercase hexadecimal characters).
        </h3>

        <ext:ColorSelector
            ID="ColorSelector1"
            runat="server"
            ShowOkCancelButtons="true"
            Format="sharplchex8">
            <Listeners>
                <Ok Handler="App.Label3.setText('Clicked OK. Color chosen: ' + color);" />
                <Cancel Handler="App.Label3.setText('Clicked Cancel. Current color: ' + item.value);" />
            </Listeners>
        </ext:ColorSelector>

        <ext:Label ID="Label3" runat="server" />
    </form>
</body>
</html>
