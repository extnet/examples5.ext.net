<%@ Page Language="C#" %>

<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Xml.Linq" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            XElement document = XElement.Load(Server.MapPath("resources/DashboardSchema.xml"));
            string defaultIcon = document.Attribute("defaultIcon") != null ? document.Attribute("defaultIcon").Value : "";

            IEnumerable<object> query = from g in document.Elements("group")
                                        select new
                                        {
                                            Title = g.Attribute("title") != null ? g.Attribute("title").Value : "",
                                            Items = (from i in g.Elements("item")
                                                     select new
                                                     {
                                                         Title = i.Element("title") != null ? i.Element("title").Value : "",
                                                         Icon = i.Element("item-icon") != null ? i.Element("item-icon").Value : defaultIcon,
                                                         Id = i.Element("id") != null ? i.Element("id").Value : ""
                                                     }
                                                )
                                        };

            this.Store1.DataSource = query;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Grouping DataView - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        div.item-wrap {
            float: left;
            border: 1px solid transparent;
            margin: 5px 25px 5px 25px;
            width: 100px;
            cursor: pointer;
            height: 120px;
            text-align: center;
        }

            div.item-wrap img {
                margin: 5px 0px 0px 5px;
                width: 61px;
                height: 77px;
            }

            div.item-wrap h6 {
                font-size: 14px;
                color: #3A4B5B;
                font-family: tahoma,arial,san-serif;
                margin: 0px;
            }

        div.x-view-over {
            border: solid 1px silver;
        }

        #items-ct {
            padding: 0px 30px 24px 30px;
        }

            #items-ct h2 {
                border-bottom: 2px solid #3A4B5B;
                cursor: pointer;
            }

                #items-ct h2 div {
                    background: transparent url(resources/images/group-expand-sprite.gif) no-repeat 3px -47px;
                    padding: 4px 4px 4px 17px;
                    font-family: tahoma,arial,san-serif;
                    font-size: 12px;
                    color: #3A4B5B;
                }

            #items-ct .collapsed h2 div {
                background-position: 3px 3px;
            }

            #items-ct .group-body {
                margin-left: 2px;
            }

            #items-ct .collapsed .group-body {
                display: none;
            }
    </style>

    <script>
        var itemClick = function (view, record, item, index, e) {
            var group = e.getTarget("h2", 3, true),
                subItem;

            if (group) {
                group.up("div").toggleCls("collapsed");
                return false;
            }

            subItem = e.getTarget(".item-wrap");

            if (subItem) {
                Ext.Msg.alert("Click", "The node with id='" + subItem.id + "' has been clicked");
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Grouping DataView Example</h1>

        <ext:Panel
            runat="server"
            Cls="items-view"
            Width="960"
            Border="false">
            <TopBar>
                <ext:Toolbar runat="server" Flat="true">
                    <Items>
                        <ext:ToolbarFill />

                        <ext:Button runat="server" Icon="BulletPlus" Text="Expand All">
                            <Listeners>
                                <Click Handler="#{Dashboard}.el.select('.group-header').removeCls('collapsed');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Icon="BulletMinus" Text="Collapse All">
                            <Listeners>
                                <Click Handler="#{Dashboard}.el.select('.group-header').addCls('collapsed');" />
                            </Listeners>
                        </ext:Button>

                        <ext:ToolbarSpacer runat="server" Width="30" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:DataView
                    ID="Dashboard"
                    runat="server"
                    SingleSelect="true"
                    ItemSelector="div.group-header"
                    EmptyText="No items to display">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Title" />
                                        <ext:ModelField Name="Items" Type="Object" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Tpl runat="server">
                        <Html>
                            <div id="items-ct">
                                <tpl for=".">
                                    <div class="group-header">
                                        <h2><div>{Title}</div></h2>
                                        <div class="group-body">
                                            <tpl for="Items">
                                                <div id="{Id}" class="item-wrap">
                                                    <img src="{Icon}" />
                                                    <div>
                                                        <h6>{Title}</h6>
                                                    </div>
                                                </div>
                                            </tpl>
                                            <div style="clear:left"></div>
                                        </div>
                                    </div>
                                </tpl>
                            </div>
                        </Html>
                    </Tpl>
                    <Listeners>
                        <ItemClick Fn="itemClick" />
                        <Refresh Handler="this.el.select('.item-wrap', true).addClsOnOver('x-view-over');" Delay="100" />
                    </Listeners>
                </ext:DataView>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
