<%@ Page Language="C#" %>

<script runat="server">
    protected void ShowDangerInfo(object sender, DirectEventArgs e)
    {
        this.ShowInfo(UI.Danger, "Danger Info", "You can insert message here");
    }

    protected void ShowWarningInfo(object sender, DirectEventArgs e)
    {
        this.ShowInfo(UI.Warning, "Warning Info", "You can insert message here");
    }

    private void ShowInfo(UI ui, string title, string message)
    {
        X.Msg.Info(new InfoPanel
        {
            QueueName = "window",
            UI = ui,
            TagString = ui.ToString().ToLowerInvariant(),
            Listeners =
            {
                AfterLayout =
                {
                    Fn = "closeHover",
                    Single = true
                }
            },

            Items = 
            { 
                new Component()
                {
                    Width = 60,
                    Height = 60,
                    Html = "<div class='icon'></div>"
                },
                    
                new Container()
                {
                    Flex = 1,
                    PaddingSpec = "0 0 0 10",
                    Items =
                    {
                        new DisplayField()
                        {
                            Cls = "title",
                            Text = title
                        },
                            
                        new DisplayField()
                        {
                            Cls = "message",
                            Text = message
                        },
                            
                        new Ext.Net.Button()
                        {
                            Cls= "close",
                            Hidden = true,
                            Icon = Icon.Decline,
                            Handler = "this.up('infopanel').destroy();"
                        }
                    }
                }
            }
        }).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Items infos - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .solid {
            border-radius: 0px;
            box-shadow: none;
            border-bottom: 1px solid #c1c1c1;
        }

            .solid .x-infopanel-body {
                padding: 0px;
            }

        .icon {
            position: absolute;
            top: 50%;
            left: 50%;
            height: 52px;
            width: 41px;
            margin-left: -20px;
            margin-top: -26px;
        }

        .close {
            position: absolute;
            top: 50%;
            right: 3px;
            margin-top: -13px;
        }

        .x-infopanel-info .icon {
            background: url(info.png);
        }

        .x-infopanel-success .icon {
            background: url(success.png);
        }

        .x-infopanel-danger .icon {
            background: url(danger.png);
        }

        .x-infopanel-warning .icon {
            background: url(warning.png);
        }

        .title {
            margin-top: 10px;
        }

            .title .x-form-display-field {
                font-size: 16px;
            }

        .x-infopanel-info .title .x-form-display-field {
            color: #2850c1;
        }

        .x-infopanel-success .title .x-form-display-field {
            color: #4a9d3c;
        }

        .x-infopanel-danger .title .x-form-display-field {
            color: #871414;
        }

        .x-infopanel-warning .title .x-form-display-field {
            color: #9e9a3d;
        }
    </style>

    <script>
        var closeHover = function (info) {
            var me = info,
                button = me.down("button");

            me.el.hover(function () {
                button.show();
            }, function () {
                button.hide();
            });
        }

        var showInfo = function (ui, title, message) {
            Ext.Msg.info({
                queue: "window",
                ui: ui,
                tag: ui,

                listeners: {
                    afterlayout: closeHover,
                    single: true
                },

                items: [
                    {
                        xtype: 'component',
                        width: 60,
                        height: 60,
                        html: '<div class="icon"></div>'
                    },

                    {
                        xtype: 'container',
                        flex: 1,
                        padding: '0 0 0 10',
                        items: [{
                            xtype: 'displayfield',
                            cls: 'title',
                            value: title
                        },
                        {
                            xtype: 'displayfield',
                            cls: 'message',
                            value: message
                        },
                        {
                            xtype: 'button',
                            cls: 'close',
                            hidden: true,
                            iconCls: '#Decline',
                            handler: function () {
                                this.up('infopanel').destroy();
                            }
                        }
                        ]
                    }
                ]
            });
        }

        var filter = function (ui) {
            var queue = Ext.net.InfoPanelQueue.queues["window"],
                container = queue.container;

            if (!ui && !queue.filtered) {
                return;
            }

            if (!ui) {
                App.ClearFilterBtn.toggle(true);
            }

            queue.filtered = !!ui;

            if (container && container.items) {
                Ext.suspendLayouts();
                container.items.each(function (item) {
                    (!ui || ui == item.tag) ? item.show() : item.hide(false);
                });

                Ext.resumeLayouts(true);
            }
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Window
        ID="Window1"
        runat="server"
        Width="500"
        Height="500"
        Hidden="false"
        Title="Infos">
        <Bin>
            <ext:InfoPanelQueue
                runat="server"
                Name="window"
                Container="#{Infos}"
                Sliding="false">
                <Defaults>
                    <ext:Parameter Name="header" Value="false" />
                    <ext:Parameter Name="pinned" Value="true" />
                    <ext:Parameter Name="cls" Value="solid" />
                    <ext:Parameter Name="layout" Value="hbox" />
                    <ext:Parameter Name="style" Value="position:relative;" />
                </Defaults>
                <Listeners>
                    <Add Handler="filter();" />
                </Listeners>
            </ext:InfoPanelQueue>
        </Bin>
        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Items>
            <ext:MenuPanel runat="server" Width="200" SaveSelection="false">
                <Menu runat="server">
                    <Items>
                        <ext:MenuItem
                            runat="server"
                            Text="Info (client)"
                            Handler="showInfo('info', 'Info', 'You can insert message here');" />
                        <ext:MenuItem
                            runat="server"
                            Text="Success (client)"
                            Handler="showInfo('success', 'Success Info', 'You can insert message here');" />
                        <ext:MenuItem
                            runat="server"
                            Text="Danger (server)"
                            OnDirectClick="ShowDangerInfo" />
                        <ext:MenuItem
                            runat="server"
                            Text="Warning (server)"
                            OnDirectClick="ShowWarningInfo" />
                    </Items>
                </Menu>
            </ext:MenuPanel>

            <ext:Container ID="Infos" runat="server" Flex="1">
                <LayoutConfig>
                    <ext:VBoxLayoutConfig Align="Stretch" />
                </LayoutConfig>
                <Defaults>
                    <ext:Parameter Name="margin" Value="0" Mode="Raw" />
                </Defaults>
            </ext:Container>
        </Items>
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:ToolbarFill />
                    <ext:Button
                        ID="ClearFilterBtn"
                        runat="server"
                        Text="All"
                        Pressed="true"
                        EnableToggle="true"
                        ToggleGroup="tag"
                        Handler="filter()" />
                    <ext:Button
                        runat="server"
                        Text="Info"
                        EnableToggle="true"
                        ToggleGroup="tag"
                        Icon="BulletBlue"
                        Handler="filter('info')" />
                    <ext:Button
                        runat="server"
                        Text="Success"
                        EnableToggle="true"
                        ToggleGroup="tag"
                        Icon="BulletGreen"
                        Handler="filter('success')" />
                    <ext:Button
                        runat="server"
                        Text="Danger"
                        EnableToggle="true"
                        ToggleGroup="tag"
                        Icon="BulletRed"
                        Handler="filter('danger')" />
                    <ext:Button
                        runat="server"
                        Text="Warning"
                        EnableToggle="true"
                        ToggleGroup="tag"
                        Icon="BulletYellow"
                        Handler="filter('warning')" />
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Window>
</body>
</html>
