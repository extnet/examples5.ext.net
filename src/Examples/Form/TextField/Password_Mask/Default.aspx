<%@ Page Language="C#" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Password Mask and CapsLock Detector Plugin - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Password Mask and CapsLock Detector Plugin</h1>

        <p>PasswordMask plugin emulates iPhone password style</p>
        <p>If you type a password when CapsLock is active then you will see an indicator warning (CapsLockDetector plugin)</p>
        
        <ext:Window 
            runat="server" 
            Width="350"
            Title="Password Mask"            
            Closable="false"
            BodyPadding="5">           
            <Items>
                <ext:TextField 
                    ID="PasswordField" 
                    runat="server"                    
                    FieldLabel="Password"                    
                    LabelWidth="150"
                    AnchorHorizontal="100%">
                    <Plugins>
                        <ext:PasswordMask runat="server" />

                        <ext:CapsLockDetector runat="server">
                            <Listeners>
                                <CapsLockOn Handler="#{PasswordField}.showIndicator({iconCls : '#Error', tip : 'CapsLock is active'});" />
                                <CapsLockOff Handler="#{PasswordField}.hideIndicator();" />
                            </Listeners>
                        </ext:CapsLockDetector>
                    </Plugins>
                </ext:TextField>

                <ext:TextField 
                    runat="server"                     
                    LabelWidth="150"
                    FieldLabel="Another replacement char"                    
                    AnchorHorizontal="100%">     
                    <Plugins>
                        <ext:PasswordMask runat="server" ReplacementChar="◊" />
                    </Plugins>
                </ext:TextField>     
            </Items>            
        </ext:Window>                
   </form>
</body>
</html>
