<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.GridPanel1.Store.Primary.DataSource = new object[]
            {
                new object[] { true, DateTime.Now, 1 },
                new object[] { false, DateTime.Now.AddDays(-1), 2 },
                new object[] { true, DateTime.Now.AddDays(-2), 3 },
                new object[] { false, DateTime.Now.AddDays(-3), 4 },
                new object[] { true, DateTime.Now.AddDays(-4), 5 }
            };

            this.GridPanel1.Store.Primary.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Columns Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Column Variations"
            DisableSelection="true"
            Width="960"
            Height="480">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="booleanCol" Type="Boolean" />
                                <ext:ModelField Name="dateCol" Type="Date" />
                                <ext:ModelField Name="numberCol" Type="Int" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="25" />
                    <ext:BooleanColumn runat="server" DataIndex="booleanCol" Text="Boolean" />
                    <ext:CheckColumn runat="server" DataIndex="booleanCol" Text="Check" />
                    <ext:DateColumn runat="server" DataIndex="dateCol" Text="Date" />
                    <ext:NumberColumn runat="server" DataIndex="numberCol" Text="Number" Format="0.00" />
                    <ext:TemplateColumn runat="server" DataIndex="" MenuDisabled="true" Text="Template">
                        <Template runat="server">
                            <Html>
                                <tpl for=".">
                                    {booleanCol}<br />
                                    {dateCol:date("d/m/Y")}<br />
                                    {numberCol}<br />
                                </tpl>
                            </Html>
                        </Template>
                    </ext:TemplateColumn>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" StripeRows="true" />
            </View>
        </ext:GridPanel>
    </form>
</body>
</html>