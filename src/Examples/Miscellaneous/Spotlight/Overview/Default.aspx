<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spotlight - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var updateSpot = function (cmp) {
            App.Spot.show(cmp);
            updateButtons(cmp);
        };

        var hideSpot = function () {
            if (App.Spot.active) {
                App.Spot.hide();
            }

            updateButtons();
        };

        var getButton = function (panel) {
            return panel.dockedItems.last().items.first();
        };

        var updateButtons = function (cmp) {
            cmp = cmp || {};
            getButton(App.Panel1).setDisabled(cmp.id != App.Panel1.id);
            getButton(App.Panel2).setDisabled(cmp.id != App.Panel2.id);
            getButton(App.Panel3).setDisabled(cmp.id != App.Panel3.id);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <Listeners>
                <DocumentReady Handler="updateButtons();" />
            </Listeners>
        </ext:ResourceManager>

        <h1>Spotlight</h1>

        <p>This control allows you to restrict input to a particular element by masking all other page content.</p>

        <ext:Spotlight
            ID="Spot"
            runat="server"
            Easing="EaseOut"
            Duration="300"
            />

        <ext:Button runat="server" Text="Start">
            <Listeners>
                <Click Handler="updateSpot(App.Panel1);" />
            </Listeners>
        </ext:Button>

        <ext:Panel runat="server" Border="false" Layout="Table" ShrinkWrap="Width">
            <LayoutConfig>
                <ext:TableLayoutConfig Columns="3" />
            </LayoutConfig>
            <Items>
                <ext:Panel
                    ID="Panel1"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button1" runat="server" Text="Next Panel">
                            <Listeners>
                                <Click Handler="updateSpot(App.Panel2);" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
                <ext:Panel
                    ID="Panel2"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="Next Panel">
                            <Listeners>
                                <Click Handler="updateSpot(App.Panel3);" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
                <ext:Panel
                    ID="Panel3"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button3" runat="server" Text="Done">
                            <Listeners>
                                <Click Handler="hideSpot();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
