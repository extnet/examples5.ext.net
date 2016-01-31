<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Child Page</title>
</head>
<body style="padding:10px;">
    <% System.Threading.Thread.Sleep(1000); %>
    
    Child page creation time:&nbsp;
    <%= DateTime.Now.ToLongTimeString() %>
</body>
</html>
