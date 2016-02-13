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
    <title>Bar Renderer - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function barRenderer(sprite, config, rendererData, index) {
            var store = rendererData.store,
                storeItems = store.getData().items,
                record = storeItems[index],
                fieldValue = Math.random() * 20 + 10,
                value = (record.get('Data1') >> 0) % 5,
                color = ['rgb(213, 70, 121)',
                            'rgb(44, 153, 201)',
                            'rgb(146, 6, 157)',
                            'rgb(49, 149, 0)',
                            'rgb(249, 153, 0)'][value];

            return {
                fill: color
            };
        }

        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if(choice == 'yes') {
                    btn.up('panel').down('chart').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Bar Renderer Sample</h1>

        <p>Displaying a horizontal bar series with a bar renderer that modifies the color of each bar.</p>

        <ext:Panel
            runat="server"
            Title="Bar Renderer"
            Width="800"
            Height="600"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            Icon="ArrowRefresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save Chart"
                            Icon="Disk"
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
                            Fields="Data1"
                            Position="Bottom"
                            Grid="true"
                            Title="Number of Hits">
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Fields="Name" Position="Left" Title="Month of the Year" />
                    </Axes>

                    <Series>
                        <ext:BarSeries
                            XField="Name"
                            YField="Data1">
                            <Label
                                Display="InsideEnd"
                                Field="Data1"
                                Orientation="Horizontal"
                                Color="#333"
                                TextAlign="Center">
                                <Renderer Handler="return Ext.util.Format.number(text, '0,0');" />
                            </Label>
                            <Renderer Fn="barRenderer" />
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>