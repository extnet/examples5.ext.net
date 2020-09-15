<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.TimeField1.SelectedTime = new TimeSpan(15,0,0);
            this.TimeField2.SelectedTime = new TimeSpan(17, 0, 0);
        }
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        TimeSpan time1 = TimeField1.SelectedTime;
        TimeSpan time2 = TimeField2.SelectedTime;

        this.TimeField1.SelectedTime = time2;
        this.TimeField2.SelectedTime = time1;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TimeField Control Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Locale="en-US" />

        <h1>TimeField Control Variations</h1>
        <br />

        <h2>1. 12-hour time format</h2>
        <ext:TimeField
            ID="TimeField1"
            runat="server"
            MinTime="9:00"
            MaxTime="18:00"
            Increment="30"
            Format="hh:mm tt"
            />

        <br />
        <br />

        <h2>2. 24-hour time format</h2>

        <ext:TimeField
            ID="TimeField2"
            runat="server"
            MinTime="9:00"
            MaxTime="18:00"
            Increment="30"
            SelectedTime="09:00"
            Format="H:mm"
            />

        <br />
        <br />

        <ext:Button runat="server" Text="Swap Selected Times" OnDirectClick="Button1_Click" />
    </form>

</body>
</html>
