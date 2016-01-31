<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (CultureInfo culture in Ext.Net.ResourceManager.SupportedCultures)
        {
            this.ComboBox1.Items.Add(new Ext.Net.ListItem(culture.EnglishName, culture.ToString()));
        }

        if (!this.IsPostBack)
        {
            bool isParent;
            
            if (Ext.Net.ResourceManager.IsSupportedCulture(this.ResourceManager1.Locale, out isParent))
            {
                string cultureName = isParent ? this.ResourceManager1.Locale.Split(new char[] { '-' })[0] : this.ResourceManager1.Locale;
                this.ComboBox1.SelectedItems.Add(new Ext.Net.ListItem { Value = cultureName });
            }
        }
    }
        
    protected void ComboBox1_ItemSelected(object sender, EventArgs e)
    {
        if (this.ComboBox1.SelectedItems[0].Value == "Ignore")
        {
            this.ResourceManager1.Locale = "Ignore";
            return;
        }
        
        this.Page.Culture = this.ComboBox1.SelectedItems[0].Value;                  
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Locale - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />    

    <style>
        .spacer {
            width  : 176px; 
            height : 5px; 
            border-bottom : dotted 1px gray;
            margin-bottom : 5px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <h1>Auto detect language (depending UI Culture)</h1>
        
        <ext:ComboBox 
            ID="ComboBox1" 
            runat="server" 
            AutoPostBack="true" 
            OnItemSelected="ComboBox1_ItemSelected" 
            Width="176">
            <Items>
                <ext:ListItem Text="None" Value="Ignore" />
            </Items>
        </ext:ComboBox>
        
        <div class="spacer" />
        
        <ext:DatePicker runat="server" />
    </form>
</body>
</html>