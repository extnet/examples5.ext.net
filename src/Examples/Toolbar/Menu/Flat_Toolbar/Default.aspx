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
            <ext:Button runat="server" Icon="Add">
                <Listeners>
                    <Click Handler="Ext.Msg.alert('Click','Click on Add');" />                                
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Html="Simple button" />
                </ToolTips>
            </ext:Button>
            
             <ext:Button runat="server" Icon="Accept">
                <Listeners>
                    <Click Handler="Ext.Msg.alert('Click','Click on Accept');" />                                
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Html="Simple button" />
                </ToolTips>
            </ext:Button>
            
             <ext:Button runat="server" Icon="Delete">
                <Listeners>
                    <Click Handler="Ext.Msg.alert('Click','Click on Delete');" />                                
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Html="Simple button" />
                </ToolTips>
            </ext:Button>
            
            <ext:ToolbarSeparator/>
            
            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" Icon="GroupAdd" Pressed="true" />
            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" Icon="GroupDelete" />
            <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group2" Icon="GroupEdit" />
        </Items>
    </ext:Toolbar>
    
    <h2>Panel with Flat Toolbar</h2>
    
    <ext:Panel runat="server" Title="Panel with toolbar" Width="300" Height="185" Frame="true">
        <TopBar>
            <ext:Toolbar runat="server" Flat="true">
                <Items>                        
                    <ext:Button runat="server" Icon="Add">
                        <Listeners>
                            <Click Handler="Ext.Msg.alert('Click','Click on Add');" />                                
                        </Listeners>
                        <ToolTips>
                            <ext:ToolTip runat="server" Html="Simple button" />
                        </ToolTips>
                    </ext:Button>
                    
                     <ext:Button runat="server" Icon="Accept">
                        <Listeners>
                            <Click Handler="Ext.Msg.alert('Click','Click on Accept');" />                                
                        </Listeners>
                        <ToolTips>
                            <ext:ToolTip runat="server" Html="Simple button" />
                        </ToolTips>
                    </ext:Button>
                    
                     <ext:Button runat="server" Icon="Delete">
                        <Listeners>
                            <Click Handler="Ext.Msg.alert('Click','Click on Delete');" />                                
                        </Listeners>
                        <ToolTips>
                            <ext:ToolTip runat="server" Html="Simple button" />
                        </ToolTips>
                    </ext:Button>
                    
                    <ext:ToolbarSeparator/>                        
                    
                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" Icon="GroupAdd" Pressed="true" />
                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" Icon="GroupDelete" />
                    <ext:Button runat="server" EnableToggle="true" ToggleGroup="Group1" Icon="GroupEdit" />
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Panel>
</body>
</html>