<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Layout Toolbar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" Theme="Gray" />

    <p>The example is designed for the classic themes - Gray and Blue.</p>
    <p>It might require adjusting for other themes such as Crisp, Neptune, Triton, or Spotless.</p>

    <h2>Vertical Flat Toolbar</h2>

    <ext:Toolbar runat="server" Layout="Container" Width="25" Flat="true">
        <Items>
            <ext:Button runat="server" Icon="Accept" />
            <ext:Button runat="server" Icon="Add" />
            <ext:Button runat="server" Icon="Application" />
            <ext:Button runat="server" Icon="Bell" />
            <ext:Button runat="server" Icon="Bomb" />
        </Items>
    </ext:Toolbar>

    <h2>Table Toolbar</h2>

    <ext:Panel runat="server" Title="Panel" Height="180" Width="360">
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Toolbar runat="server" Width="109" Flat="false" Layout="Table">
                        <LayoutConfig>
                            <ext:TableLayoutConfig Columns="3" />
                        </LayoutConfig>
                        <Defaults>
                            <ext:Parameter Name="width" Value="33" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="1" StandOut="true" />
                            <ext:Button runat="server" Text="2" StandOut="true" />
                            <ext:Button runat="server" Text="3" StandOut="true" />
                            <ext:Button runat="server" Text="4" StandOut="true" />
                            <ext:Button runat="server" Text="5" StandOut="true" />
                            <ext:Button runat="server" Text="6" StandOut="true" />
                            <ext:Button runat="server" Text="7" StandOut="true" />
                            <ext:Button runat="server" Text="8" StandOut="true" />
                            <ext:Button runat="server" Text="9" StandOut="true" />
                        </Items>
                    </ext:Toolbar>

                    <ext:ToolbarSeparator runat="server" />

                    <ext:Toolbar runat="server" Width="109" Flat="false" Layout="Table">
                        <LayoutConfig>
                            <ext:TableLayoutConfig Columns="3" />
                        </LayoutConfig>
                        <Defaults>
                            <ext:Parameter Name="width" Value="33" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="1" StandOut="true" />
                            <ext:Button runat="server" Text="2" StandOut="true" />
                            <ext:Button runat="server" Text="3" StandOut="true" />
                            <ext:Button runat="server" Text="4" StandOut="true" Width="103" ColSpan="3" />
                            <ext:Button runat="server" Text="5" StandOut="true" />
                            <ext:Button runat="server" Text="6" StandOut="true" />
                            <ext:Button runat="server" Text="7" StandOut="true" />
                        </Items>
                    </ext:Toolbar>

                    <ext:ToolbarSeparator runat="server" />

                    <ext:Toolbar runat="server" Width="105" Flat="false" Layout="Table">
                        <LayoutConfig>
                            <ext:TableLayoutConfig Columns="1" />
                        </LayoutConfig>
                        <Defaults>
                            <ext:Parameter Name="width" Value="99" Mode="Raw" />
                        </Defaults>
                        <Items>
                            <ext:Button runat="server" Text="1" Icon="BulletTick" />
                            <ext:Button runat="server" Text="2" Icon="BulletTick" />
                            <ext:Button runat="server" Text="3" Icon="BulletTick" />
                        </Items>
                    </ext:Toolbar>
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Panel>

    <h2>Vertical Toolbar In Panel</h2>

    <ext:Panel
        runat="server"
        Title="Vertical Toolbar"
        Width="360"
        Height="180"
        BodyPadding="18"
        Html="Your Content">
        <DockedItems>
            <ext:Toolbar runat="server" Dock="Left" Vertical="true">
                <Items>
                    <ext:Button runat="server" Icon="Accept" />
                    <ext:Button runat="server" Icon="Add" />
                    <ext:Button runat="server" Icon="Application" />
                    <ext:Button runat="server" Icon="Bell" />
                    <ext:Button runat="server" Icon="Bomb" />
                </Items>
            </ext:Toolbar>
        </DockedItems>
    </ext:Panel>

    <h2>Multiple Toolbars</h2>

    <ext:Panel runat="server" Title="Panel" Width="360" Height="180">
        <DockedItems>
            <ext:Toolbar runat="server" Dock="Top">
                <Items>
                    <ext:Button runat="server" Icon="Accept" />
                    <ext:Button runat="server" Icon="Add" />
                    <ext:Button runat="server" Icon="Application" />
                    <ext:Button runat="server" Icon="Bell" />
                    <ext:Button runat="server" Icon="Bomb" />
                </Items>
            </ext:Toolbar>

            <ext:Toolbar runat="server" Dock="Top">
                <Items>
                    <ext:Button runat="server" Icon="Accept" />
                    <ext:Button runat="server" Icon="Add" />
                    <ext:Button runat="server" Icon="Application" />
                    <ext:Button runat="server" Icon="Bell" />
                    <ext:Button runat="server" Icon="Bomb" />
                </Items>
            </ext:Toolbar>

            <ext:Toolbar runat="server" Dock="Top">
                <Items>
                    <ext:Button runat="server" Icon="Accept" />
                    <ext:Button runat="server" Icon="Add" />
                    <ext:Button runat="server" Icon="Application" />
                    <ext:Button runat="server" Icon="Bell" />
                    <ext:Button runat="server" Icon="Bomb" />
                </Items>
            </ext:Toolbar>
        </DockedItems>
    </ext:Panel>
</body>
</html>