<%@ Page Language="C#" %>

<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
        this.Chart2.GetStore().DataBind();
    }

    [DirectMethod]
    public void Download(string data1, string data2)
    {
        data1 = data1.Substring(data1.IndexOf("base64,") + 7);
        byte[] bitmapData1 = Convert.FromBase64String(data1);

        data2 = data2.Substring(data2.IndexOf("base64,") + 7);
        byte[] bitmapData2 = Convert.FromBase64String(data2);

        System.Drawing.Image image1 = System.Drawing.Image.FromStream(new MemoryStream(bitmapData1));
        System.Drawing.Image image2 = System.Drawing.Image.FromStream(new MemoryStream(bitmapData2));

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=chart.png");
        Response.ContentType = "image/png";

        using (Bitmap result = new Bitmap(Math.Max(image1.Width, image2.Width), image1.Height + image2.Height))
        {
            using (var canvas = Graphics.FromImage(result))
            {
                canvas.Clear(System.Drawing.Color.White);
                canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                canvas.DrawImage(image1, 0, 0);
                canvas.DrawImage(image2, 0, image1.Height);
                canvas.Save();
            }

            using (MemoryStream ms = new MemoryStream())
            {
                result.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                ms.WriteTo(Response.OutputStream);
            }
        }

        Response.End();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Export Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var download = function (btn) {
            Ext.MessageBox.confirm('Download', 'Really?', function (choice) {
                if (choice === 'yes') {
                    var data1 = App.Chart1.getImage().data;
                    var data2 = App.Chart2.getImage().data;
                    App.direct.Download(data1, data2, { isUpload: true });
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Merge Two Charts Sample</h1>

        <ext:Panel
            runat="server"
            Layout="VBox"
            Width="960">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Reload"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="Download"
                            IconCls="x-md md-icon-save"
                            Handler="download"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Panel
                    runat="server"
                    Width="960"
                    Height="480"
                    Title="Trends, 2014"
                    Layout="Fit">
                    <Items>
                        <ext:CartesianChart ID="Chart1" runat="server" InsetPadding="30">
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
                                <ext:NumericAxis Position="Left" Minimum="0" Maximum="100" Fields="Data1" Grid="false">
                                    <Label Font="10px Arial" />
                                    <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                                </ext:NumericAxis>

                                <ext:CategoryAxis Position="Bottom" Fields="Name" Grid="false">
                                    <Label Font="11px Arial" />
                                    <Renderer Handler="return label.substr(0, 3);" />
                                </ext:CategoryAxis>
                            </Axes>

                            <Series>
                                <ext:LineSeries XField="Name" YField="Data1">
                                    <Listeners>
                                        <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                                    </Listeners>

                                    <Tooltip runat="server" TrackMouse="true" Width="110" Height="25">
                                        <Renderer Handler="toolTip.setTitle(record.get('Data1') + ' visits in ' + record.get('Name').substr(0, 3));" />
                                    </Tooltip>

                                    <StyleSpec>
                                        <ext:Sprite StrokeStyle="#18428E" LineWidth="3" />
                                    </StyleSpec>

                                    <Marker>
                                        <ext:CircleSprite
                                            Radius="4"
                                            LineWidth="0"
                                            FillStyle="#18428E"
                                            StrokeStyle="#18428E"
                                            />
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
                    Title="Trends, 2015"
                    Layout="Fit">
                    <Items>
                        <ext:CartesianChart ID="Chart2" runat="server" InsetPadding="30">
                            <Store>
                                <ext:Store
                                    runat="server"
                                    Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>"
                                    AutoDataBind="true">
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="Name" />
                                                <ext:ModelField Name="Data2" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>

                            <Axes>
                                <ext:NumericAxis Position="Left" Minimum="0" Maximum="100" Fields="Data2" Grid="false">
                                    <Label Font="10px Arial" />
                                    <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                                </ext:NumericAxis>

                                <ext:CategoryAxis Position="Bottom" Fields="Name" Grid="false">
                                    <Label Font="11px Arial" />
                                    <Renderer Handler="return label.substr(0, 3);" />
                                </ext:CategoryAxis>
                            </Axes>

                            <Series>
                                <ext:LineSeries XField="Name" YField="Data2">
                                    <Tooltip runat="server" TrackMouse="true" Width="110" Height="25">
                                        <Renderer Handler="toolTip.setTitle(record.get('Data2') + ' visits in ' + record.get('Name').substr(0, 3));" />
                                    </Tooltip>

                                    <StyleSpec>
                                        <ext:Sprite StrokeStyle="#18428E" LineWidth="3" />
                                    </StyleSpec>

                                    <Marker>
                                        <ext:CircleSprite
                                            Radius="4"
                                            LineWidth="0"
                                            FillStyle="#18428E"
                                            StrokeStyle="#18428E"
                                            />
                                    </Marker>
                                </ext:LineSeries>
                            </Series>
                        </ext:CartesianChart>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
