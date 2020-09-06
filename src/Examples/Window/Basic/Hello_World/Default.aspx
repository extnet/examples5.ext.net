<%@ Page Language="C#" %>

<script runat="server">
    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        this.Window1.Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Hello World - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Hello World=</h1>

        <p>The following sample demonstrates how to configure a new Window and <code>show</code> the Window if closed.</p>

        <ext:Button runat="server" Text="Show Window (Client Event)" OnClientClick="#{Window1}.show();" />

        <br />

        <ext:Button runat="server" Text="Show Window (Server Event)" OnDirectClick="Button2_Click" />

        <ext:Window
            ID="Window1"
            runat="server"
            Title="Hello World"
            Height="270"
            Width="360"
            BodyStyle="background-color: #fff;"
            BodyPadding="18"
            Hidden="true"
            Modal="true">
            <Content>
                This is my first <a target="_blank" href="https://ext.net/"> Ext.NET</a> Window.
            </Content>
        </ext:Window>
    </form>
</body>
</html>