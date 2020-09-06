<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Using Action - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var changeText = function (panel) {
            var btn = panel.getComponent('myAction'),
                ref = btn.baseAction;

            Ext.Msg.prompt('Enter Text', 'Enter new text for the Action:', function (btn, text) {
                if (btn == 'ok' && text) {
                    ref.setText(text);
                    ref.setHandler(function () {
                        Ext.Msg.alert('Click','You clicked on "' + ref.getText() + '".');
                    });
                }
            });
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Using Action</h1>

    <p>Actions let you share client-side handlers, configuration and updates across Toolbar, Button and Menu components.</p>

    <ext:Panel
        ID="Panel1"
        runat="server"
        Title="Actions"
        Width="480"
        Height="480">
        <Bin>
            <ext:Action
                ID="Action1"
                runat="server"
                Text="Do something"
                Handler="Ext.Msg.alert('Click', 'You did something.');"
                Icon="Add"
                ItemID="myAction"
                />
        </Bin>
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:ActionRef runat="server" Action="#{Action1}" />
                    <ext:Button runat="server" Text="Action Menu">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:ActionRef runat="server" Action="#{Action1}" />
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:Button>
                </Items>
            </ext:Toolbar>
        </TopBar>
        <Items>
            <ext:ActionRef runat="server" Action="#{Action1}" InstanceType="Ext.Net.SplitButton" />
        </Items>
        <BottomBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Button runat="server" Text="Disable">
                        <Listeners>
                            <Click Handler="var action = #{Action1}; action.setDisabled(!action.isDisabled()); this.setText(action.isDisabled() ? 'Enable' : 'Disable');" />
                        </Listeners>
                    </ext:Button>

                    <ext:Button runat="server" Text="Change Icon">
                        <Listeners>
                            <Click Handler="var action = #{Action1}; action.setIconCls(action.getIconCls() == '#Add' ? '#Delete' : '#Add');" />
                        </Listeners>
                    </ext:Button>

                    <ext:Button
                        runat="server"
                        Text="Change Text"
                        Handler="#{Action1}.setText('Something else');"
                        />

                    <ext:Button
                        runat="server"
                        Text="Another Text Change"
                        Handler="changeText(#{Panel1});"
                        />
                </Items>
            </ext:Toolbar>
        </BottomBar>
     </ext:Panel>
</body>
</html>