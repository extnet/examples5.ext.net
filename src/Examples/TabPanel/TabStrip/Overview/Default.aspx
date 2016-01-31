<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TabStrip and TabStripItem - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TabStrip with setting the TabStripItems .ActionItemID Property</h1>

        <p>The TabStrip component can be added to any position within a Toolbar.</p>

        <ext:Panel
            runat="server"
            Height="185"
            Width="350"
            Layout="card"
            ActiveIndex="0"
            DefaultBorder="false"
            DefaultPadding="5">
            <TopBar>
                <ext:Toolbar runat="server" StyleSpec="padding-bottom:0px;">
                    <Items>
                        <ext:Button runat="server" Icon="Database" />
                        <ext:Button runat="server" Icon="Disk" />
                        <ext:ToolbarFill runat="server" />
                        <ext:TabStrip runat="server" Width="155">
                            <Items>
                                <ext:Tab ActionItemID="pnlSummary" Text="Summary" />
                                <ext:Tab ActionItemID="pnlData" Text="Data" />
                            </Items>
                        </ext:TabStrip>
                        <ext:ToolbarSeparator runat="server" />
                        <ext:Button runat="server" Icon="Key" />
                        <ext:Button runat="server" Icon="Help" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Panel ID="pnlSummary" runat="server" Html="Summary" Header="false" />
                <ext:Panel ID="pnlData" runat="server" Html="Data" Header="false" />
            </Items>
        </ext:Panel>

        <br />
        <h1>TabStrip with ActionContainerID</h1>

        <ext:Panel
            ID="Panel2"
            runat="server"
            Height="105"
            Width="350"
            Layout="card"
            ActiveIndex="0"
            DefaultBorder="false"
            DefaultPadding="5">
            <TopBar>
                <ext:Toolbar runat="server" StyleSpec="padding-bottom:0px;">
                    <Items>
                        <ext:TabStrip runat="server" Width="155" ActionContainerID="Panel2">
                            <Items>
                                <ext:Tab Text="Summary" />
                                <ext:Tab Text="Data" />
                            </Items>
                        </ext:TabStrip>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Panel runat="server" Html="Summary" Header="false" />
                <ext:Panel runat="server" Html="Data" Header="false" />
            </Items>
        </ext:Panel>

        <br />
        <h1>Setting ActionItemID with Divs</h1>

        <ext:TabStrip runat="server" Width="155">
            <Items>
                <ext:Tab Text="Summary" ActionItemID="elm1" />
                <ext:Tab Text="Data" ActionItemID="elm2" />
            </Items>
        </ext:TabStrip>

        <div id="elm1" style="padding: 5px;">Summary</div>
        <div id="elm2" style="padding: 5px;">Data</div>
    </form>
</body>
</html>
