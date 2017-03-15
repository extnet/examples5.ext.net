<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Ext.Net.Examples" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.ResourceManager1.DirectEventUrl = "/";

            Theme theme = Ext.Net.Theme.Crisp;

            if (this.Session["Ext.Net.Theme"] != null)
            {
                theme = (Theme)this.Session["Ext.Net.Theme"];
            }

            ((Ext.Net.CheckMenuItem)this.FindControl(theme.ToString() + "ThemeItem")).Checked = true;

            this.TriggerField1.Focus();
            this.CheckMenuItemScriptMode.Checked = Convert.ToBoolean(this.Session["Ext.Net.SourceFormatting"]);

            ResourceManager.RegisterControlResources<TagLabel>();

            if (this.Request.QueryString["clearExamplesCache"] != null)
            {
                this.Page.Cache.Remove("ExamplesTreeNodes");
            }
        }
    }

    protected void GetExamplesNodes(object sender, NodeLoadEventArgs e)
    {
        if (e.NodeID == "Root")
        {
            Ext.Net.NodeCollection nodes = this.Page.Cache["ExamplesTreeNodes"] as Ext.Net.NodeCollection;

            if (nodes == null)
            {
                nodes = UIHelpers.BuildTreeNodes(false);
                this.Page.Cache.Add("ExamplesTreeNodes", nodes, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration, CacheItemPriority.Default, null);
            }

            e.Nodes = nodes;
        }
    }

    [DirectMethod]
    public static int GetHashCode(string s)
    {
        return Math.Abs("/Examples".ConcatWith(s).ToLower().GetHashCode());
    }

    [DirectMethod]
    public void SetTheme(string theme)
    {
        if (theme == "Blue")
        {
            theme = "Default";
        }

        theme = theme.Replace(" ", "");
        this.Session["Ext.Net.Theme"] = (Theme)Enum.Parse(typeof(Theme), theme);
    }

    [DirectMethod]
    public void ChangeScriptMode(bool debug)
    {
        if (debug)
        {
            this.Session["Ext.Net.ScriptMode"] = Ext.Net.ScriptMode.Debug;
            this.Session["Ext.Net.SourceFormatting"] = true;
        }
        else
        {
            this.Session["Ext.Net.ScriptMode"] = Ext.Net.ScriptMode.Release;
            this.Session["Ext.Net.SourceFormatting"] = false;
        }

        this.Response.Redirect("");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples - ASP.NET (Web Forms + MVC) component framework integrating the cross-browser Sencha Ext JS JavaScript Library.</title>
    <link rel="stylesheet" href="resources/css/main.css?v=1.0.5" />
    <link rel="shortcut icon" href="favicon.ico" />

    <script src="resources/js/main.js"></script>

    <script>
        // A workaround for the GitHub issue #915
        Ext.data.TreeModel.override({
            expand: function () {
                if (this.data.visible) {
                    this.callParent(arguments);
                }
            }
        });
    </script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Crisp" />

    <ext:History runat="server">
        <Listeners>
            <Change Fn="change" />
        </Listeners>
    </ext:History>

    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel
                runat="server"
                Header="false"
                Region="North"
                Border="false"
                Height="90">
                <Content>
                    <header class="site-header" role="banner">
                        <nav class="top-navigation">
                            <div class="logo-container">
                                <img src="resources/images/ext.net-logo.png" />
                            </div>
                            <div class="navigation-bar">
                                <h1 class="nav-title">
                                    Examples Explorer
                                    <span>(3.3.0)</span>
                                </h1>
                                <ul id="nav-menu" class="nav-menu">
                                    <li>
                                        <div class="menu-button"><span class="f-icon-reorder"></span></div>
                                        <ul>
                                            <li><a href="http://examples.ext.net/">Web Forms Examples (v4)</a></li>
                                            <li><a href="http://mvc.ext.net/">MVC Examples (v4)</a></li>
                                            <li class="separator"></li>
                                            <li><a href="http://examples3.ext.net/">Web Forms Examples (v3)</a></li>
                                            <li><a href="http://mvc3.ext.net/">MVC Examples (v3)</a></li>
                                            <li class="separator"></li>
                                            <li><a href="http://examples2.ext.net/">Web Forms Examples (v2)</a></li>
                                            <li><a href="http://mvc2.ext.net/">MVC Examples (v2)</a></li>
                                            <li class="separator"></li>
                                            <li><a href="http://examples1.ext.net/">Web Forms Examples (v1)</a></li>
                                            <li class="separator"></li>
                                            <li><a href="http://docs.sencha.com/extjs/5.1">EXT JS Documentation</a></li>
                                            <li><a href="http://docs.ext.net/">Ext.NET Documentation</a></li>
                                            <li class="separator"></li>
                                            <li><a href="http://forums.ext.net/">Community Forums</a></li>
                                            <li><a href="http://ext.net/faq/">FAQ</a></li>
                                            <li><a href="http://ext.net/contact/">Contact</a></li>
                                            <li><a href="http://ext.net/">Ext.NET Home</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </header>
                </Content>
            </ext:Panel>
            <ext:Panel
                runat="server"
                Region="West"
                Layout="Fit"
                Width="240"
                Header="false"
                Collapsible="true"
                Split="true"
                CollapseMode="Mini"
                MarginSpec="0 0 4 4"
                Border="false">
                <Items>
                    <ext:TreePanel
                        ID="exampleTree"
                        runat="server"
                        Header="false"
                        AutoScroll="true"
                        Lines="false"
                        UseArrows="true"
                        CollapseFirst="false"
                        RootVisible="false"
                        Animate="false"
                        HideHeaders="true">
                        <TopBar>
                            <ext:Toolbar runat="server">
                                <Items>
                                    <ext:TextField
                                        ID="TriggerField1"
                                        runat="server"
                                        EnableKeyEvents="true"
                                        Flex="1"
                                        EmptyText="Filter Examples..."
                                        RemoveClearTrigger="true">
                                        <Triggers>
                                            <ext:FieldTrigger Icon="Clear" Hidden="true" />
                                        </Triggers>
                                        <Listeners>
                                            <KeyUp Fn="keyUp" Buffer="500" />
                                            <TriggerClick Fn="clearFilter" />
                                            <SpecialKey Fn="filterSpecialKey" Delay="1" />
                                        </Listeners>
                                    </ext:TextField>

                                    <ext:Button runat="server" Icon="Cog" ToolTip="Options">
                                        <Menu>
                                            <ext:Menu runat="server">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Expand All" IconCls="icon-expand-all">
                                                        <Listeners>
                                                            <Click Handler="#{exampleTree}.expandAll(false);" />
                                                        </Listeners>
                                                    </ext:MenuItem>

                                                    <ext:MenuItem runat="server" Text="Collapse All" IconCls="icon-collapse-all">
                                                        <Listeners>
                                                            <Click Handler="#{exampleTree}.collapseAll(false);" />
                                                        </Listeners>
                                                    </ext:MenuItem>

                                                    <ext:MenuSeparator runat="server" />

                                                    <ext:CheckMenuItem runat="server" Text="NEW Only">
                                                        <Listeners>
                                                            <CheckChange Fn="filterNewExamples" />
                                                        </Listeners>
                                                    </ext:CheckMenuItem>

                                                    <ext:CheckMenuItem
                                                        ID="CheckMenuItemScriptMode"
                                                        runat="server"
                                                        Text="Debug Mode">
                                                        <Listeners>
                                                            <CheckChange Handler="App.direct.ChangeScriptMode(checked);" />
                                                        </Listeners>
                                                    </ext:CheckMenuItem>

                                                    <ext:MenuSeparator runat="server" />

                                                    <ext:MenuItem runat="server" Text="Theme" Icon="Paintcan">
                                                        <Menu>
                                                            <ext:Menu runat="server">
                                                                <Items>
                                                                    <ext:CheckMenuItem ID="AriaThemeItem" runat="server" Text="Aria" Group="theme" />
                                                                    <ext:CheckMenuItem ID="DefaultThemeItem" runat="server" Text="Blue" Group="theme" />
                                                                    <ext:CheckMenuItem ID="GrayThemeItem" runat="server" Text="Gray" Group="theme" />
                                                                    <ext:CheckMenuItem ID="CrispThemeItem" runat="server" Text="Crisp" Group="theme" />
                                                                    <ext:CheckMenuItem ID="CrispTouchThemeItem" runat="server" Text="Crisp Touch" Group="theme" />
                                                                    <ext:CheckMenuItem ID="NeptuneThemeItem" runat="server" Text="Neptune" Group="theme" />
                                                                    <ext:CheckMenuItem ID="NeptuneTouchThemeItem" runat="server" Text="Neptune Touch" Group="theme" />
                                                                </Items>
                                                                <Listeners>
                                                                    <Click Fn="themeChange" />
                                                                </Listeners>
                                                            </ext:Menu>
                                                        </Menu>
                                                    </ext:MenuItem>

                                                    <ext:MenuSeparator runat="server" />

                                                    <ext:MenuItem runat="server" Text="Search by" Icon="Find">
                                                        <Menu>
                                                            <ext:Menu runat="server">
                                                                <Items>
                                                                    <ext:CheckMenuItem
                                                                        ID="SearchByTitles"
                                                                        runat="server"
                                                                        Checked="true"
                                                                        Text="Titles" />

                                                                    <ext:CheckMenuItem
                                                                        ID="SearchByTags"
                                                                        runat="server"
                                                                        Checked="true"
                                                                        Text="Tags" />
                                                                </Items>
                                                            </ext:Menu>
                                                        </Menu>
                                                    </ext:MenuItem>

                                                    <ext:MenuItem runat="server" Text="Tag Cloud" Icon="WeatherClouds">
                                                        <Listeners>
                                                            <Click Fn="showTagCloud" />
                                                        </Listeners>
                                                    </ext:MenuItem>
                                                </Items>
                                            </ext:Menu>
                                        </Menu>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>

                        <Store>
                            <ext:TreeStore runat="server" OnReadData="GetExamplesNodes">
                                <Proxy>
                                    <ext:PageProxy>
                                        <RequestConfig Method="GET" Type="Load" />
                                    </ext:PageProxy>
                                </Proxy>
                                <Root>
                                    <ext:Node NodeID="Root" Expanded="true" />
                                </Root>
                                <Fields>
                                    <ext:ModelField Name="tags" />
                                    <ext:ModelField Name="isNew" />
                                </Fields>
                            </ext:TreeStore>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:TreeColumn runat="server" DataIndex="text" Flex="1">
                                    <Renderer Fn="treeRenderer" />
                                </ext:TreeColumn>
                            </Columns>
                        </ColumnModel>
                        <Listeners>
                            <ItemClick Handler="onTreeItemClick(record, e);" />
                            <AfterRender Fn="onTreeAfterRender" />
                        </Listeners>
                    </ext:TreePanel>
                </Items>
            </ext:Panel>
            <ext:TabPanel
                ID="ExampleTabs"
                runat="server"
                Region="Center"
                MarginSpec="0 4 4 0"
                Cls="tabs"
                MinTabWidth="115">
                <Items>
                    <ext:Panel
                        ID="tabHome"
                        runat="server"
                        Title="Home"
                        HideMode="Offsets"
                        Icon="Application">
                        <Loader runat="server" Mode="Frame" Url="Home/">
                            <LoadMask ShowMask="true" />
                        </Loader>
                    </ext:Panel>
                </Items>
                <Listeners>
                    <TabChange Fn="addToken" />
                </Listeners>
                <Plugins>
                    <ext:TabCloseMenu runat="server" />
                </Plugins>
            </ext:TabPanel>
        </Items>
    </ext:Viewport>

    <ext:Window
        ID="LinkWindow"
        runat="server"
        Modal="true"
        Hidden="true"
        Icon="Link"
        Layout="absolute"
        Width="400"
        Height="110"
        Title="Direct Link"
        Closable="false"
        Resizable="false">
        <Items>
            <ext:TextField
                ID="exampleLink"
                runat="server"
                Width="364"
                Cls="dlText"
                X="10"
                Y="10"
                SelectOnFocus="true"
                ReadOnly="true" />
        </Items>
        <Listeners>
            <Show Handler="exampleLink.setValue(this.exampleName);" />
        </Listeners>
        <Buttons>
            <ext:Button
                runat="server"
                Text=" Open"
                Icon="ApplicationDouble">
                <Listeners>
                    <Click Handler="window.open(LinkWindow.exampleName);" />
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Title="Open Example in the separate window" />
                </ToolTips>
            </ext:Button>
            <ext:Button
                runat="server"
                Text=" Open (Direct)"
                Icon="ApplicationGo">
                <Listeners>
                    <Click Handler="window.open(LinkWindow.exampleUrl, '_blank');" />
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Title="Open Example in the separate window using a direct link" />
                </ToolTips>
            </ext:Button>
            <ext:Button runat="server" Text="Close">
                <Listeners>
                    <Click Handler="this.findParentByType('window').hide(null);" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
</body>
</html>
