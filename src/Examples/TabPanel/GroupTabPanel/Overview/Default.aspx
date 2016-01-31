<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GroupTabPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var shortTestMarkup = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.";
    </script>

    <style>
        .custom {
            background-color : gray;
            border : solid 15px gray;
        }
        .custom .x-grouptabs-corner {
            background-image : none;
        }
        
        .custom .x-active-group .x-grouptab-cell {
            background : #DBDBDB;
            border : none !important;
        }

        .custom .x-grouptabbar .x-panel-body  {
            background-color: gray;
        }
        
        .custom .x-grouptab-row .x-active-tab,
        .custom .x-grouptabbar .x-active-tab .x-grid-cell-inner{
            background-color : white;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <p>GroupTabPanel doesn't work.</p>
    <p>There is an <a href="https://github.com/extnet/Ext.NET.Pro/issues/548">Issue</a> opened.</p>
    <p>We are sorry for the inconveniece.</p>
    
    <%--<ext:Viewport runat="server" Layout="FitLayout">
        <Items>
            <ext:Panel runat="server" Layout="FitLayout" Border="false">
                <Items>
                    <ext:GroupTabPanel ID="GroupTabPanel1" runat="server">
                        <Items>
                            <ext:Panel runat="server">
                                <Items>
                                    <ext:Portal 
                                        runat="server" 
                                        Title="Dashboard"
                                        Border="false">
                                        <Items>
                                            <ext:PortalColumn 
                                                runat="server"                                        
                                                ColumnWidth="1">
                                                <Items>
                                                    <ext:Portlet 
                                                        runat="server" 
                                                        Title="Portlet 1" 
                                                        Padding="6"
                                                        Html="={shortTestMarkup}" 
                                                        />
                                            
                                                    <ext:Portlet runat="server" Title="Stock Portlet" Layout="FitLayout" Height="300">
                                                        <Items>
                                                            <ext:UserControlLoader runat="server" Path="StockPortlet.ascx" />    
                                                        </Items>
                                                    </ext:Portlet>

                                                    <ext:Portlet 
                                                        runat="server" 
                                                        Title="Portlet 2" 
                                                        Padding="6"
                                                        Html="={shortTestMarkup}" 
                                                        />
                                                </Items>
                                            </ext:PortalColumn>                                  
                                        </Items>
                                    </ext:Portal>
                            
                                    <ext:UserControlLoader runat="server" Path="Tickets.ascx" />
                            
                                    <ext:Panel 
                                        runat="server" 
                                        Title="Subscriptions" 
                                        Icon="Newspaper" 
                                        StyleSpec="padding: 10px;" 
                                        Border="false"
                                        Layout="Fit">
                                        <Items>
                                            <ext:TabPanel runat="server" ActiveTabIndex="0">
                                                <Items>
                                                    <ext:Panel 
                                                        runat="server" 
                                                        Title="Subscriptions" 
                                                        BodyPadding="5"
                                                        Html="={shortTestMarkup}" 
                                                        />
                                                </Items>
                                            </ext:TabPanel>
                                        </Items>
                                    </ext:Panel>
                                    <ext:Panel
                                        runat="server" 
                                        Title="Users" 
                                        Icon="Group" 
                                        StyleSpec="padding: 10px;"
                                        Html="={shortTestMarkup}" 
                                        />
                                </Items>
                            </ext:Panel>
                            <ext:Panel runat="server">
                                <Items>
                                    <ext:Panel 
                                        runat="server" 
                                        Title="Configuration" 
                                        StyleSpec="padding: 10px;"
                                        Html="={shortTestMarkup}" 
                                        />
                                    <ext:Panel 
                                        runat="server" 
                                        Title="Email Templates" 
                                        Icon="Email"
                                        StyleSpec="padding: 10px;" 
                                        Border="false">
                                        <Items>
                                            <ext:FormPanel runat="server" Title="Form Layout" BodyStyle="padding:15px">
                                                <FieldDefaults LabelWidth="75" LabelPad="20" LabelSeparator="" />
                                                <Defaults>
                                                    <ext:Parameter Name="width" Value="230" />
                                                    <ext:Parameter Name="msgTarget" Value="side" />
                                                </Defaults>
                                                <Items>
                                                    <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" />
                                                    <ext:TextField runat="server" FieldLabel="Last Name" />
                                                    <ext:TextField runat="server" FieldLabel="Company" />
                                                    <ext:TextField runat="server" FieldLabel="Email" Vtype="email" />
                                                </Items>
                                                <Buttons>
                                                    <ext:Button runat="server" Text="Save" />
                                                    <ext:Button runat="server" Text="Cancel" />
                                                </Buttons>
                                            </ext:FormPanel>
                                        </Items>    
                                    </ext:Panel>
                                </Items>
                            </ext:Panel>
                        </Items>                
                    </ext:GroupTabPanel>    
                </Items>

                <BottomBar>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:SplitButton
                                runat="server" 
                                AllowDepress="false"
                                Icon="Tab" 
                                ToggleGroup="group"
                                Pressed="true" 
                                Text="Dashboard">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Tickets" Icon="TagBlue">
                                                <Listeners>
                                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(0) && #{GroupTabPanel1}.setActiveTab(1);" />
                                                </Listeners>
                                            </ext:MenuItem>
                                            <ext:MenuItem runat="server" Text="Subscriptions" Icon="Newspaper">
                                                <Listeners>
                                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(0) && #{GroupTabPanel1}.setActiveTab(2);" />
                                                </Listeners>
                                            </ext:MenuItem>
                                            <ext:MenuItem runat="server" Text="Users" Icon="Group">
                                                <Listeners>
                                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(0) && #{GroupTabPanel1}.setActiveTab(3);" />
                                                </Listeners>
                                            </ext:MenuItem>
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                                <Listeners>
                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(0) && #{GroupTabPanel1}.setActiveTab(0);" />
                                </Listeners>
                            </ext:SplitButton>
                            <ext:ToolbarSpacer runat="server" />
                            <ext:SplitButton 
                                ID="Group2Btn" 
                                AllowDepress="false"
                                runat="server" 
                                Icon="Tab" 
                                ToggleGroup="group" 
                                Text="Configuration">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Email Templates" Icon="Email">
                                                <Listeners>
                                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(1) && #{GroupTabPanel1}.setActiveTab(1);" />
                                                </Listeners>
                                            </ext:MenuItem>
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                                <Listeners>
                                    <Click Handler="#{GroupTabPanel1}.setActiveGroup(1) && #{GroupTabPanel1}.setActiveTab(0);" />
                                </Listeners>
                            </ext:SplitButton>
                            <ext:ToolbarFill runat="server" />
                            <ext:Button ID="Button1" runat="server" Text="Set Custom Css Class" Icon="BulletBlue">
                                <Listeners>
                                    <Click Handler="#{GroupTabPanel1}.addCls('custom'); this.disable(); #{Button2}.enable();" />
                                </Listeners>
                            </ext:Button>
                            
                            <ext:Button ID="Button2" runat="server" Text="Remove Customer Css Class" Disabled="true" Icon="BulletBlack">
                                <Listeners>
                                    <Click Handler="#{GroupTabPanel1}.removeCls('custom'); this.disable(); #{Button1}.enable();" />
                                </Listeners>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </BottomBar>
            </ext:Panel>
        </Items>
    </ext:Viewport>--%>
</body>
</html>