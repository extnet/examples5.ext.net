<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toolbar ButtonGroups - Ext.NET Examples</title>

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
            MinMinWidth="500"
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
            Title="Multiple Columns with bottom title"
            MinMinWidth="500"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
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
                        <ext:ButtonGroup
                            runat="server"
                            Title="Other Actions"
                            HeaderPosition="Bottom"
                            Columns="2">
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
            Title="Multiple Columns (No Titles, Double Stack)"
            MinWidth="500"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server" Columns="3">
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
                        <ext:ButtonGroup runat="server" Columns="3">
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
            Title="Mix and Match Icon Sizes"
            MinWidth="500"
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
                                    RowSpan="3"
                                    >
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
            Title="Medium Icons, Arrows to the Bottom"
            MinWidth="500"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
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

                        <ext:ButtonGroup runat="server" Title="Other Actions">
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
            Title="Medium Icons, Text and Arrows to the Right"
            MinWidth="500"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
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

                        <ext:ButtonGroup runat="server" Layout="TableLayout">
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
            Title="Small Icons, Text and Arrows to the Right"
            MinWidth="500"
            Height="250"
            StyleSpec="margin-top:15px"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ButtonGroup runat="server">
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

                        <ext:ButtonGroup runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Format" IconCls="add16" />
                            </Items>
                        </ext:ButtonGroup>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:TabPanel runat="server" Height="300" MinWidth="500" StyleSpec="margin-top:15px">
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

                <ext:Panel runat="server" Title="Insert">
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

                <ext:Panel runat="server" Title="Page Layout">
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
                                            RowSpan="3"
                                            Cls="x-btn-as-arrow"
                                            />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            RowSpan="3"
                                            ArrowAlign="Bottom"
                                            Scale="Large">
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