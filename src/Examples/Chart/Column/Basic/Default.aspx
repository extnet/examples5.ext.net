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
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice === 'yes') {
                    btn.up('panel').down('chart').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>Display a sets of random data in a column series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:Panel
            runat="server"
            Width="960"
            Height="600"
            Layout="Fit">
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
                    runat="server">
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
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Data1"
                            Grid="true"
                            Title="Number of Hits"
                            Minimum="0">
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" Title="Month of the Year">
                            <Label RotationDegrees="-45" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:BarSeries
                            Highlight="true"
                            XField="Name"
                            YField="Data1">
                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="toolTip.setTitle(record.get('Name') + ': ' + record.get('Data1'));" />
                            </Tooltip>
                            <Label
                                Display="InsideEnd"
                                Field="Data1"
                                Orientation="Horizontal"
                                Color="#333"
                                TextAlign="Center"
                                RotationDegrees="45">
                                <Renderer Handler="return Ext.util.Format.number(text, '0');" />
                            </Label>
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
