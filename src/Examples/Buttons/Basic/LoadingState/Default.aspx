<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        System.Threading.Thread.Sleep(2000);

        X.Msg.Info("Server Time", DateTime.Now.ToLongTimeString()).Show();
    }
</script>
    
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Button Loading Variations - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />
   
    <h1>Button Loading Variations</h1>
    
    <p>Each sample runs with a two second delay server-side to simulate a long running process.</p>

    <h2>1. Button with AutoLoadingState</h2>
    
    <ext:Button 
        runat="server" 
        Text="Click Me" 
        AutoLoadingState="true" 
        OnDirectClick="Button1_Click" 
        />

    <h2>2. Button with custom &lt;LoadingState&gt; configuration</h2>

    <ext:Button runat="server" Text="Click Me" OnDirectClick="Button1_Click">
        <LoadingState Text="Please Wait..." />
    </ext:Button>

</body>
</html>
