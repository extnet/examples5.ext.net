<%@ Page Language="C#" %>

<%@ Import Namespace="System.Threading" %>

<script runat="server">
    protected void StartLongAction(object sender, DirectEventArgs e)
    {
        this.Session["LongAction"] = 0;
        ThreadPool.QueueUserWorkItem(LongAction);
        this.ResourceManager1.AddScript("{0}.startTask('longaction');", this.TaskManager1.ClientID);
    }

    private void LongAction(object state)
    {
        for (int i = 0; i < 10; i++)
        {
            Thread.Sleep(1000);
            this.Session["LongAction"] = i + 1;
        }

        this.Session.Remove("LongAction");
    }

    protected void Refresh(object sender, DirectEventArgs e)
    {
        object progress = this.Session["LongAction"];

        if (progress != null)
        {
            X.Js.Call("updateMask", string.Format("Step {0} of {1}...", progress.ToString(), 10));
        }
        else
        {
            this.ResourceManager1.AddScript("{0}.stopTask('longaction');", this.TaskManager1.ClientID);
            X.Js.Call("updateMask", "All finished!");
        }
    }
</script>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>TaskManager Poll Server - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script>
        var updateMask = function (text) {
            myMask.down("div.x-mask-msg-text").update(text);
        };
    </script>
</head>
<body>
    <form runat="server">
        <p>The example demonstrates how to poll a server during some long action executed in a separate thread.</p>

        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:Button
            ID="Button1"
            runat="server"
            Text="Start long action"
            Handler="window.myMask = Ext.net.Mask.show({ msg: 'Initial...' });"
            OnDirectClick="StartLongAction"
            />

        <ext:TaskManager ID="TaskManager1" runat="server">
            <Tasks>
                <ext:Task
                    TaskID="longaction"
                    Interval="1000"
                    AutoRun="false"
                    OnStart="#{Button1}.setDisabled(true);"
                    OnStop="#{Button1}.setDisabled(false);
                            Ext.defer(Ext.net.Mask.hide, 1000);">
                    <DirectEvents>
                        <Update OnEvent="Refresh" />
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
