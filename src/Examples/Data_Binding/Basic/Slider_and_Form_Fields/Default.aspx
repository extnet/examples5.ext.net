<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Slider and Form Fields - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        public class MyModel
        {
            public static object Model = new
            {
                //data : Object
                //This object holds the arbitrary data that populates the ViewModel and is then available for binding.
                data = new
                {
                    red = 255,
                    green = 100,
                    blue = 150
                }
            };
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Slider and Form Fields</h1>

        <p>Shows how a Slider widget can be used with a ViewModel.</p>

        <ext:Panel
            runat="server"
            Width="480"
            BodyPadding="18"
            Title="Color Components"
            Layout="Anchor"
            DefaultAnchor="0"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <Items>
                <ext:FieldContainer runat="server" FieldLabel="Red" LabelWidth="60">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Middle" />
                    </LayoutConfig>
                    <Items>
                        <ext:NumberField
                            runat="server"
                            Width="100"
                            BindString="{red}"
                            MarginSpec="0 10 0 0"
                            MinValue="0"
                            MaxValue="255"
                            />
                        <ext:Slider
                            runat="server"
                            Single="true"
                            Flex="1"
                            BindString="{red}"
                            PublishOnComplete="false"
                            MinValue="0"
                            MaxValue="255"
                            />
                    </Items>
                </ext:FieldContainer>

                <ext:FieldContainer runat="server" FieldLabel="Green" LabelWidth="60">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Middle" />
                    </LayoutConfig>
                    <Items>
                        <ext:NumberField
                            runat="server"
                            Width="100"
                            BindString="{green}"
                            MarginSpec="0 10 0 0"
                            MinValue="0"
                            MaxValue="255"
                            />
                        <ext:Slider
                            runat="server"
                            Single="true"
                            Flex="1"
                            BindString="{green}"
                            PublishOnComplete="false"
                            MinValue="0"
                            MaxValue="255"
                            />
                    </Items>
                </ext:FieldContainer>

                <ext:FieldContainer runat="server" FieldLabel="Blue" LabelWidth="60">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Middle" />
                    </LayoutConfig>
                    <Items>
                        <ext:NumberField
                            runat="server"
                            Width="100"
                            BindString="{blue}"
                            MarginSpec="0 10 0 0"
                            MinValue="0"
                            MaxValue="255"
                            />
                        <ext:Slider
    runat="server"
    Single="true"
    Flex="1"
    BindString="{blue}"
    PublishOnComplete="false"
    MinValue="0"
    MaxValue="255"
 />
                    </Items>
                </ext:FieldContainer>

                <ext:Component runat="server" Height="100">
                    <Bind>
                        <ext:Parameter Name="style" Value="{backgroundColor: '#{red:hex(2)}{green:hex(2)}{blue:hex(2)}'}" Mode="Raw" />
                    </Bind>
                </ext:Component>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>