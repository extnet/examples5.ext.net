<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Resizable - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="resources/css/basic.css" rel="stylesheet" />

    <script>
        var hideImage = function () {
            var customEl = App.CustomResizer.getEl();
            document.body.insertBefore(customEl.dom, document.body.firstChild);

            customEl.on('dblclick', function () {
                customEl.hide(true);
            });

            customEl.hide();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Handler="hideImage();" />
            </Listeners>
        </ext:ResourceManager>

        <h1>Resizable Examples</h1>

        <p>These examples show how to apply a floating (default) and pinned Resizable component to a standard element.</p>

        <p>
            <b>Basic Example</b><br />
            This is a basic as you get. To resize the box, position your mouse anywhere near the bottom,
            right or border right edge of the box. This example uses the default "floating" handles.
        </p>

        <div id="basic">Resize Me!</div>

        <ext:Resizer
            runat="server"
            Target="basic"
            Width="200"
            Height="100"
            MinWidth="100"
            MinHeight="50"
            />

        <hr/>

        <p>
            <b>Wrapped Elements</b>
            <br />
            Some elements such as images and textareas don't allow child elements. Prior to Ext JS 3.x, you had
            to wrap these elements and set up a Resizable with resize child. With Ext JS 3.x we made it a little
            easier for you and all you had to do was set "wrap:true". Now with Ext JS 4.x we go a step further
            and automatically detect if the element needs a wrap and wrap it for you.
        </p>

        <p>
            <b>Pinned Handles</b><br />
            Notice this example has the resize handles "pinned". This is done by setting "pinned:true".
        </p>

        <p>
            <b>Dynamic Sizing</b>
            <br />
            If you don't like the proxy resizing, you can also turn on dynamic sizing. Just set "dynamic:true".
        </p>

        <p>
            Here's a textarea that is wrapped (automatically), has pinned handles and has dynamic sizing turned on.
        </p>

        <textarea id="dwrapped" style="resize: none;">
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna. Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa.
            Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit. Quisque dolor magna, ornare sed, elementum porta, luctus in, leo.
        </textarea>
        <br />
        <br />

        <ext:Resizer
            runat="server"
            Target="dwrapped"
            Pinned="true"
            Width="450"
            Height="150"
            MinWidth="200"
            MinHeight="50"
            Dynamic="true"
            />
        <hr/>

        <p>
            <b>Preserve Ratio</b><br />
            For some things like images, you will probably want to preserve the ratio of width to height. Just set PreserveRatio=true.
        </p>

        <img id="wrapped" src="resources/images/flower.jpg" width="200" height="133" />

        <ext:Resizer
            runat="server"
            Target="wrapped"
            Pinned="true"
            MinWidth="50"
            MinHeight="50"
            PreserveRatio="true"
            />
        <hr/>

        <p>
            <b>Snapping</b>
            <br />
            To resize in fixed increments, specify the <code>WidthIncrement</code> or <code>HeightIncrement</code> options. The image below
            resizes (maintaining its aspect ratio) in increments of 20 pixels in both directions.
        </p>

        <img id="croix-de-fer" src="resources/images/CroixDeFer.jpg" width="160" height="120"/>

        <ext:Resizer
            runat="server"
            Target="croix-de-fer"
            Width="160"
            Height="120"
            MinWidth="160"
            MinHeight="120"
            PreserveRatio="true"
            HeightIncrement="20"
            WidthIncrement="20"
            />
        <hr/>

        <p>
            <b>Transparent Handles</b><br />
            If you just want the element to be resizable without any fancy handles, set transparent to true.
        </p>
        <img id="transparent" src="resources/images/grass.jpg" width="200" height="133" />

        <ext:Resizer
            runat="server"
            Target="transparent"
            MinWidth="50"
            MinHeight="50"
            PreserveRatio="true"
            Transparent="true"
            />
        <hr />

        <p>
            <b>Customizable Handles</b><br />
            Resizable elements are resizable 8 ways. 8 way resizing for a static positioned element will cause the element to be positioned relative and taken out of the document flow. For resizing which adjusts the
            x and y of the element, the element should be positioned absolute. You can also control which handles are displayed by setting the "handles" attribute.
            The handles are styled using CSS so they can be customized to look however you would like them to.
        </p>
        <p>
            This image has 8 way resizing, custom handles and preserved aspect ratio.<br />
            <b>Double click anywhere on the image to hide it when you are done.</b>
        </p>
        <img id="custom" src="resources/images/stones.jpg" width="200" height="150" style="position:absolute;left:0;top:0;" />

        <ext:Resizer
            ID="CustomResizer"
            runat="server"
            Target="custom"
            Pinned="true"
            MinWidth="50"
            MinHeight="50"
            PreserveRatio="true"
            Handles="All"
            Dynamic="true"
            />

        <div style="padding:8px;border:1px solid #c3daf9;background:#d9e8fb;width:150px;text-align:center;">
            <ext:Button runat="server" Text="Show Me">
                <Listeners>
                    <Click Handler="var el = #{CustomResizer}.getEl(); el.center(); el.show(true);" />
                </Listeners>
            </ext:Button>
        </div>
        <hr />

        <ext:Panel
            ID="ExtNetSite"
            runat="server"
            Title="Resizable panel"
            Width="400"
            Height="200">
            <Loader
                runat="server"
                Url="https://ext.net"
                Mode="Frame" />
            <ResizableConfig
                runat="server"
                MinHeight="200"
                MinWidth="200"
                Transparent="true" />
        </ext:Panel>


        <br />
        <p>Images: graur codrin, Matt Banks, Lavoview (FreeDigitalPhotos.net)</p>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
