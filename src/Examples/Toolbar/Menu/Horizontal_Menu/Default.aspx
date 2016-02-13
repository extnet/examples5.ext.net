<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Horizontal Menu - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .horizontal-menu .x-menu-item-link {
            line-height: 20px;
        }

        .horizontal-menu .x-menu-item-arrow
        {
            display:none;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h2>Horizontal Menu</h2>

    <p>Demonstrates how to organize the horizontal menu</p>

    <ext:Menu
        runat="server"
        Floating="false"
        Layout="HBoxLayout"
        ShowSeparator="false"
        Cls="horizontal-menu">
        <Defaults>
            <ext:Parameter Name="MenuAlign" Value="tl-bl?" Mode="Value" />
        </Defaults>
        <Items>
            <ext:MenuItem runat="server" Text="Item 1" Icon="BulletBlue">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem Text="Item 1.1" />
                            <ext:MenuItem Text="Item 1.2" />
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:MenuItem>
            <ext:MenuItem runat="server" Text="Item 2" Icon="BulletBlue">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem Text="Item 2.1" />
                            <ext:MenuItem Text="Item 2.2" />
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:MenuItem>
            <ext:MenuItem runat="server" Text="Item 3" Icon="BulletBlue">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem Text="Item 3.1" />
                            <ext:MenuItem Text="Item 3.2" />
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:MenuItem>
            <ext:MenuItem runat="server" Text="Item 4" Icon="BulletBlue">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem Text="Item 4.1" />
                            <ext:MenuItem Text="Item 4.2" />
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:MenuItem>
        </Items>
    </ext:Menu>
</body>
</html>