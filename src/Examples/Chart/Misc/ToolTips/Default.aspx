<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Tips Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .x-tip {
            background-color: #fff;
            border-radius: 0.5em;
            -moz-border-radius: 0.5em;
            -webkit-border-radius: 0.5em;
            border-radius: 0.5em;
            border: 1px solid rgba(134, 84, 41, 0.5);
            opacity: 0.95;
        }

        .x-tip-header {
            margin-bottom: 5px;
        }

        .x-tip .x-panel .x-panel-body.x-layout-fit {
            border: none;
        }

        .x-tip .x-panel.x-grid-section.x-panel-noborder.x-fit-item {
            margin: 0;
        }

        .x-tip .x-panel.x-box-item {
            top: 0 !important;
        }

        .x-tip-header-body .x-component.x-box-item {
            width: 100%;
            text-align: center;
        }

        .x-tip-body {
            text-shadow: none;
        }

        .x-panel {
            margin: 20px;
        }

        ul {
            margin-left: 10px;
        }

            ul li {
                display: block;
                font-weight: normal;
                color: #444;
                padding: 2px;
            }
    </style>

    <script>
        var tipsRenderer = function (toolTip, record, context) {
            var data = [{
                    name: 'Data1',
                    data: record.get('Data1')
                }, {
                    name: 'Data2',
                    data: record.get('Data2')
                }, {
                    name: 'Data3',
                    data: record.get('Data3')
                }, {
                    name: 'Data4',
                    data: record.get('Data4')
                }, {
                    name: 'Data5',
                    data: record.get('Data5')
                }], i, l, html;

            toolTip.setTitle("Information for " + record.get('Name'));

            App.PieStore1.loadData(data);
            App.Grid1.store.loadData(data);
            App.Grid1.setSize(480, 130);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Chart in tips example</h1>

        <p>Showing a Pie Chart and a Grid Panel as elements in a tooltip.</p>

        <ext:Panel
            runat="server"
            Title="Line Chart"
            Width="960"
            Height="480"
            Layout="Fit">
            <Items>
                <ext:CartesianChart
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
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                        <ext:ModelField Name="Data5" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Axes>
                        <ext:NumericAxis Position="Left" Fields="Data1" Grid="true" />
                        <ext:CategoryAxis Position="Bottom" Fields="Name" />
                    </Axes>

                    <Series>
                        <ext:LineSeries XField="Name" YField="Data1">
                            <Marker>
                                <ext:CircleSprite Radius="5" />
                            </Marker>
                            <Tooltip
                                runat="server"
                                TrackMouse="true"
                                Width="580"
                                Height="170"
                                Layout="Fit">
                                <Items>
                                    <ext:Container runat="server" Layout="HBox">
                                        <Items>
                                            <ext:PolarChart
                                                runat="server"
                                                Width="100"
                                                Height="100"
                                                Shadow="false"
                                                InsetPadding="0"
                                                Animation="false">
                                                <Store>
                                                    <ext:Store ID="PieStore1" runat="server">
                                                        <Model>
                                                            <ext:Model runat="server">
                                                                <Fields>
                                                                    <ext:ModelField Name="name" />
                                                                    <ext:ModelField Name="data" />
                                                                </Fields>
                                                            </ext:Model>
                                                        </Model>
                                                    </ext:Store>
                                                </Store>

                                                <Series>
                                                    <ext:PieSeries AngleField="data" ShowInLegend="false">
                                                        <Label
                                                            Field="name"
                                                            Font="9px Arial"
                                                            CalloutLine="false"
                                                            />
                                                    </ext:PieSeries>
                                                </Series>
                                            </ext:PolarChart>

                                            <ext:GridPanel ID="Grid1" runat="server" Width="480" Height="130">
                                                <Store>
                                                    <ext:Store runat="server">
                                                        <Model>
                                                            <ext:Model runat="server">
                                                                <Fields>
                                                                    <ext:ModelField Name="name" />
                                                                    <ext:ModelField Name="data" />
                                                                </Fields>
                                                            </ext:Model>
                                                        </Model>
                                                    </ext:Store>
                                                </Store>

                                                <ColumnModel>
                                                    <Columns>
                                                        <ext:Column runat="server" Text="Name" DataIndex="name" />
                                                        <ext:Column runat="server" Text="Data" DataIndex="data" />
                                                    </Columns>
                                                </ColumnModel>
                                            </ext:GridPanel>
                                        </Items>
                                    </ext:Container>
                                </Items>
                                <Renderer Fn="tipsRenderer" />
                            </Tooltip>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
