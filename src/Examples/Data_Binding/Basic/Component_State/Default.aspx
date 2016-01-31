<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Component State - Ext.Net Examples</title>        
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Component State</h1>

        <p>This example shows how to use basic data binding to bind the state of one component to the state of another.</p>
        
        <ext:Panel 
            runat="server" 
            Width="350" 
            BodyPadding="10" 
            Layout="AnchorLayout"
            Title="Sign Up Form"
            ViewModel="<%# true %>"
            AutoDataBind="true">
            <Items>
                <ext:Checkbox runat="server" BoxLabel="Is Admin" Reference="isAdmin" />
                <ext:TextField runat="server" FieldLabel="Admin Key" Anchor="0">
                    <Bind>
                        <ext:Parameter Name="disabled" Value="{!isAdmin.checked}" />
                    </Bind>
                </ext:TextField>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>