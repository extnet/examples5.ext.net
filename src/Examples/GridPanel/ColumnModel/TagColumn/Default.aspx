<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.Data;
            this.Store1.DataBind();
        }
    }

    private IEnumerable Data
    {
        get
        {
            return new List<object>()
            {
                new {tags = "Tag 1,Tag 2,Tag 3"},
                new {tags = new string[] {"Tag 1", "Tag 2", "Tag 3" }},
                new {tags = new object[] {
                    new {text = "Tag 1", iconCls = "#User"},
                    new {text = "Tag 2", iconCls = "#UserAdd"},
                    new {text = "Tag 3", iconCls = "#UserDelete"}
                }},
                new {tags = new Tags {
                    new Tag{Text = "Tag 1", Icon = Icon.CommentAdd},
                    new Tag{Text = "Tag 2", Icon = Icon.CommentDelete},
                    new Tag{Text = "Tag 3", Icon = Icon.CommentEdit}
                }}
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TagColumn - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>TagColumn</h1>

    <ext:GridPanel runat="server" Title="Grid with TagColumn" Width="250">
        <Store>
            <ext:Store ID="Store1" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="tags" Type="object" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel>
            <Columns>
                <ext:RowNumbererColumn runat="server" />
                <ext:TagColumn runat="server" Text="Tags" DataIndex="tags" Flex="1" />
            </Columns>
        </ColumnModel>
    </ext:GridPanel>
</body>
</html>