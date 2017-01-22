<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        X.Toast("Toast shown!");
        return;
    }
    
    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        X.Toast("Toast with title at bottom shown!", "MyTitle", ToastAlign.Bottom);
        return;
    }

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        object toastObj = new
        {
            html = "This toast was defined from code behind from an anonymous object!",
            title = "Object toast",
            align = JSON.EnumToString(ToastAlign.Right), // Map the enum to the client-side supported string.
            anchor = "Button3",
            stickWhileHover = true,
            closeOnMouseDown = true,
            autoClose = true,
            autoCloseDelay = 2500
        };

        X.Toast(toastObj);
        return;
    }

    protected void Button4_Click(object sender, DirectEventArgs e)
    {
        var toastComp = new Toast()
        {
            Html = "This toast was defined from code behind from an Ext.Net.Toast component definition!",
            Title = "Object toast",
            Align = ToastAlign.Right,
            Anchor = "Button3",
            StickWhileHover = true,
            CloseOnMouseDown = true,
            AutoClose = true,
            AutoCloseDelay = 2500
        };

        X.Toast(toastComp);
        return;
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
        <p>
            Click the buttons below to see the toast drop. Check sources for how this is done.
        </p>

        <hr />
        <h2>1: Simple client-side toast</h2>
        <ext:Button runat="server" Handler="Ext.toast('This is a client-side simple toast!');" Text="Trigger Toast" />

        <hr />
        <h2>2: Simple server-side toast</h2>
        <ext:Button runat="server" OnDirectClick="Button1_Click" Text="Trigger Toast" />

        <hr />
        <h2>3: Server-side toast with title and position</h2>
        <ext:Button runat="server" OnDirectClick="Button2_Click" Text="Trigger Toast" />

        <hr />
        <h2>4: Server-side toast defined with an anonymous object.</h2>
        <ext:Button runat="server" ID="Button3" OnDirectClick="Button3_Click" Text="Trigger Toast" />

        <hr />
        <h2>5: Server-side toast defined with an Ext.Net.Toast component definition.</h2>
        <ext:Button runat="server" ID="Button1" OnDirectClick="Button4_Click" Text="Trigger Toast" />

        <hr />
        <h2>6: Markup toast</h2>
        <p>
            See source code, the toast is displayed first, once the page loads.
        </p>

        <ext:Toast
            runat="server"
            ID="Toast1" 
            StickWhileHover="true">
            <Content>
                This toast is defined in markup and shows once -- once the page is loaded.
            </Content>
        </ext:Toast>
    </form>
</body>
</html>