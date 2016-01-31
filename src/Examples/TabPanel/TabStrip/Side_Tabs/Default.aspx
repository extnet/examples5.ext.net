<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Side Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-panel p {
            margin: 0;
        }

        .tab-cont {
            float: left;
            margin: 0 15px 15px 0;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Side Tabs</h1>

        <div class="tab-cont">
            <h2>Left-Aligned Tabs</h2>
            <ext:TabStrip runat="server" TabPosition="Left">
                <Items>
                    <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 2" Closable="true" />
                    <ext:Tab Text="Tab 3" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabStrip>
        </div>

        <div class="tab-cont">
            <h2>Right-Aligned Tabs</h2>
            <ext:TabStrip runat="server" TabPosition="Right">
                <Items>
                    <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 2" Closable="true" />
                    <ext:Tab Text="Tab 3" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabStrip>
        </div>

        <div class="x-clear"></div>

        <div class="tab-cont">
            <h2>Left-Aligned Tabs With Scrolling</h2>
            <ext:TabStrip runat="server"
                TabPosition="Left"
                Height="300">
                <Items>
                    <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 2" Closable="true" />
                    <ext:Tab Text="Tab 3" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    <ext:Tab Text="Tab 4" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 5" Closable="true" />
                    <ext:Tab Text="Tab 6" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabStrip>
        </div>

        <div class="tab-cont">
            <h2>Right-Aligned Tabs With Scrolling</h2>
            <ext:TabStrip runat="server"
                TabPosition="Right"
                Height="300">
                <Items>
                    <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 2" Closable="true" />
                    <ext:Tab Text="Tab 3" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    <ext:Tab Text="Tab 4" Icon="ApplicationViewList" />
                    <ext:Tab Text="Tab 5" Closable="true" />
                    <ext:Tab Text="Tab 6" />
                    <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabStrip>
        </div>

        <div class="x-clear"></div>

        <h2>Docked TabStrip</h2>
        <ext:Panel runat="server" Width="345" Height="294">
            <DockedItems>
                <ext:TabStrip runat="server"
                    TabPosition="Left">
                    <Items>
                        <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                        <ext:Tab Text="Tab 2" Closable="true" />
                        <ext:Tab Text="Tab 3" />
                        <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    </Items>
                </ext:TabStrip>

                <ext:TabStrip runat="server"
                    TabPosition="Right">
                    <Items>
                        <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                        <ext:Tab Text="Tab 2" Closable="true" />
                        <ext:Tab Text="Tab 3" />
                        <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    </Items>
                </ext:TabStrip>

                <ext:TabStrip runat="server">
                    <Items>
                        <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                        <ext:Tab Text="Tab 2" Closable="true" />
                        <ext:Tab Text="Tab 3" />
                        <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    </Items>
                </ext:TabStrip>

                <ext:TabStrip runat="server"
                    TabPosition="Bottom">
                    <Items>
                        <ext:Tab Text="Tab 1" Icon="ApplicationViewList" />
                        <ext:Tab Text="Tab 2" Closable="true" />
                        <ext:Tab Text="Tab 3" />
                        <ext:Tab Text="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    </Items>
                </ext:TabStrip>
            </DockedItems>
        </ext:Panel>
    </form>
</body>
</html>
