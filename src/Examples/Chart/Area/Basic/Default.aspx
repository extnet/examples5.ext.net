<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = new List<object>
        {
            new { month = "Jan", data1 = 20 },
            new { month = "Feb", data1 = 20 },
            new { month = "Mar", data1 = 19 },
            new { month = "Apr", data1 = 18 },
            new { month = "May", data1 = 18 },
            new { month = "Jun", data1 = 17 },
            new { month = "Jul", data1 = 16 },
            new { month = "Aug", data1 = 16 },
            new { month = "Sep", data1 = 16 },
            new { month = "Oct", data1 = 16 },
            new { month = "Nov", data1 = 15 },
            new { month = "Dec", data1 = 15 }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Area Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var downloadWithOptions = function (chart, form) {
            var opts = form.getForm().getValues(false, false, false, true);

            // simple empty values remove, optimize it if it is required
            Ext.Object.each(opts, function (key, value, myself) {
                if (Ext.isObject(value)) {
                    Ext.Object.each(value, function (key, value, myself) {
                        if (Ext.isEmpty(value)) {
                            delete myself[key];
                        }
                    });

                    if (Ext.Object.isEmpty(value)) {
                        delete myself[key];
                    }
                }
                else if (Ext.isEmpty(value)) {
                    delete myself[key];
                }
            });
            chart.download(opts);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:Container runat="server" OverflowY="Auto">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Center" Align="Center" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel
                            runat="server"
                            Width="650"
                            BodyStyle="background: transparent !important">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Pack="Center" Align="Center" />
                            </LayoutConfig>
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarFill />

                                        <ext:Button
                                            runat="server"
                                            Text="Preview"
                                            IconCls="x-md md-icon-search"
                                            Handler="App.Chart1.preview();" />

                                        <ext:SplitButton
                                            runat="server"
                                            Text="Download as PNG"
                                            IconCls="x-md md-icon-save-alt"
                                            Handler="App.Chart1.download();">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:UserControlLoader runat="server" Path="DownloadOptions.ascx" />
                                                        <ext:Button runat="server"
                                                            Text="Download with options"
                                                            Margin="10"
                                                            Handler="downloadWithOptions(App.Chart1, this.prev());" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:CartesianChart
                                    ID="Chart1"
                                    runat="server"
                                    Height="500"
                                    Width="650"
                                    StyleSpec="background:#fff;"
                                    InsetPadding="40">
                                    <Store>
                                        <ext:Store
                                            ID="Store1"
                                            runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="month" />
                                                        <ext:ModelField Name="data1" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Items>
                                        <ext:TextSprite
                                            Text="Area Charts - Basic Area"
                                            FontSize="22"
                                            Width="100"
                                            Height="30"
                                            X="40"
                                            Y="20" />

                                        <ext:TextSprite
                                            Text="Data: Browser Stats 2012 - Internet Explorer"
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
                                            Fields="data1"
                                            Position="Left"
                                            Grid="true"
                                            Minimum="0"
                                            Maximum="24">
                                            <Renderer Handler="return layoutContext.renderer(label) + '%';" />
                                        </ext:NumericAxis>

                                        <ext:CategoryAxis
                                            Position="Bottom"
                                            Fields="month"
                                            Grid="true">
                                            <Label RotationDegrees="-45" />
                                        </ext:CategoryAxis>
                                    </Axes>
                                    <Series>
                                        <ext:AreaSeries
                                            XField="month"
                                            YField="data1">
                                            <StyleSpec>
                                                <ext:Sprite GlobalAlpha="0.8" />
                                            </StyleSpec>
                                            <Marker>
                                                <ext:CircleSprite GlobalAlpha="0" ScalingX="0.01" ScalingY="0.01" Duration="200" Easing="EaseOut" />
                                            </Marker>
                                            <HighlightDefaults>
                                                <ext:CircleSprite GlobalAlpha="1" ScalingX="1.5" ScalingY="1.5" />
                                            </HighlightDefaults>
                                            <Tooltip runat="server" TrackMouse="true">
                                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data1') + ' %');" />
                                            </Tooltip>
                                        </ext:AreaSeries>
                                    </Series>
                                </ext:CartesianChart>

                                <ext:GridPanel runat="server" StoreID="Store1" StyleSpec="margin-top: 10px;" Width="250">
                                    <ColumnModel>
                                        <Columns>
                                            <ext:Column runat="server" Text="Month" DataIndex="month" Sortable="false" MenuDisabled="true" />
                                            <ext:Column runat="server" Text="IE" DataIndex="data1" Sortable="false" MenuDisabled="true">
                                                <Renderer Handler="return value + '%';" />
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
