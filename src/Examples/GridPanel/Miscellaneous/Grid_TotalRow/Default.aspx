<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store store = this.GridPanel1.GetStore();

            store.DataSource = new object[]
            {
                new object[] {"1", "1.1", "1.01"},
                new object[] {"2", "2.2", "2.02"},
                new object[] {"3", "3.3", "3.01"}
            };

            store.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with Total Row - Ext.Net Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var updateTotal = function (grid, container) {
            if (!grid.view.rendered) {
                return;
            }

            var field,
                value,
                width,
                data = {test1: 0, test2: 0, test3: 0},
                c,
                cs = grid.headerCt.getVisibleGridColumns();

            for (var j = 0, jlen = grid.store.getCount(); j < jlen; j++) {
                var r = grid.store.getAt(j);

                for (var i = 0, len = cs.length; i < len; i++) {
                    c = cs[i];
                    if (c.dataIndex) {
                        data[c.dataIndex] += r.get(c.dataIndex);
                    }
                }
            }

            container.suspendLayout = true;

            for (var i = 0; i < cs.length; i++) {
                c = cs[i];
                value = data[c.dataIndex];

                field = container.down('component[name="'+c.dataIndex+'"]');

                container.remove(field, false);
                container.insert(i, field);
                width = c.getWidth();
                field.setWidth(width - 1);
                field.setValue(c.renderer ? (c.renderer)(value, {}, {}, 0, i, grid.store, grid.view) : value);
            }

            container.items.each(function (field) {
                var column = grid.headerCt.down('component[dataIndex="'+field.name+'"]');
                field.setVisible(column.isVisible());
            });

            container.suspendLayout = false;
            container.updateLayout();
        };
    </script>

    <style>
        .total-field {
            background-color : #fff;
            padding          : 0px 1px 1px 1px;
            margin-right     : 1px;
        }

        .total-field .x-form-display-field{
            border           : solid 1px silver;
            font-weight      : bold !important;
            font-size        : 11px;
            font-family      : tahoma, arial, verdana, sans-serif;
            color            : #000;
            padding          : 0px 0px 0px 5px;
            height           : 22px;
            margin-top       : 0px;
            padding-top      : 3px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <h1>GridPanel with Total Row</h1>

        <ext:ResourceManager runat="server" />

        <ext:GridPanel ID="GridPanel1" runat="server" Width="300">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="test1" Type="Int"/>
                                <ext:ModelField Name="test2" Type="Float"/>
                                <ext:ModelField Name="test3" Type="Float"/>
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Test1" DataIndex="test1" Flex="1" />
                    <ext:Column runat="server" Text="Test2" DataIndex="test2" Flex="1" />
                    <ext:Column runat="server" Text="Test3" DataIndex="test3" Flex="1" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <Listeners>
                        <Refresh Handler="updateTotal(this.panel, #{Container1});" />
                    </Listeners>
                </ext:GridView>
            </View>
            <Listeners>
                <ColumnResize Handler="updateTotal(this, #{Container1});" />
                <ColumnMove Handler="updateTotal(this, #{Container1});" />
                <ColumnHide Handler="updateTotal(this, #{Container1});" />
            </Listeners>
            <DockedItems>
                <ext:FieldContainer ID="Container1" runat="server" Layout="HBoxLayout" Dock="Bottom" StyleSpec="margin-top:2px;">
                    <Defaults>
                        <ext:Parameter Name="height" Value="24" />
                    </Defaults>
                    <Items>
                        <ext:DisplayField
                            runat="server"
                            Name="test1"
                            Cls="total-field"
                            Text="-"
                            />
                        <ext:DisplayField
                            runat="server"
                            Name="test2"
                            Cls="total-field"
                            Text="-"
                            />
                        <ext:DisplayField
                            runat="server"
                            Name="test3"
                            Cls="total-field"
                            Text="-"
                            />
                    </Items>
                </ext:FieldContainer>
            </DockedItems>
        </ext:GridPanel>
    </form>
</body>
</html>