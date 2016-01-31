<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public void UnhandledException()
    {
        throw new Exception("Unhandled Exception");
    }

    [DirectMethod]
    public void CatchException()
    {
        try
        {
            throw new Exception("An Exception was Thrown");
        }
        catch(Exception e)
        {
            Ext.Net.ResourceManager.AjaxSuccess = false;
            Ext.Net.ResourceManager.AjaxErrorMessage = e.Message;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectMethod and UserControls - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" DirectMethodNamespace="CompanyX" />
        
        <h1>Handling Exceptions in [DirectMethod]</h1>
        
        <div class="information">
            <p>The <code>DirectMethodNamespace</code> property has been set to "<b>CompanyX</b>" on the &lt;ext:ResourceManager> which overrides the default <code>[DirectMethod]</code> Namespace value of "<b>App.direct</b>".</p>
        </div>
        
        <h2>Dealing with [DirectMethod] Exceptions and request failure</h2>
        
        <p>&nbsp;</p>
        
        <h3>Example</h3>
           
        <ext:Button ID="Button1" runat="server" Text="Unhandled Exception">
            <Listeners>
                <Click Handler="CompanyX.UnhandledException({ failure: function (msg) { Ext.Msg.alert('Failure', msg); } });" />
            </Listeners>
        </ext:Button>
        
        <br />
        
        <ext:Button ID="Button2" runat="server" Text="Catch Exception">
            <Listeners>
                <Click Handler="CompanyX.CatchException({ failure: function (msg) { Ext.Msg.alert('Failure', msg); } });" />
            </Listeners>
        </ext:Button>
    </form>
</body>
</html>