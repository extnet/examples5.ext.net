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

    <script>
        var timeConverter = function (value, texts) {
            var value10 = value % 10;

            if ((value10 == 1) && ((value == 1) || (value > 20))) {
              return texts[0];
            } else if ((value10 > 1) && (value10 < 5) && ((value > 20) || (value < 10) )) {
              return texts[1];
            }

            return texts[2];
        }

        Ext.apply(Ext.util.Format.timeSettings, {
            pastPrefix: null,
            futurePrefix: "через",
            pastSuffix: "назад",
            futureSuffix: "",
            seconds: "меньше минуты",
            minute: "минуту",
            minutes: function (value) { return timeConverter(value, ["{0} минута", "{0} минуты", "{0} минут"]); },
            hour: "час",
            hours: function (value) { return timeConverter(value, ["{0} час", "{0} часа", "{0} часов"]); },
            day: "день",
            days: function (value) { return timeConverter(value, ["{0} день", "{0} дня", "{0} дней"]); },
            month: "месяц",
            months: function (value) { return timeConverter(value, ["{0} месяц", "{0} месяца", "{0} месяцев"]); },
            year: "год",
            years: function (value) { return timeConverter(value, ["{0} год", "{0} года", "{0} лет"]); }
        });

    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DisplayTime - Russian localization</h1>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="500"
            Height="500"
            Title="DisplayTime"
            IconCls="x-md md-icon-calendar-today"
            Closable="false"
            BodyPadding="18"
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