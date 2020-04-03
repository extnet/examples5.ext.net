<%@ Page Language="C#" %>

<script runat="server">
    protected void DoSomething(object sender, DirectEventArgs e)
    {
        System.Threading.Thread.Sleep(8000);
    }

    [DirectMethod]
    public void SomeDirectMethod()
    {
        System.Threading.Thread.Sleep(8000);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectEvent Duration Messages - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <h1>DirectEvent Duration Messages</h1>

        <p>More information about this functionality you can find in <a href="https://forums.ext.net/showthread.php?35661" target="_blank">this Ext.NET forum thread</a>.</p>

        <ext:ResourceManager runat="server">
            <DirectEventDurationMessages>
                <ext:DurationMessage Duration="1000" Message="Global duration message for 1000 milliseconds" />
                <ext:DurationMessage Duration="3500" Message="Global duration message for 3500 milliseconds" />
                <ext:DurationMessage Duration="5000" Message="Global duration message for 5000 milliseconds" />
            </DirectEventDurationMessages>
            <Listeners>
                <AjaxRequestComplete Handler="Ext.Msg.alert('Done', 'The operation has been completed.')" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Container runat="server" Layout="VBox">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 0 7 0" Mode="Value"></ext:Parameter>
            </Defaults>
            <Items>
                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Run" Width="75">
                            <DirectEvents>
                                <Click OnEvent="DoSomething">
                                    <EventMask>
                                        <DurationMessages>
                                            <ext:DurationMessage Duration="1000" Message="Hm... taking a bit longer than expected..." />
                                            <ext:DurationMessage Duration="3500" Message="Well, this is a bit unexpected... almost there now..." />
                                            <ext:DurationMessage Duration="5000" Message="Woah, this is embarrassing. The server is taking really long. Sorry about this... still waiting..." />
                                        </DurationMessages>
                                    </EventMask>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Label runat="server" Text="&nbsp;- a long running DirectEvent with specific duration messages" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Run" OnDirectClick="DoSomething" Width="75" />
                        <ext:Label runat="server" Text="&nbsp;- a long running DirectEvent with global duration messages" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Run" Width="75">
                            <DirectEvents>
                                <Click OnEvent="DoSomething">
                                    <EventMask ShowMask="true" ShowDurationMessages="false" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Label runat="server" Text="&nbsp;- a long running DirectEvent without any duration messages, but with a regular mask" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Run" Width="75">
                            <Listeners>
                                <Click Handler="App.direct.SomeDirectMethod({
                                                    eventMask: {
                                                        durationMessages: [{
                                                            duration: 1000,
                                                            message: 'DirectMethod duration message for 1000 milliseconds'
                                                        }, {
                                                            duration: 3000,
                                                            message: 'DirectMethod duration message for 3000 milliseconds'
                                                        }]
                                                    }
                                                });" />
                            </Listeners>
                        </ext:Button>
                        <ext:Label runat="server" Text="&nbsp;- a long running DirectMethod with specific duration messages" />
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Forbid" Width="75">
                            <Listeners>
                                <Click Handler="Ext.net.DirectEvent.forbidDurationMessages = !Ext.net.DirectEvent.forbidDurationMessages;
                                                var text = Ext.net.DirectEvent.forbidDurationMessages ? 'Allow' : 'Forbid';
                                                this.setText(text);
                                                App.Label1.setText('&nbsp;- ' + text + ' duration messages');" />
                            </Listeners>
                        </ext:Button>
                        <ext:Label ID="Label1" runat="server" Text="&nbsp;- Forbid duration messages" />
                    </Items>
                </ext:Container>
            </Items>
        </ext:Container>
    </form>
</body>
</html>