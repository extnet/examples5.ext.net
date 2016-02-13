<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store store = this.GridPanel1.GetStore();
            store.DataSource = new object[]
            {
                new object[] { "Company X", "1" },
                new object[] { "Company Y", "2" },
                new object[] { "Company Z", "3" }
            };
        }
    }

    protected void Update(object sender, DirectEventArgs e)
    {
        this.HyperlinkColumn1.Pattern = "Visit Website";
        this.HyperlinkColumn1.HrefPattern = "http://ext.net?id={href}&someParamMore=hello";
        this.HyperlinkColumn1.UpdatePatternTpl();
        this.GridPanel1.Refresh();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HyperlinkColumn - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>HyperlinkColumn</h1>

        <p>Please note that links in these HyperlinkColumns are demonstration only.</p>

        <ext:GridPanel ID="GridPanel1" runat="server" Width="500">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="name"  />
                                <ext:ModelField Name="id" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company Name"
                        DataIndex="name"
                        Flex="1"
                        />

                    <ext:Column
                        runat="server"
                        Text="Company ID"
                        DataIndex="id"
                        Flex="1"
                        />

                    <ext:HyperlinkColumn
                        ID="HyperlinkColumn1"
                        runat="server"
                        Text="Hyperlink"
                        Flex="1"
                        DataIndex="name"
                        DataIndexHref="id"
                        Pattern="{text:uppercase}"
                        HrefPattern="http://ext.net?companyId={href}"
                        />
                </Columns>
            </ColumnModel>
            <Buttons>
                <ext:Button runat="server" Text="Change Hyperlink Pattern" OnDirectClick="Update" />
            </Buttons>
        </ext:GridPanel>
    </form>
</body>
</html>