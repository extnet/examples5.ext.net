<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Australia - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                DrawContainer draw = this.Draw1;
                draw.Width = 300;
                draw.Height = 300;

                string[] colors = new string[] {
                        "#8D38C9",
                        "#00FFFF",
                        "#FF00FF",
                        "#008000",
                        "#FFFF00",
                        "#0000FF",
                        "#FF0000"
                };

                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(Server.MapPath("Australia.xml"));

                List<object> info = new List<object>();

                int i = 0;
                foreach (System.Xml.XmlNode state in doc.SelectNodes("states/state"))
                {
                    PathSprite sprite = new PathSprite
                    {
                        Path = state.SelectSingleNode("path").InnerText,
                        FillStyle = "#808080",
                        StrokeStyle = "#000",
                        LineWidth = 1,
                        Linejoin = StrokeLinejoin.Round/*,
                        Cursor = "pointer"*/
                    };

                    //sprite.Listeners.MouseOver.Handler = string.Format("onMouseOver(this, {0}, {1});", JSON.Serialize(colors[i]), i);
                    //sprite.Listeners.MouseOut.Handler = "onMouseOut(this);";

                    draw.Items.Add(sprite);
                    i++;

                    info.Add(new {
                        state = state.SelectSingleNode("name").InnerText,
                        desc = state.SelectSingleNode("description").InnerText
                    });
                }

                InfoHolder.Items.Add("mapInfo", info);
            }
        }


    </script>

    <script>
        function onMouseOver(sprite, color, idx) {
            sprite.fx.stop();
            sprite.setAttributes({
                fill : color,
                duration: 500
            });
            sprite.getSurface().renderFrame();

            App.StateName.setValue(App.InfoHolder.mapInfo[idx].state);
            App.StateDesc.setValue(App.InfoHolder.mapInfo[idx].desc);
        }

        function onMouseOut(sprite) {
            sprite.fx.stop();
            sprite.setAttributes({
                fill : "#808080",
                duration: 500
            });

            sprite.getSurface().renderFrame();
        }
    </script>

    <style>
        .x-state-desc .x-form-display-field{
            font-size: 14px;
        }

        .x-state-name .x-form-display-field{
            text-align:center;
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ObjectHolder ID="InfoHolder" runat="server" />

        <ext:Viewport runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:DrawContainer ID="Draw1" runat="server" />
                <ext:Container runat="server" Height="300" Width="300" Layout="Anchor">
                    <Items>
                        <ext:DisplayField ID="StateName" runat="server" Cls="x-state-name" AnchorHorizontal="100%" />
                        <ext:DisplayField ID="StateDesc" runat="server" Cls="x-state-desc" AnchorHorizontal="100%" />
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>