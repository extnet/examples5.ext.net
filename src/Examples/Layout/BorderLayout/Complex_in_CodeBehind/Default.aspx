<%@ Page Language="C#" Debug="true" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        /////////////////
        // WEST REGION //
        /////////////////

        // Make Panel for West Region
        Ext.Net.Panel west = new Ext.Net.Panel();
        west.ID = "WestPanel";
        west.Width = Unit.Pixel(175);

        // Make Navigation Panel for Accordion
        Ext.Net.Panel pnlNavigation = new Ext.Net.Panel();
        pnlNavigation.ID = "Navigation";
        pnlNavigation.Title = "Navigation";
        pnlNavigation.Border = false;
        pnlNavigation.BodyPadding = 18;
        pnlNavigation.Icon = Icon.FolderGo;
        pnlNavigation.Html = "Navigation";

        // Make Settings Panel for Accordion
        Ext.Net.Panel pnlSettings = new Ext.Net.Panel();
        pnlSettings.ID = "Settings";
        pnlSettings.Title = "Settings";
        pnlSettings.Border = false;
        pnlSettings.BodyPadding = 18;
        pnlSettings.Icon = Icon.FolderWrench;
        pnlSettings.Html = "Some settings in here";
        west.Layout = "Accordion";

        // Add Navigation and Settings Panels to West Panel
        west.Items.Add(pnlNavigation);
        west.Items.Add(pnlSettings);

        ///////////////////
        // CENTER REGION //
        ///////////////////

        // Make TabPanel for Center Region
        TabPanel center = new TabPanel();
        center.ID = "CenterPanel";
        center.ActiveTabIndex = 0;

        // Make Tab
        Ext.Net.Panel tab1 = new Ext.Net.Panel();
        tab1.ID = "Tab1";
        tab1.Title = "Close Me";
        tab1.Closable = true;
        tab1.Border = false;
        tab1.BodyPadding = 18;
        tab1.Html = "Hello ...";

        Ext.Net.Panel tab2 = new Ext.Net.Panel();
        tab2.ID = "Tab2";
        tab2.Title = "Center";
        tab2.Border = false;
        tab2.BodyPadding = 18;
        tab2.Html = "... World";

        // Add Tab's to TabPanel
        center.Items.Add(tab1);
        center.Items.Add(tab2);

        /////////////////
        // EAST REGION //
        /////////////////

        // Make Panel for East Region
        Ext.Net.Panel east = new Ext.Net.Panel();
        east.ID = "EastPanel";
        east.Title = "East";
        east.Width = Unit.Pixel(225);
        east.Layout = "Fit";

        // Make TabPanel for East Panel
        TabPanel tpEast = new TabPanel();
        tpEast.ActiveTabIndex = 1;
        tpEast.TabPosition = TabPosition.Bottom;
        tpEast.Border = false;

        // Make Tab 1
        Ext.Net.Panel tabEast1 = new Ext.Net.Panel();
        tabEast1.Title = "Tab 1";
        tabEast1.Border = false;
        tabEast1.BodyPadding = 18;
        tabEast1.Html = "East Tab 1";

        // Make Tab 2
        Ext.Net.Panel tabEast2 = new Ext.Net.Panel();
        tabEast2.Title = "Tab 2";
        tabEast2.Closable = true;
        tabEast2.Border = false;
        tabEast2.BodyPadding = 18;
        tabEast2.Html = "East Tab 2";

        // Add Tab's to East TabPanel
        tpEast.Items.Add(tabEast1);
        tpEast.Items.Add(tabEast2);

        // Add FitLayout container to East Panel
        east.Items.Add(tpEast);

        //////////////////
        // SOUTH REGION //
        //////////////////

        // Make Panel for South Region
        Ext.Net.Panel south = new Ext.Net.Panel();
        south.ID = "SouthPanel";
        south.Title = "South";
        south.Height = Unit.Pixel(150);
        south.BodyPadding = 18;
        south.Html = "South";


        ///////////////////////
        // MAIN BORDERLAYOUT //
        ///////////////////////

        // Set Center Region properties
        center.Region = Region.Center;

        // Set West Region properties
        west.Title = "West";
        west.MinWidth = 175;
        west.MaxWidth = 400;
        west.Split = true;
        west.Collapsible = true;
        west.Region = Region.West;

        // Set East Region properties
        east.MinWidth = 180;
        east.Split = true;
        east.Collapsible = true;
        east.Region = Region.East;

        // Set South Region properties
        south.Split = true;
        south.Collapsible = true;
        south.Region = Region.South;

        /////////////////
        // MAIN WINDOW //
        /////////////////

        // Make Window to hold everything
        Window win = new Window();
        win.ID = "Window1";
        win.Title = "Complex Layout";
        win.Icon = Icon.Application;
        win.Width = Unit.Pixel(640);
        win.Height = Unit.Pixel(480);
        win.Plain = true;
        win.Border = false;
        win.BodyBorder = 0;
        win.Collapsible = true;
        win.AnimateTarget = "Button1";
        win.Layout = "Border";

        // Add BorderLayout to Window
        win.Items.Add(west);
        win.Items.Add(east);
        win.Items.Add(center);
        win.Items.Add(south);

        // Add Window to Form
        this.PlaceHolder1.Controls.Add(win);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Complex BorderLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Complex BorderLayout in CodeBehind</h1>

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