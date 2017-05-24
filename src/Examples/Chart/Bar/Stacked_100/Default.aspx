<%@ Page Language="C#" %>

<script runat="server">
    public List<object> Data
    {
        get
        {
            return new List<object>
            {
                new { Month = "Jan", Data1 = 20, Data2 = 37, Data3 = 35, Data4 = 4 },
                new { Month = "Feb", Data1 = 20, Data2 = 37, Data3 = 36, Data4 = 5 },
                new { Month = "Mar", Data1 = 19, Data2 = 36, Data3 = 37, Data4 = 4 },
                new { Month = "Apr", Data1 = 18, Data2 = 36, Data3 = 38, Data4 = 5 },
                new { Month = "May", Data1 = 18, Data2 = 35, Data3 = 39, Data4 = 4 },
                new { Month = "Jun", Data1 = 17, Data2 = 34, Data3 = 42, Data4 = 4 },
                new { Month = "Jul", Data1 = 16, Data2 = 34, Data3 = 43, Data4 = 4 },
                new { Month = "Aug", Data1 = 16, Data2 = 33, Data3 = 44, Data4 = 4 },
                new { Month = "Sep", Data1 = 16, Data2 = 32, Data3 = 44, Data4 = 4 },
                new { Month = "Oct", Data1 = 16, Data2 = 32, Data3 = 45, Data4 = 4 },
                new { Month = "Nov", Data1 = 15, Data2 = 31, Data3 = 46, Data4 = 4 },
                new { Month = "Dec", Data1 = 15, Data2 = 31, Data3 = 47, Data4 = 4 }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Stacked Bar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function convert(value, record) {
            var total = 0;
            Ext.Object.each(record.data, function (key, value) {
                total += Ext.isNumber(value) ? value : 0;
            });
            return Math.max(0, 100 - total);
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Stacked Bar Chart Sample</h1>

        <p>100% stacked bars are multi-series bar charts where categories are stacked (percentage</p>
        <p>values) next to each other, with an additional category 'Others' that is used to sum up</p>
        <p>the various categories for each series to a perfect 100%.</p>

        <ext:Container
            runat="server"
            Width="800"
            Height="500"
            Layout="FitLayout">
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    FlipXY="true"
                    InsetPadding="40">
                    <Store>
                        <ext:Store runat="server" Data="<%# Data %>" AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                        <ext:ModelField Name="Other">
                                            <Convert Fn="convert" />
                                        </ext:ModelField>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <LegendConfig Dock="Right" />

                    <Items>
                        <ext:TextSprite
                            Text="Bar Charts - 100% Stacked Bars"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20" />

                        <ext:TextSprite
                            Text="Data: Browser Stats 2012"
                            FontSize="10"
                            X="12"
                            Y="480" />

                        <ext:TextSprite
                            Text="Source: http://www.w3schools.com/"
                            FontSize="10"
                            X="12"
                            Y="495" />
                    </Items>

                    <Axes>
                        <ext:NumericAxis
                            Fields="Data1"
                            Position="Bottom"
                            Grid="true"
                            MajorTickSteps="10"
                            Minimum="0"
                            Maximum="100">
                            <Renderer Handler="return label + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Fields="Month" Position="Left" Grid="true" />
                    </Axes>

                    <Series>
                        <ext:BarSeries
                            XField="Month"
                            YField="Data1,Data2,Data3,Data4,Other"
                            Titles="IE,Firefox,Chrome,Safari,Other"
                            Stacked="true">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.8" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite FillStyle="yellow" />
                            </HighlightConfig>
                            <Tooltip TrackMouse="true">
                                <Renderer Handler="var browser = context.series.getTitle()[Ext.Array.indexOf(context.series.getYField(), context.field)]; toolTip.setHtml(browser + ' for ' + record.get('Month') + ': ' + record.get(context.field) + '%');" />
                            </Tooltip>
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Container>
    </form>
</body>
</html>