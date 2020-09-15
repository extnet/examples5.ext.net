<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = new object[]
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
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Radial Charts Basic - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel runat="server" BodyStyle="background: transparent !important" Width="650">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Center" Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Preview" Handler="this.up('panel').down('polar').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    Height="500"
                    InsetPaddingSpec="40 40 60 40">
                    <Store>
                        <ext:Store runat="server">
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
                    <Interactions>
                        <ext:RotateInteraction />
                    </Interactions>
                    <Items>
                        <ext:TextSprite
                            Text="Radial Charts - Basic"
                            FontSize="22"
                            Width="100"
                            Height="30"
                            X="40"
                            Y="20"
                            />

                        <ext:TextSprite
                            Text="Data: Browser Stats 2012 - Internet Explorer"
                            FontSize="10"
                            X="12"
                            Y="480"
                            />

                        <ext:TextSprite
                            Text="Source: http://www.w3schools.com/"
                            FontSize="10"
                            X="12"
                            Y="495"
                            />
                    </Items>
                    <Axes>
                        <ext:NumericAxis
                            Position="Radial"
                            Fields="data1"
                            Grid="true"
                            Minimum="0"
                            Maximum="25"
                            MajorTickSteps="4">
                            <Renderer Handler="return label + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Angular" Grid="true" />
                    </Axes>
                    <Series>
                        <ext:RadarSeries AngleField="month" RadiusField="data1">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.80" />
                            </StyleSpec>
                            <HighlightConfig>
                                <ext:Sprite FillStyle="#000" LineWidth="2" StrokeStyle="#fff" />
                            </HighlightConfig>
                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="toolTip.setHtml(record.get('month') + ': ' + record.get('data1') + '%');" />
                            </Tooltip>
                        </ext:RadarSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
