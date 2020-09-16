<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HBoxLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
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

    <ext:Viewport runat="server" Layout="Border">
        <Items>
            <ext:Panel
                ID="btns"
                runat="server"
                Title="HBox Layout"
                Rounded="false"
                Region="North"
                Split="true"
                Height="180"
                Layout="Fit"
                />
            <ext:Panel runat="server" Region="Center" BodyPadding="18">
                <Items>
                    <ext:Container runat="server" Layout="HBox">
                        <Defaults>
                            <ext:Parameter Name="margin" Value="0 10 0 0" Mode="Value" />
                            <ext:Parameter Name="toggleGroup" Value="btns" Mode="Value" />
                            <ext:Parameter Name="allowDepress" Value="false" Mode="Raw" />
                            <ext:Parameter Name="width" Value="150" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="Spaced" OnClientClick="replace(#{pnlSpaced});" />
                            <ext:Button runat="server" Text="Align: Top" OnClientClick="replace(#{pnlAlignTop});" />
                            <ext:Button runat="server" Text="Align: Middle" OnClientClick="replace(#{pnlAlignMiddle});" />
                            <ext:Button runat="server" Text="Align: Stretch" OnClientClick="replace(#{pnlAlignStretch});" />
                            <ext:Button runat="server" Text="Align: StretchMax" OnClientClick="replace(#{pnlAlignStretchMax});" />
                        </Items>
                    </ext:Container>
                    <ext:Container runat="server" Layout="HBox" MarginSpec="10 0 0 0">
                        <Defaults>
                            <ext:Parameter Name="margin" Value="0 10 0 0" Mode="Value" />
                            <ext:Parameter Name="pressed" Value="false" Mode="Raw" />
                            <ext:Parameter Name="toggleGroup" Value="btns" Mode="Value" />
                            <ext:Parameter Name="allowDepress" Value="false" Mode="Raw" />
                            <ext:Parameter Name="width" Value="150" Mode="Raw" />
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
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18" >
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
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18">
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
                <ext:Button
                    runat="server"
                    Text="Button 4"
                    Flex="1"
                    MarginSpec="0"
                    />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlFlexRatio"
            runat="server"
            Layout="HBox"
            BodyPadding="18">
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
                <ext:Button
                    runat="server"
                    Text="Button 4"
                    Flex="3"
                    MarginSpec="0"
                    />
            </Items>
        </ext:Panel>

        <ext:Panel
            ID="pnlPackStart"
            runat="server"
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18">
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
            Layout="HBox"
            BodyPadding="18">
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