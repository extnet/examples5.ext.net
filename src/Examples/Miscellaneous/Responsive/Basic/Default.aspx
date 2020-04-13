<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Responsive - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="pictos/pictos.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" GlyphFontFamily="Pictos" />

        <ext:Panel
            runat="server"
            BodyPadding="20"
            Html="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.">
            <Factory Instance="My.TabItem" Alias="mytabitem" />
            <TabConfig runat="server">
                <ResponsiveConfig>
                    <ext:ResponsiveRule Rule="wide">
                        <CustomConfig>
                            <ext:ConfigItem Name="iconAlign" Value="left" />
                            <ext:ConfigItem Name="textAlign" Value="left" />
                        </CustomConfig>
                    </ext:ResponsiveRule>

                    <ext:ResponsiveRule Rule="tall">
                        <ResponsiveConfig>
                            <ext:Button runat="server" IconAlign="Top" TextAlign="Center" Width="120" />
                        </ResponsiveConfig>
                    </ext:ResponsiveRule>
                </ResponsiveConfig>
            </TabConfig>
        </ext:Panel>

        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:TabPanel runat="server" TabRotation="0">
                    <ResponsiveConfig>
                        <ext:ResponsiveRule Rule="tall">
                            <ResponsiveConfig>
                                <ext:TabPanel runat="server" TabPosition="Top" />
                            </ResponsiveConfig>
                        </ext:ResponsiveRule>

                        <ext:ResponsiveRule Rule="wide">
                            <ResponsiveConfig>
                                <ext:TabPanel runat="server" TabPosition="Left" />
                            </ResponsiveConfig>
                        </ext:ResponsiveRule>
                    </ResponsiveConfig>

                    <TabBarConfig Width="110" />

                    <Items>
                        <ext:Panel
                            runat="server"
                            FactoryAlias="mytabitem"
                            Title="Home"
                            Glyph="72"
                            XHtml="">
                            <Content>
                                <h2>Responsive Design Demo</h2>

                                <p>This example demonstrates how to make your app responsive to changes in
                                screen size or orientation.  Applications that run on tablets often need to
                                change the position and/or layout of navigational elements when the orientation
                                changes (when the device is rotated). This application uses a built-in feature
                                in Ext JS called <code>responsiveConfig</code> to make real-time changes to the
                                navigation tab bar as the screen size changes.  We use "wide" to describe a
                                situation where the screen width is larger than its height, and "tall" when the
                                screen\'s height is larger than its width.</p>

                                <ul>
                                    <li>Application header is docked to the left when "wide" and top when "tall."</li>
                                    <li>Tab icons are left-aligned when "wide" and top-aligned when "tall."</li>
                                    <li>Tab text is left-aligned when "wide" and centered when "tall."</li>
                                    <li>Tabs stretch to fit the width of the tab bar when "wide", but have a
                                    uniform width of 100px when "tall".</li>
                                </ul>

                                <p>Try resizing the window in your desktop browser, or rotating your tablet
                                to see it in action!</p>

                                <p>For more info on how to use responsiveConfig in your application, see the
                                API Docs for <a href="https://docs.sencha.com/extjs/7.2.0/classic/Ext.mixin.Responsive.html">Ext.mixin.Responsive</a>
                                </p>
                            </Content>
                        </ext:Panel>

                        <ext:Panel
                            runat="server"
                            Title="Users"
                            Glyph="117"
                            FactoryAlias="mytabitem"
                            />

                        <ext:Panel
                            runat="server"
                            Title="Groups"
                            Glyph="85"
                            FactoryAlias="mytabitem"
                            />

                        <ext:Panel
                            runat="server"
                            Title="Settings"
                            Glyph="42"
                            FactoryAlias="mytabitem"
                            />
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>