<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        JSON.RequestSettings = new Newtonsoft.Json.JsonSerializerSettings();
        JSON.RequestSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Local;
            
        this.Store1.DataSource = new List<object> { 
            new { message = "Message1", date = DateTime.Now.AddMinutes(-1) },
            new { message = "Message2", date = DateTime.Now.AddMinutes(-25) },
            new { message = "Message3", date = DateTime.Now.AddHours(-1) },
            new { message = "Message4", date = DateTime.Now.AddHours(-10) },
            new { message = "Message5", date = DateTime.Now.AddDays(-2) }
        };
    }
    </script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DisplayTime Field - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:Window 
            ID="Window1"
            runat="server" 
            Width="500"
            Height="500"
            Title="Messages"
            Icon="Date"
            Closable="false"
            BodyPadding="5"   
            BodyStyle="background-color:white;"         
            Layout="FitLayout">
            <Items>
                <ext:DataView runat="server">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Fields>
                                <ext:ModelField Name="message" />
                                <ext:ModelField Name="date" Type="Date" />
                            </Fields>
                        </ext:Store>
                    </Store>
                    <ItemTpl>
                        <Html>
                            <p>{message}</p>
                            <div style="color:gray;">{date:time}</div>
                            <hr />
                        </Html>                        
                    </ItemTpl>
                </ext:DataView>
            </Items>
        </ext:Window>                
   </form>
</body>
</html>