<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Ext.Net.Examples" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.ResourceManager1.DirectEventUrl = this.Request.Url.AbsoluteUri;

            Theme theme = Ext.Net.Theme.Triton;

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
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Ext.NET Examples - ASP.NET (Web Forms + MVC) component framework integrating the cross-browser Sencha Ext JS JavaScript Library.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="resources/css/main.css?4.1.0.1" />
    <link rel="shortcut icon" href="favicon.ico" />

    <script src="resources/js/perfect-scrollbar.min.js?0.6.8"></script>
    <script src="resources/js/main.js?4.1.0.0"></script>

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
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Triton" />

    <ext:History runat="server">
        <Listeners>
            <Change Fn="change" />
        </Listeners>
    </ext:History>

    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Container
                ID="RedirectOverlay"
                runat="server"
                Cls="redirect-overlay"
                WidthSpec="80%"
                Modal="true"
                Floating="true">
                <LayoutConfig>
                    <ext:VBoxLayoutConfig Align="Stretch" />
                </LayoutConfig>
                <Items>
                    <ext:Component
                        Cls="redirect-overlay-body"
                        runat="server"
                        Html="<p>Looks like you are browsing from a phone or a tablet device. Would you like to redirect to Ext.NET Mobile examples?</p>"/>

                    <ext:Button
                        runat="server"
                        Text="Redirect"
                        Flex="1"
                        Handler="onRedirect" />

                    <ext:Button
                        runat="server"
                        Text="Stay here"
                        Flex="1"
                        Handler="onStay" />

                    <ext:Checkbox
                        ID="RememberCheckbox"
                        Cls="remember-me"
                        runat="server"
                        BoxLabel="Remember my choice" />
                </Items>
            </ext:Container>

            <ext:Panel
                runat="server"
                Header="false"
                Region="North"
                Border="false"
                Height="70">
                <Content>
                    <header class="site-header" role="banner">
                        <nav class="top-navigation">
                            <div class="logo-container">
                                <img src="resources/images/extdotnet-logo.svg" />
                            </div>
                            <div class="navigation-bar">
                                <div class="platform-selector-container">
                                    <ext:Button
                                        Cls="platform-selector"
                                        runat="server"
                                        Width="360px"
                                        Text="Web Forms Examples (4.1)"
                                        Height="70px"
                                        ArrowVisible="false">
                                        <Menu >
                                            <ext:Menu Cls ="platform-selector-dropdown" Plain="true" runat="server">
                                                <Items>
                                                    <ext:MenuItem
                                                        runat="server"
                                                        Text="MVC Examples (4.1)"
                                                        Href="http://mvc.ext.net/"
                                                        Height="70px"
                                                        Width="358px"
                                                        Padding="12"/>
                                                    <ext:MenuItem
                                                        runat="server"
                                                        Text="Mobile Examples (4.1)"
                                                        Href="http://mobile.ext.net/"
                                                        Height="70px"
                                                        Width="358px"
                                                        Padding="12"/>
                                                    <ext:MenuItem
                                                        runat="server"
                                                        Text="MVC Mobile Examples (4.1)"
                                                        Href="http://mvc.mobile.ext.net/"
                                                        Height="70px"
                                                        Width="358px"
                                                        Padding="12"/>
                                                </Items>
                                            </ext:Menu>
                                        </Menu>
                                    </ext:Button>
                                </div>
                                <input type="checkbox" id="menu-button-checkbox"/>
                                <label id="menu-button" for="menu-button-checkbox">
                                    <span></span>
                                </label>
                            </div>
                        </nav>
                    </header>
                </Content>
            </ext:Panel>
            <ext:Panel
                ID="rightnav"
                runat="server"
                Region="East"
                Width="270"
                Header="false"
                MarginSpec="0"
                Hidden="true"
                Border="false"
                BodyCls="right-nav-menu">
                <Content>
                    <ul id="nav-menu" class="nav-menu">
                        <li><a href="http://examples.ext.net/">Web Forms Examples</a></li>
                        <li><a href="http://mvc.ext.net/">MVC Examples</a></li>
                        <li><a href="http://mobile.ext.net/">Mobile Examples</a></li>
                        <li><a href="http://mvc.mobile.ext.net/">MVC Mobile Examples</a></li>
                        <li class="separator"></li>
                        <li><a href="http://docs.sencha.com/extjs/6.0/6.0.0-classic/">EXT JS Documentation</a></li>
                        <li><a href="http://docs.ext.net/">Ext.NET Documentation</a></li>
                        <li class="separator"></li>
                        <li><a href="http://forums.ext.net/">Community Forums</a></li>
                        <li><a href="http://ext.net/faq/">FAQ</a></li>
                        <li><a href="http://ext.net/contact/">Contact</a></li>
                        <li><a href="http://ext.net/">Ext.NET Home</a></li>
                        <li class="separator"></li>
                        <li>
                            <a href="#" data-toggle="collapse" data-target="#archives"><i class="fa collapse-icon"></i> Archives</a>
                            <ul class="collapse" id="archives">
                                <li class="section-title">Ext.NET 3</li>
                                <li><a href="http://examples3.ext.net/">Web Forms Examples (3.3)</a></li>
                                <li><a href="http://mvc3.ext.net/">MVC Examples (3.3)</a></li>
                                <li class="separator"></li>
                                <li class="section-title">Ext.NET 2</li>
                                <li><a href="http://examples2.ext.net/">Web Forms Examples (2.5)</a></li>
                                <li><a href="http://mvc2.ext.net/">MVC Examples (2.5)</a></li>
                                <li class="separator"></li>
                                <li class="section-title">Ext.NET 1</li>
                                <li><a href="http://examples1.ext.net/">Web Forms Examples (1.7)</a></li>
                            </ul>
                        </li>
                    </ul>
                    <a href="http://ext.net/store/" class="button button-success button-block button-sidebar-right">Get Ext.NET</a>
                </Content>
            </ext:Panel>
            <ext:Panel
                runat="server"
                Region="West"
                Layout="Fit"
                Width="270"
                Header="false"
                MarginSpec="0"
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
                            <ext:Toolbar runat="server" Cls="left-header">
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

                                    <ext:Button runat="server" id="OptionsButton" IconCls="fa fa-cog" ToolTip="Options" ArrowVisible="false">
                                        <Menu>
                                            <ext:Menu runat="server" MinWidth="200">
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
                                                            <ext:Menu runat="server" MinWidth="200">
                                                                <Items>
                                                                    <ext:CheckMenuItem ID="AriaThemeItem" runat="server" Text="Aria" Group="theme" />
                                                                    <ext:CheckMenuItem ID="DefaultThemeItem" runat="server" Text="Blue" Group="theme" />
                                                                    <ext:CheckMenuItem ID="GrayThemeItem" runat="server" Text="Gray" Group="theme" />
                                                                    <ext:CheckMenuItem ID="CrispThemeItem" runat="server" Text="Crisp" Group="theme" />
                                                                    <ext:CheckMenuItem ID="CrispTouchThemeItem" runat="server" Text="Crisp Touch" Group="theme" />
                                                                    <ext:CheckMenuItem ID="NeptuneThemeItem" runat="server" Text="Neptune" Group="theme" />
                                                                    <ext:CheckMenuItem ID="NeptuneTouchThemeItem" runat="server" Text="Neptune Touch" Group="theme" />
                                                                    <ext:CheckMenuItem ID="TritonThemeItem" runat="server" Text="Triton" Group="theme" />
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
                                                            <ext:Menu runat="server" MinWidth="200">
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

                                                    <%--<ext:MenuItem runat="server" Text="Tag Cloud" Icon="WeatherClouds">
                                                        <Listeners>
                                                            <Click Fn="showTagCloud" />
                                                        </Listeners>
                                                    </ext:MenuItem>--%>
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
                MarginSpec="0"
                Cls="tabs"
                MinTabWidth="115">
                <Items>
                    <ext:Panel
                        ID="tabHome"
                        runat="server"
                        Title="Home"
                        HideMode="Offsets"
                        IconCls="fa fa-home">
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
</body>
</html>
