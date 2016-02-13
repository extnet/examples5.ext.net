<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Window win = new Window()
        {
            ID = "Window1",
            Title = "Ext.NET",
            Width = Unit.Pixel(1000),
            Height = Unit.Pixel(600),
            Modal = true,
            AutoRender = false,
            Collapsible = true,
            Maximizable = true,
            Hidden = true,
            Loader = new ComponentLoader
            {
                Url = "http://ext.net",
                Mode = LoadMode.Frame,
                LoadMask =
                {
                    ShowMask = true
                }
            }
        };

        this.Form.Controls.Add(win);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Load External Website into Window - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Load External Website into an &lt;ext:Window></h1>

        <p>Load an external url into a Window using the AutoLoad property.
            All Properties for the &lt;ext:Window> are set during the Page_Load Event.</p>

        <ext:Button runat="server" Text="Show Window" Icon="Application">
            <Listeners>
                <Click Handler="#{Window1}.show(this);" />
            </Listeners>
        </ext:Button>
    </form>
</body>
</html>