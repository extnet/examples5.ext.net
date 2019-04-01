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
    <title>Basic Hello World Window - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Simple Ext.NET Window Sample</h1>

        <p>The following sample demonstrates how to configure a new Window Component and "show" the Window if closed.</p>

        <ext:Button
            runat="server"
            Text="Show Window (Client Event)"
            Icon="Application"
            OnClientClick="#{Window1}.show();"
            />

        <br />

        <ext:Button
            runat="server"
            Text="Show Window (Server Event)"
            Icon="Application"
            OnDirectClick="Button2_Click"
            />

        <ext:Window
            ID="Window1"
            runat="server"
            Title="Hello World"
            Icon="Application"
            Height="185"
            Width="350"
            BodyStyle="background-color: #fff;"
            BodyPadding="5"
            Hidden="true"
            Modal="true">
            <Content>
                This is my first <a target="_blank" href="https://ext.net/"> Ext.NET</a> Window.
            </Content>
        </ext:Window>
    </form>
</body>
</html>