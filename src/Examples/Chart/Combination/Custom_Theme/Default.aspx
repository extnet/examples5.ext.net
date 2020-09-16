<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { month = "Jan", data1 = 20, data2 = 37, data3 = 35, data4 = 4 },
            new { month = "Feb", data1 = 20, data2 = 37, data3 = 36, data4 = 5 },
            new { month = "Mar", data1 = 19, data2 = 36, data3 = 37, data4 = 4 },
            new { month = "Apr", data1 = 18, data2 = 36, data3 = 38, data4 = 5 },
            new { month = "May", data1 = 18, data2 = 35, data3 = 39, data4 = 4 },
            new { month = "Jun", data1 = 17, data2 = 34, data3 = 42, data4 = 4 },
            new { month = "Jul", data1 = 16, data2 = 34, data3 = 43, data4 = 4 },
            new { month = "Aug", data1 = 16, data2 = 33, data3 = 44, data4 = 4 },
            new { month = "Sep", data1 = 16, data2 = 32, data3 = 44, data4 = 4 },
            new { month = "Oct", data1 = 16, data2 = 32, data3 = 45, data4 = 4 },
            new { month = "Nov", data1 = 15, data2 = 31, data3 = 46, data4 = 4 },
            new { month = "Dec", data1 = 15, data2 = 31, data3 = 47, data4 = 4 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Theme - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Theme</h1>
        <p>This example demonstrates how easy it is to change the colors of a chart's series using a custom theme.</p>

        <ext:ChartTheme runat="server" ThemeName="custom-theme" Colors="#1ABC9C,#F1C40F,#3498DB,#C0392B,#9B59B6">
            <Axis>
                <Defaults>
                    <ext:NumericAxis>
                        <Style StrokeStyle="#7F8C8D" />
                        <Label FillStyle="#7F8C8D" FontSize="18" />
                    </ext:NumericAxis>
                </Defaults>
            </Axis>
        </ext:ChartTheme>

        <ext:CartesianChart
            ID="Chart1"
            runat="server"
            Theme="custom-theme"
            Width="650"
            Height="500"
            InsetPadding="40">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="month" />
                                <ext:ModelField Name="data1" />
                                <ext:ModelField Name="data2" />
                                <ext:ModelField Name="data3" />
                                <ext:ModelField Name="data4" />
                                <ext:ModelField Name="other">
                                    <Convert Handler="var total = 0; Ext.Object.each(record.data, function(key, value) { total += Ext.isNumber(value) ? value : 0; }); return Math.max(0, 100 - total);" />
                                </ext:ModelField>
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>

            <LegendConfig Dock="Bottom" />

            <Items>
                <ext:TextSprite
                    Text="Column Charts - 100% Stacked Columns"
                    FontSize="22"
                    Width="100"
                    Height="30"
                    X="40"
                    Y="20"
                    />

                <ext:TextSprite
                    Text="Data: Browser Stats 2012"
                    FontSize="10"
                    X="12"
                    Y="420"
                    />

                <ext:TextSprite
                    Text="Source: http://www.w3schools.com/"
                    FontSize="10"
                    X="12"
                    Y="435"
                    />
            </Items>

            <Axes>
                <ext:NumericAxis
                    Fields="data1,data2,data3,data4,other"
                    Position="Left"
                    Grid="true"
                    Minimum="0"
                    Maximum="100">
                    <Renderer Handler="return label + '%';" />
                </ext:NumericAxis>

                <ext:CategoryAxis Fields="month" Position="Bottom" Grid="true">
                    <Label RotationDegrees="-45" />
                </ext:CategoryAxis>
            </Axes>

            <Series>
                <ext:BarSeries
                    Titles="IE,Firefox,Chrome,Safari,Others"
                    XField="month"
                    YField="data1,data2,data3,data4,other"
                    Stacked="true">
                    <StyleSpec>
                        <ext:Sprite Opacity="0.8" />
                    </StyleSpec>
                    <HighlightDefaults>
                        <ext:Sprite Opacity="1" StrokeStyle="black" />
                    </HighlightDefaults>
                    <Tooltip TrackMouse="true">
                        <Renderer Handler="var browser = context.series.getTitle()[Ext.Array.indexOf(context.series.getYField(), context.field)]; toolTip.setHtml(browser + ' for ' + record.get('month') + ': ' + record.get(context.field) + '%');" />
                    </Tooltip>
                </ext:BarSeries>
            </Series>
        </ext:CartesianChart>
    </form>
</body>
</html>
