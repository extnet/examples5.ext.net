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

        <h1>Column Chart Sample</h1>

        <p>Display a sets of random data in a column series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:Panel
            runat="server"
            Title="Column Chart"
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
                    runat="server">
                    <AnimationConfig Easing="BounceOut" Duration="750" />
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(5, 0) %>"
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

                    <Gradients>
                        <ext:LinearGradient GradientID="v-1" Degrees="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(212, 40, 40)" />
                                <ext:GradientStop Offset="100" Color="rgb(117, 14, 14)" />
                            </Stops>
                        </ext:LinearGradient>

                        <ext:LinearGradient GradientID="v-2" Degrees="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(180, 216, 42)" />
                                <ext:GradientStop Offset="100" Color="rgb(94, 114, 13)" />
                            </Stops>
                        </ext:LinearGradient>

                        <ext:LinearGradient GradientID="v-3" Degrees="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(43, 221, 115)" />
                                <ext:GradientStop Offset="100" Color="rgb(14, 117, 56)" />
                            </Stops>
                        </ext:LinearGradient>

                        <ext:LinearGradient GradientID="v-4" Degrees="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(45, 117, 226)" />
                                <ext:GradientStop Offset="100" Color="rgb(14, 56, 117)" />
                            </Stops>
                        </ext:LinearGradient>

                        <ext:LinearGradient GradientID="v-5" Degrees="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(187, 45, 222)" />
                                <ext:GradientStop Offset="100" Color="rgb(85, 10, 103)" />
                            </Stops>
                        </ext:LinearGradient>
                    </Gradients>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Data1"
                            Title="Number of Hits"
                            Minimum="0"
                            Maximum="100">
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                            <GridConfig>
                                <Odd StrokeStyle="#555" />
                                <Even StrokeStyle="#555" />
                            </GridConfig>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" Title="Month of the Year" />
                    </Axes>

                    <Series>
                        <ext:BarSeries
                            Highlight="true"
                            XField="Name"
                            YField="Data1">
                            <Label
                                Display="InsideEnd"
                                Field="Data1"
                                Orientation="Horizontal"
                                FillStyle="#000"
                                Font="17px Arial"
                                TextAlign="Center">
                                <Renderer Handler="return Ext.util.Format.number(text, '0');" />
                            </Label>
                            <StyleSpec>
                                <ext:Sprite Opacity="0.95" />
                            </StyleSpec>
                            <Renderer Handler="var colors = ['url(#v-1)','url(#v-2)','url(#v-3)','url(#v-4)','url(#v-5)'];return {fill : colors[index % colors.length]};" />
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>