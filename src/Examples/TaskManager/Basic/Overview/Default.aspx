<%@ Page Language="C#" %>

<script runat="server">
    protected void RefreshTime(object sender, DirectEventArgs e)
    {
        this.ServerTimeLabel.Text = DateTime.Now.ToString("HH:mm:ss");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TaskManager with Client and Server Side Events - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Handler="window.msg = function (text) {
                    #{LogArea}.setValue(
                        Ext.String.format('{0}\n{1} : {2}',
                        #{LogArea}.getValue(),
                        text,
                        Ext.Date.format(new Date(), 'H:i:s')));
                    };" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    runat="server"
                    Region="Center"
                    Title="TaskManager example"
                    Icon="Time"
                    Border="false">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button
                                    ID="btnStartAll"
                                    runat="server"
                                    Text="Start All Tasks"
                                    Icon="ControlPlayBlue"
                                    Disabled="true">
                                    <Listeners>
                                        <Click Handler="this.disable();#{TaskManager1}.startAll();#{btnStopAll}.enable()" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button
                                    ID="btnStopAll"
                                    runat="server"
                                    Text="Stop All Tasks"
                                    Icon="ControlStopBlue">
                                    <Listeners>
                                        <Click Handler="this.disable();#{TaskManager1}.stopAll();#{btnStartAll}.enable();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel
                            runat="server"
                            Title="Local time"
                            BodyStyle="text-align:center;"
                            BodyPadding="20"
                            Flex="1">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Pack="Center" Align="Center" />
                            </LayoutConfig>
                            <Items>
                                <ext:Label ID="LocalTimeLabel" runat="server" StyleSpec="font-weight:bold;font-size:500%;" Width="280" Height="50" />
                            </Items>
                            <BottomBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                            <ext:Button ID="StartLocalTime" runat="server" Text="Start Task">
                                            <Listeners>
                                                <Click Handler="#{TaskManager1}.startTask(0);" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="StopLocalTime" runat="server" Text="Stop Task">
                                            <Listeners>
                                                <Click Handler="#{TaskManager1}.stopTask(0);" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </BottomBar>
                        </ext:Panel>
                        <ext:Panel
                            ID="ServerTimeContainer"
                            runat="server"
                            Title="Server Time (update every 5 seconds)"
                            BodyStyle="text-align:center;"
                            BodyPadding="20"
                            Flex="1">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Pack="Center" Align="Center"/>
                            </LayoutConfig>
                            <Items>
                                <ext:Label ID="ServerTimeLabel" runat="server" StyleSpec="font-weight:bold;font-size:500%;" Width="280" Height="50" />
                            </Items>
                            <BottomBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                            <ext:Button ID="StartServerTime" runat="server" Text="Start Task">
                                            <Listeners>
                                                <Click Handler="#{TaskManager1}.startTask('servertime');" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="StopServerTime" runat="server" Text="Stop Task">
                                            <Listeners>
                                                <Click Handler="#{TaskManager1}.stopTask('servertime');" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </BottomBar>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel
                    runat="server"
                    Region="South"
                    Height="200"
                    Border="false"
                    Layout="Fit">
                    <Items>
                        <ext:TextArea ID="LogArea" runat="server" />
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>

        <ext:TaskManager ID="TaskManager1" runat="server">
            <Tasks>
                <ext:Task
                    OnStart="
                        #{StartLocalTime}.setDisabled(true);
                        #{StopLocalTime}.setDisabled(false);
                        msg('Start Client');"
                    OnStop="
                        #{StartLocalTime}.setDisabled(false);
                        #{StopLocalTime}.setDisabled(true);
                        msg('Stop Client');">
                    <Listeners>
                        <Update Handler="#{LocalTimeLabel}.setText(Ext.Date.format(new Date(), 'H:i:s'));" />
                    </Listeners>
                </ext:Task>

                <ext:Task
                    TaskID="servertime"
                    Interval="5000"
                    OnStart="
                        #{StartServerTime}.setDisabled(true);
                        #{StopServerTime}.setDisabled(false);
                        msg('Start Server')"
                    OnStop="
                        #{StartServerTime}.setDisabled(false);
                        #{StopServerTime}.setDisabled(true);
                        msg('Stop Server')">
                    <DirectEvents>
                        <Update OnEvent="RefreshTime">
                            <EventMask
                                ShowMask="true"
                                Target="CustomTarget"
                                CustomTarget="={#{ServerTimeContainer}.body}"
                                MinDelay="350"
                                />
                        </Update>
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
