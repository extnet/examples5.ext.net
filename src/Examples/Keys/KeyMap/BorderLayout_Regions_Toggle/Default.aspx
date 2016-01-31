<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>KeyMap Toggling BorderLayout Regions - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
</head>
<body>
    <ext:ResourceManager runat="server" />
        
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel 
                ID="North" 
                runat="server" 
                Title="North" 
                Region="North" 
                Frame="true" 
                Height="200" 
                Collapsible="true" 
                />
            <ext:Panel 
                ID="West" 
                runat="server" 
                Title="West" 
                Region="West" 
                Frame="true" 
                Width="200" 
                Collapsible="true" 
                />
            <ext:Panel runat="server" Region="Center" BodyPadding="5">
                <Content>
                    <ul>
                        <li>If keys are not working then click on center area</li>
                        <li>NORTH toggle: N</li>
                        <li>WEST toggle: W</li>
                        <li>EAST toggle: E</li>
                        <li>SOUTH toggle: S</li>
                    </ul>
                </Content>
            </ext:Panel>
            <ext:Panel 
                ID="East" 
                runat="server" 
                Title="East" 
                Region="East" 
                Frame="true" 
                Width="200" 
                Collapsible="true" 
                />
            <ext:Panel 
                ID="South" 
                runat="server" 
                Title="South" 
                Region="South" 
                Frame="true" 
                Height="200" 
                Collapsible="true" 
                />
        </Items>
    </ext:Viewport>
    
    <ext:KeyMap runat="server" Target="={Ext.isGecko ? Ext.getDoc() : Ext.getBody()}">        
        <Binding>
                <ext:KeyBinding Handler="#{North}.toggleCollapse();">
                <Keys>
                    <ext:Key Code="N" />
                </Keys>
            </ext:KeyBinding>    
        
            <ext:KeyBinding Handler="#{West}.toggleCollapse();">
                <Keys>
                    <ext:Key Code="W" />
                </Keys>
            </ext:KeyBinding>
        
            <ext:KeyBinding Handler="#{East}.toggleCollapse();">
                <Keys>
                    <ext:Key Code="E" />
                </Keys>
            </ext:KeyBinding>
        
            <ext:KeyBinding Handler="#{South}.toggleCollapse();">
                <Keys>
                    <ext:Key Code="S" />
                </Keys>
            </ext:KeyBinding>
        </Binding>        
    </ext:KeyMap>
</body>
</html>