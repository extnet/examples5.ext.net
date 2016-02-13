<%@ Page Language="C#" %>

<%@ Import Namespace="System.Globalization" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Locale - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Locale="nl" />

        <h1>Dutch as default laguage</h1>

        <ext:DatePicker runat="server" />
    </form>
</body>
</html>