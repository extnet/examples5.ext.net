<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Flat Toolbar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h2>Flat Toolbar</h2>

    <ext:Toolbar runat="server" Flat="true">
        <Items>
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

            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" IconCls="x-md md-icon-add-circle-outline" Pressed="true" />
            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" IconCls="x-md md-icon-remove-circle-outline" />
            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" IconCls="x-md md-icon-edit" />
        </Items>
    </ext:Toolbar>

    <h2>Panel with Flat Toolbar</h2>

    <ext:Panel runat="server" Title="Panel with toolbar" Width="480" Height="270" Frame="true">
        <TopBar>
            <ext:Toolbar runat="server" Flat="true">
                <Items>
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

                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" IconCls="x-md md-icon-add-circle-outline" Pressed="true" />
                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" IconCls="x-md md-icon-remove-circle-outline" />
                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" IconCls="x-md md-icon-edit" />
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Panel>
</body>
</html>