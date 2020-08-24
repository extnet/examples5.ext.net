<%@ Page Language="C#" %>

<%@ Register Src="modules/AccordionWindow.ascx" TagPrefix="mod" TagName="AccordionWindow" %>
<%@ Register Src="modules/GridWindow.ascx" TagPrefix="mod" TagName="GridWindow" %>
<%@ Register Src="modules/SystemStatus.ascx" TagPrefix="mod" TagName="SystemStatus" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            // dynamic module loading via DesktopModuleProxy
            this.LoadControl("modules/WhatsNew.ascx");

            // Fixes some theme-specific settings
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

            switch (curTheme.Theme)
            {
                case Ext.Net.Theme.Spotless:
                case Ext.Net.Theme.Triton:
                    // For this one the value specified in markup is good.
                    break;
                case Ext.Net.Theme.Classic:
                case Ext.Net.Theme.Gray:
                    Desktop1.TaskBar.QuickStartWidth = 50;
                    Desktop1.TaskBar.TrayWidth = 90;
                    break;
                case Ext.Net.Theme.CrispTouch:
                case Ext.Net.Theme.NeptuneTouch:
                    Desktop1.TaskBar.QuickStartWidth = 84;
                    Desktop1.TaskBar.TrayWidth = 127;
                    break;
                case Ext.Net.Theme.Crisp:
                case Ext.Net.Theme.Neptune:
                    Desktop1.TaskBar.QuickStartWidth = 64;
                    Desktop1.TaskBar.TrayWidth = 114;
                    break;
                case Ext.Net.Theme.Aria:
                    Desktop1.TaskBar.QuickStartWidth = 64;
                    Desktop1.TaskBar.TrayWidth = 119;
                    break;
                case Ext.Net.Theme.Graphite:
                    CustomToolbar.Defaults.Add(new Ext.Net.Parameter("width", "145", ParameterMode.Raw));
                    CustomToolbar.Width = 725;
                    Desktop1.StartMenu.Width = 350;
                    Desktop1.TaskBar.QuickStartWidth = 112;
                    Desktop1.TaskBar.TrayWidth = 174;
                    GreetingWindow.Width = 260;
                    GreetingWindow.Height = 110;
                    StartMenuToolbar.Width = 150;
                    break;
                case Ext.Net.Theme.Material:
                    CustomToolbar.Defaults.Add(new Ext.Net.Parameter("width", "135", ParameterMode.Raw));
                    CustomToolbar.Width = 725;
                    Desktop1.StartMenu.Width = 310;
                    Desktop1.TaskBar.QuickStartWidth = 112;
                    Desktop1.TaskBar.TrayWidth = 183;
                    GreetingWindow.Width = 200;
                    GreetingWindow.Height = 110;
                    StartMenuToolbar.Width = 130;
                    break;
            }
        }
    }

    protected void Logout_Click(object sender, DirectEventArgs e)
    {
        // Logout from Authenticated Session
        this.Response.Redirect("Default.aspx");
    }

    [DirectMethod(ShowMask = true)]
    public void CreateWindow()
    {
        Desktop.GetInstance().CreateWindow(new Window
        {
            Title = "New window",
            Width = 300,
            Height = 300,
            CloseAction = CloseAction.Destroy,
            Html="The window is created"
        });
    }

    [DirectMethod(ShowMask=true)]
    public void AddNewModule()
    {
        Desktop.GetInstance().RemoveModule("add-module");
        DesktopModuleProxy control = Ext.Net.Utilities.ControlUtils.FindControl<Ext.Net.DesktopModuleProxy>(this.LoadControl("modules/TabWindow.ascx"));
        control.RegisterModule();
    }

    [DirectMethod(ShowMask = true)]
    public void AddAnotherModule()
    {
        Desktop.GetInstance().RemoveModule("add1-module");
        DesktopModule m = new DesktopModule
        {
            ModuleID = "dyn-mod",
            Shortcut = new DesktopShortcut
            {
                Name = "Dynamic Module"
            },

            Launcher = new Ext.Net.MenuItem
            {
                Text = "Dynamic module"
            },

            Window =
            {
                new Window
                {
                    Title = "Dynamic Window",
                    Width = 300,
                    Height = 300,
                    DefaultRenderTo = Ext.Net.DefaultRenderTo.Form,
                    Icon = Icon.ApplicationAdd
                }
            },

            AutoRun = true
        };

        Desktop1.AddModule(m);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>

    <link href="resources/desktop.css" rel="stylesheet" />

    <script>
        var tile = function () {
            Ext.net.Desktop.desktop.tileWindows();
        };

        var cascade = function () {
            Ext.net.Desktop.desktop.cascadeWindows();
        };

        var initSlidePanel = function () {
            this.setHeight(Ext.net.Desktop.desktop.body.getHeight());

            if (!this.windowListen) {
                this.windowListen = true;
                this.show();

                this.el.alignTo(Ext.net.Desktop.desktop.body, 'tl-tr', [0, 0]);
                Ext.on("resize", initSlidePanel, this);
            }
        };
    </script>
</head>
<body>
        <ext:ResourceManager runat="server">
            <Listeners>
                <WindowResize Handler="Ext.net.Bus.publish('App.Desktop.ready');" Buffer="500" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Desktop ID="Desktop1" runat="server">
            <Modules>
                <ext:DesktopModule ModuleID="Hello" AutoRun="true">
                    <Window>
                        <ext:Window runat="server"
                            ID="GreetingWindow"
                            Plain="true"
                            Padding="10"
                            Width="150"
                            Height="100"
                            Title="Greeting"
                            CloseAction="Destroy"
                            Maximizable="false"
                            Minimizable="false">
                            <Content>
                                Welcome to Ext.Net desktop!
                            </Content>
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="notepad">
                    <Shortcut Name="Notepad" IconCls="x-notepad-shortcut" SortIndex="2" />
                    <Launcher Text="Notepad" Icon="ApplicationForm" />
                    <Window>
                        <ext:Window runat="server"
                            Title="Notepad"
                            Width="750"
                            Height="400"
                            Icon="ApplicationForm"
                            AnimCollapse="false"
                            Border="false"
                            HideMode="Offsets"
                            Layout="Fit"
                            CloseAction="Destroy">
                            <Items>
                                <ext:HtmlEditor
                                    runat="server"
                                    Text="Some <b>rich</b> <font color='red'>text</font> goes <u>here</u><br>Give it a try!" />
                            </Items>
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="create-module">
                    <Shortcut Name="Create window" Handler="function () {#{DirectMethods}.CreateWindow();}" SortIndex="3">
                    </Shortcut>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="add-module">
                    <Shortcut Name="Render dynamic module" Handler="function () {#{DirectMethods}.AddNewModule();}" X="200" Y="100" TextCls="x-long-label">
                    </Shortcut>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="add1-module">
                    <Shortcut Name="Render another module" Handler="function () {#{DirectMethods}.AddAnotherModule();}" X="200" Y="300" TextCls="x-long-label">
                    </Shortcut>
                </ext:DesktopModule>
            </Modules>

            <DesktopConfig Wallpaper="resources/wallpapers/blue.jpg" ShortcutDragSelector="true">
                <ShortcutDefaults IconCls="x-default-shortcut" />
                <ContextMenu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem runat="server" Text="Change Settings" />
                            <ext:MenuSeparator runat="server" />
                            <ext:MenuItem runat="server" Text="Tile" Handler="tile" Icon="ApplicationTileVertical" />
                            <ext:MenuItem runat="server" Text="Cascade" Handler="cascade" Icon="ApplicationCascade" />
                        </Items>
                    </ext:Menu>
                </ContextMenu>

                <Content>
                   <ext:Image runat="server" ImageUrl="resources/logo.png" StyleSpec="position:absolute;top: 50%;left: 50%;width: 77px; height: 78px;margin-top: -39px; margin-left: -39px;"/>
                   <ext:Image runat="server" ImageUrl="resources/powered.png" StyleSpec="position:absolute;right:10px;bottom:20px;width:300px;height:39px;"/>
                   <ext:DisplayField runat="server" Text="You can place controls to desktop" FieldStyle="color:white;font-size:24px;" StyleSpec="position:absolute;left: 50%; bottom: 100px;margin-left: -180px;"/>
                   <ext:DisplayField runat="server" Text="Move mouse to the right edge -->" FieldStyle="color:white;font-size:24px;" StyleSpec="position:absolute;right:50px;top:50px;"/>

                   <ext:Toolbar ID="CustomToolbar" runat="server" Width="545" Floating="true" ClassicButtonStyle="true" Flat="true" Border="false" Shadow="false">
                        <Defaults>
                            <ext:Parameter Name="IconAlign" Value="top" />
                            <ext:Parameter Name="Width" Value="105" />
                            <ext:Parameter Name="Icon" Value="resources/cmd.png" />
                            <ext:Parameter Name="Scale" Value="large" />
                            <ext:Parameter Name="Handler" Value="function () {Ext.Msg.alert('Launch', this.text);}" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="Word" />
                            <ext:Button runat="server" Text="Excel" />
                            <ext:Button runat="server" Text="Notepad" />
                            <ext:Button runat="server" Text="Paint" />
                            <ext:Button runat="server" Text="Explorer" />
                        </Items>
                        <MessageBusListeners>
                            <ext:MessageBusListener Name="App.Desktop.ready" Handler="this.el.anchorTo(Ext.net.Desktop.desktop.body, 'c-b', [0, -50]);" />
                        </MessageBusListeners>
                    </ext:Toolbar>
                </Content>
            </DesktopConfig>

            <StartMenu Title="Ext.Net Desktop" Icon="Application" Height="300">
                <ToolConfig>
                    <ext:Toolbar ID="StartMenuToolbar" runat="server" Width="100">
                        <Items>
                            <ext:Button runat="server" Text="Settings" Icon="Cog" />
                            <ext:Button runat="server" Text="Logout" Icon="Key">
                                <DirectEvents>
                                    <Click OnEvent="Logout_Click">
                                        <EventMask ShowMask="true" Msg="Good Bye..." MinDelay="1000" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </ToolConfig>
            </StartMenu>

            <TaskBar QuickStartWidth="80" TrayWidth="125">
                <QuickStart>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button runat="server" Handler="tile" Icon="ApplicationTileVertical" OverflowText="Tile windows">
                                <QTipCfg Text="Tile windows" />
                            </ext:Button>

                            <ext:Button runat="server" Handler="cascade" Icon="ApplicationCascade" OverflowText="Cascade windows">
                                <QTipCfg Text="Cascade windows" />
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </QuickStart>

                <Tray>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button ID="LangButton" runat="server" Text="EN" Cls="x-bold-text" MenuAlign="br-tr" ArrowVisible="false">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="English" Checked="true" CheckHandler="function (item, checked) {checked && #{LangButton}.setText('EN');}" />
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="French" CheckHandler="function (item, checked) {checked && #{LangButton}.setText('FR');}" />
                                            <ext:MenuSeparator runat="server" />
                                            <ext:MenuItem runat="server" Text="Show the Language Bar" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:ToolbarFill runat="server" />
                        </Items>
                    </ext:Toolbar>
                </Tray>
            </TaskBar>
            <Listeners>
                <Ready BroadcastOnBus="App.Desktop.ready" />
            </Listeners>
        </ext:Desktop>

        <ext:Panel runat="server" Title="Slide panel" Frame="true" Width="250" Layout="Accordion" Floating="true" Shadow="false" Hidden="true">
            <Items>
                <ext:Panel runat="server" Title="Section 1" Icon="User" />
                <ext:Panel runat="server" Title="Section 2" Icon="UserB" />
                <ext:Panel runat="server" Title="Section 3" Icon="UserB" />
                <ext:Panel runat="server" Title="Section 4" Icon="UserB" />
                <ext:Panel runat="server" Title="Section 5" Icon="UserB" />
            </Items>
            <MessageBusListeners>
                <ext:MessageBusListener Name="App.Desktop.ready" Fn="initSlidePanel" />
            </MessageBusListeners>
            <Plugins>
                <ext:MouseDistanceSensor runat="server" Opacity="false" Threshold="25">
                    <Listeners>
                        <Near Handler="this.component.el.alignTo(Ext.net.Desktop.desktop.body, 'tr-tr', [0, 0], true);" />
                        <Far Handler="this.component.el.alignTo(Ext.net.Desktop.desktop.body, 'tl-tr', [0, 0], true);" />
                    </Listeners>
                </ext:MouseDistanceSensor>
            </Plugins>
        </ext:Panel>

        <%--Modules from User controls--%>
        <mod:AccordionWindow runat="server" />
        <mod:GridWindow runat="server" />
        <mod:SystemStatus runat="server" />
</body>
</html>