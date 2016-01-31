<%@ Page Language="C#" %>

<script runat="server">
    
    /// <summary>
    /// Possible arguments: 
    ///     - string action
    ///     - string action, Dictionary<string, object> extraParams
    ///     - string action, Dictionary<string, object> extraParams, object serviceParams
    /// </summary>
    /// <returns></returns>
    [DirectMethod]    
    public static object BindData()
    {
        return Data; 
    }

    private static object[] Data
    {
        get
        {
            DateTime now = DateTime.Now;

            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, now },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, now },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, now },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, now },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, now },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, now },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, now },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, now },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, now },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, now },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, now },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, now },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, now },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, now },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, now },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, now },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, now },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, now },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, now },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, now },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, now },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, now },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, now },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, now },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, now },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, now },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, now },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, now },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, now }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>PageProxy with DirectMethod - Ext.NET Examples</title>  
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };
    </script>  
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>PageProxy with DirectMethod</h1>
       
        <ext:GridPanel
            ID="GridPanel1"
            runat="server" 
            Title="Array Grid" 
            Width="700" 
            Height="310">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" />
                                <ext:ModelField Name="price" Type="Float" />
                                <ext:ModelField Name="change" Type="Float" />
                                <ext:ModelField Name="pctChange" Type="Float" />
                                <ext:ModelField Name="lastChange" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>                                      
                    <Proxy>
                        <ext:PageProxy DirectFn="App.direct.BindData">
                            <Reader>
                                <ext:ArrayReader />
                            </Reader>
                        </ext:PageProxy>
                    </Proxy>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="35" />
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change">
                        <Renderer Fn="change" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange">
                        <Renderer Fn="pctChange" />
                    </ext:Column>
                    <ext:DateColumn runat="server" Text="Last Updated" Width="85" DataIndex="lastChange" Format="H:mm:ss" />
                </Columns>
            </ColumnModel>                  
        </ext:GridPanel>
    </form>
</body>
</html>