<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Reorderable Toolbars - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Reorderable Toolbars</h1>

        <p>This toolbar has the Ext.ux.ToolbarReorderer plugin applied to it.</p>

        <p>Each item in the Toolbar has an optional 'reorderable' property, which will make the button draggable if set to true. In this example the 4 rightmost buttons are reorderable.</p>

        <ext:Toolbar runat="server" Width="960">
            <Plugins>
                <ext:BoxReorderer runat="server" DefaultReorderable="true">
                    <Listeners>
                        <Drop Handler="var sb = [];
                                       container.items.each(function (item) {
                                           sb.push(item.text);
                                       });
                                       #{Label1}.setText(sb.join(', '));" />
                    </Listeners>
                </ext:BoxReorderer>
            </Plugins>

            <Items>
                <ext:SplitButton ID="SplitButton1" runat="server" Text="Menu Button" Icon="Add" Reorderable="false">
                    <Menu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:MenuItem runat="server" Text="Menu Item 1" />
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:SplitButton>

                <ext:SplitButton ID="SplitButton2" runat="server" Text="Cut" Icon="Add">
                    <Menu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:MenuItem runat="server" Text="Cut Menu Item" />
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:SplitButton>

                <ext:Button ID="Button1" runat="server" Text="Copy" Icon="Add" />

                <ext:Button ID="Button2" runat="server" Text="Paste" Icon="Add">
                    <Menu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:MenuItem runat="server" Text="Paste Menu Item" />
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
                <ext:Button ID="Button3" runat="server" Text="Format" Icon="Add" />
            </Items>
        </ext:Toolbar>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>