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
    <title>Pie Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var tipRenderer = function (toolTip, record, context) {
            var total = 0;

            App.Chart1.getStore().each(function (rec) {
                total += rec.get('Data1');
            });

            toolTip.setTitle(record.get('Name') + ': ' + Math.round(record.get('Data1') / total * 100) + '%');
        };

        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice === 'yes') {
                    btn.up('panel').down('polar').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Pie Chart Example</h1>

        <p>Display 5 sets of random data using a pie chart. Reload data will randomly generate a new set of data in the store.</p>

        <p>Toggle Donut button will dynamically change the chart between a Donut and Pie chart.</p>

        <p>Click or hover on the legend items to highlight and remove them from the chart.</p>

        <ext:Panel
            runat="server"
            Width="960"
            Height="600"
            Title="Semester Trends"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Save Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData" />

                        <ext:Button runat="server" Text="Donut" EnableToggle="true">
                            <Listeners>
                                <Toggle Handler="App.Chart1.series[0].setDonut(pressed ? 35 : false); App.Chart1.redraw();" />
                            </Listeners>
                        </ext:Button>

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
                    Shadow="true"
                    InsetPadding="60"
                    InnerPadding="20">
                    <LegendConfig runat="server" Dock="Right" />
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(6) %>"
                            AutoDataBind="true">
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
                    <Interactions>
                        <ext:ItemHighlightInteraction />
                        <ext:RotateInteraction />
                    </Interactions>
                    <Series>
                        <ext:PieSeries
                            AngleField="Data1"
                            ShowInLegend="true"
                            Donut="0"
                            HighlightMargin="20">
                            <Label Field="Name" Display="Rotate" FontSize="18" FontFamily="Arial" />
                            <Tooltip runat="server" TrackMouse="true" Width="140" Height="28">
                                <Renderer Fn="tipRenderer" />
                            </Tooltip>
                        </ext:PieSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
