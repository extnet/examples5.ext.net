<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DropDownField Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var getTasks = function (tree) {
            var msg = [],
                selNodes = tree.getChecked();
            msg.push("[");

            Ext.each(selNodes, function (node) {
                if (msg.length > 1) {
                    msg.push(",");
                }

                msg.push(node.data.text);
            });

            msg.push("]");

            return msg.join("");
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DropDownField Overview</h1>

        <h2>Panel with AccordionLayout</h2>

        <ext:DropDownField ID="Field1" runat="server" TriggerIcon="Search">
            <Component>
                <ext:Panel runat="server" Height="250" Layout="Accordion">
                    <Items>
                        <ext:MenuPanel runat="server" Title="Group 1" IconCls="x-md md-icon-group">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" />
                                    <ext:MenuItem runat="server" Text="Item 2" />
                                    <ext:MenuItem runat="server" Text="Item 3" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field1}.setValue('Group 1 - '+menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>

                        <ext:MenuPanel runat="server" Title="Group 2" IconCls="x-md md-icon-group">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" />
                                    <ext:MenuItem runat="server" Text="Item 2" />
                                    <ext:MenuItem runat="server" Text="Item 3" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field1}.setValue('Group 2 - '+menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>

                        <ext:MenuPanel runat="server" Title="Group 3" IconCls="x-md md-icon-group">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" />
                                    <ext:MenuItem runat="server" Text="Item 2" />
                                    <ext:MenuItem runat="server" Text="Item 3" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field1}.setValue('Group 3 - '+menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>
                    </Items>
                </ext:Panel>
            </Component>
        </ext:DropDownField>

        <h2>Panel with Multiple Columns and Custom Align</h2>

        <ext:DropDownField
            ID="Field2"
            runat="server"
            TriggerIcon="SimpleRight"
            PickerAlign="tl-tr?"
            Editable="false"
            MatchFieldWidth="false">
            <Component>
                <ext:Panel
                    runat="server"
                    Width="400"
                    Height="90"
                    Layout="HBox">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:MenuPanel
                            runat="server"
                            Border="false"
                            Flex="1"
                            SaveSelection="false">
                            <Menu runat="server" ShowSeparator="false">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 2" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 3" IconCls="x-md md-icon-group" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field2}.setValue(menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>

                        <ext:MenuPanel
                            runat="server"
                            Border="false"
                            Flex="1"
                            SaveSelection="false">
                            <Menu runat="server" ShowSeparator="false">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 4" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 5" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 6" IconCls="x-md md-icon-group" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field2}.setValue(menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>

                        <ext:MenuPanel
                            runat="server"
                            Border="false"
                            Flex="1"
                            SaveSelection="false">
                            <Menu runat="server" ShowSeparator="false">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 7" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 8" IconCls="x-md md-icon-group" />
                                    <ext:MenuItem runat="server" Text="Item 9" IconCls="x-md md-icon-group" />
                                </Items>
                                <Listeners>
                                    <Click Handler="#{Field2}.setValue(menuItem.text);" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>
                    </Items>
                </ext:Panel>
            </Component>
        </ext:DropDownField>

        <h2>TreePanel</h2>

        <ext:DropDownField
            ID="Field3"
            runat="server"
            Editable="false"
            Width="480">
            <Component>
                <ext:TreePanel
                    runat="server"
                    Title="My Task List"
                    IconCls="x-md md-icon-check-circle-outline"
                    Height="480"
                    Width="480"
                    Shadow="false"
                    UseArrows="true"
                    Scrollable="Both"
                    Animate="true"
                    EnableDD="true"
                    ContainerScroll="true"
                    RootVisible="false">
                    <Root>
                        <ext:Node>
                            <Children>
                                <ext:Node Text="To Do" IconCls="x-md md-icon-folder">
                                    <Children>
                                        <ext:Node Text="Go jogging" Leaf="true" Checked="False" />
                                        <ext:Node Text="Take a nap" Leaf="true" Checked="False" />
                                        <ext:Node Text="Clean house" Leaf="true" Checked="False" />
                                    </Children>
                                </ext:Node>

                                <ext:Node Text="Grocery List" IconCls="x-md md-icon-folder">
                                    <Children>
                                        <ext:Node Text="Bananas" Leaf="true" Checked="False" />
                                        <ext:Node Text="Milk" Leaf="true" Checked="False" />
                                        <ext:Node Text="Cereal" Leaf="true" Checked="False" />

                                        <ext:Node Text="Energy foods" IconCls="x-md md-icon-folder">
                                            <Children>
                                                <ext:Node Text="Coffee" Leaf="true" Checked="False" />
                                                <ext:Node Text="Red Bull" Leaf="true" Checked="False" />
                                            </Children>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>

                                <ext:Node Text="Kitchen Remodel" IconCls="x-md md-icon-folder">
                                    <Children>
                                        <ext:Node Text="Finish the budget" Leaf="true" Checked="False" />
                                        <ext:Node Text="Call contractors" Leaf="true" Checked="False" />
                                        <ext:Node Text="Choose design" Leaf="true" Checked="False" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                    </Root>

                    <Buttons>
                        <ext:Button runat="server" Text="Close">
                            <Listeners>
                                <Click Handler="#{Field3}.collapse();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>

                    <Listeners>
                        <CheckChange Handler="this.dropDownField.setValue(getTasks(this), false);" />
                    </Listeners>

                </ext:TreePanel>
            </Component>
            <Listeners>
                <Expand Handler="this.component.getRootNode().expand(true);" Single="true" Delay="10" />
            </Listeners>
        </ext:DropDownField>

        <h2>GridPanel with Grouping</h2>

        <ext:DropDownField
            ID="DropDownFieldGrid"
            runat="server"
            Editable="false"
            Width="480">
            <Listeners>
                <Expand Handler="this.picker.setWidth(500);" />
            </Listeners>
            <Component>
                <ext:GridPanel
                    runat="server"
                    Height="480"
                    Title="Plants"
                    Frame="true"
                    ForceFit="true">
                    <Store>
                        <ext:Store ID="Store1" runat="server" GroupField="Light">
                            <Proxy>
                                <ext:AjaxProxy Url="../../../GridPanel/Shared/PlantService.asmx/Plants">
                                    <ActionMethods Read="POST" />
                                    <Reader>
                                        <ext:XmlReader Record="Plant" />
                                    </Reader>
                                </ext:AjaxProxy>
                            </Proxy>
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Common" />
                                        <ext:ModelField Name="Light" />
                                        <ext:ModelField Name="Price" Type="Float" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="Common" Direction="ASC" />
                            </Sorters>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="Common Name" DataIndex="Common" />
                            <ext:Column runat="server" Text="Light" DataIndex="Light" />
                            <ext:Column
                                runat="server"
                                Text="Price"
                                DataIndex="Price"
                                Align="End"
                                Groupable="false">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:ImageCommandColumn runat="server" Align="Center">
                                <Commands>
                                    <ext:ImageCommand IconCls="x-md md-icon-check-circle-outline" CommandName="Pick">
                                        <ToolTip Title="Plant" Text="Click to choose this plant" />
                                    </ext:ImageCommand>
                                </Commands>
                                <Listeners>
                                    <Command Handler="this.gridRef.dropDownField.setValue(record.data.Common);" />
                                </Listeners>
                            </ext:ImageCommandColumn>
                        </Columns>
                    </ColumnModel>

                    <View>
                        <ext:GridView runat="server" LoadMask="true" />
                    </View>

                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>

                    <Features>
                        <ext:Grouping runat="server" HideGroupedHeader="true" StartCollapsed="true" />
                    </Features>
                </ext:GridPanel>
            </Component>
        </ext:DropDownField>
    </form>
</body>
</html>