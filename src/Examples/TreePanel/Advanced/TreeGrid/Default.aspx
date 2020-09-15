<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreeGrid - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var formatHours = function (v) {
            if (v < 1) {
                return Math.round(v * 60) + " mins";
            } else if (Math.floor(v) !== v) {
                var min = v - Math.floor(v);
                return Math.floor(v) + "h " + Math.round(min * 60) + "m";
            } else {
                return v + " hour" + (v === 1 ? "" : "s");
            }
        };

        var handler = function (grid, rowIndex, colIndex, actionItem, event, record, row) {
            Ext.Msg.alert('Editing' + (record.get('done') ? ' completed task' : '') , record.get('task'));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>
            TreeGrid Example
        </h1>
        <p>
            This example is an advanced tree example. It illustrates:
        </p>
        <ul class="feature-list">
            <li>Multiple headers
            </li>
            <li>Header hiding, showing, reordering and resizing
            </li>
            <li>useArrows configuration
            </li>
            <li>Keyboard Navigation
            </li>
            <li>Discontiguous selection by holding the CTRL key
            </li>
            <li>singleExpand has been set to true
            </li>
        </ul>

        <br />

        <ext:TreePanel
            runat="server"
            Title="Core Team Projects"
            Width="500"
            Height="480"
            Collapsible="true"
            UseArrows="true"
            RootVisible="false"
            MultiSelect="true"
            SingleExpand="true"
            FolderSort="true">
            <Fields>
                <ext:ModelField Name="task" />
                <ext:ModelField Name="user" />
                <ext:ModelField Name="duration" />
                <ext:ModelField Name="done" Type="Boolean" />
            </Fields>
            <ColumnModel>
                <Columns>
                    <ext:TreeColumn
                        runat="server"
                        Text="Task"
                        Flex="2"
                        Sortable="true"
                        DataIndex="task" />
                    <ext:TemplateColumn
                        runat="server"
                        Text="Duration"
                        Flex="1"
                        Sortable="true"
                        DataIndex="duration"
                        Align="Center">
                        <Template runat="server">
                            <Html>
                                {duration:this.formatHours}
                            </Html>
                            <Functions>
                                <ext:JFunction Name="formatHours" Fn="formatHours" />
                            </Functions>
                        </Template>
                    </ext:TemplateColumn>
                    <ext:Column
                        runat="server"
                        Text="Assigned To"
                        Flex="1"
                        Sortable="true"
                        DataIndex="user" />
                    <ext:CheckColumn runat="server"
                       Text="Done"
                       DataIndex="done"
                       Width="60"
                       Editable="true"
                       StopSelection="false" />
                    <ext:ActionColumn runat="server"
                        Text="Edit"
                        Width="50"
                        MenuDisabled="true"
                        Align="Center">
                        <Items>
                            <ext:ActionItem Tooltip="Edit task" IconCls="x-md md-icon-edit" Handler="handler">
                                <IsDisabled Handler="return !record.data.leaf;" />
                            </ext:ActionItem>
                        </Items>
                    </ext:ActionColumn>
                </Columns>

            </ColumnModel>

            <Root>
                <ext:Node Text="Tasks">
                    <Children>
                        <ext:Node IconCls="x-md md-icon-folder" Expanded="true">
                            <CustomAttributes>
                                <ext:ConfigItem Name="task" Value="Project: Shopping" Mode="Value" />
                                <ext:ConfigItem Name="duration" Value="13.25" />
                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                            </CustomAttributes>
                            <Children>
                                <ext:Node IconCls="x-md md-icon-folder">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="task" Value="Housewares" Mode="Value" />
                                        <ext:ConfigItem Name="duration" Value="1.25" />
                                        <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Kitchen supplies" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Groceries" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.4" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                                <ext:ConfigItem Name="done" Value="true" Mode="Raw" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Cleaning supplies" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.4" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Office supplies" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.2" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                                <ext:Node IconCls="x-md md-icon-folder" Expanded="true">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="task" Value="Remodeling" Mode="Value" />
                                        <ext:ConfigItem Name="duration" Value="12" />
                                        <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Retile kitchen" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="6.5" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node IconCls="x-md md-icon-folder">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Paint bedroom" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="2.75" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                            <Children>
                                                <ext:Node Leaf="true">
                                                    <CustomAttributes>
                                                        <ext:ConfigItem Name="task" Value="Ceiling" Mode="Value" />
                                                        <ext:ConfigItem Name="duration" Value="1.25" />
                                                        <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                                    </CustomAttributes>
                                                </ext:Node>
                                                <ext:Node Leaf="true">
                                                    <CustomAttributes>
                                                        <ext:ConfigItem Name="task" Value="Walls" Mode="Value" />
                                                        <ext:ConfigItem Name="duration" Value="1.5" />
                                                        <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                                    </CustomAttributes>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Decorate living room" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="2.75" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                                <ext:ConfigItem Name="done" Value="true" Mode="Raw" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Fix lights" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.75" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                                <ext:ConfigItem Name="done" Value="true" Mode="Raw" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Reattach screen door" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="2" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                        <ext:Node IconCls="x-md md-icon-folder">
                            <CustomAttributes>
                                <ext:ConfigItem Name="task" Value="Project: Testing" Mode="Value" />
                                <ext:ConfigItem Name="duration" Value="2" />
                                <ext:ConfigItem Name="user" Value="Core Team" Mode="Value" />
                            </CustomAttributes>
                            <Children>
                                <ext:Node IconCls="x-md md-icon-folder">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="task" Value="Mac OSX" Mode="Value" />
                                        <ext:ConfigItem Name="duration" Value="0.75" />
                                        <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Safari" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                                <ext:Node IconCls="x-md md-icon-folder">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="task" Value="Windows" Mode="Value" />
                                        <ext:ConfigItem Name="duration" Value="3.75" />
                                        <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Safari" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Internet Explorer" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="3" />
                                                <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                                <ext:Node IconCls="x-md md-icon-folder">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="task" Value="Linux" Mode="Value" />
                                        <ext:ConfigItem Name="duration" Value="0.5" />
                                        <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                        <ext:Node Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                                <ext:ConfigItem Name="duration" Value="0.25" />
                                                <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                    </Children>
                </ext:Node>
            </Root>
        </ext:TreePanel>
    </form>
</body>
</html>