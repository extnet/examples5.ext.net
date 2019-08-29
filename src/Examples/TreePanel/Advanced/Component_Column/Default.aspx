<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with ComponentColumn - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel with ComponentColumn</h1>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Title="My Task List"
            Icon="Accept"
            Height="400"
            Width="350"
            UseArrows="true"
            Scrollable="Both"
            Animate="true"
            HideHeaders="true"
            RootVisible="false">
            <Root>
                <ext:Node>
                    <Children>
                        <ext:Node Text="To Do" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Go jogging" Leaf="true" />
                                <ext:Node Text="Take a nap" Leaf="true" />
                                <ext:Node Text="Clean house" Leaf="true" />
                            </Children>
                        </ext:Node>

                        <ext:Node Text="Grocery List" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Bananas" Leaf="true" />
                                <ext:Node Text="Milk" Leaf="true" />
                                <ext:Node Text="Cereal" Leaf="true" />

                                <ext:Node Text="Energy foods" Icon="Folder" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Coffee" Leaf="true" />
                                        <ext:Node Text="Red Bull" Leaf="true" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>

                        <ext:Node Text="Kitchen Remodel" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Finish the budget" Leaf="true" />
                                <ext:Node Text="Call contractors" Leaf="true" />
                                <ext:Node Text="Choose design" Leaf="true" />
                            </Children>
                        </ext:Node>
                    </Children>
                </ext:Node>
            </Root>

            <ColumnModel>
                <Columns>
                    <ext:TreeColumn runat="server" Flex="1" DataIndex="text" />
                    <ext:ComponentColumn runat="server" Width="120">
                        <Component>
                            <ext:ProgressBar runat="server" Text="Progress" />
                        </Component>
                        <Listeners>
                            <BeforeBind Handler="return e.record.data.leaf;" />
                            <Bind Handler="cmp.setValue(Math.random());" />
                        </Listeners>
                    </ext:ComponentColumn>
                </Columns>
            </ColumnModel>

         </ext:TreePanel>
    </form>
</body>
</html>