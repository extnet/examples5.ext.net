<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        JSON.RequestSettings = new Newtonsoft.Json.JsonSerializerSettings();
        JSON.RequestSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Local;

        var date = DateTime.Now.AddSeconds(-5);
        var field = new DisplayTimeField { FieldLabel = date.ToLongTimeString(), Date = date };
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
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DisplayTime Field - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        Ext.util.Format.timeSettings = {
            pastPrefix: null,
            futurePrefix: null,
            pastSuffix: "ago",
            futureSuffix: "from now",
            seconds10: "less than 10 seconds",
            seconds: "less than a minute",
            minute: "about a minute",
            minutes: "{0} minutes",
            hour: "about an hour",
            hours: "about {0} hours",
            day: "a day",
            days: "{0} days",
            month: "about a month",
            months: "{0} months",
            year: "about a year",
            years: "{0} years",
            ranges : [
                {value: 0, unit: "second"},
                {value: 10, unit: "second", setting: "seconds10"}, // <- new range, less than 10 seconds
                {value: 45, unit: "second", setting : "seconds"},
                {value: 90, unit: "second", setting : "minute"},
                {value: 45, unit: "minute", setting : "minutes"},
                {value: 90, unit: "minute", setting : "hour"},
                {value: 24, unit: "hour", setting : "hours"},
                {value: 42, unit: "hour", setting : "day"},
                {value: 30, unit: "day", setting : "days"},
                {value: 45, unit: "day", setting : "month"},
                {value: 365, unit: "day", setting : "months", divider: 30},
                {value: 1.5, unit: "year", setting : "year"},
                {value: Number.POSITIVE_INFINITY, unit: "year", setting : "years"},
            ]
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DisplayTime</h1>

        <p>Custom ranges can be defined via Ext.util.Format.timeSettings</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="500"
            Height="250"
            Title="DisplayTime"
            Icon="Date"
            Closable="false"
            BodyPadding="18"
            DefaultLabelSeparator=" "
            />
   </form>
</body>
</html>