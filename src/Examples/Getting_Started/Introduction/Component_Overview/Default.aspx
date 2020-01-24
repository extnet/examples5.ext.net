<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.TestData;

            Theme theme = Ext.Net.Theme.Triton;

            if (this.Session["Ext.Net.Theme"] != null)
            {
                theme = (Theme)this.Session["Ext.Net.Theme"];
            }

            if (this.Request["theme"] != null)
            {
                theme = (Theme)Enum.Parse(typeof(Theme), this.Request["theme"]);
            }

            foreach (var supportedTheme in (Theme[])Enum.GetValues(typeof(Theme)))
            {
                if (supportedTheme == Ext.Net.Theme.None)
                {
                    continue;
                }

                var ts = supportedTheme.ToString();

                this.ComboBoxTheme.Items.Add(new Ext.Net.ListItem(Ext.Net.Examples.Util.UpperCaseToSpace(ts), ts));
            }

            if (theme == Ext.Net.Theme.Material)
            {
                this.ComboBoxTheme.AddCls("not-empty");
            }

            this.ResourceManager1.Theme = theme;
            this.ComboBoxTheme.SelectedItems.Add(new Ext.Net.ListItem { Value = theme.ToString() });
        }
    }

    protected void Store1_Refresh(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.TestData;
        this.Store1.DataBind();
    }

    private object[] TestData
    {
        get
        {
            DateTime now = DateTime.Now;

            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, now },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, now },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, now },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, now },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, now },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, now },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, now },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, now },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, now },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, now },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, now },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, now },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, now },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, now },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, now },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, now },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, now },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, now },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, now },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, now },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, now },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, now },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, now },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, now },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, now },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, now },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, now },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, now },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, now }
            };
        }
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        string msg = "This is a sample Alert MessageBox<br /><br />Server Timestamp : " + DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss");
        X.Msg.Alert("Message", msg).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Component and Themes Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="overview.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <div id="header">
            <div id="styleswitcher">
                <ext:ComboBox
                    ID="ComboBoxTheme"
                    runat="server"
                    FieldLabel="Choose Theme"
                    Width="300">
                    <Listeners>
                        <Select Handler="window.location.search = '?theme=' + records[0].data[this.valueField];" />
                    </Listeners>
                </ext:ComboBox>
            </div>
            <h1>Ext.NET <span>View and test every Component against bundled Themes.</span></h1>
        </div>

        <ext:Window
            runat="server"
            Width="170"
            Height="170"
            MinWidth="150"
            Title="Window"
            BodyPadding="5"
            Html="Click Submit"
            Collapsible="true"
            X="570"
            Y="130">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Toolbar" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Buttons>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Submit"
                    Icon="Accept"
                    OnDirectClick="Button1_Click" />
            </Buttons>
        </ext:Window>

        <ext:Container
            runat="server"
            Height="1865"
            Width="1440"
            Layout="AbsoluteLayout"
            StyleSpec="background-image: url('/resources/images/bg-main.png');">
            <Items>
                <%--
                    =============================================================
                    Panel / Window
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Width="170"
                    Height="170"
                    Title="Basic Panel"
                    BodyPadding="5"
                    Html="Some content"
                    Collapsible="true"
                    X="10"
                    Y="10" />

                <ext:Panel
                    runat="server"
                    Width="170"
                    Height="170"
                    Title="Masked Panel"
                    BodyPadding="5"
                    Html="Some content"
                    Collapsible="true"
                    X="190"
                    Y="10">
                    <Listeners>
                        <Render Handler="this.body.mask('Loading...');" Delay="50" />
                    </Listeners>
                </ext:Panel>

                <ext:Panel
                    runat="server"
                    Width="170"
                    Height="170"
                    Title="Framed Panel"
                    Frame="true"
                    Html="Some content"
                    Collapsible="true"
                    X="370"
                    Y="10" />

                <%--
                    =============================================================
                    Basic Panel With Toolbars
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Width="700"
                    Height="170"
                    Title="Basic Panel With Toolbars"
                    X="730"
                    Y="10">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ToolbarTextItem runat="server" Text="Toolbar &amp; Menus" />
                                <ext:ToolbarSpacer runat="server" />
                                <ext:ToolbarSeparator runat="server" />
                                <ext:Button runat="server" Text="Button" />
                                <ext:Button runat="server" Text="Menu Button">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Menu Item" />
                                                <ext:CheckMenuItem ID="Item1" runat="server" Text="Check 1" Checked="true" />
                                                <ext:CheckMenuItem ID="Item2" runat="server" Text="Check 2" />
                                                <ext:MenuSeparator runat="server" />
                                                <ext:CheckMenuItem ID="Item3" runat="server" Text="Option 1" Checked="true" Group="opts" />
                                                <ext:CheckMenuItem ID="Item4" runat="server" Text="Option 1" Group="opts" />
                                                <ext:MenuSeparator runat="server" />
                                                <ext:MenuItem runat="server" Text="Sub-items">
                                                    <Menu>
                                                        <ext:Menu runat="server">
                                                            <Items>
                                                                <ext:MenuItem runat="server" Text="Item 1" />
                                                                <ext:MenuItem runat="server" Text="Item 2" />
                                                            </Items>
                                                        </ext:Menu>
                                                    </Menu>
                                                </ext:MenuItem>
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                                <ext:SplitButton runat="server" Text="Split Button">
                                    <Menu>
                                        <ext:Menu runat="server">
                                            <Items>
                                                <ext:MenuItem runat="server" Text="Item 1" />
                                                <ext:MenuItem runat="server" Text="Item 2" />
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:SplitButton>
                                <ext:Button runat="server" Text="Toggle Button" EnableToggle="true" Pressed="true" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <BottomBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ToolbarTextItem runat="server" Text="Bottom Bar" />
                            </Items>
                        </ext:Toolbar>
                    </BottomBar>
                </ext:Panel>

                <%--
                    =============================================================
                    Form Fields
                    =============================================================
                --%>

                <ext:FormPanel
                    ID="FormPanel1"
                    runat="server"
                    Title="Form Fields"
                    Width="710"
                    Height="1130"
                    Frame="true"
                    X="10"
                    Y="190"
                    BodyStyle="padding:10px 20px;"
                    DefaultAnchor="100%"
                    DefaultMsgTarget="side"
                    DefaultAllowBlank="false">
                    <Tools>
                        <ext:Tool Type="Toggle" />
                        <ext:Tool Type="Close" />
                        <ext:Tool Type="Minimize" />
                        <ext:Tool Type="Maximize" />
                        <ext:Tool Type="Restore" />
                        <ext:Tool Type="Gear" />
                        <ext:Tool Type="Pin" />
                        <ext:Tool Type="Unpin" />
                        <ext:Tool Type="Right" />
                        <ext:Tool Type="Left" />
                        <ext:Tool Type="Up" />
                        <ext:Tool Type="Down" />
                        <ext:Tool Type="Refresh" />
                        <ext:Tool Type="Plus" />
                        <ext:Tool Type="Help" />
                        <ext:Tool Type="Search" />
                        <ext:Tool Type="Save" />
                        <ext:Tool Type="Print" />
                    </Tools>
                    <Items>
                        <ext:DisplayField
                            runat="server"
                            FieldLabel="DisplayField"
                            Text="A value here" />
                        <ext:TextField
                            runat="server"
                            FieldLabel="TextField"
                            EmptyText="Enter a value"
                            AllowBlank="false" />
                        <ext:NumberField
                            runat="server"
                            FieldLabel="NumberField"
                            EmptyText="(This field is optional)" />
                        <ext:TextField
                            runat="server"
                            FieldLabel="w/Indicator"
                            IndicatorIcon="Information"
                            Anchor="-20"
                            IndicatorTip="An Indicator ToolTip" />
                        <ext:TextField runat="server" FieldLabel="w/Note" Note="Simple note" />

                        <ext:FieldContainer runat="server" FieldLabel="FieldContainer" Layout="HBoxLayout">
                            <Items>
                                <ext:ComboBox runat="server" Width="50" Editable="false" DataIndex="Title">
                                    <Items>
                                        <ext:ListItem Text="Mr" Value="mr" />
                                        <ext:ListItem Text="Mrs" Value="mrs" />
                                        <ext:ListItem Text="Miss" Value="miss" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="mr" />
                                    </SelectedItems>
                                </ext:ComboBox>

                                <ext:TextField runat="server" Flex="1" />

                                <ext:TextField runat="server" Flex="1" />
                            </Items>
                        </ext:FieldContainer>

                        <ext:TextField runat="server" FieldLabel="TextField with triggers">
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" />
                                <ext:FieldTrigger Icon="Search" />
                            </Triggers>
                        </ext:TextField>

                        <ext:ComboBox runat="server" FieldLabel="ComboBox" Resizable="true">
                            <Items>
                                <ext:ListItem Text="Foo" />
                                <ext:ListItem Text="Bar" />
                            </Items>
                        </ext:ComboBox>
                        <ext:DateField runat="server" FieldLabel="DateField" />
                        <ext:TimeField runat="server" FieldLabel="TimeField" />
                        <ext:SpinnerField runat="server" FieldLabel="SpinnerField" />
                        <ext:Slider runat="server" Number="50" FieldLabel="SliderField">
                            <Plugins>
                                <ext:SliderTip runat="server">
                                    <GetText Handler="return thumb.value;" />
                                </ext:SliderTip>
                            </Plugins>
                        </ext:Slider>

                        <ext:TextArea runat="server" FieldLabel="TextArea" />
                        <ext:CheckboxGroup runat="server" FieldLabel="Checkboxes" ColumnsWidths="100,100">
                            <Items>
                                <ext:Checkbox runat="server" BoxLabel="Foo" Checked="true" />
                                <ext:Checkbox runat="server" BoxLabel="Bar" />
                            </Items>
                        </ext:CheckboxGroup>
                        <ext:RadioGroup runat="server" ColumnsWidths="100,100">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Foo" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Bar" />
                            </Items>
                        </ext:RadioGroup>
                        <ext:HtmlEditor runat="server" HideLabel="true" Height="110" Text="Mouse over toolbar for tooltips." />
                        <ext:FieldSet runat="server" Title="Plain Fieldset" Height="50" />
                        <ext:FieldSet runat="server" Title="Collapsible Fieldset" Height="50" Collapsible="true" />
                        <ext:FieldSet runat="server" Title="Checkbox Fieldset" Height="50" CheckboxToggle="true" />
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" Text="Toggle Enabled">
                            <Listeners>
                                <Click Handler="var fp = #{FormPanel1};
                                                fp.cascade(function (item) {
                                                    if (item !== fp) {
                                                        item.setDisabled(!item.disabled);
                                                    }
                                                });" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="Reset Form" OnClientClick="#{FormPanel1}.getForm().reset();" />
                        <ext:Button runat="server" Text="Validate" OnClientClick="#{FormPanel1}.getForm().isValid();" />
                    </Buttons>
                </ext:FormPanel>

                <%--
                    =============================================================
                    BorderLayout
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Title="BorderLayout Panel"
                    Width="700"
                    Height="380"
                    X="730"
                    Y="190"
                    Layout="BorderLayout"
                    DefaultCollapsible="true"
                    DefaultSplit="true">
                    <Items>
                        <ext:Panel runat="server" Title="Center" Region="Center" Html="Center" Collapsible="false" />
                        <ext:Panel runat="server" Title="North" Region="North" Html="North" Height="70" MarginSpec="5 5 0 5" />
                        <ext:Panel runat="server" Title="East" Region="East" Html="East" Width="140" MarginSpec="0 5 0 0" />
                        <ext:Panel runat="server" Title="West" Region="West" Html="West" Width="140" MarginSpec="0 0 0 5" CollapseMode="Mini" />
                        <ext:Panel runat="server" Title="South" Region="South" Html="South" Height="70" MarginSpec="0 5 5 5" />
                    </Items>
                </ext:Panel>

                <%--
                    =============================================================
                    GridPanel
                    =============================================================
                --%>

                <ext:GridPanel
                    runat="server"
                    Title="GridPanel"
                    Width="700"
                    Height="270"
                    X="730"
                    Y="580">
                    <Store>
                        <ext:Store
                            ID="Store1"
                            runat="server"
                            OnRefreshData="Store1_Refresh"
                            PageSize="10">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="company" />
                                        <ext:ModelField Name="price" Type="Float" />
                                        <ext:ModelField Name="change" Type="Float" />
                                        <ext:ModelField Name="pctChange" Type="Float" />
                                        <ext:ModelField Name="lastChange" Type="Date" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="Company" Width="160" DataIndex="company" Flex="1" />
                            <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                            <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange" />
                            <ext:DateColumn runat="server" Text="Last Updated" Width="85" DataIndex="lastChange" Format="H:mm:ss" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>
                    <View>
                        <ext:GridView runat="server" StripeRows="true" />
                    </View>
                    <%--<LoadMask ShowMask="true" />--%>
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Toolbar" />
                                <ext:ToolbarFill runat="server" />
                                <ext:TextField runat="server">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" />
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                </ext:TextField>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <BottomBar>
                        <ext:PagingToolbar runat="server" />
                    </BottomBar>
                </ext:GridPanel>

                <%--
                    =============================================================
                    Accordion / Tree
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Title="AccordionLayout with TreePanel"
                    Width="700"
                    Height="320"
                    X="730"
                    Y="860"
                    Layout="AccordionLayout"
                    DefaultBorder="false">
                    <Items>
                        <ext:TreePanel runat="server" Title="TreePanel" Scrollable="Both" EnableDD="true">
                            <Root>
                                <ext:Node Text="Root Node" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Item 1" Leaf="true" />
                                        <ext:Node Text="Item 2" Leaf="true" />
                                        <ext:Node Text="Folder">
                                            <Children>
                                                <ext:Node Text="Item 3" Leaf="true" />
                                            </Children>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Root>
                        </ext:TreePanel>
                        <ext:Panel runat="server" Title="Item 2" BodyPadding="5" Html="Some content" />
                        <ext:Panel runat="server" Title="Item 3" BodyPadding="5" Html="Some content" />
                    </Items>
                </ext:Panel>

                <%--
                    =============================================================
                    TabPanel
                    =============================================================
                --%>

                <ext:TabPanel
                    runat="server"
                    Width="350"
                    Height="200"
                    X="10"
                    Y="1330"
                    DefaultPadding="5">
                    <Items>
                        <ext:Panel runat="server" Title="Tab 1" Html="TabPanel with tab scroll enabled" />
                        <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 3" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 4" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 5" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 6" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 7" Closable="true" />
                    </Items>
                </ext:TabPanel>

                <ext:TabPanel
                    runat="server"
                    Width="350"
                    Height="200"
                    X="370"
                    Y="1330"
                    DefaultPadding="5"
                    Plain="true">
                    <Items>
                        <ext:Panel runat="server" Title="Tab 1" Html="Plain TabPanel" />
                        <ext:Panel runat="server" Title="Tab 2" Closable="true" />
                        <ext:Panel runat="server" Title="Tab 3" Closable="true" />
                    </Items>
                </ext:TabPanel>

                <%--
                    =============================================================
                    DatePicker
                    =============================================================
                --%>

                <ext:DatePicker runat="server" X="10" Y="1540" />

                <%--
                    =============================================================
                    Resizable
                    =============================================================
                --%>

                <%--
                    var rszEl = Ext.DomHelper.append(Ext.getBody(), {
                        style: 'background: transparent;', html: '<div style="padding:20px;">Resizable handles</div>'
                    }, true);
                    rszEl.position('absolute', 1, 240, 1130);
                    rszEl.setSize(180, 180);
                    new Ext.Resizable(rszEl, {
                        handles: 'all',
                        pinned: true
                    });
                --%>

                <%--
                    =============================================================
                    ProgressBar / Slider
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Title="ProgressBar / Slider"
                    Width="700"
                    Height="230"
                    X="730"
                    Y="1190"
                    BodyPadding="15">
                    <Items>
                        <ext:ProgressBar runat="server" Value=".5" Text="Progress text..." />
                        <ext:Slider runat="server" Number="50" Width="420" />
                        <ext:Slider runat="server" Vertical="true" Number="50" Height="100" />
                    </Items>
                </ext:Panel>

                <%--
                    =============================================================
                    ButtonGroup
                    =============================================================
                --%>

                <ext:Panel
                    runat="server"
                    Title="ButtonGroup with various Buttons and Icon sizes"
                    Width="700"
                    Height="270"
                    X="730"
                    Y="1430">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ButtonGroup runat="server" Title="Clipboard" Layout="TableLayout">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3" />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>

                                <ext:ButtonGroup runat="server" Title="Other Actions" Layout="TableLayout">
                                    <LayoutConfig>
                                        <ext:TableLayoutConfig Columns="3" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Button
                                            runat="server"
                                            Text="Paste"
                                            IconCls="add32"
                                            Scale="Large"
                                            IconAlign="Top"
                                            Cls="x-btn-as-arrow"
                                            RowSpan="3" />
                                        <ext:SplitButton
                                            runat="server"
                                            Text="Menu Button"
                                            IconCls="add32"
                                            IconAlign="Top"
                                            ArrowAlign="Bottom"
                                            Scale="Large"
                                            RowSpan="3">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Menu Button 1" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                                            <Menu>
                                                <ext:Menu runat="server">
                                                    <Items>
                                                        <ext:MenuItem runat="server" Text="Cut Menu Item" />
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:SplitButton>
                                        <ext:Button runat="server" Text="Copy" IconCls="add16" />
                                        <ext:Button runat="server" Text="Format" IconCls="add16" />
                                    </Items>
                                </ext:ButtonGroup>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
            </Items>
        </ext:Container>
    </form>
</body>
</html>
