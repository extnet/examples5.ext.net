<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string text = "\u0635\u0650\u0641 \u062E\u064E\u0644\u0642\u064E \u062E\u064E\u0648\u062F\u0650 \u0643\u064E\u0645\u0650\u062B\u0644\u0650 \u0627\u0644\u0634\u064E\u0645\u0633\u0650 \u0625\u0650\u0630 \u0628\u064E\u0632\u064E\u063A\u064E\u062A \u2014 \u064A\u064E\u062D\u0638\u0649 \u0627\u0644\u0636\u064E\u062C\u064A\u0639\u064F \u0628\u0650\u0647\u0627 \u0646\u064E\u062C\u0644\u0627\u0621\u064E \u0645\u0650\u0639\u0637\u0627\u0631\u0650";
        int i = 50;
        string[] sentences = new string[i];
        string[] words = text.Split(' ');
        string paragraph;

        while (i-- > 0) {
            sentences[i] = text;
        }
        paragraph = string.Join(" ", sentences);

        object data = new object[] {
            new object[] { words[6], words[8], words[9], words[10], words[11], words[12] },
            new object[] { words[5], words[4], words[3], words[2], words[1], words[0] },
            new object[] { words[12], words[11], words[10], words[9], words[8], words[6] },
            new object[] { words[0], words[1], words[2], words[3], words[4], words[5] },
            new object[] { words[6], words[8], words[9], words[10], words[11], words[12] },
            new object[] { words[5], words[4], words[3], words[2], words[1], words[0] },
            new object[] { words[12], words[11], words[10], words[9], words[8], words[6] },
            new object[] { words[0], words[1], words[2], words[3], words[4], words[5] },
            new object[] { words[6], words[8], words[9], words[10], words[11], words[12] },
            new object[] { words[5], words[4], words[3], words[2], words[1], words[0] },
            new object[] { words[12], words[11], words[10], words[9], words[8], words[6] },
            new object[] { words[0], words[1], words[2], words[3], words[4], words[5] },
            new object[] { words[6], words[8], words[9], words[10], words[11], words[12] },
            new object[] { words[5], words[4], words[3], words[2], words[1], words[0] },
            new object[] { words[12], words[11], words[10], words[9], words[8], words[6] },
            new object[] { words[0], words[1], words[2], words[3], words[4], words[5] },
            new object[] { words[6], words[8], words[9], words[10], words[11], words[12] },
            new object[] { words[5], words[4], words[3], words[2], words[1], words[0] },
            new object[] { words[12], words[11], words[10], words[9], words[8], words[6] },
            new object[] { words[0], words[1], words[2], words[3], words[4], words[5] }
        };

        Viewport viewport = new Viewport
        {
            Layout = "Border",
            RTL = true,
            Items = {
                new Ext.Net.Panel
                {
                    Region = Region.North,
                    Title = "\u0634\u0645\u0627\u0644",
                    Height = 100,
                    Html = paragraph,
                    AutoScroll = true,
                    Collapsible = true,
                    Split = true
                },

                new Ext.Net.Panel
                {
                    Region= Region.West,
                    Title = "\u0627\u0644\u0645\u0646\u0637\u0642\u0629 \u0627\u0644\u063a\u0631\u0628\u064a\u0629",
                    Width = 200,
                    Collapsible = true,
                    Split = true
                },

                new Ext.Net.GridPanel
                {
                    Region = Region.Center,
                    Title = "\u0645\u0631\u0643\u0632 \u0627\u0644\u0645\u0646\u0637\u0642\u0629",
                    ColumnModel =
                    {
                        Columns =
                        {
                            new Column { DataIndex = "foo", Text = words[0] },
                            new Column { DataIndex = "bar", Text = words[1] },
                            new Column { DataIndex = "baz", Text = words[2] },
                            new Column { DataIndex = "zork", Text = words[3] },
                            new Column { DataIndex = "gork", Text = words[4] },
                            new Column { DataIndex = "bork", Text = words[5], Flex = 1 }
                        }
                    },
                    Store =
                    {
                        new Store
                        {
                            Model =
                            {
                                new Model
                                {
                                    Fields =
                                    {
                                        new ModelField("foo"),
                                        new ModelField("bar"),
                                        new ModelField("baz"),
                                        new ModelField("zork"),
                                        new ModelField("gork"),
                                        new ModelField("bork")
                                    }
                                }
                            },

                            Reader =
                            {
                                new ArrayReader()
                            },

                            Data = data
                        }
                    }
                },

                new Ext.Net.Panel
                {
                    Region = Region.East,
                    Title = "\u0627\u0644\u0645\u0646\u0637\u0642\u0629 \u0627\u0644\u0634\u0631\u0642\u064a\u0629",
                    Width = 200,
                    Collapsible = true,
                    Split = true
                },

                new Ext.Net.Panel
                {
                    Region = Region.South,
                    Title = "\u062c\u0646\u0648\u0628 \u0627\u0644\u0645\u0646\u0637\u0642\u0629",
                    Height = 100,
                    Collapsible = true,
                    Split = true
                }
            }
        };

        this.Form.Controls.Add(viewport);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RTL - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
    </form>
</body>
</html>
