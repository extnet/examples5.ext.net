<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Store store = this.ComboBox1.GetStore();

        store.DataSource = new object[]
        {
            new object[] { ResourceManager.GetIconClassName(Icon.FlagFr), "France"},
            new object[] { ResourceManager.GetIconClassName(Icon.FlagCa), "Canada"},
            new object[] { ResourceManager.GetIconClassName(Icon.FlagDe), "Germany"},
            new object[] { ResourceManager.GetIconClassName(Icon.FlagUs), "United States"},
            new object[] { ResourceManager.GetIconClassName(Icon.FlagIt), "Italy"}
        };

        store.DataBind();

        this.ResourceManager1.RegisterIcon(Icon.FlagFr);
        this.ResourceManager1.RegisterIcon(Icon.FlagCa);
        this.ResourceManager1.RegisterIcon(Icon.FlagDe);
        this.ResourceManager1.RegisterIcon(Icon.FlagUs);
        this.ResourceManager1.RegisterIcon(Icon.FlagIt);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>IconCombo - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .icon-combo-item {
            background-repeat   : no-repeat !important;
            background-position : 3px 50% !important;
            padding-left        : 24px !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>Render an Icon in ComboBox data items</h1>

        <ext:ComboBox
            ID="ComboBox1"
            runat="server"
            Width="250"
            Editable="false"
            DisplayField="name"
            ValueField="name"
            QueryMode="Local"
            TriggerAction="All"
            EmptyText="Select a country...">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="iconCls" />
                                <ext:ModelField Name="name" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ListConfig>
                <ItemTpl runat="server">
                    <Html>
                        <div class="icon-combo-item {iconCls}">
                            {name}
                        </div>
                    </Html>
                </ItemTpl>
            </ListConfig>
            <Listeners>
                <Change Handler="if (this.valueCollection.getCount() > 0) {this.setIconCls(this.valueCollection.getAt(0).get('iconCls'));}" />
            </Listeners>
        </ext:ComboBox>
    </form>
</body>
</html>
