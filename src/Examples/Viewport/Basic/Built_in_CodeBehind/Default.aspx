<%@ Page Language="C#" %>

<%@ Import Namespace="Panel=Ext.Net.Panel" %>
  
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Center Region
        TabPanel center = new TabPanel
        {
            Region = Region.Center,
            ActiveTabIndex = 0,
            Items = 
            {
                new Panel
                {
                    Title = "Center",
                    BodyBorder = 0,
                    BodyPadding = 6,
                    Html = "<h1>Viewport with BorderLayout</h1>"
                },
                new Panel
                {
                    Title = "Close Me",
                    Closable = true,
                    BodyBorder = 0,
                    BodyPadding = 6,
                    Html = "Closable Tab"
                }
            }
        };
        
        // South Region
        Panel north = new Panel
        {
            Region = Region.North,
            Title = "North",
            Height = Unit.Pixel(150),
            BodyPadding = 6,
            Html = "North",
            Split = true,
            Collapsible = true
        };

        // East Region
        Panel east = new Panel
        {
            Region = Region.East,
            Layout = "FitLayout",
            Title = "East",
            Width = 225,
            MinWidth = 225,
            Split = true,
            Collapsible = true,
            Items = 
            { 
                new TabPanel
                {
                    ActiveTabIndex = 1,
                    TabPosition = TabPosition.Bottom,
                    BodyBorder = 0,
                    Items = 
                    { 
                        new Panel
                        {
                            Title = "Tab 1",
                            BodyBorder = 0,
                            BodyPadding = 6,
                            Html = "East Tab 1"
                        },
                        new Panel
                        {
                            Title = "Tab 2",
                            BodyBorder = 0,
                            BodyPadding = 6,
                            Html = "East Tab 2"
                        }
                    }
                }
            }
        };
        
        
        // West Region
        Panel west = new Panel
        {
            Region = Region.West,
            Title = "West",
            Width = Unit.Pixel(225),
            Layout = "AccordionLayout",
            MinWidth = 225,
            MaxWidth = 400,
            Split = true,
            Collapsible = true,
            Items = 
            { 
                new Panel
                {
                    Title = "Navigation",
                    BodyBorder = 0,
                    BodyStyle = "padding:6px;",
                    Icon = Icon.FolderGo,
                    Html = "West"
                },
                new Panel 
                {
                    Title = "Settings",
                    BodyBorder = 0,
                    BodyStyle = "padding:6px;",
                    Icon = Icon.FolderWrench,
                    Html = "Some settings in here"
                }
            }
        };
        
        
        // Viewport
        Viewport viewport = new Viewport
        {
            Layout = "BorderLayout",
            Items = 
            { 
                center,
                north, 
                east,
                west,
                new Panel 
                {
                    Region = Region.South,
                    Title = "South",
                    Height = Unit.Pixel(150),
                    BodyPadding = 6,
                    Html = "South",
                    Split = true,
                    Collapsible = true
                }
            }
        };

        // Add Viewport to Page
        this.Controls.Add(viewport);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Viewport with BorderLayout - Ext.NET Examples</title>
</head>
<body>
    <ext:ResourceManager runat="server" />
</body>
</html>