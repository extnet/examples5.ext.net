<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Window 
        ID="Window1" 
        runat="server" 
        Width="400" 
        Height="300"         
        Title="Move/Resize Window" 
        BodyPadding="6">
        <Content>
            <ul>
                <li>MOVE: Alt+LEFT/RIGHT/UP/DOWN</li>
                <li>RESIZE: Ctrl+LEFT/RIGHT/UP/DOWN</li>
            </ul>
        </Content>

        <Listeners>
            <AfterRender Handler="this.focus();" />
        </Listeners>

        <KeyMap runat="server">
            <Binding>
                <%--SIZE CHANGING--%>
                <ext:KeyBinding Ctrl="true" Handler="#{Window1}.setWidth(#{Window1}.getSize().width+10);">
                    <Keys>
                        <ext:Key Code="RIGHT" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Ctrl="true" Handler="#{Window1}.setWidth(#{Window1}.getSize().width-10);">
                    <Keys>
                        <ext:Key Code="LEFT" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Ctrl="true" Handler="#{Window1}.setHeight(#{Window1}.getSize().height-10);">
                    <Keys>
                        <ext:Key Code="UP" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Ctrl="true" Handler="#{Window1}.setHeight(#{Window1}.getSize().height+10);">
                    <Keys>
                        <ext:Key Code="DOWN" />
                    </Keys>
                </ext:KeyBinding>
            
                <%--POSITION CHANGING--%>
                <ext:KeyBinding Alt="true" Handler="#{Window1}.setPosition(#{Window1}.getPosition(false)[0]+10);" DefaultEventAction="PreventDefault">
                    <Keys>
                        <ext:Key Code="RIGHT" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Alt="true" Handler="#{Window1}.setPosition(#{Window1}.getPosition(false)[0]-10);" DefaultEventAction="PreventDefault">
                    <Keys>
                        <ext:Key Code="LEFT" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Alt="true" Handler="#{Window1}.setPosition(undefined, #{Window1}.getPosition(false)[1]-10);" DefaultEventAction="PreventDefault">
                    <Keys>
                        <ext:Key Code="UP" />
                    </Keys>
                </ext:KeyBinding>
            
                <ext:KeyBinding Alt="true" Handler="#{Window1}.setPosition(undefined, #{Window1}.getPosition()[1]+10);" DefaultEventAction="PreventDefault">
                    <Keys>
                        <ext:Key Code="DOWN" />
                    </Keys>
                </ext:KeyBinding>
            </Binding>
        </KeyMap>
    </ext:Window>
</body>
</html>