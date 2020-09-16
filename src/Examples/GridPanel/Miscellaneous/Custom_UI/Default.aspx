<%@ Page Language="C#" %>

<script runat="server">
    private object[] Data
    {
        get
        {
            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") }
            };
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.Data;
            this.Store1.DataBind();
        }
    }

    protected void Store1_ReadData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.Data;
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom GridPanel UI - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var linkClick = function (index) {
            alert("Company: " + App.Store1.getAt(index).get("company"));
        };

        var linkRenderer = function (value, meta, record, index) {
            return Ext.String.format("<a class='company-link' href='#' onclick='linkClick({1});'>{0}</a>", value, index);
        };
    </script>

    <style>
        .x-grid-custom .x-grid-item TD {
            font : 12px/16px "segoe ui",arial,sans-serif;
        }

        .x-grid-custom .x-column-header {
            background : #718CA1 url(header_sprite.png) repeat scroll 0 bottom;
            font       : 12px/16px "segoe ui",arial,sans-serif;
            height     : 22px;
            border-left-color  : #6085A5;
            border-right-color : #728BA1;
        }

        .x-grid-custom .x-column-header-over {
            background : #ebf3fd url(header_sprite_over.png) repeat 0 bottom !important;
        }

        .x-grid-custom .x-column-header div {
          color : white;
        }

        .x-grid-custom .company-link {
            color : #0E3D4F;
        }

        .x-grid-custom .x-column-header-trigger {
          background : #718CA1 url(grid3-hd-btn.png) no-repeat left center;
        }

        .x-grid-custom .x-grid-item-alt .x-grid-cell {
            background-color : #DAE2E8;
        }

        .x-grid-custom .x-grid-item-over .x-grid-cell {
            border-color : #728BA1;
            background   : url(row-over.png);
        }

        .x-grid-custom .x-grid-item-selected .x-grid-cell {
            background   : url(row-selected.png) repeat-x scroll 0 0 #7BBBCF;
            border-color : #728BA1;
            border-style : solid;
        }

        .x-grid-custom .x-grid-item-selected TD,
        .x-grid-custom .x-grid-item-selected TD .company-link {
            color : #fff;
        }

        .x-grid-custom .x-toolbar .x-toolbar-text {
            color : #fff !important;
        }

        .x-grid-custom .x-toolbar {
            background : url(toolbar-bg.png) repeat-x 0 0 !important;
        }

        .x-grid-custom .x-tbar-loading {
            background-image : url(refresh.gif) !important;
        }

        .x-grid-custom .x-tbar-page-first {
          background-image : url(page-first.gif) !important;
        }

        .x-grid-custom .x-tbar-page-last {
          background-image : url(page-last.gif) !important;
        }

        .x-grid-custom .x-tbar-page-next {
          background-image : url(page-next.gif) !important;
        }

        .x-grid-custom .x-tbar-page-prev {
          background-image : url(page-prev.gif) !important;
        }

        .x-grid-custom .x-paging-info {
          color : #fff;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" Theme="Classic" />

    <h1>Custom GridPanel UI</h1>

    <p>Demonstrates how to customize a GridPanel look and feel via CSS.</p>
    <p>Compatible with the classic themes - Gray and Blue ('blue' is now called "Classic"). To use with other themes, the CSS rules should be adjusted.</p>

    <ext:Window
        runat="server"
        Plain="true"
        Layout="Fit"
        Width="670"
        Height="310"
        Closable="false"
        Border="false"
        Header="false">
        <Items>
            <ext:GridPanel runat="server" Cls="x-grid-custom" Border="false">
                <Store>
                    <ext:Store ID="Store1" runat="server" PageSize="10" OnReadData=Store1_ReadData>
                        <Model>
                            <ext:Model runat="server" IDProperty="company">
                                <Fields>
                                    <ext:ModelField Name="company" />
                                    <ext:ModelField Name="price" Type="Float" />
                                    <ext:ModelField Name="change" Type="Float" />
                                    <ext:ModelField Name="pctChange" Type="Float" />
                                    <ext:ModelField Name="lastChange" Type="Date" DateFormat="yyyy-MM-dd hh:mm:tt" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:Column
                            runat="server"
                            Text="Company"
                            DataIndex="company"
                            Flex="1">
                            <Renderer Fn="linkRenderer" />
                        </ext:Column>
                        <ext:Column runat="server" Text="Price" DataIndex="price">
                            <Renderer Format="UsMoney" />
                        </ext:Column>
                        <ext:Column runat="server" Text="Change" DataIndex="change">
                        </ext:Column>
                        <ext:Column runat="server" Text="Change" DataIndex="pctChange">
                        </ext:Column>
                        <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" />
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel runat="server" Mode="Multi" />
                </SelectionModel>
                <BottomBar>
                    <ext:PagingToolbar runat="server" />
                </BottomBar>
                <View>
                    <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
                </View>
            </ext:GridPanel>
        </Items>
    </ext:Window>
</body>
</html>