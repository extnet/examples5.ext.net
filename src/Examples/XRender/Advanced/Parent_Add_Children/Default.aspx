<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities"%>
<%@ Import Namespace="Panel=Ext.Net.Panel" %>

<script runat="server">
    /*  1. Build a new Window
        -----------------------------------------------------------------------------------------------*/

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        this.BuildWindow().Render(this.Form);

        this.Button1.Disabled = true;
        this.Button2.Disabled = false;
    }


    /*  2. Build a new TabPanel and add to Window
        -----------------------------------------------------------------------------------------------*/

    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        TabPanel tabPanel = this.BuildTabPanel();

        tabPanel.Items.Add(this.BuildPanel(1));
        tabPanel.Render("App.Window1", RenderMode.AddTo);

        this.Button2.Disabled = true;
        this.Button3.Disabled = false;
    }


    /*  3. Build a new Panel and add to TabPanel
        -----------------------------------------------------------------------------------------------*/

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        int index = this.GetIndex();

        this.BuildPanel(index).Render("App.TabPanel1", RenderMode.AddTo);
    }


    /*  Widget Builders
        -----------------------------------------------------------------------------------------------*/

    private Window BuildWindow()
    {
        return this.X().Window()
                        .ID("Window1")
                        .Title("My Window")
                        .Height(270)
                        .Width(480)
                        .Layout("Fit");
    }

    private TabPanel BuildTabPanel()
    {
        return this.X().TabPanel()
                        .ID("TabPanel1")
                        .BodyBorder(0);
    }

    private Panel BuildPanel(int index)
    {
        return this.X().Panel()
                        .ID("Tab" + index)
                        .Title("Tab " + index)
                        .BodyPadding(18)
                        .Html("Tab" + index + " was created at: " + DateTime.Now.ToLongTimeString());
    }


    /*  Helpers
        -----------------------------------------------------------------------------------------------*/

    private int GetIndex()
    {
        int index = Convert.ToInt32(this.Hidden1.Text);
        this.Hidden1.Text = (index + 1).ToString();
        return index;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Dynamic creation from code-behind - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Dynamic creation from code-behind</h1>

        <ext:Hidden ID="Hidden1" runat="server" Text="2" />

        <ext:Button
            ID="Button1"
            runat="server"
            Text="Step 1: Create Window"
            OnDirectClick="Button1_Click"
            />

        <ext:Button
            ID="Button2"
            runat="server"
            Text="Step 2: Add TabPanel"
            OnDirectClick="Button2_Click"
            Disabled="true"
            />

        <ext:Button
            ID="Button3"
            runat="server"
            Text="Step 3: Add Tab"
            OnDirectClick="Button3_Click"
            Disabled="true"
            />
    </form>
</body>
</html>