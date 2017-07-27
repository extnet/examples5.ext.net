<%@ Page Language="C#" %>

<script runat="server">
    protected void SetValueClick(object sender, DirectEventArgs e)
    {
        this.Field1.SetValue("Item11,Item12", "[Go jogging,Take a nap]");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DropDownField ValueText Mode - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var getValues = function (tree) {
            var msg = [],
                selNodes = tree.getChecked();

            Ext.each(selNodes, function (node) {
                msg.push(node.data.id);
            });

            return msg.join(",");
        };

        var getText = function (tree) {
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

        var syncValue = function (value) {
            var tree = this.component;

            var ids = value.split(",");
            tree.setChecked({ids: ids, silent: true});

            tree.getSelectionModel().deselectAll();
            Ext.each(ids, function (id) {
                var node = tree.store.getNodeById(id);

                if (node) {
                    tree.getSelectionModel().select(node, true);
                }
            }, this);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DropDownField ValueText Mode</h1>

        <ext:Container runat="server" Width="350" Height="500">
            <Items>
                <ext:DropDownField
                    ID="Field1"
                    runat="server"
                    UnderlyingValue="Item22,Item23"
                    Text="[Milk,Cereal]"
                    Editable="false"
                    Width="300"
                    TriggerIcon="SimpleArrowDown"
                    Mode="ValueText">
                    <Component>
                        <ext:TreePanel
                            runat="server"
                            Title="My Task List"
                            Icon="Accept"
                            Height="300"
                            Width="300"
                            Shadow="false"
                            UseArrows="true"
                            AutoScroll="true"
                            Animate="true"
                            EnableDD="true"
                            ContainerScroll="true"
                            RootVisible="false">
                            <Root>
                                <ext:Node>
                                    <Children>
                                        <ext:Node Text="To Do" Icon="Folder">
                                            <Children>
                                                <ext:Node NodeID="Item11" Text="Go jogging" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item12" Text="Take a nap" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item13" Text="Clean house" Leaf="true" Checked="False" />
                                            </Children>
                                        </ext:Node>
                                        <ext:Node Text="Grocery List" Icon="Folder">
                                            <Children>
                                                <ext:Node NodeID="Item21" Text="Bananas" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item22" Text="Milk" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item23" Text="Cereal" Leaf="true" Checked="False" />

                                                <ext:Node Text="Energy foods" Icon="Folder">
                                                    <Children>
                                                        <ext:Node NodeID="Item241" Text="Coffee" Leaf="true" Checked="False" />
                                                        <ext:Node NodeID="Item242" Text="Red Bull" Leaf="true" Checked="False" />
                                                    </Children>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                        <ext:Node Text="Kitchen Remodel" Icon="Folder">
                                            <Children>
                                                <ext:Node NodeID="Item31" Text="Finish the budget" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item32" Text="Call contractors" Leaf="true" Checked="False" />
                                                <ext:Node NodeID="Item33" Text="Choose design" Leaf="true" Checked="False" />
                                            </Children>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Root>
                            <Buttons>
                                <ext:Button runat="server" Text="Close">
                                    <Listeners>
                                        <Click Handler="#{Field1}.collapse();" />
                                    </Listeners>
                                </ext:Button>
                            </Buttons>
                            <Listeners>
                                <CheckChange Handler="this.dropDownField.setValue(getValues(this), getText(this), false);" />
                            </Listeners>
                            <SelectionModel>
                                <ext:TreeSelectionModel runat="server" Mode="Multi" />
                            </SelectionModel>
                            </ext:TreePanel>
                    </Component>
                    <Listeners>
                        <Expand Handler="this.component.getRootNode().expand(true);" Single="true" Delay="20" />
                    </Listeners>
                    <SyncValue Fn="syncValue" />
                </ext:DropDownField>

                <ext:Container runat="server" Layout="HBox">
                    <Items>
                        <ext:Button runat="server" Text="Show Value">
                            <Listeners>
                                <Click Handler="alert(#{Field1}.getValue());" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Show Text">
                            <Listeners>
                                <Click Handler="alert(#{Field1}.getText());" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Set Value">
                            <DirectEvents>
                                <Click OnEvent="SetValueClick" />
                            </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Container>
   </form>
</body>
</html>