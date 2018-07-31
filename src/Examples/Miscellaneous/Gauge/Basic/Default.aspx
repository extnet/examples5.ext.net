<%@ Page Language="C#" %>


<script runat="server">
    public void Page_Load(object sender, EventArgs e)
    {
        Panel1.ViewModel = new { data = new { value = 30 } };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic Gauge - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style type="text/css">
        .x-gauge-green .x-gauge-value {
            fill: green
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Basic Gauge component overview.</h1>
        
        <p>Pull the slider around to update the gauges' display value.</p>

        <ext:Panel ID="Panel1" runat="server" Title="Basic Gauge" Width="800" Height="500">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Slider
                            ID="Slider1"
                            runat="server"
                            Single="true"
                            FieldLabel="Value"
                            BindString="{value}"
                            WidthSpec="100%" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Gauge
                    ID="Gauge1"
                    runat="server"
                    Flex="1"
                    BindString="{value}"
                    />
                <ext:Gauge
                    ID="Gauge2"
                    runat="server"
                    Flex="1"
                    TrackStart="180"
                    TrackLength="360"
                    BindString="{value}"
                    UIName="green"
                    />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
