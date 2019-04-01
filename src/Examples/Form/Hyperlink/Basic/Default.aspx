<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Hyperlink Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Hyperlink Variations</h1>

    <h2>Simple Hyperlink</h2>

    <ext:Hyperlink
        runat="server"
        NavigateUrl="https://ext.net"
        Text="https://ext.net"
        Target="_blank"
        />

    <h2>Hyperlink with Icon</h2>

    <ext:Hyperlink
        runat="server"
        Icon="Application"
        Target="_blank"
        NavigateUrl="https://ext.net"
        Text="https://ext.net"
        />

    <h2>Hyperlink with Right Aligned Icon</h2>

    <ext:Hyperlink
        runat="server"
        Icon="Application"
        IconAlign="Right"
        Target="_blank"
        NavigateUrl="https://ext.net"
        Text="https://ext.net"
        />

    <h2>Image Hyperlink</h2>

    <ext:Hyperlink
        runat="server"
        Target="_blank"
        NavigateUrl="https://ext.net"
        ImageUrl="https://speed.ext.net/identity/extnet-logo-small.png"
        />
</body>
</html>