<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Charts - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-panel {
            margin-bottom : 20px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Charts Example</h1>

        <p>Displaying multiple charts and mixed charts with mouse over and click interaction.</p>

        <ext:Panel
            runat="server"
            Width="960"
            Height="480"
            Title="Trends, 2007/2008 (No styling)"
            Layout="Fit">
            <Items>
                <ext:CartesianChart runat="server" InsetPadding="30">
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
                        <ext:NumericAxis Position="Left" Minimum="0" Fields="Data1" Grid="true">
                            <Label Font="Arial" FontSize="10" />
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name">
                            <Label Font="Arial" FontSize="11" />
                            <Renderer Handler="return label.substr(0, 3) + ' 07';" />
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:LineSeries XField="Name" YField="Data1" Fill="false">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tooltip runat="server" TrackMouse="true">
                                <Renderer Handler="toolTip.setTitle(record.get('Name') + '<br />' + record.get('Data1'));" />
                            </Tooltip>

                            <StyleSpec>
                                <ext:Sprite FillStyle="#38B8BF" StrokeStyle="#38B8BF" LineWidth="3" />
                            </StyleSpec>

                            <Marker>
                                <ext:CircleSprite Radius="4" LineWidth="0" FillStyle="#38B8BF" StrokeStyle="#38B8BF" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Width="960"
            Height="480"
            Title="Trends, 2007/2008 (No styling)"
            Layout="Fit">
            <Items>
                <ext:CartesianChart runat="server" InsetPadding="30">
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
                        <ext:NumericAxis Position="Left" Minimum="0" Fields="Data1" Grid="true">
                            <Label Font="Arial" FontSize="10" />
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name">
                            <Label Font="Arial" FontSize="11" />
                            <Renderer Handler="return label.substr(0, 3);" />
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:LineSeries XField="Name" YField="Data1" Fill="false">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tooltip runat="server" TrackMouse="true" Width="110" Height="25">
                                <Renderer Handler="toolTip.setTitle(record.get('Data1') + ' visits in ' + record.get('Name').substr(0, 3));"></Renderer>
                            </Tooltip>

                            <StyleSpec>
                                <ext:Sprite FillStyle="#38B8BF" StrokeStyle="#38B8BF" LineWidth="3" />
                            </StyleSpec>

                             <Marker>
                                <ext:CircleSprite Radius="4" LineWidth="0" FillStyle="#38B8BF" StrokeStyle="#38B8BF" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Width="960"
            Height="480"
            Title="Trends, 2007/2008 (Simple styling)"
            Layout="Fit">
            <Items>
                <ext:CartesianChart runat="server" InsetPadding="30">
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

                    <Gradients>
                        <ext:LinearGradient GradientID="bar-gradient" Degrees="90">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="#99BBE8" />
                                <ext:GradientStop Offset="0.7" Color="#77AECE" />
                                <ext:GradientStop Offset="1" Color="#77AECE" />
                            </Stops>
                        </ext:LinearGradient>
                    </Gradients>

                    <Axes>
                        <ext:NumericAxis Position="Left" Minimum="0" Maximum="100" Fields="Data1" Grid="true">
                            <Label FontSize="10" />
                            <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" Grid="true">
                            <Label FontSize="11" />
                            <Renderer Handler="return label.substr(0, 3);" />
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:BarSeries XField="Name" YField="Data1">
                            <StyleSpec>
                                <ext:Sprite FillStyle="url(#bar-gradient)" LineWidth="3" StrokeStyle="#77AECE" />
                            </StyleSpec>
                        </ext:BarSeries>

                        <ext:LineSeries XField="Name" YField="Data1" Fill="false">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tooltip runat="server" TrackMouse="true" Width="110" Height="25">
                                <Renderer Handler="toolTip.setTitle(record.get('Data1') + ' visits in ' + record.get('Name').substr(0, 3));"></Renderer>
                            </Tooltip>

                            <StyleSpec>
                                <ext:Sprite FillStyle="#18428E" StrokeStyle="#18428E" LineWidth="3" />
                            </StyleSpec>

                            <Marker>
                                <ext:Sprite SpriteType="Circle"
                                    Radius="4"
                                    LineWidth="0"
                                    FillStyle="#18428E"
                                    StrokeStyle="#18428E" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>