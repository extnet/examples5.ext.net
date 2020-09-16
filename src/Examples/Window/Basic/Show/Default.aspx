<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, EventArgs e)
    {
        this.Window1.Show();
    }

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        this.Window3.Show();
    }

    protected void Button5_Click(object sender, DirectEventArgs e)
    {
        this.Window5.Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Show a Hidden Window - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <CustomDirectEvents>
                <ext:DirectEvent Target="Button5" OnEvent="Button5_Click" />
            </CustomDirectEvents>
            <CustomListeners>
                <ext:Listener Target="Button6" Handler="#{Window6}.show();return false;" />
            </CustomListeners>
        </ext:ResourceManager>

        <h1>Show a Hidden Window</h1>

        <p>This sample demonstrates several client-side and server-side techniques for triggering the <code>&lt;ext:Window></code> to show if hidden.</p>

        <p>Within server-side code, the <code>.Show()</code> Method should be used. Within client-side code, the <code>.show()</code> function should be used.</p>

        <h2>Example</h2>

        <h3>Ext.NET Buttons</h3>

        <p>
            <ext:Button runat="server" Text="Click Listener">
                <Listeners>
                    <Click Handler="#{Window2}.show()" />
                </Listeners>
            </ext:Button>
        </p>

        <p>
            <ext:Button ID="Button3" runat="server" Text="Click DirectEvent">
                <DirectEvents>
                    <Click OnEvent="Button3_Click" />
                </DirectEvents>
            </ext:Button>
        </p>

        <p>
            <ext:Button
                runat="server"
                Text="With PostBack"
                OnClick="Button1_Click"
                AutoPostBack="true"
                />
        </p>

        <br />

        <h3>ASP.NET Buttons</h3>

        <p>
            <asp:Button runat="server" Text="ASP.NET Button with OnClientClick" OnClientClick="App.Window4.show();return false;" />
        </p>

        <p>
            <asp:Button runat="server" OnClientClick="return false;" Text="ASP.NET Button with Custom DirectEvent" />
        </p>

        <p>
            <asp:Button runat="server" Text="ASP.NET Button with Custom Listener" OnClientClick="return false;" />
        </p>

        <ext:Window
            ID="Window1"
            runat="server"
            Title="With PostBack"
            Hidden="true"
            Width="360"
            Height="270"
            X="250"
            Y="100"
            />

        <ext:Window
            ID="Window2"
            runat="server"
            Title="Click Listener"
            Hidden="true"
            Width="360"
            Height="270"
            X="275"
            Y="150"
            />

        <ext:Window
            ID="Window3"
            runat="server"
            Title="Click DirectEvent"
            Hidden="true"
            Width="360"
            Height="270"
            X="300"
            Y="200"
            />

        <ext:Window
            ID="Window4"
            runat="server"
            Title="ASP.NET Button with OnClientClick"
            Hidden="true"
            Width="360"
            Height="270"
            X="325"
            Y="250"
            />

        <ext:Window
            ID="Window5"
            runat="server"
            Title="ASP.NET Button with Custom DirectEvent"
            Hidden="true"
            Width="360"
            Height="270"
            X="350"
            Y="300"
            />

        <ext:Window
            ID="Window6"
            runat="server"
            Title="ASP.NET Button with Custom Listener"
            Hidden="true"
            Width="360"
            Height="270"
            X="375"
            Y="350"
            />
    </form>
</body>
</html>