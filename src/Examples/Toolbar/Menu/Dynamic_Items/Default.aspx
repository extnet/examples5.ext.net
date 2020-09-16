<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public string Items(Dictionary<string, string> parameters)
    {
        System.Threading.Thread.Sleep(1500); //emulate net delay
        string tag = parameters["tag"];

        List<Ext.Net.MenuItem> items = new List<Ext.Net.MenuItem>();
        switch (tag)
        {
            case "file":
                items.Add(new Ext.Net.MenuItem("New") { IconCls = "x-md md-icon-add-circle" });
                items.Add(new Ext.Net.MenuItem("Open") { IconCls = "x-md md-icon-folder" });
                items.Add(new Ext.Net.MenuItem("Save") { IconCls = "x-md md-icon-save" });
                items.Add(new Ext.Net.MenuItem("Save As")
                {
                    Menu = {
                        new Ext.Net.Menu
                        {
                            TagString = "saveas",
                            Items = {
                                new Ext.Net.MenuItem { IconCls="x-loading-indicator", Text="Loading...", Focusable=false, HideOnClick=false }
                            },
                            Loader = new ComponentLoader
                            {
                                Mode = LoadMode.Component,
                                DirectMethod = "#{DirectMethods}.Items",
                                RemoveAll = true,
                                Params = {
                                    new Ext.Net.Parameter("tag", "this.tag", ParameterMode.Raw)
                                }
                            }
                        }
                    }
                });
                items.Add(new Ext.Net.MenuItem("Print")
                {
                    IconCls = "x-md md-icon-print",
                    Menu =
                    {
                        new Ext.Net.Menu
                        {
                            Items = {
                                new Ext.Net.MenuItem { IconCls="x-loading-indicator", Text="Loading...", Focusable=false, HideOnClick=false }
                            },
                            TagString = "print",
                            Loader = new ComponentLoader
                            {
                                Mode = LoadMode.Component,
                                DirectMethod = "#{DirectMethods}.Items",
                                RemoveAll = true,
                                Params = {
                                    new Ext.Net.Parameter("tag", "this.tag", ParameterMode.Raw)
                                }
                            }
                        }
                    }
                });
                break;

            case "edit":
                items.Add(new Ext.Net.MenuItem("Copy") { });
                items.Add(new Ext.Net.MenuItem("Paste") { });
                items.Add(new Ext.Net.MenuItem("Cut") { });
                break;

            case "insert":
                items.Add(new Ext.Net.MenuItem("Picture") { });
                items.Add(new Ext.Net.MenuItem("Shape") { });
                items.Add(new Ext.Net.MenuItem("Chart") { });
                break;

            case "saveas":
                items.Add(new Ext.Net.MenuItem("Format 1"));
                items.Add(new Ext.Net.MenuItem("Format 2"));
                items.Add(new Ext.Net.MenuItem("Format 3"));
                break;

            case "print":
                items.Add(new Ext.Net.MenuItem("Print"));
                items.Add(new Ext.Net.MenuItem("Quick print"));
                items.Add(new Ext.Net.MenuItem("Preview"));
                break;
            default:
                items.Add(new Ext.Net.MenuItem { Text = "No Items", Disabled = true });
                break;
        }

        return ComponentLoader.ToConfig(items);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Dynamic Menu Items - Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Toolbar runat="server">
            <Items>
                <ext:Button runat="server" Text="File">
                    <Menu>
                        <ext:Menu runat="server" TagString="file">
                            <Items>
                                <ext:MenuItem
                                    runat="server"
                                    IconCls="x-loading-indicator"
                                    Text="Loading..."
                                    Focusable="false"
                                    HideOnClick="false"
                                    />
                            </Items>
                            <Loader Mode="Component" DirectMethod="#{DirectMethods}.Items" RemoveAll="true">
                                <Params>
                                    <ext:Parameter Name="tag" Value="this.tag" Mode="Raw" />
                                </Params>
                            </Loader>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
                <ext:Button runat="server" Text="Edit">
                    <Menu>
                        <ext:Menu runat="server" TagString="edit">
                            <Items>
                                <ext:MenuItem
                                    runat="server"
                                    IconCls="x-loading-indicator"
                                    Text="Loading..."
                                    Focusable="false"
                                    HideOnClick="false"
                                    />
                            </Items>
                            <Loader Mode="Component" DirectMethod="#{DirectMethods}.Items" RemoveAll="true">
                                <Params>
                                    <ext:Parameter Name="tag" Value="this.tag" Mode="Raw" />
                                </Params>
                            </Loader>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
                <ext:Button runat="server" Text="Insert">
                    <Menu>
                        <ext:Menu runat="server" TagString="insert">
                            <Items>
                                <ext:MenuItem
                                    runat="server"
                                    IconCls="x-loading-indicator"
                                    Text="Loading..."
                                    Focusable="false"
                                    HideOnClick="false"
                                    />
                            </Items>
                            <Loader Mode="Component" DirectMethod="#{DirectMethods}.Items" RemoveAll="true">
                                <Params>
                                    <ext:Parameter Name="tag" Value="this.tag" Mode="Raw" />
                                </Params>
                            </Loader>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
                <ext:Button runat="server" Text="Invalid tag">
                    <Menu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:MenuItem
                                    runat="server"
                                    IconCls="x-loading-indicator"
                                    Text="Loading..."
                                    Focusable="false"
                                    HideOnClick="false"
                                    />
                            </Items>
                            <Loader Mode="Component" DirectMethod="#{DirectMethods}.Items" RemoveAll="true">
                                <Params>
                                    <ext:Parameter Name="tag" Value="invalid_tag" Mode="Value" />
                                </Params>
                            </Loader>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </form>
</body>
</html>
