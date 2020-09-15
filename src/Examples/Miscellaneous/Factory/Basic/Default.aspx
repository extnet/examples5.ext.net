<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Factory should be registered once only after application start
        // So, you can do it in Global.asax
        // Here we use HasFactory method to avoid multiple registering
        // After registering, factory can be used in any application page by defing FactoryAlias or FactoryInstance for widget

        // See such code in Global.asax

        /*
         if (!Ext.Net.ResourceManager.HasFactory("mybutton"))
            {
                Ext.Net.ResourceManager.AddFactory(delegate
                {
                    var b = new Ext.Net.Button
                    {
                        Text = "Factory button",
                        Handler = "Ext.Msg.alert('Factory button', 'The button is clicked');",
                        Plugins =
                    {
                        new Badge
                        {
                            Text = "20"
                        }
                    },

                        Factory = new FactoryConfig
                        {
                            Alias = "mybutton",
                            Instance = "My.Button"
                        }
                    };

                    return b;
                }, "mybutton", "My.Button");
            }

            if (!Ext.Net.ResourceManager.HasFactory("mywindow"))
            {
                Ext.Net.ResourceManager.AddFactory("~/Examples/Miscellaneous/Factory/Basic/MyWindow.ascx", "mywindow", "My.Window");
            }
         */
    }

    protected void RenderWindow(object sender, DirectEventArgs e)
    {
        (new Ext.Net.Window()
        {
            FactoryAlias = "mywindow",
            MessageBusListeners =
            {
                new MessageBusListener { Name="MyWindow.SubmitForm", Handler="App.direct.SendEmail({formId : data.formId});" }
            }
        }).Render();
    }

    [DirectMethod]
    public void SendEmail()
    {
        string sendTo = this.Request["sendTo"];
        string subject = this.Request["subject"];
        string body = this.Request["body"];

        X.Msg.Alert("Email has been sent", string.Concat(
            "Send To: ", sendTo, "<br/>",
            "Subject: ", subject, "<br/>",
            "Body: ", body)).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Factory - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Factory</h1>

        <p>Factory allows to register control (or a user control or a view) as factory and reuse across all pages in your application</p>

        <p>Please note that Content cannot be used inside factory widget because the Content region cannot be clonned.</p>

        <ext:Button runat="server" Text="Factory widget, click me" FactoryAlias="mybutton" />

        <ext:Button runat="server" Text="Render factory window" OnDirectClick="RenderWindow" />
    </form>
</body>
</html>