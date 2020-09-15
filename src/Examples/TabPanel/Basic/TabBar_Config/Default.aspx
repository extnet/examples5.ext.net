<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TabBar Config - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

            switch (curTheme.Theme)
            {
                case Ext.Net.Theme.Aria:
                    Window1.Height = 555;
                    break;
                case Ext.Net.Theme.Spotless:
                case Ext.Net.Theme.Triton:
                case Ext.Net.Theme.CrispTouch:
                    Window1.Width = 665;
                    Window1.Height = 530;
                    break;
                case Ext.Net.Theme.Gray:
                case Ext.Net.Theme.Classic:
                    Window1.Width = 675;
                    Window1.Height = 503;
                    break;
                case Ext.Net.Theme.Graphite:
                    Window1.Width = 668;
                    Window1.Height = 638;
                    break;
                case Ext.Net.Theme.Crisp:
                    Window1.Width = 665;
                    Window1.Height = 513;
                    break;
                case Ext.Net.Theme.Material:
                    Window1.Width = 670;
                    Window1.Height = 557;
                    break;
                case Ext.Net.Theme.Neptune:
                    Window1.Width = 670;
                    Window1.Height = 518;
                    break;
                case Ext.Net.Theme.NeptuneTouch:
                    Window1.Width = 670;
                    Window1.Height = 533;
                    break;
            }
        }

        protected void AddTab(object sender, DirectEventArgs e)
        {
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current).Theme;
            var accessible = curTheme == Ext.Net.Theme.Aria || curTheme == Ext.Net.Theme.Graphite;

            Ext.Net.Panel panel = new Ext.Net.Panel
            {
                Title = "New Tab",
                Closable = !accessible,
                Layout = "Fit",
                Items = {
                    new UserControlLoader{Path="ElementChooser.ascx"}
                }
            };

            if (accessible)
            {
                var closeToolbar = new Toolbar();
                closeToolbar.Add(new Ext.Net.Button()
                {
                    Text = "Close",
                    Handler = "this.up('panel').destroy();"
                });
                panel.TopBar.Add(closeToolbar);
            }

            TabPanel1.Add(panel);
            panel.Render();

            TabPanel1.SetLastTabAsActive();
        }
    </script>

    <style>
        .x-newtab-item
        {
            float: left;
            margin: 10px;
            width: 200px;
            height: 200px;
            border: 2px solid #E0E0E0;
            cursor: pointer;
            text-align: center;
        }

        .x-newtab-over-item
        {
            border: 2px solid gray;
        }

        .x-newtab-item h1
        {
            font-size: 160px;
            margin-top: 25px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            ID="Window1"
            Title="TabBar Config"
            Width="680"
            Resizable="false"
            Closable="false"
            Height="530"
            IconCls="x-md md-icon-link"
            Layout="Fit">
            <Items>
                <ext:TabPanel ID="TabPanel1" runat="server">
                    <TabBar>
                        <ext:Button runat="server" Flat="true" IconCls="x-md md-icon-add-circle-outline">
                            <DirectEvents>
                                <Click OnEvent="AddTab" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Flat="true" IconCls="x-md md-icon-help-outline">
                            <Listeners>
                                <Click Handler="Ext.Msg.alert('Help', 'Here is help message');" />
                            </Listeners>
                        </ext:Button>
                    </TabBar>
                </ext:TabPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
