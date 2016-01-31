<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        JSON.RequestSettings = new Newtonsoft.Json.JsonSerializerSettings();
        JSON.RequestSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Local;
            
        var date = DateTime.Now;
        var field = new DisplayTimeField { FieldLabel = date.ToShortTimeString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddMinutes(-1);
        field = new DisplayTimeField { FieldLabel = date.ToShortTimeString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddMinutes(-10);
        field = new DisplayTimeField { FieldLabel = date.ToShortTimeString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddHours(-1);
        field = new DisplayTimeField { FieldLabel = date.ToShortTimeString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddHours(-10);
        field = new DisplayTimeField { FieldLabel = date.ToShortTimeString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddDays(-1);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddDays(-10);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddMonths(-1);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddMonths(-10);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddYears(-1);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);

        date = DateTime.Now.AddYears(-10);
        field = new DisplayTimeField { FieldLabel = date.ToShortDateString(), Date = date };
        Window1.Items.Add(field);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DisplayTime Field - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>DisplayTime</h1>
        
        <p>DisplayTime converts passed date to friendly format</p>

        <p>DisplayTime can automatically update text if set AutoUpdate=true (update interval is controled by UpdateInterval property)</p>
        
        <ext:Window 
            ID="Window1"
            runat="server" 
            Width="500"
            Height="500"
            Title="DisplayTime"
            Icon="Date"
            Closable="false"
            BodyPadding="5"
            DefaultLabelSeparator=" ">                        
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:DateField runat="server" FieldLabel="Date&nbsp;to&nbsp;DisplayField" LabelWidth="125">
                            <Listeners>
                                <Select Handler="#{DisplayField1}.setValue(Ext.util.Format.time(this.getValue()));" />
                            </Listeners>
                        </ext:DateField>
                        <ext:ToolbarSeparator />
                        <ext:DisplayField ID="DisplayField1" runat="server" />
                    </Items>
                </ext:Toolbar>
            </BottomBar>            
        </ext:Window>                
   </form>
</body>
</html>