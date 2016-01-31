<%@ Page Language="C#" %>

<%@ Import Namespace="Panel=Ext.Net.Panel" %>
<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        int index = this.GetIndex();

        /* TabPanel */

        Ext.Net.Panel tab = new Panel
        {
            ID = "Tab" + index,
            Title = "Tab " + index,
            Html = "Tab {0} : ({1})".FormatWith(index, DateTime.Now.ToLongTimeString()),
            BodyPadding = 5,
            Border = false
        };
        
        tab.AddTo(this.TabPanel1);
        
        this.TabPanel1.SetActiveTab("Tab" + index);
        
        
        /* Accordion */

        Ext.Net.Panel panel = new Panel
        {
            ID = "Panel" + index,
            Title = "Panel " + index,
            Html = "Panel {0} : ({1})".FormatWith(index, DateTime.Now.ToLongTimeString()),
            BodyPadding = 5,
            Border = false
        };

        // You can also call .Render and pass RenderMode.AddTo as the second param
        // p.Render(this.Panel1, RenderMode.AddTo);

        // or, call .AddTo Method which performs the same action as above line.
        panel.AddTo(this.Panel1);

        panel.Expand();
    }

    private int GetIndex()
    {
        int index = Convert.ToInt32(this.Hidden1.Text) + 1;
        
        this.Hidden1.Text = index.ToString();

        return index;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Dynamically add a new Panel to a Parent Items Collection - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Dynamically add a new Panel to a Parent Items Collection</h1>
        
        <ext:Button 
            runat="server" 
            Text="Add Panel" 
            Icon="Add" 
            OnDirectClick="Button1_Click" 
            />
        
        <ext:Hidden ID="Hidden1" runat="server" Text="1" />
        
        <h2>Add a Panel to the TabPanel</h2>
        
        <ext:TabPanel 
            ID="TabPanel1" 
            runat="server" 
            Height="185" 
            Width="350">
            <Items>
                <ext:Panel 
                    runat="server" 
                    Title="Tab 1" 
                    Html="Tab 1" 
                    BodyPadding="5" 
                    />
            </Items>
        </ext:TabPanel>
        
        <h2>Add a Panel to the Accordion Layout</h2>
        
        <ext:Panel 
            ID="Panel1" 
            runat="server" 
            Title="Accordion"
            MinHeight="215"
            Width="350"
            Layout="Accordion">
            <Items>
                <ext:Panel 
                    runat="server" 
                    Title="Panel 1" 
                    Html="Panel 1" 
                    BodyPadding="5" 
                    Border="false" 
                    />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>