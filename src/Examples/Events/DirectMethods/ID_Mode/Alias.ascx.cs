using Ext.Net;

[DirectMethodProxyID(IDMode = DirectMethodProxyIDMode.Alias, Alias = "UC")]
public partial class AliasID : System.Web.UI.UserControl
{
    [DirectMethod]
    public void HelloUserControl()
    {
        X.Msg.Alert("Message", "Hello from UserControl").Show();
    }
}