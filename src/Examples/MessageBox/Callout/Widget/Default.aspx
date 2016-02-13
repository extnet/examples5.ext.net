<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = new List<object>()
        {
            new {name = "User 1"},
            new {name = "User 2"},
            new {name = "User 3"},
            new {name = "User 4"},
            new {name = "User 5"}
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Callout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        h3.x-callout-header {
            /* to deactivate h3 rule from resources/css/examples.css */
            font-family: inherit;
        }

        .list h3 {
            color:        #66757F;
            font-weight:  bold;
            font-size:    14px;
            height:       24px;
            line-height:  22px;
            padding-left: 10px;
        }

        .list ul {
            list-style: none outside none;
            padding: 0;
            margin: 0;
        }

        .list li {
            white-space: nowrap;
            width:       100%;
            display:     block;
            height:      40px;
            padding:     7px 15px 7px 10px;
            cursor:      pointer;
        }

        .list li a {
            font-size:   14px;
            color:       #66757F;
            line-height: 24px;
        }

        .over {
            background-color: #0084B4;
        }

        li.over a {
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Widget</h1>

    <ext:TextField runat="server" EmptyText="Focus the field to see the Callout" Width="250">
        <Callouts>
            <ext:Callout
                runat="server"
                Alignment="BottomLeft"
                Trigger="Focus"
                BodyStyle="padding:2px 0px;">
                <BodyWidget>
                    <ext:DataView
                        runat="server"
                        Width="250"
                        Cls="list"
                        ItemSelector="li"
                        OverItemCls="over"
                        TrackOver="true" >
                        <Store>
                            <ext:Store ID="Store1" runat="server">
                                <Fields>
                                    <ext:ModelField Name="name" />
                                </Fields>
                            </ext:Store>
                        </Store>
                        <Tpl>
                            <Html>
                                <h3>Saved Users</h3>
                                <ul>
                                    <tpl for=".">
                                        <li>
                                            <a>{name}</a>
                                        </li>
                                    </tpl>
                                </ul>
                            </Html>
                        </Tpl>
                        <Listeners>
                            <ItemClick Handler="this.callout.calloutOwner.setValue(record.data.name);" />
                        </Listeners>
                    </ext:DataView>
                </BodyWidget>
            </ext:Callout>
        </Callouts>
    </ext:TextField>
</body>
</html>