<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Label Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Label Variations</h1>

    <h2>Simple Label</h2>

    <ext:Label runat="server" Text="Hello World" />

    <h2>Label with Html</h2>

    <ext:Label runat="server" Html="<i>Label</i>" />

    <h2>Label with Icon</h2>

    <ext:Label runat="server" Text="Hello World" IconCls="x-md md-icon-check-circle-outline" />

    <h2>Label with Right Aligned Icon</h2>

    <ext:Label
        runat="server"
        Text="Hello World"
        IconCls="x-md md-icon-check-circle-outline"
        IconAlign="Right"
        />
</body>
</html>