<%@ Page Language="C#" %>

<%@ Import Namespace="System.IO" %>
  
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        StreamReader streamReader = File.OpenText(MapPath("~/App_Readme/Ext.NET/Sample.Web.config"));
        this.pre1.InnerText = streamReader.ReadToEnd();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Sample Web.config file - Ext.NET Examples</title>
    <link href="/resources/css/examples.css"  rel="stylesheet" />
</head>
<body>
    <pre class="code" runat="server" id="pre1"></pre>
</body>
</html>
    