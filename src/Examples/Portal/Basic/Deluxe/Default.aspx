<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            string text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.";

            this.ResourceManager1.RegisterClientScriptBlock("text", string.Format("var text=\"{0}\";", text));

            foreach (Portlet portlet in ControlUtils.FindControls<Portlet>(this.Page))
            {
                if (!portlet.ID.Equals("Portlet1"))
                {
                    portlet.Html = "={text}";
                    portlet.BodyPadding = 5;
                }
            }
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Deluxe Portal in TabPanel - Ext.NET Examples</title>

    <style>
        body {
            font-size : 12px;
            background-color : #284051;
            font-family : "Trebuchet MS",sans-serif;
        }

        #settingsWrapper {
            border-bottom    : 1px solid #111;
            background-color : #323232;
            padding-left     : 4px;
        }

        #settings {
            padding : 2px;
            border-bottom : 1px solid #3B3B3B;
        }

        #settings ul li {
            display      : inline;
            color        : #fff;
            margin-right : 8px;
            line-height  : 24px;
            padding      : 2px;
            padding-left : 19px;
        }

        #settings ul li a, #settings ul li a:link {
            color : #fff;
            text-decoration : none;
        }

        #settings ul li a:hover {
            text-decoration : underline;
        }

        #pageTitle {
            font-family : "Trebuchet MS",sans-serif;
            font-size   : 17px;
            text-align  : center;
            color       : #fff;
            margin-top  : 20px;
        }

        #itemAddContent {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Add) %>) no-repeat 0 2px;
        }

        #itemComments {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Comment) %>) no-repeat 0 2px;
        }

        #itemActivities {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Star) %>) no-repeat 0 2px;
        }

        #itemContacts {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Vcard) %>) no-repeat 0 2px;
        }

        #TabPanel1 ul.x-tab-strip-top {
            background-image : none !important;
            background-color : #284051;
        }

        .x-panel-dd-spacer {
            border : 2px dashed #284051;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:Viewport
            runat="server"
            StyleSpec="background-color: transparent;"
            Layout="Border">
            <Items>
                <ext:Panel
                    ID="pnlNorth"
                    runat="server"
                    Region="North"
                    Height="105"
                    Border="false"
                    BodyStyle="background-color: transparent;">
                    <Content>
                        <div id="settingsWrapper">
                            <div id="settings">
                                <ul>
                                    <li id="itemAddContent"><a href="#">Add content</a></li>
                                    <li id="itemComments"><a href="#">Comments</a></li>
                                    <li id="itemActivities"><a href="#">Activities</a></li>
                                    <li id="itemContacts"><a href="#">Contacts</a></li>
                                </ul>
                            </div>
                        </div>
                        <div id="pageTitle">Page Title</div>
                    </Content>
                </ext:Panel>
                <ext:Panel
                    runat="server"
                    Region="West"
                    Title="Settings"
                    Width="200"
                    ID="pnlSettings"
                    BodyStyle="background-color: #284051;"
                    Collapsible="true"
                    Split="true"
                    MinWidth="175"
                    MaxWidth="400"
                    MarginSpec="5 0 5 5"
                    Layout="Accordion">
                    <Items>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Icon="PageWhiteCopy"
                            Title="Content"
                            Html="={text}"
                            BodyPadding="6" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Icon="Star"
                            Title="Activities"
                            Html="={text}"
                            BodyPadding="6" />
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Icon="Group"
                            Title="Contacts"
                            Html="={text}"
                            BodyPadding="6" />
                    </Items>
                </ext:Panel>
                <ext:TabPanel
                    ID="TabPanel1"
                    Region="Center"
                    runat="server"
                    Title="TabPanel"
                    ActiveTabIndex="0"
                    Border="false"
                    BodyStyle="background-color: #4D778B; border: 1px solid #AABBCC; border-top: none;"
                    MarginSpec="5 5 5 0">
                    <Items>
                        <ext:Panel
                            ID="Tab1"
                            runat="server"
                            Title="Internet"
                            Icon="Vcard"
                            BodyStyle="background-color: transparent;"
                            Layout="Fit">
                            <Items>
                                <ext:Portal
                                    ID="Portal1"
                                    runat="server"
                                    Border="false"
                                    BodyStyle="background-color: transparent;">
                                    <Items>
                                        <ext:PortalColumn
                                            runat="server"
                                            ColumnWidth=".33">
                                            <Items>
                                                <ext:Portlet
                                                    ID="Portlet1"
                                                    runat="server"
                                                    Title="Ext.Net"
                                                    Height="450"
                                                    BodyPadding="0">
                                                    <Loader runat="server" Url="https://ext.net/" Mode="Frame">
                                                        <LoadMask ShowMask="true" />
                                                    </Loader>
                                                </ext:Portlet>
                                            </Items>
                                        </ext:PortalColumn>
                                        <ext:PortalColumn
                                            runat="server"
                                            ColumnWidth=".33">
                                            <Items>
                                                <ext:Portlet ID="Portlet2" Title="Panel 2" runat="server" />
                                                <ext:Portlet ID="Portlet3" Title="Another Panel 2" runat="server" />
                                            </Items>
                                        </ext:PortalColumn>
                                        <ext:PortalColumn
                                            runat="server"
                                            ColumnWidth=".34">
                                            <Items>
                                                <ext:Portlet ID="Portlet4" Title="Panel 3" runat="server" />
                                                <ext:Portlet ID="Portlet5" Title="Another Panel 3" runat="server" />
                                            </Items>
                                        </ext:PortalColumn>
                                    </Items>
                                </ext:Portal>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            ID="Tab2"
                            runat="server"
                            Title="General"
                            Icon="House"
                            BodyStyle="background-color: transparent;"
                            Layout="Fit">
                            <Items>
                                <ext:Portal
                                    ID="Portal2"
                                    runat="server"
                                    Border="false"
                                    BodyStyle="background-color: transparent;">
                                    <Items>
                                        <ext:PortalColumn runat="server" />
                                        <ext:PortalColumn runat="server">
                                            <Items>
                                                <ext:Portlet ID="Portlet6" Title="Panel 3" runat="server" />
                                                <ext:Portlet ID="Portlet7" Title="Another Panel 3" runat="server" />
                                            </Items>
                                        </ext:PortalColumn>
                                        <ext:PortalColumn runat="server">
                                            <Items>
                                                <ext:Portlet ID="Portlet8" Title="Another Panel 1" runat="server" />
                                            </Items>
                                        </ext:PortalColumn>
                                    </Items>
                                </ext:Portal>
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Fun"
                            Icon="ColorSwatch"
                            BodyStyle="background-color: transparent;"
                            Layout="Fit">
                            <Items>
                                <ext:Portal
                                    ID="Portal3"
                                    runat="server"
                                    Border="false"
                                    BodyStyle="background-color: transparent;">
                                    <Items>
                                        <ext:PortalColumn runat="server">
                                            <Items>
                                                <ext:Portlet ID="Portlet9" runat="server" Title="My &quot;Fun&quot; Portlet" />
                                            </Items>
                                        </ext:PortalColumn>
                                        <ext:PortalColumn runat="server" />
                                        <ext:PortalColumn runat="server" />
                                    </Items>
                                </ext:Portal>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
