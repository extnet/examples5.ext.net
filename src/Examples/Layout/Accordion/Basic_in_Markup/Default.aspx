<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AccordionLayout in Markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Accordion Layout in Markup</h1>

    <ext:Window
        runat="server"
        Title="Accordion"
        Width="250"
        Height="400"
        Maximizable="true"
        BodyBorder="0"
        Icon="ApplicationTileVertical"
        Layout="Accordion">
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Button runat="server" Icon="Connect">
                        <ToolTips>
                            <ext:ToolTip
                                runat="server"
                                Title="Rich ToolTips"
                                Html="Let your users know what they can do!" />
                        </ToolTips>
                    </ext:Button>
                    <ext:Button ID="Button2" runat="server" Icon="UserAdd" />
                    <ext:Button ID="Button3" runat="server" Icon="UserDelete" />
                </Items>
            </ext:Toolbar>
        </TopBar>
        <Items>
            <ext:TreePanel runat="server" Title="Online Users" RootVisible="false">
                <Tools>
                    <ext:Tool Type="Refresh" Handler="Ext.Msg.alert('Message','Refresh Tool Clicked!');" />
                </Tools>
                <Root>
                    <ext:Node Text="Root">
                        <Children>
                            <ext:Node Text="Friends" Expanded="true">
                                <Children>
                                    <ext:Node Text="George" Icon="User" Leaf="True" />
                                    <ext:Node Text="Brian" Icon="User" Leaf="True" />
                                    <ext:Node Text="Jon" Icon="User" Leaf="True" />
                                    <ext:Node Text="Tim" Icon="User" Leaf="True" />
                                    <ext:Node Text="Brent" Icon="User" Leaf="True" />
                                    <ext:Node Text="Fred" Icon="User" Leaf="True" />
                                    <ext:Node Text="Bob" Icon="User" Leaf="True" />
                                </Children>
                            </ext:Node>
                            <ext:Node Text="Family" Expanded="true">
                                <Children>
                                    <ext:Node Text="Kelly" Icon="UserFemale" Leaf="True" />
                                    <ext:Node Text="Sara" Icon="UserFemale" Leaf="True" />
                                    <ext:Node Text="Zack" Icon="UserGreen" Leaf="True" />
                                    <ext:Node Text="John" Icon="UserGreen" Leaf="True" />
                                </Children>
                            </ext:Node>
                        </Children>
                    </ext:Node>
                </Root>
            </ext:TreePanel>
            <ext:Panel runat="server" Title="Settings" />
            <ext:Panel runat="server" Title="Even More Stuff" />
            <ext:Panel runat="server" Title="My Stuff" />
        </Items>
    </ext:Window>
</body>
</html>