using Ext.Net;

[DirectMethodProxyID(IDMode = DirectMethodProxyIDMode.None)]
public partial class NoneID : System.Web.UI.MasterPage
{
    [DirectMethod]
    public void HelloMasterPage()
    {
        X.Msg.Alert("Message", "Hello from MasterPage").Show();
    }
}
