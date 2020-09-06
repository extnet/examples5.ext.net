<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toolbar ButtonGroups - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel
            runat="server"
            Title="Standard"
            Width="960"
            Height="300"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline">
                            <Menu>
                                <ext:Menu runat="server" Plain="true">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                        <ext:ToolbarSeparator />
                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                            <Menu>
                                <ext:Menu runat="server" Plain="true">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>
                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                        <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                            <Menu>
                                <ext:Menu runat="server" Plain="true">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                        <ext:ToolbarSeparator />
                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Multiple Columns - bottom title"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup
                            runat="server"
                            Title="Clipboard"
                            HeaderPosition="Bottom"
                            Columns="2">
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup
                            runat="server"
                            Title="Other Actions"
                            HeaderPosition="Bottom"
                            Columns="2">
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Multiple Columns - No titles & double stack"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Columns="3">
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup runat="server" Columns="3">
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Mix and Match Icon Sizes"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Title="Clipboard" Columns="3">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Paste"
                                    IconCls="x-md md-icon-content-paste"
                                    Scale="Large"
                                    IconAlign="Top"
                                    Cls="x-btn-as-arrow"
                                    RowSpan="3"
                                    />
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="x-md md-icon-check-circle-outline"
                                    IconAlign="Top"
                                    ArrowAlign="Bottom"
                                    Scale="Large"
                                    RowSpan="3">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Title="Other Actions" Columns="3">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Paste"
                                    IconCls="x-md md-icon-content-paste"
                                    Scale="Large"
                                    IconAlign="Top"
                                    Cls="x-btn-as-arrow"
                                    RowSpan="3"
                                    />
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="x-md md-icon-check-circle-outline"
                                    IconAlign="Top"
                                    ArrowAlign="Bottom"
                                    Scale="Large"
                                    RowSpan="3"
                                    >
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Medium Icons - Bottom trigger"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Title="Clipboard">
                            <Defaults>
                                <ext:Parameter Name="scale" Value="medium" />
                                <ext:Parameter Name="iconAlign" Value="top" />
                            </Defaults>
                            <Items>
                                <ext:SplitButton
                                    runat="server"
                                    Text="Menu Button"
                                    IconCls="x-md md-icon-content-cut"
                                    ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" Cls="x-btn-as-arrow" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server" Title="Other Actions">
                            <Defaults>
                                <ext:Parameter Name="scale" Value="medium" />
                                <ext:Parameter Name="iconAlign" Value="top" />
                            </Defaults>
                            <Items>
                                <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-check-circle-outline" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Button 1" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" Cls="x-btn-as-arrow" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste" ArrowAlign="Bottom">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Medium Icons - Right text and trigger"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Cut" IconCls="x-md md-icon-content-cut" Scale="Medium" />
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" Scale="Medium" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste" Scale="Medium">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
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
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" Scale="Medium" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:Panel
            runat="server"
            Title="Small Icons - Right text and trigger"
            Width="960"
            Height="300"
            MarginSpec="20 0 0 0"
            BodyPadding="18"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Cut" IconCls="x-md md-icon-content-cut" />
                                <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                                    <Menu>
                                        <ext:Menu runat="server" Plain="true">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                            </Items>
                        </ext:ButtonGroup>

                        <ext:ButtonGroup runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:TabPanel runat="server" Width="960" Height="300" MarginSpec="20 0 0 0">
            <Items>
                <ext:Panel runat="server" Title="Home">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ButtonGroup runat="server" Title="Clipboard" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
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
                                <ext:ButtonGroup runat="server" Title="Clipboard" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
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
                                <ext:ButtonGroup runat="server" Title="Clipboard" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Columns="3">
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="x-md md-icon-content-paste"
                                            Scale="Large"
                                            IconAlign="Top"
                                            RowSpan="3"
                                            Cls="x-btn-as-arrow"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="x-md md-icon-check-circle-outline"
                                            IconAlign="Top"
                                            RowSpan="3"
                                            ArrowAlign="Bottom"
                                            Scale="Large">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                                            <Menu>
                                                <ext:Menu runat="server" Plain="true">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                                        <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-create" />
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