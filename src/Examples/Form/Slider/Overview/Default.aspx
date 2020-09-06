<%@ Page Language="C#" %>

<script runat="server">
    protected void SubmitColor(object sender, DirectEventArgs e)
    {
        X.Js.Alert("Color: " + System.Drawing.Color.FromArgb(Convert.ToInt32(RedSlider.Number), Convert.ToInt32(GreenSlider.Number), Convert.ToInt32(BlueSlider.Number)).ToString());
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>SliderField - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <ext:XScript runat="server">
        <script>
            var toHex = function (value) {
                var str = value.toString(16);

                if (str.length == 1) {
                    str = "0" + str;
                }

                return str;
            };

            var updateColor = function () {
                // It is enough to check whether the last defined component has
                // been completed before proceeding
                if (#{ColorPreview}) {
                    var color = "#" +
                        toHex(#{RedSlider}.getValue().toString(16)) +
                        toHex(#{GreenSlider}.getValue().toString(16)) +
                        toHex(#{BlueSlider}.getValue().toString(16));

                    color = color.toUpperCase();

                    #{ColorPreview}.setTitle("Color: " + color);
                    #{ColorPreview}.body.setStyle("background-color", color);
                };
            };
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Slider</h1>

        <ext:FormPanel
            ID="FormPanel1"
            runat="server"
            Title="Color Chooser"
            Width="400"
            Height="480"
            ButtonAlign="Left"
            BodyPadding="18"
            DefaultAnchor="100%">
            <Items>
                <ext:Slider
                    ID="RedSlider"
                    runat="server"
                    Single="true"
                    FieldLabel="Red"
                    LabelStyle="color:red"
                    Number="255"
                    MaxValue="255">
                    <Listeners>
                        <Change Fn="updateColor" />
                    </Listeners>
                </ext:Slider>

                <ext:Slider
                    ID="GreenSlider"
                    runat="server"
                    Single="true"
                    FieldLabel="Green"
                    LabelStyle="color:green"
                    Number="255"
                    MaxValue="255">
                    <Listeners>
                        <Change Fn="updateColor" />
                    </Listeners>
                </ext:Slider>

                <ext:Slider
                    ID="BlueSlider"
                    runat="server"
                    Single="true"
                    FieldLabel="Blue"
                    LabelStyle="color:blue"
                    Number="255"
                    MaxValue="255">
                    <Listeners>
                        <Change Fn="updateColor" />
                    </Listeners>
                </ext:Slider>

                <ext:Panel
                    ID="ColorPreview"
                    runat="server"
                    Title="Color: #FFFFFF"
                    Border="false"
                    StyleSpec="margin:10px;"
                    Height="75"
                    />

            </Items>
            <Listeners>
                <AfterLayout Fn="updateColor" Single="true" />
            </Listeners>
            <FooterBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Max All">
                            <Listeners>
                                <Click Handler="#{FormPanel1}.items.each(function (c) {
                                                    if (c instanceof Ext.slider.Single) {
                                                        c.setValue(255);
                                                    }
                                                });" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="Min All">
                            <Listeners>
                                <Click Handler="#{FormPanel1}.items.each(function (c) {
                                                    if (c instanceof Ext.slider.Single) {
                                                        c.setValue(0);
                                                    }
                                                });" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Save">
                            <DirectEvents>
                                <Click OnEvent="SubmitColor" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" Text="Reset">
                            <Listeners>
                                <Click Handler="#{FormPanel1}.getForm().reset();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </FooterBar>
        </ext:FormPanel>
    </form>
</body>
</html>
