<%@ Page Language="C#" %>

<script runat="server">
    protected void Show_Badge(object sender, DirectEventArgs e)
    {
        X.Msg.Badge("Panel1", "From Server").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Badge - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .x-badge-over {
            cursor: pointer;
        }

        .x-badge-over .x-badge-inner {
            color: yellow;
            text-decoration: underline;
        }

        .x-badge-noshadow {
            box-shadow: none;
            -moz-box-shadow: none;
            -webkit-box-shadow: none;
        }
    </style>
</head>
<body style="padding:30px;">
    <ext:ResourceManager runat="server" />

    <h1>Badge</h1>

    <h3>Scale</h3>

    <ext:Container runat="server" Layout="HBox">
        <Defaults>
            <ext:Parameter Name="margin" Value="0 100 0 0" Mode="Value" />
        </Defaults>
        <Items>
            <ext:Panel runat="server" Width="150" Height="60" Title="Panel 1">
                <Plugins>
                    <ext:Badge runat="server" Scale="Small" Text="Small" />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="150" Height="60" Title="Panel 2">
                <Plugins>
                    <ext:Badge runat="server" Scale="Medium" Text="Medium" />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="150" Height="60" Title="Panel 3">
                <Plugins>
                    <ext:Badge runat="server" Scale="Large" Text="Large" />
                </Plugins>
            </ext:Panel>
        </Items>
    </ext:Container>

    <br />

    <h3>UI</h3>

    <ext:Container runat="server" Layout="HBox">
        <Defaults>
            <ext:Parameter Name="margin" Value="0 20 0 0" Mode="Value" />
        </Defaults>
        <Items>
            <ext:Button runat="server" Text="Default">
                <Plugins>
                    <ext:Badge runat="server" Text="1" />
                </Plugins>
            </ext:Button>

            <ext:Button runat="server" Text="Primary">
                <Plugins>
                    <ext:Badge runat="server" Text="2" UI="Primary" />
                </Plugins>
            </ext:Button>

            <ext:Button runat="server" Text="Success">
                <Plugins>
                    <ext:Badge runat="server" Text="3" UI="Success" />
                </Plugins>
            </ext:Button>

            <ext:Button
                runat="server"
                Text="Info"
                Width="70"
                Scale="Medium"
                TextAlign="Left">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="4"
                        UI="Info"
                        AlignmentSpec="r-r"
                        OffsetX="-10"
                        Cls="x-badge-noshadow"
                        />
                </Plugins>
            </ext:Button>

            <ext:Button
                runat="server"
                Text="Danger"
                Width="95"
                Scale="Medium"
                TextAlign="Left">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="5"
                        UI="Danger"
                        AlignmentSpec="r-r"
                        OffsetX="-10"
                        Cls="x-badge-noshadow"
                        />
                </Plugins>
            </ext:Button>

            <ext:Button
                runat="server"
                Text="Warning"
                Width="100"
                Scale="Medium"
                TextAlign="Left">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="6"
                        UI="Warning"
                        AlignmentSpec="r-r"
                        OffsetX="-10"
                        Cls="x-badge-noshadow"
                        />
                </Plugins>
            </ext:Button>
        </Items>
    </ext:Container>

    <br />

    <h3>Action</h3>

    <ext:Panel runat="server" Width="150" Height="60" Title="Click on the badge">
        <Plugins>
            <ext:Badge runat="server" Scale="Medium" Text="99" OverCls="x-badge-over">
                <Listeners>
                    <Click Handler="alert(item.html);" />
                </Listeners>
            </ext:Badge>
        </Plugins>
    </ext:Panel>

    <br />

    <h3>Custom align</h3>

    <ext:Container runat="server" Layout="HBox">
        <Defaults>
            <ext:Parameter Name="margin" Value="0 30 0 0" Mode="Value" />
        </Defaults>
        <Items>
            <ext:Panel runat="server" Width="70" Height="80" Title="Panel 1" Frame="true">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="1"
                        AlignmentSpec="l-tl"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="70" Height="80" Title="Panel 2" Frame="true">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="2"
                        AlignmentSpec="c-l"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="70" Height="80" Title="Panel 3" Frame="true">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="3"
                        AlignmentSpec="b-bl"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="70" Height="80" Title="Panel 4" Frame="true">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="4"
                        AlignmentSpec="bl-tr"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server" Width="70" Height="80" Title="Panel 5" Frame="true">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        Text="5"
                        AlignmentSpec="c-c"
                        />
                </Plugins>
            </ext:Panel>
        </Items>
    </ext:Container>

    <br />
    <h3>Dynamic</h3>

    <ext:Panel
        ID="Panel1"
        runat="server"
        Title="Dynamic Badge"
        Width="200"
        Height="200">
        <Defaults>
            <ext:Parameter Name="margin" Value="10" />
        </Defaults>
        <Items>
            <ext:Button runat="server" Text="hello" Handler="Ext.Msg.badge(this.up('panel'), 'hello');" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="2" Handler="Ext.Msg.badge(this.up('panel'), 2);" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="+10" Handler="Ext.Msg.badge(this.up('panel'), '+10');" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="-3" Handler="Ext.Msg.badge(this.up('panel'), '-3');" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="''" Handler="Ext.Msg.badge(this.up('panel'), '');" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="Clickable" Handler="Ext.Msg.badge(this.up('panel'), {text: 'Click me', listeners: {click: function (item) {alert(item.html);} }});" />
            <ext:Label runat="server" Text="->" />
            <ext:Button runat="server" Text="From server" OnDirectClick="Show_Badge" />
        </Items>
    </ext:Panel>
</body>
</html>
