<%@ Page Language="C#" %>

<%@ Import Namespace="System.Threading" %>

<script runat="server">
    protected void StartLongAction(object sender, DirectEventArgs e)
    {
        this.Session["LongActionProgress"] = 0;
        ThreadPool.QueueUserWorkItem(LongAction);
        this.ResourceManager1.AddScript("{0}.startTask('longactionprogress');", this.TaskManager1.ClientID);
    }

    private void LongAction(object state)
    {
        for (int i = 0; i < 10; i++)
        {
            Thread.Sleep(1000);
            this.Session["LongActionProgress"] = i+1;
        }

        this.Session.Remove("LongActionProgress");
    }

    protected void RefreshProgress(object sender, DirectEventArgs e)
    {
        object progress = this.Session["LongActionProgress"];

        if (progress != null)
        {
            this.Progress1.UpdateProgress(((int)progress) / 10f, string.Format("Step {0} of {1}...", progress.ToString(), 10));
        }
        else
        {
            this.ResourceManager1.AddScript("{0}.stopTask('longactionprogress');", this.TaskManager1.ClientID);
            this.Progress1.UpdateProgress(1,"All finished!");
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ProgressBar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>Progress Bar</h1>

        <p>The example shows how to update the ProgressBar during long server-side actions.</p>

        <ext:Button
            ID="ShowProgress1"
            runat="server"
            Text="Start long action"
            OnDirectClick="StartLongAction"
            />

        <br />

        <ext:ProgressBar ID="Progress1" runat="server" Width="300" />

        <ext:TaskManager ID="TaskManager1" runat="server">
            <Tasks>
                <ext:Task
                    TaskID="longactionprogress"
                    Interval="1000"
                    AutoRun="false"
                    OnStart="
                        #{ShowProgress1}.setDisabled(true);"
                    OnStop="
                        #{ShowProgress1}.setDisabled(false);">
                    <DirectEvents>
                        <Update OnEvent="RefreshProgress" />
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>

    </form>
</body>
</html>
