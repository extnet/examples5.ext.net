<%@ Page Language="C#" %>

<script runat="server">
    private void BuildCards()
    {
        // 1. Add required css rules
        CSS.SwapStyleSheet("cards", "styles.css");

        // 2. Append main Container
        Element topEl = DomHelper.Append(X.Body(), new DomObject { ID = "Cards1", Cls = "cards-container" });

        // 3. Append header Container
        Element header = DomHelper.Append(topEl, new DomObject { Cls = "cards-header" });

        DomHelper.Append(header,
            new DomObject {
                Tag = HtmlTextWriterTag.Ul,
                Children = {
                     new DomObject {
                         Tag = HtmlTextWriterTag.Li,
                         Children = {
                            new DomObject {
                                Tag = HtmlTextWriterTag.A,
                                Html = "RECENT",
                                CustomConfig = { new ConfigItem("rel", "c0", ParameterMode.Value)}
                            }
                         }
                     },

                     new DomObject {
                         Tag = HtmlTextWriterTag.Li,
                         Children = {
                            new DomObject {
                                Tag = HtmlTextWriterTag.A,
                                Html = "COMMENTS",
                                CustomConfig = { new ConfigItem("rel", "c1", ParameterMode.Value)}
                            }
                         }
                     },

                     new DomObject {
                         Tag = HtmlTextWriterTag.Li,
                         Children = {
                            new DomObject {
                                Tag = HtmlTextWriterTag.A,
                                Html = "POPULAR",
                                CustomConfig = { new ConfigItem("rel", "c2", ParameterMode.Value)}
                            }
                         }
                     },

                     new DomObject {
                         Tag = HtmlTextWriterTag.Li,
                         Children = {
                            new DomObject {
                                Tag = HtmlTextWriterTag.A,
                                Html = "TAGS",
                                CustomConfig = { new ConfigItem("rel", "c3", ParameterMode.Value)}
                            }
                         }
                     }
                }
            }
        );

        // 4. Append Content Container
        Element content = DomHelper.Append(topEl, new DomObject { Cls = "cards-content" });
        Element curCard = DomHelper.Append(content,
            new DomObject{
                Cls = "current-card",
                Children = {
                   new DomObject { Html = "RECENT", ID = "c0", Cls = "card" },
                   new DomObject { Html = "COMMENTS<br />COMMENTS", ID = "c1", Cls = "card" },
                   new DomObject { Html = "POPULAR<br />POPULAR<br />POPULAR", ID = "c2", Cls = "card" },
                   new DomObject { Html = "TAGS<br />TAGS<br />TAGS<br />TAGS", ID = "c3", Cls = "card" }
                }
            }
        );

        curCard.SetStyle("height", "auto");

        topEl.Chaining = true;

        topEl.Select(".cards-header a", true)
            .Hover(new JFunction {Fn = "hoverCard"}, JFunction.EmptyFn)
            .First()
            .AddCls("current")
            .Render();

        content.Chaining = true;
        content.Select(".card").SetVisibilityMode(VisibilityMode.Display).Hide().First().Show().Render();
    }

    protected void CreateClick(object sender, DirectEventArgs e)
    {
        this.BuildCards();

        this.Button1.Disabled = true;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Element Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var hoverCard = function () {
            Ext.get("Cards1").select(".cards-header a").removeCls("current");

            var id = Ext.get(this).addCls("current").getAttribute("rel");

            Ext.get("Cards1").select(".card").hide().filter("#"+id).show();
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Button ID="Button1" runat="server" Text="Create cards" OnDirectClick="CreateClick" />
</body>
</html>