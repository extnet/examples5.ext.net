<%@ Page Language="C#" %>

<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Chart1.GetStore().DataBind();
    }

    [DirectMethod]
    public void Download(string data)
    {
        data = data.Substring(data.IndexOf("base64,") + 7);
        byte[] bitmapData = Convert.FromBase64String(data);

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=chart.png");
        Response.ContentType = "image/png";

        using (System.Drawing.Image image = System.Drawing.Image.FromStream(new MemoryStream(bitmapData)))
        {
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
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
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Save', 'Save Chart to an image?', function (choice) {
                if (choice === 'yes') {
                    btn.up('panel').down('chart').download({
                        format: 'image/png'
                    });
                }
            });
        };

        var exportChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Export', 'Export Chart to an image?', function (choice) {
                if (choice == 'yes') {
                    var data = btn.up('panel').down('chart').getImage().data;

                    App.direct.Download(data, { isUpload: true });
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Download Chart Sample</h1>

        <ext:Panel
            runat="server"
            Title="Area Chart"
            Width="960"
            Height="600"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Download via chart.download()"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart" />

                        <ext:Button
                            runat="server"
                            Text="Download via DirectMethod"
                            IconCls="x-md md-icon-save-alt"
                            Handler="exportChart" />

                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    Legend="true"
                    InsetPadding="20">
                    <Background>
                        <Gradient>
                            <ext:LinearGradient GradientID="Gradient1" Degrees="90">
                                <Stops>
                                    <ext:GradientStop Color="#feffff" Offset="0" />
                                    <ext:GradientStop Color="#d2ebf9" Offset="60" />
                                </Stops>
                            </ext:LinearGradient>
                        </Gradient>
                    </Background>
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
                                        <ext:ModelField Name="Data6" />
                                        <ext:ModelField Name="Data7" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Fields="Data1,Data2,Data3,Data4,Data5,Data6,Data7"
                            Title="Number of Hits"
                            Minimum="0" />

                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="Name"
                            Title="Month of the Year"
                            Grid="true">
                            <Label RotationDegrees="315" />
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:AreaSeries
                            XField="Name"
                            YField="Data1,Data2,Data3,Data4,Data5,Data6,Data7">
                        </ext:AreaSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
