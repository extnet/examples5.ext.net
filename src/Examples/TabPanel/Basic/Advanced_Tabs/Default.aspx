<%@ Page Language="C#" %>

<%@ Import Namespace="Panel=Ext.Net.Panel" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Window win = new Window
        {
            Height = 250,
            Width = 600,
            Closable = false,
            Title = "Scrollable Tabs",
            Layout = "Fit"
        };

        TabPanel tabs = new TabPanel
        {
            ID = "TabPanel1",
            Border = false,
            MinTabWidth = 100,                      
            ActiveTabIndex = 6,
            Plugins =
            {
                new TabScrollerMenu { PageSize = 5 }
            }
        };
        
        tabs.Add(new Panel { Title = "Our First Tab" });
        
        int index = 1;
        
        while (index <= 11)
        {
            Panel tab = new Panel
            {
                Title = "Tab # " + index.ToString(),
                Html = "Tab " + index.ToString(),
                Closable = true,
                Border=false,
                Padding = 6
            };
            
            tabs.Items.Add(tab);
            index++;
        }

        win.Items.Add(tabs);
        
        this.Form.Controls.Add(win);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Scrollable Tabs with TabScrollerMenu Plugin - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Scrollable Tabs with TabScrollerMenu Plugin</h1>
    </form>
</body>
</html>
