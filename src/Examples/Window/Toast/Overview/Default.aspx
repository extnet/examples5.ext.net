<%@ Page Language="C#" %>

<script runat="server">
    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        X.Toast("Toast 2");
    }
    
    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        X.Toast("Toast 3", "Toast", ToastAlign.Bottom);
    }

    protected void Button4_Click(object sender, DirectEventArgs e)
    {
        object toastObj = new
        {
            html = "Toast 4",
            title = "Toast",
            align = JSON.EnumToString(ToastAlign.Right), // Map the enum to the client-side supported string.
            anchor = "Button4",
            stickWhileHover = true,
            closeOnMouseDown = true,
            autoClose = true,
            autoCloseDelay = 2500,
            width = 180
        };

        X.Toast(toastObj);
    }

    protected void Button5_Click(object sender, DirectEventArgs e)
    {
        var config = new Toast()
        {
            Html = "Toast 5",
            Title = "Toast",
            Align = ToastAlign.Right,
            Anchor = "Button5",
            StickWhileHover = true,
            CloseOnMouseDown = true,
            AutoClose = true,
            AutoCloseDelay = 2500,
            Width = 180
        };

        X.Toast(config);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Window Toast Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Window Toast Overview</h1>
        
        <h2>Client-Side Toast</h2>
        
        <ext:Button runat="server" Handler="Ext.toast('Toast 1');" Text="Toast 1" />


        <h2>Server-Side Toast</h2>
        
        <ext:Button runat="server" OnDirectClick="Button2_Click" Text="Toast 2" />

        <h2>Server-Side Toast With Title And Position</h2>
        
        <ext:Button runat="server" OnDirectClick="Button3_Click" Text="Toast 3" />

        <h2>Server-Side Toast Defined With An Anonymous Object</h2>

        <ext:Button ID="Button4" runat="server" OnDirectClick="Button4_Click" Text="Toast 4" />

        <h2>Server-Side Toast Defined By Config Object</h2>

        <ext:Button ID="Button5" runat="server" OnDirectClick="Button5_Click" Text="Toast 5" />

        <h2>Markup Toast</h2>

        <p>See source code for the Toast that is displayed on page load.</p>

        <ext:Toast runat="server">
            <Content>
                Toast rendered on page load
            </Content>
        </ext:Toast>
    </form>
</body>
</html>