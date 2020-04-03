<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toolbar Button Groups - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .add32 {
            background-image : url(images/add32.gif) !important;
        }
        .add16 {
            background-image : url(images/add16.gif) !important;
        }
        .add24 {
            background-image : url(images/add24.gif) !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel
            runat="server"
            Title="Standard"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                        <ext:ToolbarSeparator />
                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                        <ext:Button runat="server" Text="Paste" IconCls="add16">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                        <ext:ToolbarSeparator />
                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
        <ext:Panel
            runat="server"
            Title="Multi columns"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Title="Clipboard" Layout="Table">
                            <LayoutConfig>
                                <ext:TableLayoutConfig Columns="2" />
                            </LayoutConfig>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Paste" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup runat="server" Title="Other Actions" Layout="Table">
                            <LayoutConfig>
                                <ext:TableLayoutConfig Columns="2" />
                            </LayoutConfig>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Paste" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
        <ext:Panel
            runat="server"
            Title="Multi columns (No titles, double stack)"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Layout="Table">
                            <LayoutConfig>
                                <ext:TableLayoutConfig Columns="3" />
                            </LayoutConfig>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Paste" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup runat="server" Layout="Table">
                            <LayoutConfig>
                                <ext:TableLayoutConfig Columns="3" />
                            </LayoutConfig>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Paste" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Mix and match icon sizes"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Title="Clipboard" Columns="3">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Paste"
                                    IconCls="add32"
                                    Scale="Large"
                                    IconAlign="Top"
                                    Cls="x-btn-as-arrow"
                                    RowSpan="3"
                                    />
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="add32"
                                    IconAlign="Top"
                                    ArrowAlign="Bottom"
                                    Scale="Large"
                                    RowSpan="3">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Title="Other Actions" Columns="3">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Paste"
                                    IconCls="add32"
                                    Scale="Large"
                                    IconAlign="Top"
                                    Cls="x-btn-as-arrow"
                                    RowSpan="3"
                                    />
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="add32"
                                    IconAlign="Top"
                                    ArrowAlign="Bottom"
                                    Scale="Large"
                                    RowSpan="3">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Medium icons, arrows to the bottom"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Title="Clipboard" Layout="Table">
                            <Defaults>
                                <ext:Parameter Name="scale" Value="medium" />
                                <ext:Parameter Name="iconAlign" Value="top" />
                            </Defaults>
                            <Items>
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="add24"
                                    ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add24" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add24" Cls="x-btn-as-arrow" />
                                <ext:Button runat="server" Text="Paste" IconCls="add24" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format<br/>Stuff" IconCls="add24" />
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Title="Other Actions" Layout="Table">
                            <Defaults>
                                <ext:Parameter Name="scale" Value="medium" />
                                <ext:Parameter Name="iconAlign" Value="top" />
                            </Defaults>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="add24" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="add24" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="add24" Cls="x-btn-as-arrow" />
                                <ext:Button runat="server" Text="Paste" IconCls="add24" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="add24" Cls="x-btn-as-arrow" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Medium icons, text and arrows to the left"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Layout="Table">
                            <Items>
                                <ext:Button runat="server" Text="Cut" IconCls="add24" Scale="Medium" />
                                <ext:Button runat="server" Text="Copy" IconCls="add24" Scale="Medium" />
                                <ext:Button runat="server" Text="Paste" IconCls="add24" Scale="Medium">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Layout="Table">
                            <Items>
                                <ext:Button runat="server" Text="Format" IconCls="add24" Scale="Medium" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Small icons, text and arrows to the left"
            Width="900"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Layout="Table">
                            <Items>
                                <ext:Button runat="server" Text="Cut" IconCls="add16" />
                                <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                <ext:Button runat="server" Text="Paste" IconCls="add16">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Layout="Table">
                            <Items>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>


        <ext:TabPanel runat="server" Height="300" StyleSpec="margin-top:15px">
            <Items>
                <ext:Panel runat="server" Title="Home">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ButtonGroup runat="server" Title="Clipboard" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>

                <ext:Panel runat="server" Title="Insert">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ButtonGroup runat="server" Title="Clipboard" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>

                <ext:Panel runat="server" Title="Page Layout">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ButtonGroup runat="server" Title="Clipboard" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Layout="Table">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
            </Items>
        </ext:TabPanel>
    </form>
</body>
</html>
