<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        var panel = new Ext.Net.Panel();
        var btnExpand = new Ext.Net.Button();
        var btnCollapse = new Ext.Net.Button();
        var btnMicro = new Ext.Net.Button();
        StatusBar statusBar = new StatusBar();

        var tree = new TreeList();
        var treeStore = new TreeStore();
        Toolbar toolBar = new Toolbar();
        Ext.Net.Node root = new Ext.Net.Node();

        tree.ID = "TreeList1";

        #region Tree List store
        List<Composer> composers = this.GetData();

        foreach (Composer composer in composers)
        {
            Ext.Net.Node composerNode = new Ext.Net.Node()
            {
                Text = composer.Name,
                IconCls = "x-fa fa-" + composer.Icon
            };
            root.Children.Add(composerNode);

            foreach(Composition composition in composer.Compositions)
            {
                Ext.Net.Node compositionNode = new Ext.Net.Node()
                {
                    Text = composition.Type.ToString(),
                    IconCls = "x-fa fa-book"
                };
                composerNode.Children.Add(compositionNode);

                foreach (Piece piece in composition.Pieces)
                {
                    Ext.Net.Node pieceNode = new Ext.Net.Node()
                    {
                        Text = piece.Title,
                        IconCls = "x-fa fa-music",
                        Leaf = true
                    };
                    compositionNode.Children.Add(pieceNode);
                }
            }
        }

        root.Expanded = true;
        treeStore.Root.Add(root);
        tree.Store.Add(treeStore);
        #endregion Tree List store

        panel.ID = "Panel1";
        panel.Icon = Icon.BookOpen;
        panel.Title = "Catalog";
        panel.Scrollable = ScrollableOption.Both;
        panel.Width = Unit.Pixel(400);
        panel.Height = Unit.Pixel(450);
        panel.LayoutConfig.Add(new VBoxLayoutConfig() { Align = VBoxAlign.Stretch });
        panel.Add(tree);

        #region Top and bottom bars on panel
        btnExpand.Text = "Expand All";
        btnExpand.Handler = tree.ClientID + ".getStore().getRoot().expandChildren(true);";

        btnCollapse.Text = "Collapse All";
        btnCollapse.Handler = tree.ClientID + ".getStore().getRoot().collapseChildren(true);";

        btnMicro.Text = "Toggle Micro";
        btnMicro.EnableToggle = true;
        btnMicro.Handler = tree.ClientID + ".setMicro(this.pressed);";

        toolBar.ID = "Toolbar1";
        toolBar.Items.Add(btnExpand);
        toolBar.Items.Add(btnCollapse);
        toolBar.Items.Add(btnMicro);
        panel.TopBar.Add(toolBar);

        statusBar.ID = "StatusBar1";
        statusBar.AutoClear = 1000;
        panel.BottomBar.Add(statusBar);
        #endregion Top and bottom bars on panel

        tree.Listeners.SelectionChange.Handler = statusBar.ClientID + ".setStatus({text: 'Node Selected: <b>' + record.data.text + '</b>', clear: false});";

        this.PlaceHolder1.Controls.Add(panel);
    }

    public class Composer
    {
        public Composer(string name, string icon)
        {
            this.Name = name;
            this.Icon = icon;
        }

        public string Name { get; set; }
        public string Icon { get; set; }

        private List<Composition> compositions;
        public List<Composition> Compositions
        {
            get
            {
                if (this.compositions == null)
                {
                    this.compositions = new List<Composition>();
                }
                return this.compositions;
            }
        }
    }

    public class Composition
    {
        public Composition() { }

        public Composition(CompositionType type)
        {
            this.Type = type;
        }

        public CompositionType Type { get; set; }

        private List<Piece> pieces;
        public List<Piece> Pieces
        {
            get
            {
                if (this.pieces == null)
                {
                    this.pieces = new List<Piece>();
                }
                return this.pieces;
            }
        }
    }

    public class Piece
    {
        public Piece() {}

        public Piece(string title)
        {
            this.Title = title;
        }

        public string Title { get; set; }
    }

    public enum CompositionType
    {
        Concertos,
        Quartets,
        Sonatas,
        Symphonies
    }

    public List<Composer> GetData()
    {
        Composer beethoven = new Composer("Beethoven", "umbrella");

        Composition beethovenConcertos = new Composition(CompositionType.Concertos);
        Composition beethovenQuartets = new Composition(CompositionType.Quartets);
        Composition beethovenSonatas = new Composition(CompositionType.Sonatas);
        Composition beethovenSymphonies = new Composition(CompositionType.Symphonies);

        beethovenConcertos.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "No. 1 - C" },
            new Piece{ Title = "No. 2 - B-Flat Major" },
            new Piece{ Title = "No. 3 - C Minor" },
            new Piece{ Title = "No. 4 - G Major" },
            new Piece{ Title = "No. 5 - E-Flat Major" }
        });

        beethovenQuartets.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Six String Quartets" },
            new Piece{ Title = "Three String Quartets" },
            new Piece{ Title = "Grosse Fugue for String Quartets" }
        });

        beethovenSonatas.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Sonata in A Minor" },
            new Piece{ Title = "sonata in F Major" }
        });

        beethovenSymphonies.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "No. 1 - C Major" },
            new Piece{ Title = "No. 2 - D Major" },
            new Piece{ Title = "No. 3 - E-Flat Major" },
            new Piece{ Title = "No. 4 - B-Flat Major" },
            new Piece{ Title = "No. 5 - C Minor" },
            new Piece{ Title = "No. 6 - F Major" },
            new Piece{ Title = "No. 7 - A Major" },
            new Piece{ Title = "No. 8 - F Major" },
            new Piece{ Title = "No. 9 - D Minor" }
        });

        beethoven.Compositions.AddRange(new List<Composition>{
            beethovenConcertos,
            beethovenQuartets,
            beethovenSonatas,
            beethovenSymphonies
        });


        Composer brahms = new Composer("Brahms", "truck");

        Composition brahmsConcertos = new Composition(CompositionType.Concertos);
        Composition brahmsQuartets = new Composition(CompositionType.Quartets);
        Composition brahmsSonatas = new Composition(CompositionType.Sonatas);
        Composition brahmsSymphonies = new Composition(CompositionType.Symphonies);

        brahmsConcertos.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Violin Concerto" },
            new Piece{ Title = "Double Concerto - A Minor" },
            new Piece{ Title = "Piano Concerto No. 1 - D Minor" },
            new Piece{ Title = "Piano Concerto No. 2 - B-Flat Major" }
        });

        brahmsQuartets.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Piano Quartet No. 1 - G Minor" },
            new Piece{ Title = "Piano Quartet No. 2 - A Major" },
            new Piece{ Title = "Piano Quartet No. 3 - C Minor" },
            new Piece{ Title = "Piano Quartet No. 3 - B-Flat Minor" }
        });

        brahmsSonatas.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Two Sonatas for Clarinet - F Minor" },
            new Piece{ Title = "Two Sonatas for Clarinet - E-Flat Major" }
        });

        brahmsSymphonies.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "No. 1 - C Minor" },
            new Piece{ Title = "No. 2 - D Minor" },
            new Piece{ Title = "No. 3 - F Major" },
            new Piece{ Title = "No. 4 - E Minor" }
        });

        brahms.Compositions.AddRange(new List<Composition>{
            brahmsConcertos,
            brahmsQuartets,
            brahmsSonatas,
            brahmsSymphonies
        });


        Composer mozart = new Composer("Mozart", "magic");

        Composition mozartConcertos = new Composition(CompositionType.Concertos);

        mozartConcertos.Pieces.AddRange(new List<Piece> {
            new Piece{ Title = "Piano Concerto No. 12" },
            new Piece{ Title = "Piano Concerto No. 17" },
            new Piece{ Title = "Clarinet Concerto" },
            new Piece{ Title = "Violin Concerto No. 5" },
            new Piece{ Title = "Violin Concerto No. 4" }
        });

        mozart.Compositions.Add(mozartConcertos);

        return new List<Composer>{ beethoven, brahms, mozart };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multi Node Tree List built from code-behind - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <%
        #region Set up font awesome if the current theme does not natively supports it.
        var manager = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);
        var theme = manager.Theme;
        if (theme != Ext.Net.Theme.Triton && theme != Ext.Net.Theme.Graphite && theme != Ext.Net.Theme.Material)
        {
    %>
    <link href="/resources/css/font-awesome.min.css" rel="stylesheet" />
    <style type="text/css">
        /* wraps over the x-fa CSS class to match the reference from the Triton/Graphite themes */
        .x-fa {
          display: inline-block;
          font: normal normal normal 14px/1 FontAwesome;
          font-size: inherit;
          text-rendering: auto;
          -webkit-font-smoothing: antialiased;
          -moz-osx-font-smoothing: grayscale;
        }
    </style>
    <%
        }
        #endregion Set up font awesome if the current theme does not natively supports it.
    %>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>Multi Node Tree List Built From Code Behind</h1>

        <p>
            This is the equivalent to the <b>TreePanel Built from Code Behind</b> example, using the <b>TreeList</b> component.
        </p>

        <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
    </form>
</body>
</html>