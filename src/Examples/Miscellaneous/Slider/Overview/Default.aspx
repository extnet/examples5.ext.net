<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Slider - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        #custom-slider {
            width       : 214px;
            padding-top : 6px;
            background-image : url(resources/images/ticks.gif);
        }

        #custom-slider .x-slider-thumb {
            background-image : url(resources/images/slider-thumb.png);
        }

    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Slider Variations</h1>

        <h3>Basic Slider</h3>

        <ext:Slider runat="server" Width="214" />

        <br/>

        <h3>Snapping Slider</h3>

        <ext:Slider
            runat="server"
            Width="214"
            Number="50"
            Increment="10"
            />

        <br/>

        <h3>Vertical Slider</h3>

        <ext:Slider runat="server" Height="214" Vertical="true" />

        <br/>

        <h3>Slider with Custom Tip</h3>

        <ext:Slider runat="server" Width="214">
            <Plugins>
                <ext:SliderTip runat="server">
                    <GetText Fn="function (slider) { return Ext.String.format('<b>{0}% complete</b>', slider.value); }" />
                </ext:SliderTip>
            </Plugins>
        </ext:Slider>
        <br/>

        <h3>CSS Customized Slider</h3>

        <div id="custom-slider">
            <ext:Slider runat="server" Width="214" Increment="10" />
        </div>

        <h3>Multi Slider Horizontal</h3>

        <ext:Slider runat="server" Width="214" Numbers="10,50,90" />

        <br/>

        <h3>Multi Slider Vertical</h3>

        <ext:Slider
            runat="server"
            Height="214"
            Numbers="10,50,90"
            Vertical="true"
            />
    </form>
</body>
</html>
