<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Complex BorderLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Complex BorderLayout in Markup</h1>

    <ext:Button runat="server" Text="Show Window" IconCls="x-md md-icon-open-in-new">
        <Listeners>
            <Click Handler="#{Window1}.show();" />
        </Listeners>
    </ext:Button>

    <ext:Window
        ID="Window1"
        runat="server"
        Title="Complex Layout"
        IconCls="x-md md-icon-open-in-new"
        Width="960"
        Height="640"
        Plain="true"
        Border="false"
        Collapsible="true"
        BodyBorder="0"
        AnimateTarget="Button1"
        Layout="Border">
        <Items>
            <ext:Panel
                ID="WestPanel"
                runat="server"
                Region="West"
                Title="West"
                Width="250"
                Layout="Accordion"
                MinWidth="180"
                MaxWidth="480"
                Split="true"
                Collapsible="true">
                <Items>
                    <ext:Panel
                        ID="Navigation"
                        runat="server"
                        Title="Navigation"
                        Border="false"
                        BodyPadding="18"
                        Html="Navigation"
                        />
                    <ext:Panel
                        ID="Settings"
                        runat="server"
                        Title="Settings"
                        Border="false"
                        BodyPadding="18"
                        Collapsed="True"
                        Html="Some settings in here."
                        />
                </Items>
            </ext:Panel>
            <ext:TabPanel
                ID="CenterPanel"
                runat="server"
                Region="Center"
                ActiveTabIndex="0">
                <Items>
                    <ext:Panel
                        ID="Tab1"
                        runat="server"
                        Title="Close Me"
                        Closable="true"
                        Border="false"
                        BodyPadding="18"
                        Html="Hello ..."
                        />
                    <ext:Panel
                        ID="Tab2"
                        runat="server"
                        Title="Center"
                        Border="false"
                        BodyPadding="18"
                        Html="... World"
                        />
                </Items>
            </ext:TabPanel>
            <ext:Panel
                ID="EastPanel"
                runat="server"
                Region="East"
                Collapsible="true"
                Split="true"
                MinWidth="180"
                Width="250"
                Title="East"
                Layout="Fit">
                <Items>
                    <ext:TabPanel
                        runat="server"
                        ActiveTabIndex="1"
                        TabPosition="Bottom"
                        Border="false">
                        <Items>
                            <ext:Panel
                                runat="server"
                                Title="Tab 1"
                                Border="false"
                                BodyPadding="18"
                                Html="East Tab 1"
                                />
                            <ext:Panel
                                runat="server"
                                Title="Tab 2"
                                Closable="true"
                                Border="false"
                                BodyPadding="18"
                                Html="East Tab 2"
                                />
                        </Items>
                    </ext:TabPanel>
                </Items>
            </ext:Panel>
            <ext:Panel
                ID="SouthPanel"
                runat="server"
                Region="South"
                Split="true"
                Collapsible="true"
                Title="South"
                Html="South"
                Height="360"
                BodyPadding="18"
                />
        </Items>
    </ext:Window>
</body>
</html>