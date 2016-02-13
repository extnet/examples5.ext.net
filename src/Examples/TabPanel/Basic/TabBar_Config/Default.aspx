<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TabBar Config - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void AddTab(object sender, DirectEventArgs e)
        {
            Ext.Net.Panel panel = new Ext.Net.Panel
            {
                Title = "New Tab",
                Closable = true,
                Layout = "Fit",
                Items = {
                    new UserControlLoader{Path="ElementChooser.ascx"}
                }
            };
            TabPanel1.Add(panel);
            panel.Render();

            TabPanel1.SetLastTabAsActive();
        }
    </script>

    <style>
        .x-newtab-item
        {
            float:left;
            margin:10px;
            width:200px;
            height:200px;
            border: 2px solid #E0E0E0;
            cursor: pointer;
            text-align:center;
        }

        .x-newtab-over-item
        {
            border: 2px solid gray;
        }

        .x-newtab-item h1
        {
            font-size:160px;
            margin-top: 100px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            Title="TabBar Config"
            Width="680"
            Resizable="false"
            Closable="false"
            Height="500"
            Icon="Link"
            Layout="FitLayout">
            <Items>
                <ext:TabPanel ID="TabPanel1" runat="server">
                    <TabBar>
                        <ext:Button runat="server" Flat="true" Icon="Add">
                            <DirectEvents>
                                <Click OnEvent="AddTab" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Flat="true" Icon="Help">
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
