<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

            this.ResourceManager1.RegisterIcon(Icon.Information);

            Window1.Width = 250;
            Window1.Height = 350;

            switch (curTheme.Theme)
            {
                case Ext.Net.Theme.Triton:
                    Window1.Width = 310;
                    Window1.Height = 556;
                    break;
                case Ext.Net.Theme.CrispTouch:
                    Window1.Width = 330;
                    Window1.Height = 525;
                    break;
                case Ext.Net.Theme.Gray:
                case Ext.Net.Theme.Default:
                    //Window1.Height = 503; // left comment as an example/reference
                    break;
                case Ext.Net.Theme.Crisp:
                    Window1.Width = 275;
                    Window1.Height = 391;
                    break;
                case Ext.Net.Theme.Neptune:
                    Window1.Width = 290;
                    Window1.Height = 427;
                    break;
                case Ext.Net.Theme.Aria:
                    Window1.Width = 320;
                    Window1.Height = 427;
                    break;
                case Ext.Net.Theme.NeptuneTouch:
                    Window1.Width = 340;
                    Window1.Height = 559;
                    break;
            }
        }
    }

    public static string stub = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ...";

    protected void Option1_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            Html = stub
        });
    }

    protected void Option2_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.TopRight,
                TargetAnchor = AnchorPoint.TopRight,
                OffsetX = -20,
                OffsetY = 20
            },
            ShowFx = new SlideIn { Anchor = AnchorPoint.TopRight, Options = new FxConfig { Easing = Easing.BounceOut } },
            HideFx = new Ghost { Anchor = AnchorPoint.TopRight },
            Html = stub
        });
    }

    protected void Option3_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.TopLeft,
                TargetAnchor = AnchorPoint.TopLeft,
                OffsetX = 20,
                OffsetY = 20
            },
            ShowFx = new SlideIn { Anchor = AnchorPoint.TopLeft, Options = new FxConfig { Easing = Easing.BounceOut } },
            HideFx = new SwitchOff(),
            Html = stub
        });
    }

    protected void Option4_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            HideDelay = 1000,
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.BottomLeft,
                TargetAnchor = AnchorPoint.BottomLeft,
                OffsetX = 20,
                OffsetY = -20
            },
            ShowFx = new FadeIn { Options = new FxConfig { Duration = 2000 } },
            HideFx = new FadeOut { Options = new FadeOutConfig { Duration = 2000, EndOpacity = 0.25f } },
            Html = stub
        });
    }

    protected void Option10_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            Height = 150,
            Width = 300,
            BodyStyle = "padding:10px",
            Html = stub,
            ShowFx = new SlideIn { Anchor = AnchorPoint.Right },
            HideFx = new SlideOut { Anchor = AnchorPoint.Right }
        });
    }

    protected void Option11_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            AutoHide = false,
            Html = stub
        });
    }

    protected void Option12_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            HideDelay = 2000,
            Html = stub
        });
    }

    protected void Option13_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            PinEvent = "mouseover",
            Html = stub
        });
    }

    protected void Option14_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            CloseVisible = true,
            Html = stub
        });
    }

    protected void Option15_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            Width = 500,
            Height = 400,
            AutoHide = false,
            Html = stub
        });
    }

    protected void Option16_Click(object sender, DirectEventArgs e)
    {
        WindowListeners listeners = new WindowListeners();

        listeners.BeforeShow.Handler = string.Concat(BarLabel.ClientID, ".setText(Ext.Date.format(new Date(), 'g:i:s A'));");

        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            Icon = Icon.Information,
            Height = 150,
            AutoHide = false,
            CloseVisible = true,
            ContentEl = "customEl",
            Listeners = listeners
        });
    }

    protected void Option5_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.TopLeft,
                TargetAnchor = AnchorPoint.BottomRight,
                OffsetX = 10,
                OffsetY = 10,
                El = Window1.ConfigID
            },
            ShowFx = new SlideIn { Anchor = AnchorPoint.Top },
            HideFx = new Ghost { Anchor = AnchorPoint.Top },
            Html = stub
        });
    }

    protected void Option6_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            BringToFront = true,
            AlignCfg = new NotificationAlignConfig
            {
                OffsetX = -10,
                OffsetY = -10,
                El = Window1.ConfigID
            },
            Html = stub
        });
    }

    protected void Option7_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.Bottom,
                TargetAnchor = AnchorPoint.Top,
                OffsetX = 0,
                OffsetY = -2,
                El = Window1.ConfigID
            },
            Width = 300,
            Html = stub
        });
    }

    protected void Option8_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.Top,
                TargetAnchor = AnchorPoint.Bottom,
                OffsetX = 0,
                OffsetY = 2,
                El = Window1.ConfigID
            },
            ShowFx = new SlideIn{Anchor = AnchorPoint.Top},
            HideFx = new Ghost{Anchor = AnchorPoint.Top},
            Width = 300,
            Html = stub
        });
    }

    protected void Option9_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            AlignCfg = new NotificationAlignConfig
            {
                ElementAnchor = AnchorPoint.Left,
                TargetAnchor = AnchorPoint.Right,
                OffsetX = 2,
                OffsetY = 0,
                El = Window1.ConfigID
            },
            ShowFx = new SlideIn { Anchor = AnchorPoint.Left },
            HideFx = new Ghost { Anchor = AnchorPoint.Left },
            Height = 350,
            Html = stub
        });
    }

    protected void Option17_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            ShowPin = true,
            Html = stub
        });
    }

    protected void Option18_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            ShowPin = true,
            Pinned = true,
            Html = stub
        });
    }

    protected void Option19_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Title",
            ShowPin = true,
            Tools = new ToolsCollection{new Tool{Type = ToolType.Help, Handler = X.MessageBox.Alert("Help","Help button clicked").ToScript()}},
            Html = stub
        });
    }

    protected void Option20_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            PinEvent = "none",
            Plain = true,
            Header = false,
            Html = stub
        });
    }

    protected void Option21_Click(object sender, DirectEventArgs e)
    {
        Notification.Show(new NotificationConfig
        {
            Title = "Items",
            Height = 200,
            Width = 200,
            HideDelay = 7000,
            Layout = LayoutType.Border.ToString(),
            ShowPin = true,
            Items =
            {
                new Ext.Net.Panel
                {
                    Region = Region.West,
                    Collapsible = true,
                    Title = "West",
                    Width = 100,
                    Icon = Icon.Add
                },

                new Ext.Net.Panel
                {
                    Title = "Center",
                    Region = Region.Center,
                    Icon = Icon.PageWhiteEdit
                }
            },
            DockedItems =
            {
                new Toolbar
                {
                    Dock = Dock.Bottom,
                    Items =
                    {
                        new TextField
                        {
                            Flex = 1,
                            EmptyText = "Focus to pin",
                            Listeners =
                            {
                                Focus =
                                {
                                    Handler = "this.up('window').pin();"
                                }
                            }
                        },
                        new Ext.Net.Button { Icon = Icon.Magnifier }
                    }
                }
            }
        });
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Summary of Notification options - Ext.NET Examples</title>
    <style>
        .menu-label {
            border-bottom : dotted 1px;
            margin-left   : 25px;
        }
    </style>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />

    <ext:Window
        ID="Window1"
        runat="server"
        Title="Notifications"
        Layout="Accordion">
        <Items>
            <ext:MenuPanel runat="server" Title="Basic Align" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show Bottom Right">
                            <DirectEvents>
                                <Click OnEvent="Option1_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Top Right">
                            <DirectEvents>
                                <Click OnEvent="Option2_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Top Left">
                            <DirectEvents>
                                <Click OnEvent="Option3_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Bottom Left">
                            <DirectEvents>
                                <Click OnEvent="Option4_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Custom Align" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show Bottom Right Outside Window">
                            <DirectEvents>
                                <Click OnEvent="Option5_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Bottom Right Inside Window">
                            <DirectEvents>
                                <Click OnEvent="Option6_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Above Top Edge">
                            <DirectEvents>
                                <Click OnEvent="Option7_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Below Bottom Edge">
                            <DirectEvents>
                                <Click OnEvent="Option8_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem ID="MenuItem1" runat="server" Text="Show Right">
                            <DirectEvents>
                                <Click OnEvent="Option9_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="ShowMode" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:Label runat="server" Text="Click Several Times" Cls="menu-label" />
                        <ext:MenuItem runat="server" Text="Show Bottom Right">
                            <DirectEvents>
                                <Click OnEvent="Option10_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Hide Functionality" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Auto Hiding">
                            <DirectEvents>
                                <Click OnEvent="Option11_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="2 Second Delay">
                            <DirectEvents>
                                <Click OnEvent="Option12_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Mouseover Stop Hiding">
                            <DirectEvents>
                                <Click OnEvent="Option13_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Close All Other Notifications">
                            <DirectEvents>
                                <Click OnEvent="Option14_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Content Functionality" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show with Items">
                            <DirectEvents>
                                <Click OnEvent="Option21_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show with AutoLoad">
                            <DirectEvents>
                                <Click OnEvent="Option15_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show with Content Element">
                            <DirectEvents>
                                <Click OnEvent="Option16_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Tools" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show Pin Tool Button">
                            <DirectEvents>
                                <Click OnEvent="Option17_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Pinned Pin Tool Button">
                            <DirectEvents>
                                <Click OnEvent="Option18_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Custom Tool Button">
                            <DirectEvents>
                                <Click OnEvent="Option19_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Other" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="No Title">
                            <DirectEvents>
                                <Click OnEvent="Option20_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>
        </Items>
    </ext:Window>

    <div id="customEl" class="x-hidden">
        <ext:Panel
            ID="CustomEl1"
            runat="server"
            Border="false"
            BodyPadding="2"
            AutoDataBind="true"
            Height="113"
            Width="180">
            <Content>
                <%# stub %>
            </Content>
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarTextItem ID="BarLabel" runat="server" />
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Email" />
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:Panel>
    </div>
</body>
</html>