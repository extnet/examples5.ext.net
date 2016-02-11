<%@ Control Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", 0.02, 0.03},
                new object[] { "Alcoa Inc", 0.42, 1.47},
                new object[] { "Altria Group Inc", 0.28, 0.34},
                new object[] { "American Express Company", 0.01, 0.02},
                new object[] { "American International Group, Inc.", 0.31, 0.49},
                new object[] { "AT&T Inc.", -0.48, -1.54},
                new object[] { "Boeing Co.", 0.53, 0.71},
                new object[] { "Caterpillar Inc.", 0.92, 1.39},
                new object[] { "Citigroup, Inc.", 0.02, 0.04},
                new object[] { "E.I. du Pont de Nemours and Company", 0.51, 1.28},
                new object[] { "Exxon Mobil Corp", -0.43, -0.64},
                new object[] { "General Electric Company", -0.08, -0.23},
                new object[] { "General Motors Corporation",1.09, 3.74},
                new object[] { "Hewlett-Packard Co.", -0.03, -0.08},
                new object[] { "Honeywell Intl Inc", 0.05, 0.13},
                new object[] { "Intel Corporation", 0.31, 1.58},
                new object[] { "International Business Machines", 0.44, 0.54},
                new object[] { "Johnson & Johnson", 0.06, 0.09},
                new object[] { "JP Morgan & Chase & Co", 0.07, 0.15},
                new object[] { "McDonald\"s Corporation", 0.86, 2.40},
                new object[] { "Merck & Co., Inc.", 0.41, 1.01},
                new object[] { "Microsoft Corporation", 0.14, 0.54},
                new object[] { "Pfizer Inc", 0.4, 1.45},
                new object[] { "The Coca-Cola Company", 0.26, 0.58},
                new object[] { "The Home Depot, Inc.", 0.35, 1.02},
                new object[] { "The Procter & Gamble Company", 0.01, 0.02},
                new object[] { "United Technologies Corporation", 0.55, 0.88},
                new object[] { "Verizon Communications", 0.39, 1.11},
                new object[] { "Wal-Mart Stores, Inc.", 0.73, 1.63}
            };

            this.Store1.DataBind();
        }
    }
</script>


<ext:GridPanel 
    runat="server"
    Icon="TagBlue"
    Title="Tickets"
    Margin="10"
    ColumnLines="true">
    <Store>
        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="company" />
                        <ext:ModelField Name="change" Type="Float" />
                        <ext:ModelField Name="pctChange" Type="Float" />                        
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
    </Store>
    <ColumnModel runat="server">
        <Columns>
            <ext:Column runat="server" Text="Company" Sortable="true" DataIndex="company" Flex="1" />            
            <ext:Column runat="server" Text="Change" Sortable="true" DataIndex="change" Width="75">
                <Renderer Fn="change" />
            </ext:Column>
            <ext:Column runat="server" Text="Change" Sortable="true" DataIndex="pctChange"  Width="75">
                <Renderer Fn="pctChange" />
            </ext:Column>
        </Columns>
    </ColumnModel>
</ext:GridPanel>