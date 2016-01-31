<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Form.Controls.Add(new MultiSortPanel());
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multisort DataView Example</title>    
    
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Multisort DataView Example</h1>

        <p>This example shows using multiple sorters on a Store attached to a DataView.</p>
    	
        <p>We're also using the reorderable toolbar plugin to make it easy to reorder the sorters with drag and drop.</p>
    </form>
</body>
</html>