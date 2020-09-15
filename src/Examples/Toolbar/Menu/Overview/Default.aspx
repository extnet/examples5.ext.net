<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Menu3_Click(object sender, DirectEventArgs e)
    {
        X.MessageBox.Alert("Click", e.ExtraParams["Param"]).Show();
    }
</script>

<html>
<head runat="server">
    <title>Toolbar overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel
            ID="Panel1"
            runat="server"
            Title="Panel with toolbars"
            Width="720"
            Height="480">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" IconCls="x-md md-icon-add-circle-outline" StandOut="true">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Add');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="StandOut button" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-check-circle-outline" StandOut="true">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Accept');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="StandOut button" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-remove-circle-outline" StandOut="true">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Delete');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="StandOut button" />
                            </ToolTips>
                        </ext:Button>

                        <ext:ToolbarSeparator/>

                        <ext:Button runat="server" IconCls="x-md md-icon-add-circle-outline">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Add');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Simple button" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-check-circle-outline">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Accept');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Simple button" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-remove-circle-outline">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Delete');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Simple button" />
                            </ToolTips>
                        </ext:Button>

                        <ext:ToolbarSeparator/>

                        <ext:Button runat="server" IconCls="x-md md-icon-add-circle-outline" Text="Add">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Add');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Button with text" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-check-circle-outline" Text="Accept" Disabled="true">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Accept');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Disabled" />
                            </ToolTips>
                        </ext:Button>

                         <ext:Button runat="server" IconCls="x-md md-icon-remove-circle-outline" Text="Delete">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Click','Click on Delete');" />
                            </Listeners>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Button with text" />
                            </ToolTips>
                        </ext:Button>

                        <ext:ToolbarSeparator/>

                        <ext:ToolbarSpacer runat="server" />

                        <ext:Button runat="server" IconCls="x-md md-icon-open-in-new" Text="With menu">
                            <Menu>
                              <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" IconCls="x-md md-icon-check-circle-outline" Text="Menu 1" Handler="function () {alert('Menu 1');}" />
                                    <ext:MenuItem runat="server" IconCls="x-md md-icon-add-circle-outline" Text="Menu 2">
                                        <Listeners>
                                            <Click Handler="alert('Menu 2');" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem runat="server" Text="Menu 3">
                                        <DirectEvents>
                                            <Click OnEvent="Menu3_Click">
                                                <EventMask ShowMask="true" />
                                                <ExtraParams>
                                                    <ext:Parameter Name="Param" Value="Menu 3" Mode="Value" />
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:MenuItem>
                                    <ext:MenuSeparator runat="server" />
                                    <ext:MenuItem runat="server" Text="Menu 5" />
                                </Items>
                              </ext:Menu>
                            </Menu>
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="Application" />
                            </ToolTips>
                        </ext:Button>

                        <ext:ToolbarFill />

                        <ext:Button runat="server" EnableToggle="true" ToggleGroup="G1" IconCls="x-md md-icon-add-circle-outline" Pressed="true" />
                        <ext:Button runat="server" EnableToggle="true" ToggleGroup="G1" IconCls="x-md md-icon-remove-circle-outline" />
                        <ext:Button runat="server" EnableToggle="true" ToggleGroup="G1" IconCls="x-md md-icon-edit" />
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ComboBox runat="server">
                            <Items>
                                <ext:ListItem Text="Option1" />
                                <ext:ListItem Text="Option2" />
                                <ext:ListItem Text="Option3" />
                                <ext:ListItem Text="Option4" />
                                <ext:ListItem Text="Option5" />
                            </Items>
                        </ext:ComboBox>

                        <ext:ToolbarSpacer/>

                        <ext:TextField runat="server" EmptyText="[Enter some text]" />
                        <ext:ToolbarSpacer />
                        <ext:ToolbarFill />

                        <ext:DateField runat="server" />
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:Panel>
    </form>
</body>
</html>