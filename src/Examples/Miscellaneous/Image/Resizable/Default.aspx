<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Resizable Image - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var resize = function (image, factor) {
            if (!factor || !image.complete) {
                return;
            }

            var orgSize = image.getOriginalSize();

            factor = parseFloat(factor);
            image.setSize(parseInt(orgSize.width * factor), parseInt(orgSize.height * factor));
        };

        var newFactor = function (combo, dir) {
            var index = combo.store.indexOf(combo.valueCollection.getAt(0)),
                count = combo.store.getCount();

            index += dir;

            if (index >=0 && index < count) {
                combo.setValueAndFireSelect(combo.store.getAt(index).get(combo.valueField));
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    runat="server"
                    Border="false"
                    Region="North"
                    Height="160"
                    BodyPadding="18">
                    <Content>
                        <h1>Resizable Image</h1>
                        <h3>To resize the image, position your mouse anywhere near the right or bottom border</h3>
                        <br />
                        <ext:Toolbar runat="server" Flat="true">
                            <Items>
                                <ext:Button runat="server" IconCls="x-md md-icon-zoom-out">
                                    <Listeners>
                                        <Click Handler="newFactor(#{SizesCombo}, -1);" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ComboBox
                                    ID="SizesCombo"
                                    runat="server"
                                    TriggerIcon="SimpleMagnify"
                                    Editable="false">
                                    <Items>
                                        <ext:ListItem Text="1%" Value="0.01" />
                                        <ext:ListItem Text="5%" Value="0.05" />
                                        <ext:ListItem Text="10%" Value="0.1" />
                                        <ext:ListItem Text="12%" Value="0.12" />
                                        <ext:ListItem Text="16%" Value="0.16" />
                                        <ext:ListItem Text="25%" Value="0.25" />
                                        <ext:ListItem Text="33%" Value="0.33" />
                                        <ext:ListItem Text="50%" Value="0.5" />
                                        <ext:ListItem Text="66%" Value="0.66" />
                                        <ext:ListItem Text="100%" Value="1" />
                                        <ext:ListItem Text="200%" Value="2" />
                                        <ext:ListItem Text="300%" Value="3" />
                                        <ext:ListItem Text="400%" Value="4" />
                                        <ext:ListItem Text="500%" Value="5" />
                                        <ext:ListItem Text="600%" Value="6" />
                                        <ext:ListItem Text="700%" Value="7" />
                                        <ext:ListItem Text="800%" Value="8" />
                                        <ext:ListItem Text="1200%" Value="12" />
                                        <ext:ListItem Text="1600%" Value="16" />
                                        <ext:ListItem Text="2400%" Value="24" />
                                        <ext:ListItem Text="3200%" Value="32" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="0.33" />
                                    </SelectedItems>
                                    <Listeners>
                                        <Select Handler="resize(#{Image1}, records[0].get(this.valueField));" />
                                    </Listeners>
                                </ext:ComboBox>

                                <ext:Button runat="server" IconCls="x-md md-icon-zoom-in">
                                    <Listeners>
                                        <Click Handler="newFactor(#{SizesCombo}, 1);" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </Content>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Border="false"
                    Scrollable="Both"
                    Region="Center"
                    BodyPadding="18">
                    <Items>
                        <ext:Image
                            ID="Image1"
                            runat="server"
                            ImageUrl="../Shared/tokyo-subway-map.jpg">
                            <ResizableConfig runat="server" PreserveRatio="true" HandlesSummary="s e se" />
                            <Listeners>
                                <Complete Handler="newFactor(#{SizesCombo}, 0);" />
                                <ResizerResize Handler="#{SizesCombo}.setValue('');" />
                            </Listeners>
                        </ext:Image>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>