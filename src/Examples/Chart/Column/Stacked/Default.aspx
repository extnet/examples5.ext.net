<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
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
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function toggleMode(segmentedButton, button, pressed) {
            var chart = this.up('panel').down('cartesian'),
                series = chart.getSeries()[0],
                value = segmentedButton.getValue();

            series.setStacked(value === 0);
            chart.redraw();
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart - Stacked Columns</h1>

        <p>Stacked columns are multi-series column charts where categories are stacked on top of</p>
        <p>each other. This is typically done to visually represent the total of all categories</p>
        <p>for a given period or value.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Layout="AnchorLayout"
            DefaultAnchor="100%">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:SegmentedButton runat="server"
                            Width="200">
                            <Items>
                                <ext:Button runat="server" Text="Stack" Pressed="true" />
                                <ext:Button runat="server" Text="Group" />
                            </Items>
                            <Listeners>
                                <Toggle Fn="toggleMode" />
                            </Listeners>
                        </ext:SegmentedButton>

                        <ext:Button
                            runat="server"
                            Text="Preview"
                            Handler="this.up('panel').down('cartesian').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    Height="460"
                    InsetPaddingSpec="10 40 40 40">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <LegendConfig Dock="Bottom" />

                    <Items>
                        <ext:TextSprite
                            Text="Data: Browser Stats 2012"
                            FontSize="10"
                            X="12"
                            Y="380" />

                        <ext:TextSprite
                            Text="Source: http://www.w3schools.com/"
                            FontSize="10"
                            X="12"
                            Y="395" />
                    </Items>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            AdjustByMajorUnit="true"
                            Fields="Data1"
                            Grid="true"
                            Minimum="0">
                            <Renderer Handler="return label.toFixed(label < 10 ? 1: 0) + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Month" Grid="true">
                            <Label RotationDegrees="-45" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:BarSeries
                            XField="Month"
                            YField="Data1,Data2,Data3,Data4"
                            Stacked="true"
                            Titles="IE,Firefox,Chrome,Safari">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.8" />
                            </StyleSpec>

                            <HighlightConfig>
                                <ext:Sprite FillStyle="yellow" />
                            </HighlightConfig>

                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="var browser = context.series.getTitle()[Ext.Array.indexOf(context.series.getYField(), context.field)]; toolTip.setHtml(browser + ' for ' + record.get('Month') + ': ' + record.get(context.field) + '%');" />
                            </Tooltip>
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>

                <ext:GridPanel runat="server" StoreID="Store1" StyleSpec="margin-top: 10px;">
                    <ColumnModel>
                        <Defaults>
                            <ext:Parameter Name="Sortable" Value="false" />
                            <ext:Parameter Name="MenuDisabled" Value="true" />
                            <ext:Parameter Name="Renderer" Value="function(v){return v + '%';}" Mode="Raw" />
                        </Defaults>
                        <Columns>
                            <ext:Column runat="server" Text="Month" DataIndex="Month">
                                <Renderer Handler="return value;" />
                            </ext:Column>
                            <ext:Column runat="server" Text="IE" DataIndex="Data1" />
                            <ext:Column runat="server" Text="Firefox" DataIndex="Data2" />
                            <ext:Column runat="server" Text="Chrome" DataIndex="Data3" />
                            <ext:Column runat="server" Text="Safari" DataIndex="Data4" />
                        </Columns>
                    </ColumnModel>
                </ext:GridPanel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
