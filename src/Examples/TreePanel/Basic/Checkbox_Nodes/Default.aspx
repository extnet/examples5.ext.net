<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with Checkbox Enabled Children - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .complete .x-grid-cell-inner {
            text-decoration : line-through;
            color : #777;
        }
    </style>

    <script>
        var getTasks = function () {
            var msg = "",
                selChildren = App.TreePanel1.getChecked();

            Ext.each(selChildren, function (node) {
                if (msg.length > 0) {
                    msg += ", ";
                }

                msg += node.data.text;
            });

            Ext.Msg.show({
                title    : "Completed Tasks",
                msg      : msg.length > 0 ? msg : "None",
                icon     : Ext.Msg.INFO,
                minWidth : 200,
                buttons  : Ext.Msg.OK
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel with Checkbox Enabled Children</h1>

        <p>This example demonstrates a simple checkbox selection in a TrePanel. The Checkbox is enabled on leaf Children by simply setting Checked="true/false" at the node level.</p>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Title="My Task List"
            Icon="Accept"
            Height="480"
            Width="250"
            UseArrows="true"
            Scrollable="Both"
            Animate="true"
            RootVisible="false">
            <Root>
                <ext:Node>
                    <Children>
                        <ext:Node Text="To Do" Icon="Folder">
                            <Children>
                                <ext:Node Text="Go jogging" Leaf="true" Checked="False" />
                                <ext:Node Text="Take a nap" Leaf="true" Checked="False" />
                                <ext:Node Text="Clean house" Leaf="true" Checked="False" />
                            </Children>
                        </ext:Node>

                        <ext:Node Text="Grocery List" Icon="Folder">
                            <Children>
                                <ext:Node Text="Bananas" Leaf="true" Checked="False" />
                                <ext:Node Text="Milk" Leaf="true" Checked="False" />
                                <ext:Node Text="Cereal" Leaf="true" Checked="False" />

                                <ext:Node Text="Energy foods" Icon="Folder">
                                    <Children>
                                        <ext:Node Text="Coffee" Leaf="true" Checked="False" />
                                        <ext:Node Text="Red Bull" Leaf="true" Checked="False" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>

                        <ext:Node Text="Kitchen Remodel" Icon="Folder">
                            <Children>
                                <ext:Node Text="Finish the budget" Leaf="true" Checked="False" />
                                <ext:Node Text="Call contractors" Leaf="true" Checked="False" />
                                <ext:Node Text="Choose design" Leaf="true" Checked="False" />
                            </Children>
                        </ext:Node>
                    </Children>
                </ext:Node>
            </Root>

            <Listeners>
                <CheckChange Handler="var node = Ext.get(this.getView().getNode(item));
                                      node[checked ? 'addCls' : 'removeCls']('complete')" />
                <Render Handler="this.getRootNode().expand(true);" Delay="50" />
            </Listeners>

            <Buttons>
                <ext:Button runat="server" Text="Get Completed Tasks">
                    <Listeners>
                        <Click Fn="getTasks" />
                    </Listeners>
                </ext:Button>
            </Buttons>

         </ext:TreePanel>
    </form>
</body>
</html>