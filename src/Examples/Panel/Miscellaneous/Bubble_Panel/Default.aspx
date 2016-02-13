<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Bubble Panel</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="resources/css/bubble.css" rel="stylesheet" />
    <style>
        body {
            background-color : #4E79B2 !important;
        }

        #bubble-markup em {
            font-style : italic
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" SourceFormatting="True" />

    <h1>Demonstrates how to apply custom CSS</h1>

    <p>To change CSS of the panel click on the button</p>

    <div id="bubble-markup" class="x-hidden">
        <p>This is a custom panel UI to achieve a different look and feel while not changing the default appearance of an Ext.Panel.</p>

        <p>It uses the new theming system included in Ext4, to create new Ext.panel.Panel UI's using included mixins.</p>
    </div>

    <script>
        var changeUI = function () {
            var panel = App.Panel1,
                uis = ['default-framed', 'bubble'],
                index = Ext.Array.indexOf(uis, panel.ui);

            if ((index + 1) >= uis.length) {
                panel.setUI(uis[0]);
            } else {
                panel.setUI(uis[index + 1]);
            }

            panel.updateLayout();

            App.ToggleButton.setText('Toggle UI: ' + panel.ui);
        };
    </script>

    <ext:Button runat="server" ID="ToggleButton" Text="Toggle UI: default-framed">
        <Listeners>
            <Click Handler="changeUI();"></Click>
        </Listeners>
    </ext:Button>

    <ext:Panel
        runat="server"
        ID="Panel1"
        Title="Plain Old Panel"
        Width="400"
        Frame="true"
        Header="True"
        Html="Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br /><br />Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.">
        <CustomConfig>
            <ext:ConfigItem Name="contentEl" Value="bubble-markup" Mode="Value" />
        </CustomConfig>
    </ext:Panel>
</body>
</html>
