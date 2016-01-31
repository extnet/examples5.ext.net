<%@ Page Language="C#" %>

<%@ Import Namespace="System.Threading" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Confirm("Confirm", "Are you sure you want to do that?", new JFunction { Fn = "showResult" }).Show();
    }

    protected void Button2_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Prompt("Name", "Please enter your name:", new JFunction { Fn = "showResultText" }).Show();
    }

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Show(new MessageBoxConfig
        {
            Title = "Address",
            Message = "Please enter your address:",
            Width = 300,
            Buttons = MessageBox.Button.OKCANCEL,
            Multiline = true,
            AnimEl = this.Button3.ClientID,
            Fn = new JFunction { Fn = "showResultText" }
        });
    }

    protected void Button4_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Show(new MessageBoxConfig
        {
            Title = "Save Changes?",
            Message = "You are closing a tab that has unsaved changes. <br />Would you like to save your changes?",
            Buttons = MessageBox.Button.YESNOCANCEL,
            Icon = MessageBox.Icon.QUESTION,
            Fn = new JFunction { Fn = "showResult" },
            AnimEl = this.Button4.ClientID
        });
    }
    
    protected void Button5_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Show(new MessageBoxConfig
        {
            Title = "Please wait",
            Message = "Loading items...",
            ProgressText = "Initializing...",
            Width = 300,
            Progress = true,
            Closable = false,
            AnimEl = this.Button5.ClientID
        });
        
        this.StartLongAction();
    }

    protected void Button6_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Show(new MessageBoxConfig
        {
            Message = "Saving your data, please wait...",
            ProgressText = "Saving...",
            Width = 300,
            Wait = true,
            WaitConfig = new WaitConfig { Interval = 200 },
            IconCls = "ext-mb-download",
            AnimEl = this.Button6.ClientID
        });

        this.ResourceManager1.AddScript("setTimeout(function () { Ext.MessageBox.hide(); Ext.Msg.notify('Done', 'Your data was saved!'); }, 8000);");
    }

    protected void Button7_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Alert("Status", "Changes saved successfully.", new JFunction { Fn = "showResult" }).Show();
    }

    protected void Button8_Click(object sender, DirectEventArgs e)
    {
       X.Msg.Show(new MessageBoxConfig
        {
            Title = "Icon Support",
            Message = "Message with an Icon",
            Buttons = MessageBox.Button.OK,
            Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), e.ExtraParams["Icon"]),
            AnimEl = this.Button8.ClientID,
            Fn = new JFunction { Fn = "showResult" }
        });
    }
    
    private void StartLongAction()
    {
        this.Session["Task1"] = 0;
        ThreadPool.QueueUserWorkItem(LongAction);
        
        this.TaskManager1.StartTask("Task1");
    }

    private void LongAction(object state)
    {
        for (int i = 0; i < 10; i++)
        {
            Thread.Sleep(1000);
            this.Session["Task1"] = i + 1;
        }
        this.Session.Remove("Task1");
    }

    protected void RefreshProgress(object sender, DirectEventArgs e)
    {
        object progress = this.Session["Task1"];
        if (progress != null)
        {
           X.Msg.UpdateProgress(((int)progress) / 10f, string.Format("Step {0} of {1}...", progress.ToString(), 10));
        }
        else
        {
            this.TaskManager1.StopTask("Task1");
            X.MessageBox.Hide();
            this.ResourceManager1.AddScript("Ext.Msg.notify('Done', 'Your items were loaded!');");
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MessageBox - Ext.NET Examples</title>   
    
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
    <script src="/resources/js/examples.js"></script>
    
    <script>
        var showResult = function (btn) {
            Ext.Msg.notify("Button Click", "You clicked the " + btn + " button");
        };

        var showResultText = function (btn, text) {
            Ext.Msg.notify("Button Click", "You clicked the " + btn + 'button and entered the text "' + text + '".');
        };
    </script> 
    
    <style>
        .x-window-dlg .ext-mb-download {
            background : transparent url(resources/images/download.gif) no-repeat top left;
            height : 46px;
        }
    </style>  
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    
    <h1>MessageBox Dialogs</h1>
    
    <p>The following samples demonstrate how to display various MessageBox options.</p>
    
    <h2>1. Confirm</h2>
    
    <span>Standard Yes/No dialog.</span>
    
    <ext:Button ID="Button1" runat="server" Text="Show">
        <DirectEvents>
            <Click OnEvent="Button1_Click" />
        </DirectEvents>
    </ext:Button>
    
    <h2>2. Prompt</h2>
    
    <span>Standard prompt dialog.</span>
    
    <ext:Button ID="Button2" runat="server" Text="Show">
        <DirectEvents>
            <Click OnEvent="Button2_Click" />
        </DirectEvents>
    </ext:Button>
    
    <h2>3. Multi-line Prompt</h2>
    
    <span>A multi-line prompt dialog.</span>
    
    <ext:Button ID="Button3" runat="server" Text="Show" OnDirectClick="Button3_Click" />
    
    <h2>4. Yes/No/Cancel</h2>
    
    <span>Standard Yes/No/Cancel dialog.</span>
    
    <ext:Button ID="Button4" runat="server" Text="Show" OnDirectClick="Button4_Click" />
    
    <h2>5. Progress Dialog</h2>
    
    <span>Dialog with measured progress bar.</span>
    
    <ext:Button ID="Button5" runat="server" Text="Show" OnDirectClick="Button5_Click" />

    <ext:TaskManager ID="TaskManager1" runat="server">
        <Tasks>
            <ext:Task 
                TaskID="Task1"
                Interval="1000" 
                AutoRun="false">
                <DirectEvents>
                    <Update OnEvent="RefreshProgress" />
                </DirectEvents>                    
            </ext:Task>
        </Tasks>
    </ext:TaskManager>

    <h2>6. Wait Dialog</h2>
    
    <span>Dialog with indefinite ProgressBar and custom Icon (will close after 8 sec).</span>
    
    <ext:Button ID="Button6" runat="server" Text="Show" OnDirectClick="Button6_Click" />

    <h2>7. Alert</h2>
    
    <span>Standard Alert dialog.</span>
    
    <ext:Button ID="Button7" runat="server" Text="Show" OnDirectClick="Button7_Click" />

    <h2>8. Icons</h2>
    
    <span>Standard Alert with optional Icon.</span>
    
    <ext:ComboBox ID="ComboBox1" runat="server" Editable="false">
        <Items>
            <ext:ListItem Text="Error" Value="ERROR" />
            <ext:ListItem Text="Informational" Value="INFO" />
            <ext:ListItem Text="Question" Value="QUESTION" />
            <ext:ListItem Text="Warning" Value="WARNING" />
        </Items>
        <SelectedItems>
            <ext:ListItem Value="ERROR" />
        </SelectedItems>
    </ext:ComboBox>
    
    <ext:Button ID="Button8" runat="server" Text="Show">
        <DirectEvents>
            <Click OnEvent="Button8_Click">
                <ExtraParams>
                    <ext:Parameter Name="Icon" Value="#{ComboBox1}.getValue()" Mode="Raw" />
                </ExtraParams>
            </Click>
        </DirectEvents>
    </ext:Button>
</body>
</html>
