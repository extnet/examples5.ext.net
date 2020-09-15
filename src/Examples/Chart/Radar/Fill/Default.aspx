<%@ Page Language="C#" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Filled Radial Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Radar Fill Example</h1>

        <p>Display 3 sets of random data in a filled radar series. Reload data will randomly generate a new set of data in the store.</p>

        <p>Click or hover on the legend items to highlight and remove them from the chart.</p>

        <ext:Panel
            runat="server"
            Title="Filled Radar Chart"
            Width="960"
            Height="600"
            StyleSpec="overflow:hidden;"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData" />

                        <ext:Button
                            runat="server"
                            Text="Preview"
                            Handler="this.up('panel').down('polar').preview();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    StyleSpec="background:#fff;"
                    StandardTheme="Category2"
                    InsetPadding="20">
                    <LegendConfig runat="server" Dock="Right" />
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>"
                            AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Interactions>
                        <ext:RotateInteraction />
                    </Interactions>
                    <Axes>
                        <ext:NumericAxis
                            Position="Radial"
                            Fields="Data1,Data2,Data3"
                            Grid="true">
                            <Renderer Handler="return label + '%';" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Angular" Grid="true" />
                    </Axes>
                    <series>
                        <ext:RadarSeries AngleField="Name" RadiusField="Data1" ShowInLegend="true">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.4" />
                            </StyleSpec>
                        </ext:RadarSeries>

                        <ext:RadarSeries AngleField="Name" RadiusField="Data2" ShowInLegend="true">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.4" />
                            </StyleSpec>
                        </ext:RadarSeries>

                        <ext:RadarSeries AngleField="Name" RadiusField="Data3" ShowInLegend="true">
                            <StyleSpec>
                                <ext:Sprite Opacity="0.4" />
                            </StyleSpec>
                        </ext:RadarSeries>
                    </series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
