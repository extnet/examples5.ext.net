<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Notify(new NotificationConfig {
            Icon  = Icon.Accept,
            Title = "Working",
            Html  = this.TextArea1.Text
        }).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Example</title>

    <link type="text/css" rel="stylesheet" href="https://speed.ext.net/www/intro/css/main.css" />
</head>
<body>
    <ext:ResourceManager runat="server" Theme="Triton" />

    <header>
        <a href="https://ext.net/"><img src="https://speed.ext.net/identity/extnet-logo-large.png" class="logo"/></a>
    </header>

    <div class="wrapper">
        <h1>Welcome to Ext.NET!</h1>
        <p>Thank you for installing Ext.NET.</p>
        <p class="last">You can check that everything is working correctly by submitting a value in the message box below.</p>
    </div>

    <form runat="server">
        <ext:Panel
            ID="Window1"
            runat="server"
            Title="Welcome to Ext.NET"
            Height="215"
            Width="350"
            Frame="true"
            Collapsible="true"
            Cls="box"
            BodyPadding="5"
            DefaultButton="0"
            Layout="AnchorLayout"
            DefaultAnchor="100%">
            <Items>
                <ext:TextArea
                    ID="TextArea1"
                    runat="server"
                    EmptyText=">> Enter a Test Message Here <<"
                    FieldLabel="Message"
                    Height="85"
                    />
            </Items>
            <Buttons>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Submit"
                    Icon="Accept"
                    OnDirectClick="Button1_Click"
                    />
            </Buttons>
        </ext:Panel>
    </form>

    <div class="wrapper wrapper-lower">
        <h2><a href="https://ext.net/support/">Technical Support</a></h2>
        <p>Need a little help? Visit our <a href="https://ext.net/support/">Support</a> page for links to documentation, examples and more. </p>
        <hr>
        <h2><a href="https://forums.ext.net/">Community Forums</a></h2>
        <p>Keep up to date with all things Ext.NET by joining the active community in our <a href="https://forums.ext.net/">Forums</a>.</p>
        <hr>
        <h2><a href="https://examples.ext.net/">Examples</a></h2>
        <p>Ext.NET features 100+ Components and 750+ Samples for use in your ASP.NET apps. Check out the <a href="https://examples.ext.net/">Examples Explorer</a> to see what's possible.</p>
        <hr>
        <h2><a href="https://ext.net/pricing/">Purchase</a></h2>
        <p class="last">When you're ready, <a href="https://ext.net/pricing/">purchase</a> a license and start building web apps with ease!</p>
    </div>

    <footer>
        <p class="last">&copy; 2008-<%= DateTime.Today.Year %> <a href="https://object.net/">Object.NET</a>, Inc. All Rights Reserved.</p>
    </footer>
</body>
</html>