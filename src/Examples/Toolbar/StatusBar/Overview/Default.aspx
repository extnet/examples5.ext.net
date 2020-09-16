<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.ResourceManager1.RegisterIcon(Icon.Accept);
        }
    }

    protected void UpdateStatusBar(object sender, DirectEventArgs e)
    {
        // Delay the Thread for .5 seconds
        System.Threading.Thread.Sleep(500);

        string index = e.ExtraParams["index"];

        Ext.Net.Button button = ControlUtils.FindControl(this.ResourceManager1, "Button" + index) as Ext.Net.Button;

        StatusBar statusBar = ControlUtils.FindControl(this.ResourceManager1, "StatusBar" + index) as StatusBar;

        statusBar.SetStatus(new StatusBarStatusConfig("Updated: " + DateTime.Now.ToLongTimeString() + " (server time)", ""));
        button.Disabled = false;
    }

    protected void TextArea1_Save(object sender, DirectEventArgs e)
    {
        // Delay the Thread for .5 seconds to demonstrate the status indicator
        System.Threading.Thread.Sleep(500);

        StatusBarStatusConfig config = new StatusBarStatusConfig();
        config.IconCls = "x-status-saved";
        config.Text = string.Concat("Draft auto-saved at ", DateTime.Now.ToLongTimeString(), " (server time)");

        this.StatusBar4.SetStatus(config);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>StatusBar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .word-status .x-status-text {
            color : #777;
        }

        .word-status .x-status-busy {
            background   : transparent url(images/saving.gif) no-repeat scroll 3px 0px !important;
            padding-left : 25px !important;
        }

        .word-status .x-status-saved {
            background   : transparent url(/icons/accept-png/ext.axd) no-repeat scroll 3px 0px !important;
            padding-left : 25px !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>StatusBar Examples</h1>

        <p>Here are several examples of using and customizing the Ext.StatusBar component.</p>

        <h2>1. Basic StatusBar</h2>

        <p>This is a simple StatusBar with a few standard Toolbar items included.</p>

        <ext:Panel
            ID="Panel1"
            runat="server"
            Title="Basic StatusBar"
            Width="500"
            Height="180"
            BodyPadding="18">
            <Items>
                <ext:Button ID="Button1" runat="server" Text="Do Loading">
                    <DirectEvents>
                        <Click OnEvent="UpdateStatusBar" Before="el.disable();#{StatusBar1}.showBusy();">
                            <EventMask MinDelay="2000" />
                            <ExtraParams>
                                <ext:Parameter Name="index" Value="1" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Items>
            <BottomBar>
                <ext:StatusBar ID="StatusBar1" runat="server" DefaultText="Default status">
                    <Items>
                        <ext:Button runat="server" Text="A Button" />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:ToolbarTextItem runat="server" Text="Plain Text" />
                    </Items>
                </ext:StatusBar>
            </BottomBar>
        </ext:Panel>

        <h2>2. Right-Aligned StatusBar</h2>

        <p>This is a simple StatusBar that has the status element right-aligned. Any StatusBar items will be added in exactly the same order on the left side of the bar.</p>

         <ext:Panel
            ID="Panel2"
            runat="server"
            Title="Right-aligned StatusBar"
            Width="500"
            Height="180"
            BodyPadding="18">
            <Items>
                <ext:Button ID="Button2" runat="server" Text="Do Loading">
                    <DirectEvents>
                        <Click OnEvent="UpdateStatusBar" Before="el.disable();#{StatusBar2}.showBusy();">
                            <EventMask MinDelay="2000" />
                            <ExtraParams>
                                <ext:Parameter Name="index" Value="2" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Items>
            <BottomBar>
                <ext:StatusBar
                    ID="StatusBar2"
                    runat="server"
                    DefaultText="Default status"
                    StatusAlign="Right">
                    <Items>
                        <ext:Button runat="server" Text="A Button" />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:ToolbarTextItem runat="server" Text="Plain Text" />
                    </Items>
                </ext:StatusBar>
            </BottomBar>
        </ext:Panel>

        <h2>3. Status Window</h2>

        <p>You can add a StatusBar to a window in exactly the same way.</p>

        <ext:Button
            ID="Button4"
            runat="server"
            Text="Show Window"
            OnClientClick="#{Window1}.show();"
            />

        <ext:Window
            ID="Window1"
            runat="server"
            Collapsible="false"
            IconCls="x-md md-icon-open-in-new"
            Title="StatusBar Window"
            Width="960"
            MinWidth="350"
            Modal="true"
            Height="180"
            BodyPadding="18"
            Hidden="true">
            <Items>
                <ext:Button ID="Button3" runat="server" Text="Do Loading">
                    <DirectEvents>
                        <Click OnEvent="UpdateStatusBar" Before="el.disable();#{StatusBar3}.showBusy();">
                            <EventMask MinDelay="2000" />
                            <ExtraParams>
                                <ext:Parameter Name="index" Value="3" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Items>
            <BottomBar>
                <ext:StatusBar ID="StatusBar3" runat="server" DefaultText="Ready">
                    <Items>
                        <ext:Button runat="server" Text="A Button" />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:ToolbarTextItem runat="server" AutoDataBind="true" Text='<%# DateTime.Today.ToShortDateString() %>' />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:SplitButton runat="server" Text="Status Menu" MenuAlign="br-tr?">
                            <Menu>
                                <ext:Menu ID="Menu1" runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Item1" />
                                        <ext:MenuItem runat="server" Text="Item2" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                    </Items>
                </ext:StatusBar>
            </BottomBar>
        </ext:Window>

        <h2>4. Customizing the Look and Feel</h2>

        <p>This is a standard StatusBar with some custom CSS styles applied and some event handling in place to handle the TextArea's keypress events. Notice that after you've stopped typing for a few seconds a simulated auto-save process will begin.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Title="Word Processor"
            BodyPadding="18"
            Layout="Fit">
            <Items>
                <ext:TextArea
                    ID="TextArea1"
                    runat="server"
                    EnableKeyEvents="true"
                    Grow="true"
                    GrowMin="100"
                    GrowMax="200">
                    <Listeners>
                        <KeyDown
                            Handler="var v = this.getValue(),
                                wc = 0, cc = v.length ? v.length : 0;

                                if (cc &gt; 0) {
                                    wc = v.match(/\b/g);
                                    wc = wc ? wc.length / 2 : 0;
                                }

                                #{wordCount}.setText('Words: ' + wc);
                                #{charCount}.setText('Chars: ' + cc);"
                             Buffer="1"
                             />
                    </Listeners>
                    <DirectEvents>
                        <KeyPress
                            OnEvent="TextArea1_Save"
                            Buffer="1500"
                            Before="#{StatusBar4}.showBusy('Saving draft...');"
                            />
                    </DirectEvents>
                </ext:TextArea>
            </Items>
            <BottomBar>
                <ext:StatusBar
                    ID="StatusBar4"
                    CtCls="word-status"
                    runat="server"
                    DefaultText="Ready">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:ToolbarTextItem
                            ID="wordCount"
                            runat="server"
                            Text="Words: 0"
                            CtCls="x-status-text-panel"
                            />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:ToolbarTextItem
                            ID="charCount"
                            runat="server"
                            Text="Chars: 0"
                            CtCls="x-status-text-panel"
                            />
                        <ext:ToolbarSeparator runat="server" />
                        <ext:ToolbarTextItem
                            ID="clock"
                            runat="server"
                            Text=" "
                            CtCls="x-status-text-panel"
                            />
                    </Items>
                </ext:StatusBar>
            </BottomBar>
        </ext:Panel>

        <ext:TaskManager runat="server">
            <Tasks>
                <ext:Task AutoRun="true" Interval="1000">
                    <Listeners>
                        <Update Handler="#{clock}.setText(Ext.Date.format(new Date(), 'g:i:s A'));" />
                    </Listeners>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>