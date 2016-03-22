<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Advanced Color Picker Components - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script type="text/javascript">
        var onChange = function (picker, color, oldColor) {
            console.log(picker.getId() + '.color: ' + color);
        };

        var onShowMoreLess = function (button) {
            this.up('panel').getViewModel().set('full', button.value == "true" ? true : false);
        };

        var handleWindowResize = function (window, adjWidth, adjHeight) {
            var viewHeight = Ext.getWin().el.dom.innerHeight;
            var curPos = window.getXY();

            targetY = viewHeight - window.getHeight();

            if (targetY < 0) {
                targetY = 0
            } else {
                targetY = targetY / 2;
            }

            window.setPosition(curPos[0], targetY);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Advanced Color Picker Components</h1>

        This example reproduces the <a href="http://examples.sencha.com/extjs/6.0.1/examples/kitchensink/#form-color-picker" target="_blank">Forms > Color Picker</a> sencha example available on their examples' kitchen sink.

        <ext:Window 
            runat="server" 
            Width="600" 
            MinWidth="550" 
            Resizable="true" 
            BodyPadding="5" 
            Frame="true"
            Title="Color Picker Components" 
            Layout="VBoxLayout"
            Draggable="false">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>

            <CustomConfig>
                <ext:ConfigItem Name="viewModel" Value="{ data: { color: '#0f0', full: false } }" Mode="Raw" />
            </CustomConfig>

            <HeaderConfig>
                <Items>
                    <ext:Component runat="server" Cls="x-panel-header-title-default-framed" Html="Color button &#8680;" />
                    <ext:ColorButton runat="server" Width="15" Height="15" BindString="{color}">
                        <Listeners>
                            <Change Fn="onChange" />
                        </Listeners>
                    </ext:ColorButton>
                </Items>
            </HeaderConfig>

            <Items>
                <ext:ColorField runat="server" FieldLabel="Color Field" LabelWidth="75" BindString="{color}">
                    <Listeners>
                        <Change Fn="onChange" />
                    </Listeners>
                </ext:ColorField>
                <ext:ColorSelector runat="server" Hidden="true" Flex="1">
                    <CustomConfig>
                        <ext:ConfigItem Name="bind" Value="{ value: '{color}', visible: '{full}' }" Mode="Raw" />
                    </CustomConfig>
                </ext:ColorSelector>
            </Items>

            <Buttons>
                <ext:Button runat="server" Text="Show color selector &gt; &gt;" Value="true">
                    <CustomConfig>
                        <ext:ConfigItem Name="bind" Value="{ visible: '{!full}' }" Mode="Raw" />
                    </CustomConfig>
                    <Listeners>
                        <Click Fn="onShowMoreLess" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Hide color selector &lt; &lt;" Value="false">
                    <CustomConfig>
                        <ext:ConfigItem Name="bind" Value="{ visible: '{full}' }" Mode="Raw" />
                    </CustomConfig>
                    <Listeners>
                        <Click Fn="onShowMoreLess" />
                    </Listeners>
                </ext:Button>
            </Buttons>

            <Listeners>
                <Resize Fn="handleWindowResize" />
            </Listeners>
        </ext:Window>
    </form>
</body>
</html>