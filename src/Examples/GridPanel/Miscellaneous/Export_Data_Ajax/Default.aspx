<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">
    private object[] TestData
    {
        get
        {
            DateTime now = DateTime.Now;

            return new object[]
            {
                new object[] { 1, "3m Co", 71.72, 0.02, 0.03, now },
                new object[] { 2, "Alcoa Inc", 29.01, 0.42, 1.47, now },
                new object[] { 3, "Altria Group Inc", 83.81, 0.28, 0.34, now },
                new object[] { 4, "American Express Company", 52.55, 0.01, 0.02, now },
                new object[] { 5, "American International Group, Inc.", 64.13, 0.31, 0.49, now },
                new object[] { 6, "AT&T Inc.", 31.61, -0.48, -1.54, now },
                new object[] { 7, "Boeing Co.", 75.43, 0.53, 0.71, now },
                new object[] { 8, "Caterpillar Inc.", 67.27, 0.92, 1.39, now },
                new object[] { 9, "Citigroup, Inc.", 49.37, 0.02, 0.04, now },
                new object[] { 10, "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, now },
                new object[] { 11, "Exxon Mobil Corp", 68.1, -0.43, -0.64, now },
                new object[] { 12, "General Electric Company", 34.14, -0.08, -0.23, now },
                new object[] { 13, "General Motors Corporation", 30.27, 1.09, 3.74, now },
                new object[] { 14, "Hewlett-Packard Co.", 36.53, -0.03, -0.08, now },
                new object[] { 15, "Honeywell Intl Inc", 38.77, 0.05, 0.13, now },
                new object[] { 16, "Intel Corporation", 19.88, 0.31, 1.58, now },
                new object[] { 17, "International Business Machines", 81.41, 0.44, 0.54, now },
                new object[] { 18, "Johnson & Johnson", 64.72, 0.06, 0.09, now },
                new object[] { 19, "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, now },
                new object[] { 20, "McDonald\"s Corporation", 36.76, 0.86, 2.40, now },
                new object[] { 21, "Merck & Co., Inc.", 40.96, 0.41, 1.01, now },
                new object[] { 22, "Microsoft Corporation", 25.84, 0.14, 0.54, now },
                new object[] { 23, "Pfizer Inc", 27.96, 0.4, 1.45, now },
                new object[] { 24, "The Coca-Cola Company", 45.07, 0.26, 0.58, now },
                new object[] { 25, "The Home Depot, Inc.", 34.64, 0.35, 1.02, now },
                new object[] { 26, "The Procter & Gamble Company", 61.91, 0.01, 0.02, now },
                new object[] { 27, "United Technologies Corporation", 63.26, 0.55, 0.88, now },
                new object[] { 28, "Verizon Communications", 35.57, 0.39, 1.11, now },
                new object[] { 29, "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, now }
            };
        }
    }

    protected void Store1_RefreshData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.TestData;
        this.Store1.DataBind();
    }

    protected void Store1_RecordUpdated(object sender, AfterRecordUpdatedEventArgs e)
    {
        // This event is fired once for each Record that is Updated.
        string tpl = "Name: {0}, Price: {1}, LastChange: {2}<br />";
        this.Label1.Html += string.Format(tpl, e.Values["company"], e.Values["price"], e.Values["lastChange"]);
    }

    protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
    {
        string format = this.FormatType.Value.ToString();

        XmlNode xml = e.Xml;

        this.Response.Clear();

        switch(format)
        {
            case "xml":
                    string strXml = xml.OuterXml;
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
                    this.Response.AddHeader("Content-Length", strXml.Length.ToString());
                    this.Response.ContentType = "application/xml";
                    this.Response.Write(strXml);
                break;

            case "xls":
                    this.Response.ContentType = "application/vnd.ms-excel";
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
                    XslCompiledTransform xtExcel = new XslCompiledTransform();
                    xtExcel.Load(Server.MapPath("Excel.xsl"));
                    xtExcel.Transform(xml, null, Response.OutputStream);

                break;

            case "csv":
                this.Response.ContentType = "application/octet-stream";
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
                XslCompiledTransform xtCsv = new XslCompiledTransform();
                xtCsv.Load(Server.MapPath("Csv.xsl"));
                xtCsv.Transform(xml, null, Response.OutputStream);

                break;
        }

        this.Response.End();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Export Data from GridPanel into XML, Excel or CSV using an AjaxRequest - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var submitValue = function (grid, hiddenFormat, format) {
            hiddenFormat.setValue(format);
            grid.submitData(false, {isUpload:true});
        };

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

        <h1>Export Data from GridPanel into XML, Excel or CSV using an AjaxRequest</h1>

        <p>Please note that the converting to formats is not built to Ext.Net. The sample uses simple XSL converting</p>

        <%--<p>Limitations of ajax file downloading: success/failure events don't fired. Therefore the mask is impossible.</p>--%>

        <ext:Hidden ID="FormatType" runat="server" />

        <ext:Store
            ID="Store1"
            runat="server"
            OnAfterRecordUpdated="Store1_RecordUpdated"
            OnReadData="Store1_RefreshData"
            OnSubmitData="Store1_Submit"
            RemoteSort="true">
            <Proxy>
                <ext:PageProxy>
                    <Reader>
                        <ext:ArrayReader></ext:ArrayReader>
                    </Reader>
                </ext:PageProxy>
            </Proxy>
            <Model>
                <ext:Model runat="server" IDProperty="company">
                    <Fields>
                        <ext:ModelField Name="id" Type="Int" />
                        <ext:ModelField Name="company" />
                        <ext:ModelField Name="price" Type="Float" />
                        <ext:ModelField Name="change" Type="Float" />
                        <ext:ModelField Name="pctChange" Type="Float" />
                        <ext:ModelField Name="lastChange" Type="Date" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            StoreID="Store1"
            Title="Array Grid"
            Width="600"
            Height="290">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button ID="Button2" runat="server" Text="To XML" Icon="PageCode">
                            <Listeners>
                                <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'xml');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="Button3" runat="server" Text="To Excel" Icon="PageExcel">
                            <Listeners>
                                <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'xls');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="Button4" runat="server" Text="To CSV" Icon="PageAttach">
                            <Listeners>
                                <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'csv');" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server"
                        Text="Company"
                        Sortable="true"
                        DataIndex="company"
                        Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange" />
                    <ext:DateColumn runat="server" Text="Last Updated" Width="85" DataIndex="lastChange" Format="HH:mm:ss" />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>