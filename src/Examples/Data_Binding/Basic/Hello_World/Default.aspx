<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //in code-behind you can use the following

        /*
        panel.BindObject = new
        {
            title = "{title}",
            html = "{html}"
        };
        */
    }

    public class MyModel
    {
        public static object Model = new
        {
            //data : Object
            //This object holds the arbitrary data that populates the ViewModel and is then available for binding.
            data = new
            {
                title = "Hello World",
                html = "The html content",
                buttonText = "A button"
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Hello World - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Hello World</h1>

        <p>This example shows how to use basic data binding. The panel title, the content and the <br />
           button text are all pulled from the view model.</p>

        <ext:Panel
            runat="server"
            Width="500"
            BodyPadding="10"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <Bind>
                <ext:Parameter Name="title" Value="{title}" />
                <ext:Parameter Name="html" Value="{html}" />
            </Bind>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" BindString="{buttonText}" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
    </form>
</body>
</html>