<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Column Layout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Viewport runat="server" Layout="ColumnLayout">
        <Items>
            <ext:Panel 
                runat="server" 
                ColumnWidth="0.25" 
                Height="100"
                Title="Width=0.25" 
                Html="This is some content." 
                />
            <ext:Panel 
                runat="server" 
                ColumnWidth="0.75" 
                Height="100"
                Title="Width=0.75" 
                Html="This is some content." 
                />
            <ext:Panel 
                runat="server"                
                Title="Width=250px" 
                Height="100"
                Width="250" 
                Html="This is some content." 
                />
        </Items>
    </ext:Viewport>
</body>
</html>