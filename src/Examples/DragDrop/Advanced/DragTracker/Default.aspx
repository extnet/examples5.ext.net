<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        divsData.Items.Add("divs", new List<object>
        {
            new { X=20,  Y=20 },
            new { X=80,  Y=20 },
            new { X=140, Y=20 },
            new { X=200, Y=20 },
            new { X=20,  Y=80 },
            new { X=80,  Y=80 },
            new { X=140, Y=80 },
            new { X=200, Y=80 },
            new { X=20,  Y=140 },
            new { X=80,  Y=140 },
            new { X=140, Y=140 },
            new { X=200, Y=140 }
        });
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Click and Drag to Select Items - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        div.tracked-item {
            border           : 1px solid silver;
            background-color : #f0f080;
            width            : 40px;
            height           : 40px;
            text-align       : center;
            line-height      : 40px;
            font-size        : 11px;
            font-family      : sans-serif;
            position         : absolute;
            cursor           : default;
        }

        .drag-area {
            background-color : #f0f0f0 ! important;
            position         : relative;
        }

        .dd-proxy {
            opacity      : 0.4;
            -moz-opacity : 0.4;
            filter       : alpha(opacity=40);
            cursor       : default ! important;
        }

        div.tracked-item.selected {
            background-color : blue;
            color            : white;
            font-weight      : bold;
        }
    </style>

    <script>
        var startTrack = function () {
            Ext.select("div.tracked-item.selected").removeCls("selected");
            this.items = Ext.select("div.tracked-item", true);
        };

        var dragTrack = function () {
            this.items.each(function (item) {
                var r = item.getRegion(),
                    sel = this.dragRegion.intersect(r);

                if (sel) {
                    item.addCls("selected");
                } else {
                    item.removeCls("selected");
                }
            }, this);
        };

        var endTrack = function () {
            delete this.items;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ObjectHolder ID="divsData" runat="server" />

        <ext:XTemplate ID="Tpl1" runat="server">
            <Html>
                <tpl for=".">
                     <div id="item-{#}" index="{#}" class="tracked-item" style="top:{Y}px;left:{X}px;">Item {#}</div>
                </tpl>
            </html>        </ext:XTemplate>

        <ext:DragTracker ID="DragTracker1" runat="server">
            <Listeners>
                <DragStart Fn="startTrack" />
                <Drag Fn="dragTrack" />
                <DragEnd Fn="endTrack" />
            </Listeners>
        </ext:DragTracker>

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel runat="server" Region="North" Height="70">
                    <Content>
                         <h3>Click and Drag to Select Items</h3>
                    </Content>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" BodyCssClass="drag-area">
                    <Listeners>
                        <AfterRender Handler="#{Tpl1}.overwrite(this.body, #{divsData}.divs);#{DragTracker1}.initEl(this.el);" />
                    </Listeners>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>