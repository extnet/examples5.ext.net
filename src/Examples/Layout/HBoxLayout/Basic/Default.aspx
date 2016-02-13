<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HBoxLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        html, body {
            font    : normal 12px verdana;
            margin  : 0;
            padding : 0;
            border  : 0 none;
            background-color : #dfe8f6 !important;
        }
    </style>

    <script>
        var replace = function (panel) {
            var btns = Ext.getCmp("btns"),
                comp;

            comp = btns.remove(0, false);

            if (comp) {
                Ext.get("hiddenArea").appendChild(comp.getEl());
            }

            btns.add(panel);
            btns.updateLayout();
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Container
                ID="btns"
                runat="server"
                Region="North"
                Split="true"
                MinHeight="40"
                MaxHeight="85"
                MarginSpec="5 5 0 5"
                Height="50"
                Layout="Fit">
                <Items>
                    <ext:Container runat="server">
                        <Content>
                            <p style="padding:10px;color:#556677;">Select a configuration below:</p>
                        </Content>
                    </ext:Container>
                </Items>
            </ext:Container>
            <ext:Panel
                runat="server"
                Layout="Anchor"
                Region="Center"
                MarginSpec="0 5 5 5"
                BodyPadding="10">
                <Items>
                    <ext:Container
                        runat="server"
                        AnchorHorizontal="100%"
                        Layout="HBoxLayout"
                        Margin="10">
                        <Defaults>
                            <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                            <ext:Parameter Name="toggleGroup" Value="btns" Mode="Value" />
                            <ext:Parameter Name="allowDepress" Value="false" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="Spaced" OnClientClick="replace(#{pnlSpaced});" />
                            <ext:Button runat="server" Text="Align: Top" OnClientClick="replace(#{pnlAlignTop});" />
                            <ext:Button runat="server" Text="Align: Middle" OnClientClick="replace(#{pnlAlignMiddle});" />
                            <ext:Button runat="server" Text="Align: Stretch" OnClientClick="replace(#{pnlAlignStretch});" />
                            <ext:Button runat="server" Text="Align: StretchMax" OnClientClick="replace(#{pnlAlignStretchMax});" />
                        </Items>
                    </ext:Container>
                    <ext:Container
                        runat="server"
                        Layout="HBoxLayout"
                        AnchorHorizontal="100%"
                        PaddingSpec="0 10 10">
                        <Defaults>
                            <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                            <ext:Parameter Name="pressed" Value="false" Mode="Raw" />
                            <ext:Parameter Name="toggleGroup" Value="btns" Mode="Value" />
                            <ext:Parameter Name="allowDepress" Value="false" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="Flex: All Even" OnClientClick="replace(#{pnlFlexEven});" />
                            <ext:Button runat="server" Text="Flex: Ratio" OnClientClick="replace(#{pnlFlexRatio});" />
                            <ext:Button runat="server" Text="Pack: Start" OnClientClick="replace(#{pnlPackStart});" />
                            <ext:Button runat="server" Text="Pack: Center" OnClientClick="replace(#{pnlPackCenter});" />
                            <ext:Button runat="server" Text="Pack: End" OnClientClick="replace(#{pnlPackEnd});" />
                        </Items>
                    </ext:Container>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>

    <div id="hiddenArea" class="x-hidden">
        <ext:Panel
            ID="pnlSpaced"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig  Align="Top" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Component runat="server" Flex="1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" MarginSpec="0" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlAlignTop"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig  Align="Top" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlAlignMiddle"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlAlignStretch"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5" >
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlAlignStretchMax"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="StretchMax" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1 - height 30px" Height="30" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlFlexEven"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" Flex="1" />
                <ext:Button runat="server" Text="Button 2" Flex="1" />
                <ext:Button runat="server" Text="Button 3" Flex="1" />
                <ext:Button runat="server" Text="Button 4" Flex="1" MarginSpec="0" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlFlexRatio"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" Flex="1" />
                <ext:Button runat="server" Text="Button 2" Flex="1" />
                <ext:Button runat="server" Text="Button 3" Flex="1" />
                <ext:Button runat="server" Text="Button 4" Flex="3" MarginSpec="0" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlPackStart"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" Pack="Start" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlPackCenter"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlPackEnd"
            runat="server"
            Layout="HBoxLayout"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
            </Defaults>
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" Pack="End" />
            </LayoutConfig>
            <Items>
                <ext:Button runat="server" Text="Button 1" />
                <ext:Button runat="server" Text="Button 2" />
                <ext:Button runat="server" Text="Button 3" />
                <ext:Button runat="server" Text="Button 4" />
            </Items>
        </ext:Panel>
    </div>
</body>
</html>