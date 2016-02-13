<%@ Page Language="C#" %>

<%@ Import Namespace="System.Globalization" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Request.UserLanguages == null)
        {
            this.Label1.Html = "User Language: <b>Is Absent</b>";
            return;
        }

        string lang = this.Request.UserLanguages[0];
        Label1.Html = "User Language: <b>" + lang + "</b>";
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Locale - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Locale="Client" />

        <h1>User Language</h1>

        <ext:Label ID="Label1" runat="server" />

        <br />

        <ext:DatePicker runat="server" />
    </form>
</body>
</html>