<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ThemeCombo.Items.AddRange(Enum.GetNames(typeof(StandardChartTheme)).Select<string, Ext.Net.ListItem>((theme, index) =>
                new Ext.Net.ListItem(theme)));
        }
    }

    protected void ChangeTheme(object sender, DirectEventArgs e)
    {
        Chart1.StandardTheme = (StandardChartTheme)Enum.Parse(typeof(StandardChartTheme), ThemeCombo.SelectedItem.Value);
        Chart1.ReRender();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Standard Chart Themes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Standard Chart Themes</h1>
        <br />
        <br />

        <ext:ComboBox ID="ThemeCombo" runat="server" FieldLabel="Theme" Editable="false">
            <SelectedItems>
                <ext:ListItem Index="0" />
            </SelectedItems>
            <DirectEvents>
                <Select OnEvent="ChangeTheme">
                    <EventMask ShowMask="true" />
                </Select>
            </DirectEvents>
        </ext:ComboBox>

        <br />
        <br />

        <ext:CartesianChart
            ID="Chart1"
            runat="server"
            Width="960"
            Height="600"
            Shadow="true"
            FlipXY="true">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>"
                    AutoDataBind="true"
                    AutoDestroy="false">
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
                    Title="Number of Hits"
                    Minimum="0">
                    <Renderer Handler="return Ext.util.Format.number(label, '0,0');" />
                </ext:NumericAxis>

                <ext:CategoryAxis
                    Fields="Name"
                    Position="Left"
                    Title="Month of the Year" />
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
                        Color="#333"
                        TextAlign="Center" />
                </ext:BarSeries>
            </Series>
        </ext:CartesianChart>
    </form>
</body>
</html>
