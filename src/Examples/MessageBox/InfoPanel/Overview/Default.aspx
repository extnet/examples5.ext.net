<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !X.IsAjaxRequest)
        {
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

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
                case Ext.Net.Theme.Graphite:
                    Window1.Width = 375;
                    Window1.Height = 690;
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

    protected void ShowSimple1_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Info("Server time", DateTime.Now.ToShortTimeString()).Show();
    }

    protected void ShowConfig1_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Info(new InfoPanel
        {
            Title = "Server time",
            Icon = Icon.Clock,
            Html = DateTime.Now.ToShortTimeString()
        }).Show();
    }

    protected void ShowSimple2_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Info("Server time", DateTime.Now.ToShortTimeString(), "bottomright").Show();
    }

    protected void ShowConfig2_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Info(new InfoPanel
        {
            Title = "Server time",
            Icon = Icon.Clock,
            Html = DateTime.Now.ToShortTimeString(),
            QueueName = "bottomright"
        }).Show();
    }

    protected void ShowItems_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Info(new InfoPanel
        {
            Title = "Confirmation",
            Layout = "Form",
            Width = 300,
            AutoHide = false,
            Items =
            {
                new TextField
                {
                    FieldLabel = "Confirm your age"
                }
            },
            Buttons =
            {
                new Ext.Net.Button
                {
                    Text = "Confirm",
                    Handler = "this.up('infopanel').destroy();"
                }
            }
        }).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Info - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var showConfig = function (queue) {
            Ext.Msg.info({
                title: 'Time to close',
                html: "&nbsp;",
                queue: queue,
                listeners: {
                    render: function () {
                        var me = this,
                            counter = me.hideDelay / 1000;

                        me._intr = setInterval(function () {
                            me.body.update(counter-- + " sec...");
                        }, 1000);
                    },
                    destroy: function () {
                        clearInterval(this._intr);
                    }
                }
            });
        }

        var showHz = function () {
            Ext.Msg.info('Client time', Ext.Date.format(new Date(), 'G:i'), 'horizontal');
        }

        var reuse = function () {
            var cmp = Ext.getCmp('reuse'),
                rand = Math.floor(Math.random()*10000);

            if (cmp) {
                cmp.restartHideTask();
                cmp.body.update(rand);
            } else {
                Ext.Msg.info({
                    id: 'reuse',
                    title: 'Reused notification',
                    html: rand
                });
            }
        }
    </script>
    <%
    // For tnow, the Graphite theme will need custom CSS for the callout box.
    if (Ext.Net.ResourceManager.GetInstance(HttpContext.Current).Theme == Ext.Net.Theme.Graphite)
    { %>
    <style type="text/css">
        .x-infopanel { background: black }
        .x-infopanel .x-infopanel-body { background: #404040 }
    </style>
    <% } %>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <p>Main Features:</p>

    <ul>
        <li>Multiple notifications queues<br />
            You can define align position, animation, sliding direction, defaults properties for queue, all queue notifications will follow these options.</li>
        <li>Any container can be defined as notifications owner.</li>
        <li>Notification can be used as non floating widget (can be used inside Items/Content of any widget)</li>
        <li>All queue notifications are available via items property of queue</li>
        <li>Vertical and horizontal sliding is allowed.</li>
        <li>If a notification is closed then other notifications will be slided back.</li>
        <li>Notification is inherited from a panel therefore all panel functionality is available.</li>
        <li>Easy customization of css, animations, durations, spacings/padding etc.</li>
        <li>Standard UI support: Primary, Info, Success, Warning, Danger</li>
    </ul>

    <ext:Window
        ID="Window1"
        runat="server"
        Title="Notifications"
        Layout="Accordion">
        <Bin>
            <ext:InfoPanelQueue
                runat="server"
                Name="horizontal"
                AlignmentSpec="tl-tl"
                Vertical="false"
                AddToEnd="false"
                SlideTo="Right"
                />
            <ext:InfoPanelQueue
                runat="server"
                Name="topedge"
                AlignmentSpec="t-t"
                Spacing="1"
                OffsetX="0"
                OffsetY="0">
                <Listeners>
                    <BeforeAdd Handler="notification.width = Ext.dom.Element.getDocumentWidth() - 100;" />
                </Listeners>
            </ext:InfoPanelQueue>
        </Bin>
        <Items>
            <ext:MenuPanel runat="server" Title="Default queue" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show simple from server">
                            <DirectEvents>
                                <Click OnEvent="ShowSimple1_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show config from server">
                            <DirectEvents>
                                <Click OnEvent="ShowConfig1_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show simple from client">
                            <Listeners>
                                <Click Handler="Ext.Msg.info('Client time', Ext.Date.format(new Date(), 'G:i'));" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show config from client">
                            <Listeners>
                                <Click Handler="showConfig()" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Bottom-right queue" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show simple from server">
                            <DirectEvents>
                                <Click OnEvent="ShowSimple2_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show config from server">
                            <DirectEvents>
                                <Click OnEvent="ShowConfig2_Click" />
                            </DirectEvents>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show simple from client">
                            <Listeners>
                                <Click Handler="Ext.Msg.info('Client time', Ext.Date.format(new Date(), 'G:i'), 'bottomright');" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show config from client">
                            <Listeners>
                                <Click Handler="showConfig('bottomright')" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Horizontal" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show several infos">
                            <Listeners>
                                <Click Handler="showHz(); showHz(); showHz();" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Reuse" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show">
                            <Listeners>
                                <Click Fn="reuse" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Custom Align" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show Bottom Right Outside Window">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({alignmentEl:App.Window1.el, alignment: 'tl-br', title: 'Title', html:'Message'});" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Bottom Right Inside Window">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({alignmentEl:App.Window1.el, alignment: 'br-br', title: 'Title', html:'Message', bringToFront: true});" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Above Top Edge">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({alignmentEl:App.Window1.el, alignment: 'b-t', title: 'Title', html:'Message'});" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Below Bottom Edge">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({alignmentEl:App.Window1.el, alignment: 't-b', title: 'Title', html:'Message'});" />
                            </Listeners>
                        </ext:MenuItem>

                        <ext:MenuItem runat="server" Text="Show Right">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({alignmentEl:App.Window1.el, alignment: 'l-r', title: 'Title', html:'Message'});" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Items" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show">
                            <DirectEvents>
                                <Click OnEvent="ShowItems_Click" />
                            </DirectEvents>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:MenuPanel runat="server" Title="Queue with event" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Show">
                            <Listeners>
                                <Click Handler="Ext.Msg.info({queue: 'topedge', html:'Message', ui:'danger'});" />
                            </Listeners>
                        </ext:MenuItem>
                    </Items>
                </Menu>
            </ext:MenuPanel>
        </Items>
    </ext:Window>
</body>
</html>