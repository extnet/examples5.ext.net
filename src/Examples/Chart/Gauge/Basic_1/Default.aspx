<%@ Page Language="C#" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
        this.Chart2.GetStore().DataBind();
        this.Chart3.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Gauge Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

     <script>
        var saveChart = function saveChart (chart) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    chart.download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Gauge</h1>

        <p>Displaying three custom gauge charts bound to different data stores with different configuration options and easings.</p>

        <p>Click on <b>Reload Data</b> to update the information.</p>

        <ext:Panel runat="server" Width="960" Height="360">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save 1st Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart(#{Chart1});"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save 2nd Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart(#{Chart2});"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save 3rd Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart(#{Chart3});"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:PolarChart
                    ID="Chart1"
                    runat="server"
                    StyleSpec="background:#fff;"
                    InsetPadding="25"
                    Flex="1">
                    <Store>
                        <ext:Store runat="server" Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Gauge"
                            Minimum="0"
                            Maximum="100"
                            MajorTickSteps="10"
                            Margin="-10"
                            />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries
                            AngleField="Data1"
                            Donut="0"
                            Colors="#F49D10,#ddd"
                            TotalAngleDegrees="180"
                            />
                    </Series>
                </ext:PolarChart>

                <ext:PolarChart
                    ID="Chart2"
                    runat="server"
                    StyleSpec="background:#fff;"
                    InsetPadding="25"
                    Flex="1">
                    <Store>
                        <ext:Store runat="server" Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Gauge"
                            Minimum="0"
                            Maximum="100"
                            MajorTickSteps="10"
                            Margin="7"
                            />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries
                            AngleField="Data1"
                            Donut="30"
                            Colors="#82B525,#ddd"
                            TotalAngleDegrees="180"
                            />
                    </Series>
                </ext:PolarChart>

                <ext:PolarChart
                    ID="Chart3"
                    runat="server"
                    StyleSpec="background:#fff;"
                    InsetPadding="25"
                    Flex="1">
                    <AnimationConfig Easing="BounceOut" Duration="500" />
                    <Store>
                        <ext:Store runat="server" Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Gauge"
                            Minimum="0"
                            Maximum="100"
                            MajorTickSteps="10"
                            Margin="7"
                            />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries
                            AngleField="Data1"
                            Donut="80"
                            Colors="#3AA8CB,#ddd"
                            TotalAngleDegrees="180"
                            />
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>