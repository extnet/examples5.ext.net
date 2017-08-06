<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var keys = new List<KeyBindItem>()
            {
                new KeyBindItem() { Key = "o", Handler = "Ext.Msg.alert('hotkey', 'server-side added key binding for \\'o\\'.');"},
                new KeyBindItem() { Key = "shift+o", Handler = "Ext.Msg.alert('hotkey', 'server-side added key binding for \\'shift+o\\'.');"}
            };
            vp1.SetKeyMap(keys);
        }
    }
</script>
<html>
<head runat="server">
    <title>KeyMap Toggling BorderLayout Regions - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport ID="vp1" runat="server" Layout="BorderLayout">
        <KeyMap>
            <ext:KeyBindItem Key="n" Handler="#{North}.toggleCollapse();" />
            <ext:KeyBindItem Key="s" Handler="#{South}.toggleCollapse();" />
            <ext:KeyBindItem Key="e" Handler="#{East}.toggleCollapse();" />
            <ext:KeyBindItem Key="w" Handler="#{West}.toggleCollapse();" />
            <ext:KeyBindItem Key="a" Handler="Ext.each([#{North}, #{South}, #{East}, #{West}], function(cmp) { cmp.toggleCollapse(); });" />

            <%-- Modifier keys can be separated by either + or - characters --%>
            <ext:KeyBindItem Key="shift+e" Handler="Ext.each([#{North}, #{South}, #{East}, #{West}], function(cmp) { cmp.expand(); });" />
            <ext:KeyBindItem Key="ctrl-c" Handler="Ext.each([#{North}, #{South}, #{East}, #{West}], function(cmp) { cmp.collapse(); });" />
        </KeyMap>
        <Items>
            <ext:Panel
                ID="North"
                runat="server"
                Title="North"
                Region="North"
                Frame="true"
                Height="200"
                Collapsible="true"
                >
                <Content>
                    <h2>Here, the key bindings are set to the viewport component directly, instead of a standalone keymap with an arbitrary target.</h2>
                    <p>The key binding specification is different and this example illustrates some uses of it.</p>
                    <p>There's also 'o' and 'shift+o' keys bound from a server-side call during page load.</p>
                </Content>
            </ext:Panel>
            <ext:Panel
                ID="West"
                runat="server"
                Title="West"
                Region="West"
                Frame="true"
                Width="200"
                Collapsible="true"
                />
            <ext:Panel runat="server" Region="Center" BodyPadding="5" Scrollable="Vertical">
                <Content>
                    <ul>
                        <li>If keys are not working then click on center area</li>
                        <li>NORTH toggle: n</li>
                        <li>WEST toggle: w</li>
                        <li>EAST toggle: e</li>
                        <li>SOUTH toggle: s</li>
                        <li>Toggle all: a</li>
                        <li>Expand all: shift+e</li>
                        <li>Collapse all: ctrl+c</li>
                    </ul>
                </Content>
            </ext:Panel>
            <ext:Panel
                ID="East"
                runat="server"
                Title="East"
                Region="East"
                Frame="true"
                Width="200"
                Collapsible="true"
                />
            <ext:Panel
                ID="South"
                runat="server"
                Title="South"
                Region="South"
                Frame="true"
                Height="200"
                Collapsible="true"
                />
        </Items>
    </ext:Viewport>
</body>
</html>