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
    <title>Grouped Bar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    btn.up('panel').down('chart').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Grouped Bar Sample</h1>

        <p>Display 3 sets of random data in a grouped bar series.</p>

        <p>Reload data will randomly generate a new set of data in the store. Click or hover on the legend items to highlight and remove them from the chart.</p>

        <ext:Panel
            runat="server"
            Title="Grouped Bar Chart"
            Width="960"
            Height="600"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    FlipXY="true">
                    <LegendConfig Dock="Right" />
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
                    <Axes>
                        <ext:NumericAxis
                            Position="Bottom"
                            Fields="Data1,Data2,Data3"
                            Title="Number of Hits"
                            Grid="true"
                            Minimum="0">
                            <Renderer Fn="Ext.util.Format.numberRenderer('0,0')" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Fields="Name" Position="Left" Title="Month of the Year" />
                    </Axes>
                    <Series>
                        <ext:BarSeries Stacked="false"
                            XField="Name"
                            YField="Data1,Data2,Data3"
                            />
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>