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

        <p>
            This example demonstrates side-aligned tabs in Ext.Net.  Tab Panels can be configured
            with a TabPosition of "Right" to rotate the tab bar clockwise, or "Left" to rotate
            the tab bar counter-clockwise.
        </p>

        <div id="left-tabs" class="tab-cont">
            <h2>Left-Aligned Tabs</h2>
            <ext:TabPanel runat="server"
                TabPosition="Left"
                Height="300"
                Width="300">
                <Items>
                    <ext:Panel runat="server" Title="Tab 1" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 3" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabPanel>
        </div>

        <div id="right-tabs" class="tab-cont">
            <h2>Right-Aligned Tabs</h2>
            <ext:TabPanel runat="server"
                TabPosition="Right"
                Height="300"
                Width="300">
                <Items>
                    <ext:Panel runat="server" Title="Tab 1" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 3" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabPanel>
        </div>

        <div class="x-clear"></div>

        <div id="right-scroll-tabs" class="tab-cont">
            <h2>Left-Aligned Tabs With Scrolling</h2>
            <ext:TabPanel runat="server"
                TabPosition="Left"
                Height="300"
                Width="300">
                <Items>
                    <ext:Panel runat="server" Title="Tab 1" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 3" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    <ext:Panel runat="server" Title="Tab 4" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 5" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 6" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabPanel>
        </div>

        <div id="left-scroll-tabs" class="tab-cont">
            <h2>Right-Aligned Tabs With Scrolling</h2>
            <ext:TabPanel runat="server"
                TabPosition="Right"
                Height="300"
                Width="300">
                <Items>
                    <ext:Panel runat="server" Title="Tab 1" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 3" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                    <ext:Panel runat="server" Title="Tab 4" Icon="ApplicationViewList" />
                    <ext:Panel runat="server" Title="Tab 5" Closable="true" />
                    <ext:Panel runat="server" Title="Tab 6" />
                    <ext:Panel runat="server" Title="Disabled" Icon="ApplicationViewList" Closable="true" Disabled="true" />
                </Items>
            </ext:TabPanel>
        </div>
    </form>
</body>
</html>