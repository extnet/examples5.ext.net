<%@ Page Language="C#" %>

<script runat="server">    
    public class MyModel
    {
        public static object Model = new
        {
            //data : Object
            //This object holds the arbitrary data that populates the ViewModel and is then available for binding.
            data = new 
            {
                title = "Some title",
                content = "Some content"
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Dynamic - Ext.Net Examples</title>        
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Dynamic Data Binding</h1>

        <p>This example shows simple dynamic data binding. When the data in the underlying view <br />
           model is modified, the change is relayed back to the panel and the markup is updated.
        </p>
        
        <ext:Panel 
            runat="server" 
            Width="300" 
            BodyPadding="10" 
            ViewModel="<%# MyModel.Model %>" 
            AutoDataBind="true">
            <Bind>
                <ext:Parameter Name="title" Value="Info - {title}" />
                <ext:Parameter Name="html" Value="Stuff: {content}" />
            </Bind>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Change title" Handler="this.up('panel').getViewModel().set('title', 'New Title ' + new Date().getSeconds());" />
                        <ext:Button runat="server" Text="Change content" Handler=" this.up('panel').getViewModel().set('content', 'New Content ' + new Date().getSeconds());" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
    </form>
</body>
</html>