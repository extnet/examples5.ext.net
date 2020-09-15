<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public void DoConfirm()
    {
        // Manually configure Handler...
        //Msg.Confirm("Message", "Confirm?", "if (buttonId == 'yes') { CompanyX.DoYes(); } else { CompanyX.DoNo(); }").Show();

        // Configure individualock Buttons using a ButtonsConfig...
       X.Msg.Confirm("Message", "Confirm?", new MessageBoxButtonsConfig
        {
            Yes = new MessageBoxButtonConfig
            {
                Handler = "CompanyX.DoYes()",
                Text = "Yes Please"
            },
            No = new MessageBoxButtonConfig
            {
                Handler = "CompanyX.DoNo()",
                Text = "No Thanks"
            }
        }).Show();
    }

    [DirectMethod]
    public void DoYes()
    {
        this.Label1.Text = "YES";
    }

    [DirectMethod]
    public void DoNo()
    {
        this.Label1.Text = "NO";
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Confirm MessageBox with ButtonsConfig - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" DirectMethodNamespace="CompanyX" />

    <h1>Confirm MessageBox with ButtonsConfig</h1>

    <p>The following sample demonstrates using an DirectMethod to call back to the server and return a Confirmation X.MessageBox.</p>

    <p>The Confirm MessageBox is configured with a custom <b>ButtonsConfig</b> object which enables customization of each Button <code>.Text</code> and <code>.Handler</code> properties.</p>
     <pre class="code">
Msg.Confirm("Message", "Confirm?", new X.MessageBox.ButtonsConfig
{
    Yes = new X.MessageBox.ButtonConfig
    {
        Handler = "CompanyX.DoYes()",
        Text = "Yes Please"
    },
    No = new X.MessageBox.ButtonConfig
    {
        Handler = "CompanyX.DoNo()",
        Text = "No Thanks"
    }
}).Show();
    </pre>

    <p>The <code>.Handler</code> property is set with JavaScript Code which executes on the client when the Button is clicked. The 'Yes' and 'No' Buttons in this
    sample each call an individual DirectMethod which in turn calls a server-side Method.</p>

    <p>Upon selecting 'Yes' or 'No', another DirectMethod will be fired and returns a message to the Page.</p>

    <div class="information">
        <p>Please ensure you call the <code>.Show()</code> Method of the <b>MessageBox</b> object to render the MessageBox to the Page.</p>
    </div>

    <p>In addition to the custom <b>ButtonsConfig</b> object, the sample also demonstrates setting the <code>DirectMethodNamespace</code> to configure a custom namespace value for DirectMethod's instead of using the default "<code>App.direct</code>".</p>

    <pre class="code">
// Default
App.direct.DoYes();

// Custom DirectMethodNamespace
CompanyX.DoYes();
    </pre>
    <h4>Example</h4>

    <form runat="server">
        <p>
            <ext:Button runat="server" Text="Confirm" IconCls="x-md md-icon-error-outline">
                <Listeners>
                    <Click Handler="CompanyX.DoConfirm()" />
                </Listeners>
            </ext:Button>
        </p>

        <p><ext:Label ID="Label1" runat="server" Format="You clicked the '<b>{0}</b>' Button." /></p>
    </form>
</body>
</html>