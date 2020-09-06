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
    <title>Pie Renderer Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var segmentRenderer = function (sprite, config, rendererData, index) {
            var value = (rendererData.store.getAt(index).get('Data1') >> 0) % 9,
                color = ["#94ae0a", "#115fa6", "#a61120", "#ff8809", "#ffd13e", "#a61187", "#24ad9a", "#7c7474", "#a66111"][value];

            return {
                fillStyle: color
            };
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Pie Renderer Example</h1>

        <p>Display 5 sets of random data using a pie chart. Reload data will randomly generate a new set of data in the store. A renderer has been set up on to dynamically change the length and color of each slice based on the data.  In addition contrast detection has been turned on to dynamically change the font color based on the color of the item it is on.</p>

        <ext:Panel
            runat="server"
            Title="Pie Renderer Chart"
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
                            Icon="ArrowRefresh"
                            OnDirectClick="ReloadData" />

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
                    StyleSpec="background:#fff;"
                    Shadow="true"
                    InnerPadding="20">
                    <Store>
                        <ext:Store
                            runat="server"
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(5) %>"
                            AutoDataBind="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
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
                            RadiusField="Data2"
                            HighlightMargin="20">
                            <StyleSpec>
                                <ext:Sprite LineWidth="1" StrokeStyle="#fff" />
                            </StyleSpec>
                            <Label Field="Name" Display="Rotate" Font="14px Arial" />
                            <Renderer Fn="segmentRenderer" />
                        </ext:PieSeries>
                    </Series>
                </ext:PolarChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
