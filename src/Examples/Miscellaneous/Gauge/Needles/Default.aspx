<%@ Page Language="C#" %>


<script runat="server">
    public object NoDisplay = new { display = "none" };

    public object SpikyNeedle = new { type = "spike" };

    public void Page_Load(object sender, EventArgs e)
    {
        Panel1.ViewModel = new { data = new { value = 30 } };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Gauges with various kinds of needles - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Gauges' needles</h1>

        <p>This example shows some of the different gauge needles that are natively available for the component and some basic customization for them.</p>
        <p>The second gauge (left to right) in the first row uses a custom animation setup.</p>
        <p>Move the slider around to update the gauges' display value.</p>

        <ext:Panel ID="Panel1" runat="server" Title="Gauges with various kinds of needles" Width="960" Height="500">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="layout">
                    <ext:Parameter Name="type" Value="hbox" />
                    <ext:Parameter Name="align" Value="stretch" />
                </ext:Parameter>
            </Defaults>
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
                <ext:Panel runat="server" Flex="1">
                    <Items>
                        <ext:Gauge
                            ID="Gauge1"
                            runat="server"
                            Flex="1"
                            BindString="{value}"
                            ValueStyle="<%# NoDisplay %>"
                            AutoDataBind="true">
                            <NeedleConfig OuterRadiusSpec="100%" />
                        </ext:Gauge>
                        <ext:Gauge
                            ID="Gauge2"
                            runat="server"
                            Flex="1"
                            BindString="{value}"
                            Needle="Wedge">
                            <Animation Easing="InOut" Duration="2000" />
                        </ext:Gauge>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Flex="1">
                    <Items>
                        <ext:Gauge
                            ID="Gauge3"
                            runat="server"
                            Flex="1"
                            BindString="{value}"
                            NeedleObject="<%# SpikyNeedle %>"
                            AutoDataBind="true"
                            />
                        <ext:Gauge ID="Gauge4" runat="server" Flex="1" BindString="{value}">
                            <TextOffset Y="45" />
                            <NeedleConfig Type="Arrow" InnerRadius="0" />
                        </ext:Gauge>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
