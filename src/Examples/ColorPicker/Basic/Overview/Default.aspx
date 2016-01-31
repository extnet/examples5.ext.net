<%@ Page Language="C#" %>

    
<script runat="server">
    protected void Color_Changed(object sender, EventArgs e)
    {
        string tpl = "Choosen color: #<span style='color:#{0};font-weight:bold;'>{0}</span>";
        this.Label1.Html = string.Format(tpl, this.ColorPalette1.Value);
    }

    protected void AjaxColor_Changed(object sender, DirectEventArgs e)
    {
        string tpl = "Choosen color: #<span style='color:#{0};font-weight:bold;'>{0}</span>";
        this.Label2.Html = string.Format(tpl, this.ColorPalette2.Value);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ColorPalate Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h2>1. PostBack model</h2>
        
        <ext:ColorPicker
            ID="ColorPalette1" 
            runat="server" 
            AutoPostBack="true" 
            OnColorChanged="Color_Changed"
            />
        
        <ext:Label ID="Label1" runat="server" />
        
        <h2>2. DirectEvent model</h2>
        
        <ext:ColorPicker ID="ColorPalette2" runat="server">
            <DirectEvents>
                <Select OnEvent="AjaxColor_Changed" />
            </DirectEvents>
        </ext:ColorPicker>
        
        <ext:Label ID="Label2" runat="server" />
    </form>
</body>
</html>