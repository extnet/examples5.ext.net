<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { 1, 1, "Text 1", DateTime.Now.Date },
                new object[] { 2, 2, "Text 2", DateTime.Now.Date },
                new object[] { 3, 3, "Text 3", DateTime.Now.Date },
                new object[] { 4, 4, "Text 4", DateTime.Now.Date },
                new object[] { 5, 5, "Text 5", DateTime.Now.Date },
                new object[] { 6, 6, "Text 6", DateTime.Now.Date },
                new object[] { 7, 7, "Text 7", DateTime.Now.Date },
                new object[] { 8, 8, "Text 8", DateTime.Now.Date },
                new object[] { 9, 9, "Text 9", DateTime.Now.Date }
            };

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComponentColumn Pin Editor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var pinEditors = function (btn, pressed) {
            var columnConfig = btn.column,
                column = columnConfig.column;

            if (pressed) {
                column.pinOverComponent();
                column.showComponent(columnConfig.record, true);
            } else {
                column.unpinOverComponent();
                column.hideComponent(true);
            }
        };
    </script>

    <style>
        .x-over-editor-grid tr.x-grid-row {
            height: 25px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ComponentColumn as Pin Editor</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="ComponentColumn Pin Editor"
            Cls="x-over-editor-grid"
            Width="620"
            Height="480">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="IntField" Type="Int" />
                                <ext:ModelField Name="ComboField" Type="Int" />
                                <ext:ModelField Name="TextField" Type="String" />
                                <ext:ModelField Name="DateField" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:ComponentColumn
                        runat="server"
                        Editor="true"
                        OverOnly="true"
                        DataIndex="IntField"
                        Pin="true"
                        Flex="1"
                        Text="Integer">
                        <Component>
                            <ext:NumberField runat="server" />
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn
                        runat="server"
                        Editor="true"
                        OverOnly="true"
                        DataIndex="ComboField"
                        Pin="true"
                        Flex="1"
                        Text="ComboBox">
                        <Component>
                            <ext:ComboBox runat="server">
                                <Items>
                                    <ext:ListItem Text="Item 1" Value="1" Mode="Raw" />
                                    <ext:ListItem Text="Item 2" Value="2" Mode="Raw" />
                                    <ext:ListItem Text="Item 3" Value="3" Mode="Raw" />
                                    <ext:ListItem Text="Item 4" Value="4" Mode="Raw" />
                                    <ext:ListItem Text="Item 5" Value="5" Mode="Raw" />
                                    <ext:ListItem Text="Item 6" Value="6" Mode="Raw" />
                                    <ext:ListItem Text="Item 7" Value="7" Mode="Raw" />
                                    <ext:ListItem Text="Item 8" Value="8" Mode="Raw" />
                                    <ext:ListItem Text="Item 9" Value="9" Mode="Raw" />
                                </Items>
                            </ext:ComboBox>
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn
                        runat="server"
                        Editor="true"
                        OverOnly="true"
                        DataIndex="TextField"
                        Pin="true"
                        Flex="1"
                        Text="Text">
                        <Component>
                            <ext:TextField runat="server" />
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn
                        runat="server"
                        Editor="true"
                        OverOnly="true"
                        DataIndex="DateField"
                        Pin="true"
                        Flex="1"
                        Text="Date">
                        <Renderer Format="Date" FormatArgs="'d/m/Y'" />
                        <Component>
                            <ext:DateField runat="server" Format="dd/MM/yyyy" />
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn
                        runat="server"
                        Width="25"
                        PinAllColumns="false"
                        AutoWidthComponent="false"
                        OverOnly="true">
                        <Component>
                            <ext:Button
                                runat="server"
                                ToolTip="Pin editors"
                                Icon="Pencil"
                                AllowDepress="true"
                                EnableToggle="true">
                                <Listeners>
                                    <Toggle Fn="pinEditors" />
                                </Listeners>
                            </ext:Button>
                        </Component>
                    </ext:ComponentColumn>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>