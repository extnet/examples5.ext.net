<%@ Page Language="C#" %>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>Calling a WebService Endpoint from a DirectMethod - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>
        var xmlService = function (name) {
            Ext.net.DirectMethod.request({
                url          : "XmlService.asmx/SayHello",
                cleanRequest : true,
                params       : {
                    name : name
                },
                success      : function (result) {
                    Ext.Msg.alert("Xml Message", Ext.DomQuery.selectValue("string", result, ""));
                }
            });
        };
        
        var jsonServicce = function (name) {
            Ext.net.DirectMethod.request({
                url          : "JsonService.asmx/SayHello",
                cleanRequest : true,
                json         : true,
                params       : {
                    name : name
                },
                success : function (result) {
                    Ext.Msg.alert("Json Message", result);
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Calling a WebService Endpoint from a DirectMethod</h1>
        
        <ext:Panel 
            runat="server" 
            Title="Say Hello" 
            Width="300" 
            Height="185" 
            Frame="true" 
            ButtonAlign="Center"
            Layout="Form">
            <Items>
                <ext:TextField 
                    ID="txtName" 
                    runat="server" 
                    FieldLabel="Name" 
                    EmptyText="Your name here..." 
                    AnchorHorizontal="100%"
                    />
            </Items>
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="XML WebMethod">
                    <Listeners>
                        <Click Handler="xmlService(#{txtName}.getValue());" />
                    </Listeners>
                </ext:Button>
                
                <ext:Button ID="Button2" runat="server" Text="JSON WebMethod">
                    <Listeners>
                        <Click Handler="jsonServicce(#{txtName}.getValue());" />
                    </Listeners>
                </ext:Button>
           </Buttons>
        </ext:Panel>
    </form>
</body>
</html>