<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Build Panel for West Region
        Ext.Net.Panel pnl = new Ext.Net.Panel();
        pnl.ID = "Panel1";
        pnl.Title = "Navigation";
        pnl.Width = Unit.Pixel(175);
        pnl.Region = Region.West;

        // Build TabPanel for Center Region
        Ext.Net.Panel tab1 = new Ext.Net.Panel();
        tab1.Title = "First Tab";
        tab1.BodyStyle = "padding: 6px;";
        tab1.Html = "First Tab";
        

        Ext.Net.Panel tab2 = new Ext.Net.Panel();
        tab2.Title = "Another Tab";
        tab2.BodyStyle = "padding: 6px;";
        tab2.Html = "Another Tab";

        Ext.Net.Panel tab3 = new Ext.Net.Panel();
        tab3.Title = "Closeable Tab";
        tab3.Closable = true;
        tab3.BodyStyle = "padding: 6px;";
        tab3.Html = "Closeable Tab";

        TabPanel tp = new TabPanel();
        tp.ID = "TabPanel1";
        tp.Region = Region.Center;
        
        // Set first Tab to be the .ActiveTabIndex
        tp.ActiveTabIndex = 0;
        
        // Add Tabs to TabPanel
        tp.Items.Add(tab1);
        tp.Items.Add(tab2);
        tp.Items.Add(tab3);

        // Set West Region properties
        pnl.Collapsible = true;
        pnl.MinWidth = 175;
        pnl.Split = true;

        // Build Window to hold everything
        Window win = new Window();
        win.ID = "Window1";
        win.Layout = LayoutType.Border.ToString();
        win.Title = "Simple Layout";
        win.Icon = Icon.Application;
        win.Width = Unit.Pixel(600);
        win.Height = Unit.Pixel(350);
        win.Border = false;
        win.Collapsible = true;
        win.Plain = true;

        win.Items.Add(pnl);
        win.Items.Add(tp);

        // Add Window to Form
        this.PlaceHolder1.Controls.Add(win);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple BorderLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>Simple BorderLayout in CodeBehind</h1>
    
    <ext:Button 
        ID="Button1" 
        runat="server" 
        Text="Show Window" 
        Icon="Application">
        <Listeners>
            <Click Handler="#{Window1}.show();" />
        </Listeners>    
    </ext:Button>
    
    <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
</body>
</html>