<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Create Reader
        JsonReader reader = new JsonReader
        {
            RootProperty = "plants",
            TotalProperty = "total"
        };

        // Create Proxy
        AjaxProxy proxy = new AjaxProxy
        {
            Url = "Plants.ashx",
            Reader = { reader },
            ActionMethods =
            {
                Read = HttpMethod.POST
            }
        };

        Model model = new Model()
        {
            Fields = {
                new ModelField("Common"),
                new ModelField("Botanical"),
                new ModelField("Light"),
                new ModelField("Price", ModelFieldType.Float),
                new ModelField("Indoor", ModelFieldType.Boolean)
            }
        };

        // Add Proxy and Reader to Store
        Store store = new Store {
            Proxy = { proxy },
            Model = { model },
            AutoLoad = false
        };

        // Create ComboBox
        ComboBox combobox = new ComboBox
        {
            ID="ComboBox2",
            DisplayField = "Common",
            ValueField = "Common",
            TypeAhead = false,
            Width = 570,
            PageSize = 10,
            HideTrigger = true,
            ListConfig = new BoundList
            {
                LoadingText = "Searching..."
            },
            MinChars = 0,
            TriggerAction = Ext.Net.TriggerAction.Query,
            Store = { store }
        };

        combobox.ListConfig = new BoundList
        {
            ItemTpl = new XTemplate {
                Html = @"
                  <div class=""search-item"">
                     <h3><span>${Price}</span>{Common}</h3>
                     {Botanical}
                  </div>"
            }
        };

        // Add ComboBox to Controls Collection
        this.Placeholder1.Controls.Add(combobox);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComboBox with Templates and AJAX - Ext.NET Examples</title>
    <style>
        .search-item {
            font          : normal 11px tahoma, arial, helvetica, sans-serif;
            padding       : 3px 10px 3px 10px;
            border        : 1px solid #fff;
            border-bottom : 1px solid #eeeeee;
            white-space   : normal;
            color         : #555;
        }

        .search-item h3 {
            display     : block;
            font        : inherit;
            font-weight : bold;
            color       : #222;
            margin      :0px;
        }

        .search-item h3 span {
            float       : right;
            font-weight : normal;
            margin      : 0 0 5px 5px;
            width       : 100px;
            display     : block;
            clear       : none;
        }

        p { width: 650px; }

        .ext-ie .x-form-text { position : static !important; }
    </style>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ComboBox with Templates and AJAX</h1>

        <p>This is a more advanced example demonstrating how to combine Store Paging and a Template to create "live search" functionality.</p>

        <div style="width:600px;">
            <div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>
            <div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc">
                <h3 style="margin-bottom:5px;">Search the plants</h3>

            <ext:ComboBox
                runat="server"
                ID="ComboBox1"
                DisplayField="Common"
                ValueField="Common"
                TypeAhead="false"
                Width="570"
                PageSize="10"
                HideTrigger="true"
                MinChars="0"
                TriggerAction="Query">
                <ListConfig  LoadingText="Searching...">
                    <ItemTpl runat="server">
                        <Html>
                            <div class="search-item">
                                <h3><span>${Price}</span>{Common}</h3>
                                {Botanical}
                            </div>
                        </html>                    </ItemTpl>
                </ListConfig>
                <Store>
                    <ext:Store runat="server" AutoLoad="false">
                        <Proxy>
                            <ext:AjaxProxy Url="Plants.ashx">
                                <ActionMethods Read="POST" />
                                <Reader>
                                    <ext:JsonReader RootProperty="plants" TotalProperty="total" />
                                </Reader>
                            </ext:AjaxProxy>
                        </Proxy>
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Common" />
                                    <ext:ModelField Name="Botanical" />
                                    <ext:ModelField Name="Light" />
                                    <ext:ModelField Name="Price" Type="Float" />
                                    <ext:ModelField Name="Indoor" Type="Boolean" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
            </ext:ComboBox>

            <div style="padding-top:4px;">
                Plants search (type '*' (asterisk) for showing all)
            </div>
            </div></div></div>
            <div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>
        </div>

        <br />
        <br />
        <br />

        <div style="width:600px;">
            <div class="x-box-tl">
                <div class="x-box-tr">
                    <div class="x-box-tc"></div>
                </div>
            </div>
            <div class="x-box-ml">
                <div class="x-box-mr">
                    <div class="x-box-mc">
                        <h3 style="margin-bottom:5px;">Search the plants (controls dynamically created)</h3>
                        <asp:PlaceHolder ID="Placeholder1" runat="server" />
                        <div style="padding-top:4px;">
                            Plants search (type '*' (asterisk) for showing all)
                        </div>
                    </div>
                </div>
            </div>
            <div class="x-box-bl">
                <div class="x-box-br">
                    <div class="x-box-bc"></div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>