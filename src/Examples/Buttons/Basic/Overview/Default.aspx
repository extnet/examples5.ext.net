<%@ Page Language="C#" %>

<script runat="server">
    protected void Button_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Alert("DirectEvent", string.Format("Item - {0}", e.ExtraParams["Item"])).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Button Variations - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .custom-icon1 {
            background-image : url(arrow-down.gif) !important;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Buttons</h1>

    <h3>1. Button with Listener</h3>

    <ext:Button runat="server" Text="Click Me" Scale="Medium">
        <Listeners>
            <Click Handler="Ext.toast('Clicked');" />
        </Listeners>
    </ext:Button>

    <h3>2. Button with DirectEvent</h3>

    <ext:Button runat="server" Text="Click Me" Scale="Medium">
        <DirectEvents>
            <Click OnEvent="Button_Click">
                <EventMask ShowMask="true" />
                <ExtraParams>
                    <ext:Parameter Name="Item" Value="One" />
                </ExtraParams>
            </Click>
        </DirectEvents>
    </ext:Button>

    <h3>3. Button with Icon</h3>

    <ext:Button runat="server" Text="Text" Scale="Medium" IconCls="x-md md-icon-check-circle-outline" />

    <h3>4. Button with QuickTip</h3>

    <ext:Button runat="server" Text="Text" Scale="Medium">
        <ToolTips>
            <ext:ToolTip runat="server" Title="Title" Html="Description" />
        </ToolTips>
    </ext:Button>

    <h3>5. Toggle Buttons</h3>

    <ext:Container runat="server" Layout="HBoxLayout">
        <Defaults>
            <ext:Parameter Name="margin" Value="0 5 0 0" />
        </Defaults>
        <Items>
            <ext:Button runat="server" Text="Button1" Scale="Medium" EnableToggle="true" ToggleGroup="Group1" Pressed="true" />
            <ext:Button runat="server" Text="Button2" Scale="Medium" EnableToggle="true" ToggleGroup="Group1" />
            <ext:Button runat="server" Text="Button3" Scale="Medium" EnableToggle="true" ToggleGroup="Group1" />
        </Items>
    </ext:Container>

    <h3>6. Button with menu</h3>

    <ext:Button runat="server" Text="Text" Scale="Medium">
        <Menu>
            <ext:Menu runat="server">
                <Items>
                    <ext:MenuItem runat="server" Text="Item 1" IconCls="x-md md-icon-edit" />
                    <ext:MenuItem runat="server" Text="Item 2" IconCls="x-md md-icon-save" />
                    <ext:MenuItem runat="server" Text="Item 3" IconCls="x-md md-icon-print" />
                </Items>
            </ext:Menu>
        </Menu>
    </ext:Button>

    <h3>7. SplitButton with menu</h3>

    <ext:SplitButton runat="server" Text="Text" Scale="Medium">
        <Menu>
            <ext:Menu runat="server">
                <Items>
                    <ext:MenuItem runat="server" Text="Item 1" IconCls="x-md md-icon-edit" />
                    <ext:MenuItem runat="server" Text="Item 2" IconCls="x-md md-icon-save" />
                    <ext:MenuItem runat="server" Text="Item 3" IconCls="x-md md-icon-print" />
                </Items>
            </ext:Menu>
        </Menu>
    </ext:SplitButton>

    <h3>8. SplitButton with custom drop down</h3>

    <ext:SplitButton runat="server" Text="Text" Scale="Medium">
        <Bin>
            <ext:Panel runat="server" Width="180" Height="360" Layout="Accordion" Floating="true">
                <Items>
                    <ext:Panel runat="server" Title="Item 1" />
                    <ext:Panel runat="server" Title="Item 2" />
                    <ext:Panel runat="server" Title="Item 3" />
                    <ext:Panel runat="server" Title="Item 4" />
                    <ext:Panel runat="server" Title="Item 5" />
                </Items>
                <BottomBar>
                    <ext:Toolbar runat="server" ClassicButtonStyle="true">
                        <Items>
                            <ext:ToolbarFill runat="server" />
                            <ext:Button runat="server" Text="Close" Handler="function () {this.up('panel').hide();}" />
                        </Items>
                    </ext:Toolbar>
                </BottomBar>
            </ext:Panel>
        </Bin>
        <Listeners>
            <ArrowClick Handler="this.bin[0].show(); this.bin[0].alignTo(this.el);">
            </ArrowClick>
        </Listeners>
    </ext:SplitButton>

    <h3>9. CycleButton</h3>

    <ext:CycleButton runat="server" ShowText="true" Scale="Medium" PrependText="View As ">
        <Menu>
            <ext:Menu runat="server">
                <Items>
                    <ext:CheckMenuItem runat="server" Text="Text Only" IconCls="x-md md-icon-check-circle-outline" />
                    <ext:CheckMenuItem runat="server" Text="Html" IconCls="x-md md-icon-check-circle-outline" Checked="true" />
                </Items>
            </ext:Menu>
        </Menu>
    </ext:CycleButton>

    <h3>10. Flat Button</h3>

    <ext:Button runat="server" Text="FlatButton" Scale="Medium" IconCls="x-md md-icon-check-circle-outline" Flat="true" />

    <h3>11. Custom Size Button</h3>

    <ext:Button ID="Button1" runat="server" Text="128 x 128" Height="128" Width="128" />

    <h3>12. Hyperlink</h3>

    <ext:Hyperlink runat="server" Text="Hyperlink" />
</body>
</html>