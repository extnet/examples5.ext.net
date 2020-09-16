<%@ Page Language="C#" %>

<script runat="server">
    protected void SubmitSelection(object sender, DirectEventArgs e)
    {
        this.ShowSelection(MultiSelect3);
    }

    private void ShowSelection(MultiSelect ctrl)
    {
        StringBuilder sb = new StringBuilder(256);
        sb.Append("Ext.Msg.alert('Selection', '");

        foreach (Ext.Net.ListItem item in ctrl.SelectedItems)
        {
            sb.AppendFormat("Value={0}, Index={1}, Text={2} <br/>", item.Value, item.Index, item.Text);
        }

        sb.Append("');");

        ctrl.AddScript(sb.ToString());
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Overview of MultiSelect - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .label {
            font    : bold 11px tahoma,arial,sans-serif;
            width   : 300px;
            height  : 25px;
            padding : 5px 0;
            border  : 1px dotted #99bbe8;
            color   : #15428b;
            cursor  : default;
            margin  : 10px;
            background  : #dfe8f6;
            text-align  : center;
            margin-left : 0px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:TabPanel runat="server" Plain="true" Height="480">
            <Items>
                <ext:Panel
                    runat="server"
                    Title="Legend"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="2" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label runat="server" Html="<div class='label'>With Legend</div>" />
                        <ext:Label runat="server" Html="<div class='label'>Without Legend</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="260"
                            Layout="Fit">
                            <Items>
                                <ext:FieldSet runat="server" Title="With Legend" Layout="Fit">
                                    <Items>
                                        <ext:MultiSelect runat="server" Border="false">
                                            <Items>
                                                <ext:ListItem Text="Item 1" Value="1" />
                                                <ext:ListItem Text="Item 2" Value="2" />
                                                <ext:ListItem Text="Item 3" Value="3" />
                                                <ext:ListItem Text="Item 4" Value="4" />
                                                <ext:ListItem Text="Item 5" Value="5" />
                                            </Items>
                                        </ext:MultiSelect>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            PaddingSpec="2 0 0 0"
                            Height="248"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect runat="server">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Title="Selection Mode"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="2" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label runat="server" Html="<div class='label'>Simple Select</div>" />
                        <ext:Label runat="server" Html="<div class='label'>Multi Select with Ctrl/Shift</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect runat="server">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect runat="server" MultiSelect="true">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Title="Bars"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="2" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label runat="server" Html="<div class='label'>Top Bar</div>" />
                        <ext:Label runat="server" Html="<div class='label'>Bottom Bar</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Layout="Fit"
                            Width="480"
                            Height="250">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Clear Selection">
                                            <Listeners>
                                                <Click Handler="#{MultiSelect1}.reset();" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:MultiSelect ID="MultiSelect1" runat="server">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Layout="Fit"
                            Width="480"
                            Height="250">
                            <Items>
                                <ext:MultiSelect ID="MultiSelect2" runat="server">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>

                            <BottomBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Select [2,3]">
                                            <Listeners>
                                                <Click Handler="#{MultiSelect2}.setValue([2, 3]);" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </BottomBar>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Title="Drag/Drop"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="2" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label ID="Label1" runat="server" Html="<div class='label'>Drag</div>" />
                        <ext:Label ID="Label2" runat="server" Html="<div class='label'>Drop</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect runat="server" DragGroup="grp1" MultiSelect="true">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect
                                    runat="server"
                                    AppendOnly="true"
                                    DropGroup="grp1"
                                    MultiSelect="true">
                                    <Items>
                                        <ext:ListItem Text="Item 6" Value="6" />
                                        <ext:ListItem Text="Item 7" Value="7" />
                                        <ext:ListItem Text="Item 8" Value="8" />
                                        <ext:ListItem Text="Item 9" Value="9" />
                                        <ext:ListItem Text="Item 10" Value="10" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Title="Drag/Drop and reordering"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="2" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label runat="server" Html="<div class='label'>Drag/Drop with Reorder</div>" />
                        <ext:Label runat="server" Html="<div class='label'>Drag/Drop with Reorder</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect
                                    runat="server"
                                    DragGroup="grp2"
                                    DropGroup="grp2"
                                    MultiSelect="true">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect
                                    runat="server"
                                    DragGroup="grp2"
                                    DropGroup="grp2"
                                    DDReorder="true"
                                    MultiSelect="true">
                                    <Items>
                                        <ext:ListItem Text="Item 6" Value="6" />
                                        <ext:ListItem Text="Item 7" Value="7" />
                                        <ext:ListItem Text="Item 8" Value="8" />
                                        <ext:ListItem Text="Item 9" Value="9" />
                                        <ext:ListItem Text="Item 10" Value="10" />
                                    </Items>
                                </ext:MultiSelect>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Title="Submit"
                    BodyPadding="18"
                    Layout="Table">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="1" />
                    </LayoutConfig>
                    <Items>
                        <ext:Label runat="server" Html="<div class='label'>Indexes, Values and Text Submit</div>" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Width="480"
                            Height="250"
                            Layout="Fit">
                            <Items>
                                <ext:MultiSelect ID="MultiSelect3" runat="server" SubmitText="false">
                                    <Items>
                                        <ext:ListItem Text="Item 1" Value="1" />
                                        <ext:ListItem Text="Item 2" Value="2" />
                                        <ext:ListItem Text="Item 3" Value="3" />
                                        <ext:ListItem Text="Item 4" Value="4" />
                                        <ext:ListItem Text="Item 5" Value="5" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="1" />
                                        <ext:ListItem Value="3" />
                                        <ext:ListItem Value="5" />
                                    </SelectedItems>
                                </ext:MultiSelect>
                            </Items>

                            <BottomBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarFill />
                                        <ext:Button runat="server" Text="Submit" OnDirectClick="SubmitSelection" />
                                    </Items>
                                </ext:Toolbar>
                            </BottomBar>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:TabPanel>
    </form>
</body>
</html>
