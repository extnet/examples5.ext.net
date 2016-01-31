<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toolbar Switcher - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>
        var toogle = function (toolbar) {
            Ext.select('.toolbar-switch').each(function (t) {
                Ext.getCmp(t.dom.id).hide();
            });
            
            toolbar.show();
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h2>Toolbar Switcher</h2>
    
    <p>Click on any of the first three flags to change region</p>  
    
    <ext:Panel ID="Panel1" runat="server" Title="Regions" Height="250" Width="750">
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>                        
                    <ext:Button 
                        runat="server" 
                        Icon="FlagBlue" 
                        ToggleGroup="region" 
                        Pressed="true" 
                        ToolTip="Europe">
                        <Listeners>
                            <Click Handler="toogle(#{EuropeToolbar});" />
                        </Listeners>
                    </ext:Button>
                    
                    <ext:Button 
                        runat="server" 
                        Icon="FlagRed" 
                        ToggleGroup="region"
                        ToolTip="North America">
                        <Listeners>
                            <Click Handler="toogle(#{NorthAmericaToolbar});" />
                        </Listeners>
                    </ext:Button>
                    
                    <ext:Button 
                        runat="server" 
                        Icon="FlagWhite" 
                        ToggleGroup="region"
                        ToolTip="Asia">
                        <Listeners>
                            <Click Handler="toogle(#{AsiaToolbar});" />
                        </Listeners>
                    </ext:Button>
                    
                    <ext:ToolbarSeparator runat="server" />
                    
                    <ext:Toolbar ID="EuropeToolbar" runat="server" Flat="true" Cls="toolbar-switch" Flex="1">
                        <Items>
                            <ext:ToolbarTextItem runat="server" Text="Europe" />
                            <ext:ToolbarSpacer runat="server" />
                            <ext:ButtonGroup runat="server">
                                <Items>
                                    <ext:Button runat="server" Icon="FlagDk" Text="Denmark" />
                                    <ext:Button runat="server" Icon="FlagFr" Text="France" />
                                    <ext:Button runat="server" Icon="FlagFi" Text="Finland" />
                                    <ext:Button runat="server" Icon="FlagDe" Text="Germany" />
                                    <ext:Button runat="server" Icon="FlagSe" Text="Sweden" />
                                    <ext:Button runat="server" Icon="FlagGb" Text="UK" />
                                </Items>                                
                            </ext:ButtonGroup>
                        </Items>
                    </ext:Toolbar>
                    
                    <ext:Toolbar ID="NorthAmericaToolbar" runat="server" Flat="true" HideMode="Offsets" Hidden="true" Cls="toolbar-switch" Flex="1">
                        <Items>
                            <ext:ToolbarTextItem runat="server" Text="North America" />
                            <ext:ToolbarSpacer runat="server" />
                            <ext:ButtonGroup runat="server">
                                <Items>
                                    <ext:Button runat="server" Icon="FlagCa" Text="Canada" />
                                    <ext:Button runat="server" Icon="FlagUs" Text="United States of America" />
                                    <ext:Button runat="server" Icon="FlagMx" Text="Mexico" />    
                                </Items>                                
                            </ext:ButtonGroup>
                        </Items>
                    </ext:Toolbar>
                    
                    <ext:Toolbar ID="AsiaToolbar" runat="server" Flat="true" HideMode="Offsets" Hidden="true" Cls="toolbar-switch" Flex="1">
                        <Items>
                            <ext:ToolbarTextItem runat="server" Text="Asia" />
                            <ext:ToolbarSpacer runat="server" />
                            <ext:ButtonGroup runat="server">
                                <Items>
                                    <ext:Button runat="server" Icon="FlagCn" Text="China" />
                                    <ext:Button runat="server" Icon="FlagIn" Text="India" />
                                    <ext:Button runat="server" Icon="FlagJp" Text="Japan" />
                                    <ext:Button runat="server" Icon="FlagKr" Text="Republic of Korea" />
                                </Items>
                            </ext:ButtonGroup>
                        </Items>
                    </ext:Toolbar>
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Panel>
</body>
</html>