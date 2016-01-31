<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { 1, "3m Co", 71.72, 0.02, 0.03, "9/1 12:00am" },
                new object[] { 2, "Alcoa Inc", 29.01, 0.42, 1.47, "9/1 12:00am" },
                new object[] { 3, "Altria Group Inc", 83.81, 0.28, 0.34, "9/1 12:00am" },
                new object[] { 4, "American Express Company", 52.55, 0.01, 0.02, "9/1 12:00am" },
                new object[] { 5, "American International Group, Inc.", 64.13, 0.31, 0.49, "9/1 12:00am" },
                new object[] { 6, "AT&T Inc.", 31.61, -0.48, -1.54, "9/1 12:00am" },
                new object[] { 7, "Boeing Co.", 75.43, 0.53, 0.71, "9/1 12:00am" },
                new object[] { 8, "Caterpillar Inc.", 67.27, 0.92, 1.39, "9/1 12:00am" },
                new object[] { 9, "Citigroup, Inc.", 49.37, 0.02, 0.04, "9/1 12:00am" },
                new object[] { 10, "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, "9/1 12:00am" },
                new object[] { 11, "Exxon Mobil Corp", 68.1, -0.43, -0.64, "9/1 12:00am" },
                new object[] { 12, "General Electric Company", 34.14, -0.08, -0.23, "9/1 12:00am" },
                new object[] { 13, "General Motors Corporation", 30.27, 1.09, 3.74, "9/1 12:00am" },
                new object[] { 14, "Hewlett-Packard Co.", 36.53, -0.03, -0.08, "9/1 12:00am" },
                new object[] { 15, "Honeywell Intl Inc", 38.77, 0.05, 0.13, "9/1 12:00am" },
                new object[] { 16, "Intel Corporation", 19.88, 0.31, 1.58, "9/1 12:00am" },
                new object[] { 17, "International Business Machines", 81.41, 0.44, 0.54, "9/1 12:00am" },
                new object[] { 18, "Johnson & Johnson", 64.72, 0.06, 0.09, "9/1 12:00am" },
                new object[] { 19, "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, "9/1 12:00am" },
                new object[] { 20, "McDonald\"s Corporation", 36.76, 0.86, 2.40, "9/1 12:00am" },
                new object[] { 21, "Merck & Co., Inc.", 40.96, 0.41, 1.01, "9/1 12:00am" },
                new object[] { 22, "Microsoft Corporation", 25.84, 0.14, 0.54, "9/1 12:00am" },
                new object[] { 23, "Pfizer Inc", 27.96, 0.4, 1.45, "9/1 12:00am" },
                new object[] { 24, "The Coca-Cola Company", 45.07, 0.26, 0.58, "9/1 12:00am" },
                new object[] { 25, "The Home Depot, Inc.", 34.64, 0.35, 1.02, "9/1 12:00am" },
                new object[] { 26, "The Procter & Gamble Company", 61.91, 0.01, 0.02, "9/1 12:00am" },
                new object[] { 27, "United Technologies Corporation", 63.26, 0.55, 0.88, "9/1 12:00am" },
                new object[] { 28, "Verizon Communications", 35.57, 0.39, 1.11, "9/1 12:00am" },
                new object[] { 29, "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, "9/1 12:00am" }
            };

            this.Store1.DataBind();
        }
    }

    protected void ToXml(object sender, EventArgs e)
    {
        string json = this.Hidden1.Value.ToString();
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;

        string strXml = xml.OuterXml;

        this.Response.Clear();
        this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
        this.Response.AddHeader("Content-Length", strXml.Length.ToString());
        this.Response.ContentType = "application/xml";
        this.Response.Write(strXml);
        this.Response.End();
    }

    protected void ToExcel(object sender, EventArgs e)
    {
        string json = this.Hidden1.Value.ToString();
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;

        this.Response.Clear();
        this.Response.ContentType = "application/vnd.ms-excel";
        this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
        
        XslCompiledTransform xtExcel = new XslCompiledTransform();
        
        xtExcel.Load(Server.MapPath("Excel.xsl"));
        xtExcel.Transform(xml, null, this.Response.OutputStream);
        this.Response.End();
    }

    protected void ToCsv(object sender, EventArgs e)
    {
        string json = this.Hidden1.Value.ToString();
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;

        this.Response.Clear();
        this.Response.ContentType = "application/octet-stream";
        this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
        
        XslCompiledTransform xtCsv = new XslCompiledTransform();
        
        xtCsv.Load(Server.MapPath("Csv.xsl"));
        xtCsv.Transform(xml, null, this.Response.OutputStream);
        this.Response.End();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Export Data from GridPanel into XML, Excel or CSV using a full PostBack - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />    
    
    <script>
        var saveData = function () {
            App.Hidden1.setValue(Ext.encode(App.GridPanel1.getRowsValues({selectedOnly : false})));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Export Data from GridPanel into XML, Excel or CSV using a full PostBack</h1>
        
        <ext:Hidden ID="Hidden1" runat="server" />
        
        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="id" Type="Int" />
                        <ext:ModelField Name="company" />
                        <ext:ModelField Name="price" Type="Float" />
                        <ext:ModelField Name="change" Type="Float" />
                        <ext:ModelField Name="pctChange" Type="Float" />
                        <ext:ModelField Name="lastChange" Type="Date" DateFormat="M/d hh:mmtt" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>        
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server" 
            StoreID="Store1"
            Title="Export Data"
            Width="600" 
            Height="350">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                    <ext:Column runat="server" Text="Pct.Change" Width="75" DataIndex="pctChange" />
                    <ext:DateColumn runat="server" Text="Last Updated" Width="85" DataIndex="lastChange" />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <View>
                <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
            </View>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        
                        <ext:Button runat="server" Text="To XML" AutoPostBack="true" OnClick="ToXml" Icon="PageCode">
                            <Listeners>
                                <Click Fn="saveData" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button runat="server" Text="To Excel" AutoPostBack="true" OnClick="ToExcel" Icon="PageExcel">
                            <Listeners>
                                <Click Fn="saveData" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button runat="server" Text="To CSV" AutoPostBack="true" OnClick="ToCsv" Icon="PageAttach">
                            <Listeners>
                                <Click Fn="saveData" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>  
    </form>
</body>
</html>