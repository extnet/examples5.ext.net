<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml" %>

<script runat="server">
    private object[] TestData
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
                new object[] { "Government Motors Corporation", 30.27, 1.09, 3.74, now },
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
            this.Store1.DataSource = this.TestData;
        }
    }

    protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.TestData;
        this.Store1.DataBind();
    }

    protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
    {
        XmlNode xml = e.Xml;

        this.Response.Clear();

        string strXml = xml.OuterXml;

        this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
        this.Response.AddHeader("Content-Length", strXml.Length.ToString());
        this.Response.ContentType = "application/xml";
        this.Response.Write(strXml);

        this.Response.End();
    }

    protected void SaveHandler(object sender, BeforeStoreChangedEventArgs e)
    {
        XmlNode xml = e.DataHandler.XmlData;
        StringBuilder sb = new StringBuilder();

        sb.Append("<p>" + e.Action + ":</p>");

        XmlNodeList records = xml.SelectNodes("records/record");

        foreach (XmlNode record in records)
        {
            sb.Append("<p>").Append(Server.HtmlEncode(record.InnerXml)).Append("</p>");
        }

        sb.Append("<br/>");

        /*XmlNode updated = xml.SelectSingleNode("records/Updated");

        if (updated != null)
        {
            sb.Append("<p>Updated:</p>");

            XmlNodeList uRecords = updated.SelectNodes("record");

            foreach (XmlNode record in uRecords)
            {
                sb.Append("<p>").Append(Server.HtmlEncode(record.InnerXml)).Append("</p>");
            }

            sb.Append("<br/>");
        }

        XmlNode inserted = xml.SelectSingleNode("records/Created");

        if (inserted != null)
        {
            sb.Append("<p>Created:</p>");

            XmlNodeList iRecords = inserted.SelectNodes("record");

            foreach (XmlNode record in iRecords)
            {
                sb.Append("<p>").Append(Server.HtmlEncode(record.InnerXml)).Append("</p>");
            }

            sb.Append("<br/>");
        }

        XmlNode deleted = xml.SelectSingleNode("records/Deleted");

        if (deleted != null)
        {
            sb.Append("<p>Deleted:</p>");

            XmlNodeList dRecords = deleted.SelectNodes("record");

            foreach (XmlNode record in dRecords)
            {
                sb.Append("<p>").Append(Server.HtmlEncode(record.InnerXml)).Append("</p>");
            }

            sb.Append("<br/>");
        }*/

        this.Label1.Html = sb.ToString();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Local Data Paging - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var count = 0; // a counter for new records

        var exportData = function (selectedOnly) {
            App.GridPanel1.submitData({selectedOnly : selectedOnly}, {isUpload:true});
        };

        var selectRecord = function (id) {
            var grid = App.GridPanel1,
                record = grid.store.getById(id);

            if (!record) {
                Ext.Msg.alert("Error", "Record '" + id + "' not found.");
            } else {
                grid.store.loadPage(grid.store.findPage(record), {
                    callback: function () {
                        grid.getSelectionModel().select(record);
                    }
                });
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>The sample demonstrates local paging in the GridPanel</h1>

        <p>1. Local Paging</p>
        <p>2. You can submit data from all grid's pages in one request</p>
        <p>3. If you edit data on various grid's pages then you can save in one request and changes will not be lost when you navigate beetwen pages</p>
        <p>4. Get selected data from all pages</p>
        <p>5. Navigate on page by record</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Array Grid"
            Width="850"
            Height="520">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    RemoteSort="false"
                    OnReadData="MyData_Refresh"
                    OnSubmitData="Store1_Submit"
                    OnBeforeStoreChanged="SaveHandler"
                    PageSize="10">
                    <Model>
                        <ext:Model runat="server" IDProperty="company">
                            <Fields>
                                <ext:ModelField Name="company" />
                                <ext:ModelField Name="price" Type="Float" />
                                <ext:ModelField Name="change" Type="Float" />
                                <ext:ModelField Name="pctChange" Type="Float" />
                                <ext:ModelField Name="lastChange" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange" />
                    <ext:DateColumn
                        runat="server"
                        Text="Last Updated"
                        Width="120"
                        DataIndex="lastChange"
                        Format="HH:mm:ss" />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
            <BottomBar>
                <ext:PagingToolbar runat="server" />
            </BottomBar>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add record" IconCls="x-md md-icon-add-circle-outline">
                            <Listeners>
                                <Click Handler="var grid = #{GridPanel1},
                                                    store = grid.store;
                                                store.insert(0, { company : 'New' + count++ });
                                                Ext.Function.defer(function() {
                                                    grid.editingPlugin.startEditByPosition({row: 0, column: 0})
                                                }, 100); " />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="Delete selected" IconCls="x-md md-icon-remove-circle-outline">
                            <Listeners>
                                <Click Handler="var grid = #{GridPanel1},
                                                    store = grid.store,
                                                    records = grid.selModel.getSelection();
                                                store.remove(records);
                                                store.load(true);" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Find 'Government Motors'" IconCls="x-md md-icon-search">
                            <Listeners>
                                <Click Handler="selectRecord('Government Motors Corporation');" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="To XML" IconCls="x-md md-icon-xml">
                            <Listeners>
                                <Click Handler="exportData();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server" Text="Selection To XML" IconCls="x-md md-icon-xml">
                            <Listeners>
                                <Click Handler="exportData(true);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button runat="server"  Text="Save" IconCls="x-md md-icon-save">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.store.sync();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>