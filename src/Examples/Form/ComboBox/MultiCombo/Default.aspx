<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MultiCombo - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var updateButtonText = function (item, checked) {
            var text = [];

            item.parentMenu.items.each(function (item) {
                if (item.checked) {
                   text.push(item.text);
                }
            });

            if (text.length == 0) {
                App.Button1.setText("[Select Colors]");
            } else {
                App.Button1.setText("[" + text.join(",") + "]");
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h2>Simple MultiCombo</h2>

        <ext:MultiCombo runat="server" Width="260">
            <Items>
                <ext:ListItem Text="Item 1" Value="1" />
                <ext:ListItem Text="Item 2" Value="2" />
                <ext:ListItem Text="Item 3" Value="3" />
                <ext:ListItem Text="Item 4" Value="4" />
                <ext:ListItem Text="Item 5" Value="5" />
            </Items>

            <SelectedItems>
                <ext:ListItem Value="2" />
                <ext:ListItem Index="4" />
            </SelectedItems>
        </ext:MultiCombo>
        <br />

        <h2>MultiCombo with WrapBySquareBrackets</h2>

        <ext:MultiCombo
            runat="server"
            WrapBySquareBrackets="true"
            Width="260">
            <Items>
                <ext:ListItem Text="Item 1" Value="1" />
                <ext:ListItem Text="Item 2" Value="2" />
                <ext:ListItem Text="Item 3" Value="3" />
                <ext:ListItem Text="Item 4" Value="4" />
                <ext:ListItem Text="Item 5" Value="5" />
            </Items>

            <SelectedItems>
                <ext:ListItem Value="2" />
                <ext:ListItem Index="4" />
            </SelectedItems>
        </ext:MultiCombo>
        <br />

        <h2>MultiCombo with SelectionMode="Selection"</h2>

        <p>Selected items are highlighted.</p>

        <ext:MultiCombo runat="server" SelectionMode="Selection" Width="260">
            <Items>
                <ext:ListItem Text="Item 1" Value="1" />
                <ext:ListItem Text="Item 2" Value="2" />
                <ext:ListItem Text="Item 3" Value="3" />
                <ext:ListItem Text="Item 4" Value="4" />
                <ext:ListItem Text="Item 5" Value="5" />
            </Items>

            <SelectedItems>
                <ext:ListItem Value="2" />
                <ext:ListItem Index="4" />
            </SelectedItems>
        </ext:MultiCombo>
        <br />

        <h2>MultiCombo with SelectionMode="All" (checkboxes and highlight)</h2>

        <p>Selected items are highlighted and checked.</p>

        <ext:MultiCombo runat="server" SelectionMode="All" Width="260">
            <Items>
                <ext:ListItem Text="Item 1" Value="1" />
                <ext:ListItem Text="Item 2" Value="2" />
                <ext:ListItem Text="Item 3" Value="3" />
                <ext:ListItem Text="Item 4" Value="4" />
                <ext:ListItem Text="Item 5" Value="5" />
            </Items>

            <SelectedItems>
                <ext:ListItem Value="2" />
                <ext:ListItem Index="4" />
            </SelectedItems>
        </ext:MultiCombo>
        <br />

        <h2>Button with Menu to emulate MultiCombo</h2>

        <ext:Button
            ID="Button1"
            runat="server"
            Icon="Rgb"
            Text="[Select Colors]"
            Width="200">
            <Menu>
                <ext:Menu runat="server" Width="200">
                    <Defaults>
                        <ext:Parameter Name="HideOnClick" Value="false" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:CheckMenuItem runat="server" Text="Red" CheckHandler="updateButtonText" Width="194" />
                        <ext:CheckMenuItem runat="server" Text="Green" CheckHandler="updateButtonText" />
                        <ext:CheckMenuItem runat="server" Text="Blue" CheckHandler="updateButtonText" />
                    </Items>
                </ext:Menu>
            </Menu>
        </ext:Button>
    </form>
</body>
</html>