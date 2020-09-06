<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Viewport with BorderLayout - Ext.NET Examples</title>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" Layout="Border">
        <Items>
            <ext:Panel
                runat="server"
                Title="North"
                Region="North"
                Rounded="false"
                Split="true"
                Height="180"
                BodyPadding="18"
                Html="North"
                Collapsible="true"
                />
            <ext:Panel
                runat="server"
                Title="West"
                Region="West"
                Rounded="false"
                Layout="Accordion"
                Width="270"
                MinWidth="180"
                MaxWidth="360"
                Split="true"
                Collapsible="true">
                <Items>
                    <ext:Panel
                        runat="server"
                        Title="Navigation"
                        Border="false"
                        BodyPadding="18"
                        Html="West"
                        />
                    <ext:Panel
                        runat="server"
                        Title="Settings"
                        Border="false"
                        BodyPadding="18"
                        Html="Some settings in here"
                        />
                </Items>
            </ext:Panel>
            <ext:TabPanel runat="server" Region="Center">
                <Items>
                    <ext:Panel
                        runat="server"
                        Title="Center"
                        Border="false"
                        BodyPadding="18"
                        Html="<h1>Viewport with BorderLayout</h1>"
                        />
                    <ext:Panel
                        runat="server"
                        Title="Close Me"
                        Closable="true"
                        Border="false"
                        BodyPadding="18"
                        Html="Closeable Tab"
                        />
                </Items>
            </ext:TabPanel>
            <ext:Panel
                runat="server"
                Title="East"
                Region="East"
                Rounded="false"
                Collapsible="true"
                Split="true"
                MinWidth="180"
                Width="270"
                Layout="Fit">
                <Items>
                    <ext:TabPanel
                        runat="server"
                        Rounded="false"
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
                runat="server"
                Title="South"
                Region="South"
                Rounded="false"
                Split="true"
                Collapsible="true"
                Height="180"
                BodyPadding="18"
                Html="South"
                />
        </Items>
    </ext:Viewport>
</body>
</html>