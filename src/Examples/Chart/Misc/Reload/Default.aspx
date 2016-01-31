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
    <title>Reload Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Reload Column Chart Sample</h1>

        <p>Displaying a Column Chart Sample that animates when refreshing the data set.</p>

        <ext:Panel
            runat="server"
            Width="800"
            Height="400"
            Title="Column Chart with Reload - Hits per Month"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            Icon="ArrowRefresh"
                            OnDirectClick="ReloadData" />

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
                    Shadow="true">
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
                            Grid="true"
                            Title="Hits"
                            Minimum="0"
                            Maximum="100"
                            Position="Left" />

                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="Name"
                            Title="Months">
                            <Label RotationDegrees="270" />
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:BarSeries
                            XField="Name"
                            YField="Data1">
                            <Tooltip runat="server" TrackMouse="true" Width="74" Height="38">
                                <Renderer Handler="toolTip.setTitle(record.get('Name') + '<br />' + record.get('Data1')); this.update(record.get('data1'));" />
                            </Tooltip>
                            <StyleSpec>
                                <ext:Sprite FillStyle="#38B8BF" />
                            </StyleSpec>
                        </ext:BarSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
