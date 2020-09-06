<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { 1, 0.2 },
                new object[] { 2, 0.4 },
                new object[] { 3, 0.6 },
                new object[] { 4, 0.8 },
                new object[] { 5, 1.0 }
            };
        }
    }
</script>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>ProgressBar Column - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ProgressBar Column</h1>

        <ext:GridPanel
            runat="server"
            Title="ProgressBar column"
            Width="320"
            Height="180">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Index" Type="Int" />
                                <ext:ModelField Name="Percentage" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                     <ext:Column runat="server" DataIndex="Percentage" Text="Value" />
                     <ext:ProgressBarColumn runat="server" DataIndex="Percentage" Text="Progress" />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>