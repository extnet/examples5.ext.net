<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">
    private DataTable GetDataTable()
    {
        DataTable table = new DataTable();

        table.Columns.AddRange(new DataColumn[] {
            new DataColumn("Company")   { ColumnName = "Company",    DataType = typeof(string) },
            new DataColumn("Price")     { ColumnName = "Price",      DataType = typeof(double) },
            new DataColumn("Change")    { ColumnName = "Change",     DataType = typeof(double) },
            new DataColumn("PctChange") { ColumnName = "PctChange",  DataType = typeof(double) },
            new DataColumn("PctChange") { ColumnName = "LastChange", DataType = typeof(DateTime) }
        });

        foreach (object[] obj in this.Data)
        {
            table.Rows.Add(obj);
        }

        return table;
    }

    private object[] Data
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.GetDataTable();
            this.Store1.DataBind();
        }
    }

    protected void Store1_RefreshData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.GetDataTable();
        this.Store1.DataBind();
    }

    protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
    {
        string format = this.FormatType.Value.ToString();

        XmlNode xml = e.Xml;

        this.Response.Clear();

        switch (format)
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
    <title>GridPanel using DataTable with Paging and Remote Reloading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var exportData = function (format) {
            App.FormatType.setValue(format);
            var store = App.GridPanel1.store;

            store.submitData(null, {isUpload:true});
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>GridPanel using DataTable with Paging and Remote Reloading</h1>

        <p>Demonstrates how to create a grid from Array data with Local Paging and Remote Reloading.</p>

        <ext:Store
            ID="Store1"
            runat="server"
            OnReadData="Store1_RefreshData"
            OnSubmitData="Store1_Submit"
            PageSize="10">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="Company" />
                        <ext:ModelField Name="Price" Type="Float" />
                        <ext:ModelField Name="Change" Type="Float" />
                        <ext:ModelField Name="PctChange" Type="Float" />
                        <ext:ModelField Name="LastChange" Type="Date" DateFormat="yyyy-MM-ddTHH:mm:ss" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Hidden ID="FormatType" runat="server" />

        <ext:GridPanel
            id="GridPanel1"
            runat="server"
            StoreID="Store1"
            Title="DataTable Grid"
            Width="960"
            Height="320">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company"
                        DataIndex="Company"
                        Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Price"
                        Width="75"
                        DataIndex="Price">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:TextField ID="TextField1" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="Change">
                        <Renderer Fn="change" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="PctChange">
                        <Renderer Fn="pctChange" />
                    </ext:Column>
                    <ext:DateColumn
                        runat="server"
                        Text="Last Updated"
                        Width="85"
                        DataIndex="LastChange"
                        />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button
                            ID="Button1"
                            runat="server"
                            Text="To XML"
                            IconCls="x-md md-icon-xml">
                            <Listeners>
                                <Click Handler="exportData('xml');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button
                            ID="Button2"
                            runat="server"
                            Text="To Excel"
                            IconCls="x-md md-icon-apps">
                            <Listeners>
                                <Click Handler="exportData('xls');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button
                            ID="Button3"
                            runat="server"
                            Text="To CSV"
                            IconCls="x-md md-icon-attachment">
                            <Listeners>
                                <Click Handler="exportData('csv');" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar runat="server" StoreID="Store1" />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>