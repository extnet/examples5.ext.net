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
    <title>Mixed Charts - Ext.NET Examples</title>
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

        <h1>Mixed Charts Example</h1>

        <p>Display 3 sets of random data using a line, bar, and scatter series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:Panel 
            runat="server"
            Title="Mixed Charts"
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
                    StyleSpec="background:#fff;"                   
                    StandardTheme="Category1"
                    Animate="true">
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(8) %>" 
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
                        <ext:NumericAxis Position="Left" Fields="Data1,Data2,Data3" Title="Number of Hits" Grid="true" />
                        <ext:CategoryAxis Position="Bottom" Fields="Name" Title="Month of the Year" />
                    </Axes>
                    <Series>
                        <ext:BarSeries XField="Name" YField="Data1" />
                        <ext:ScatterSeries XField="Name" YField="Data2">
                            <Marker>
                                <ext:CircleSprite Radius="5" />
                            </Marker>
                        </ext:ScatterSeries>
                        <ext:LineSeries Smooth="3" Fill="true" XField="Name" YField="Data3">
                            <Marker>
                                <ext:Sprite SpriteType="Cross" />
                            </Marker>
                            <StyleSpec>                                
                                <ext:Sprite FillOpacity="0.5" />
                            </StyleSpec>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>