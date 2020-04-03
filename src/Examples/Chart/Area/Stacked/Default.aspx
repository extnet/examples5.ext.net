<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<object> data = new List<object>
        {
            new { Date = new DateTime(2009, 1, 1),  IE = 44.8, Firefox = 45.5, Chrome = 3.9,  Safari = 3,   Opera = 2.3 },
            new { Date = new DateTime(2009, 2, 1),  IE = 43.6, Firefox = 46.4, Chrome = 4,    Safari = 3,   Opera = 2.2 },
            new { Date = new DateTime(2009, 3, 1),  IE = 43.3, Firefox = 46.5, Chrome = 4.2,  Safari = 3.1, Opera = 2.3 },
            new { Date = new DateTime(2009, 4, 1),  IE = 42.1, Firefox = 47.1, Chrome = 4.9,  Safari = 3,   Opera = 2.2 },
            new { Date = new DateTime(2009, 5, 1),  IE = 41,   Firefox = 47.7, Chrome = 5.5,  Safari = 3,   Opera = 2.2 },
            new { Date = new DateTime(2009, 6, 1),  IE = 40.7, Firefox = 47.3, Chrome = 6,    Safari = 3.1, Opera = 2.1 },
            new { Date = new DateTime(2009, 7, 1),  IE = 39.4, Firefox = 47.9, Chrome = 6.5,  Safari = 3.3, Opera = 2.1 },
            new { Date = new DateTime(2009, 8, 1),  IE = 39.3, Firefox = 47.4, Chrome = 7,    Safari = 3.3, Opera = 2.1 },
            new { Date = new DateTime(2009, 9, 1),  IE = 39.6, Firefox = 46.6, Chrome = 7.1,  Safari = 3.6, Opera = 2.2 },
            new { Date = new DateTime(2009, 10, 1), IE = 37.5, Firefox = 47.5, Chrome = 8,    Safari = 3.8, Opera = 2.3 },
            new { Date = new DateTime(2009, 11, 1), IE = 37.7, Firefox = 47,   Chrome = 8.5,  Safari = 3.8, Opera = 2.3 },
            new { Date = new DateTime(2009, 12, 1), IE = 37.2, Firefox = 46.4, Chrome = 9.8,  Safari = 3.6, Opera = 2.3 },
            new { Date = new DateTime(2010, 1, 1),  IE = 36.2, Firefox = 46.3, Chrome = 10.8, Safari = 3.7, Opera = 2.2 },
            new { Date = new DateTime(2010, 2, 1),  IE = 35.3, Firefox = 46.5, Chrome = 11.6, Safari = 3.8, Opera = 2.1 },
            new { Date = new DateTime(2010, 3, 1),  IE = 34.9, Firefox = 46.2, Chrome = 12.3, Safari = 3.7, Opera = 2.2 },
            new { Date = new DateTime(2010, 4, 1),  IE = 33.4, Firefox = 46.4, Chrome = 13.6, Safari = 3.7, Opera = 2.2 },
            new { Date = new DateTime(2010, 5, 1),  IE = 32.2, Firefox = 46.9, Chrome = 14.5, Safari = 3.5, Opera = 2.2 },
            new { Date = new DateTime(2010, 6, 1),  IE = 31,   Firefox = 46.6, Chrome = 15.9, Safari = 3.6, Opera = 2.1 },
            new { Date = new DateTime(2010, 7, 1),  IE = 30.4, Firefox = 46.4, Chrome = 16.7, Safari = 3.4, Opera = 2.3 },
            new { Date = new DateTime(2010, 8, 1),  IE = 30.7, Firefox = 45.8, Chrome = 17,   Safari = 3.5, Opera = 2.3 },
            new { Date = new DateTime(2010, 9, 1),  IE = 31.1, Firefox = 45.1, Chrome = 17.3, Safari = 3.7, Opera = 2.2 },
            new { Date = new DateTime(2010, 10, 1), IE = 29.7, Firefox = 44.1, Chrome = 19.2, Safari = 3.9, Opera = 2.2 },
            new { Date = new DateTime(2010, 11, 1), IE = 28.6, Firefox = 44,   Chrome = 20.5, Safari = 4.0, Opera = 2.3 },
            new { Date = new DateTime(2010, 12, 1), IE = 27.5, Firefox = 43.5, Chrome = 22.4, Safari = 3.8, Opera = 2.2 }
        };

        this.Chart1.GetStore().DataSource = data;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Area Stacked - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <p>
            Stacked area are multi-series area charts where categories are stacked on top of each
            other. This is typically done to emphasize the quantity while comparing multiple
            categories.
        </p>

        <ext:Panel
            runat="server"
            Width="850"
            Height="650"
            Layout="Fit">
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPadding="50"
                    Animation="false">
                    <LegendConfig Dock="Bottom" />
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="IE" />
                                        <ext:ModelField Name="Chrome" />
                                        <ext:ModelField Name="Firefox" />
                                        <ext:ModelField Name="Safari" />
                                        <ext:ModelField Name="Opera" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Items>
                        <ext:TextSprite
                            Text="Area Charts - Stacked Area"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20" />

                        <ext:TextSprite
                            Text="Data: Browser Stats 2012"
                            FontSize="10"
                            X="12"
                            Y="580" />

                        <ext:TextSprite
                            Text="Source: http://www.w3schools.com/"
                            FontSize="10"
                            X="12"
                            Y="595" />
                    </Items>
                    <Axes>
                        <ext:NumericAxis
                            Fields="IE"
                            Position="Left"
                            Grid="true"
                            Minimum="0">
                            <Renderer Handler="return label.toFixed(label < 10 ? 1: 0) + '%';" />
                        </ext:NumericAxis>
                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="Date"
                            Grid="true">
                            <Label RotationDegrees="-90" />
                            <Renderer Handler="return Ext.Date.format(label, 'M');" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:AreaSeries
                            Titles="IE,Chrome,Firefox,Safari,Opera"
                            XField="Date"
                            YField="IE,Chrome,Firefox,Safari,Opera">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.8" />
                            </StyleSpec>
                            <Marker>
                                <ext:CircleSprite Opacity="0" Scaling="0.01" Duration="200" Easing="EaseOut" />
                            </Marker>
                            <HighlightDefaults>
                                <ext:CircleSprite Opacity="1" Scaling="1.5" />
                            </HighlightDefaults>
                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="var browser = context.series.getTitle()[Ext.Array.indexOf(context.series.getYField(), context.field)]; toolTip.setHtml(browser + ' for ' +  Ext.Date.format(record.get('Date'), 'M d') + ': ' + record.get(context.field) + '%');" />
                            </Tooltip>
                        </ext:AreaSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
