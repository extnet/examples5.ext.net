<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new List<object> {
                new {Id = 1, Company = "C1"},
                new {Id = 2, Company = "C2"},
                new {Id = 3, Company = "C3"},
                new {Id = 4, Company = "C4"},
                new {Id = 5, Company = "C5"},
                new {Id = 6, Company = "C6"}
            };
            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Behaviour for FilterHeader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        Ext.net.FilterHeader.behaviour.addBehaviour("string", {
            name: "any",

            is: function (value) {
                return Ext.net.StringUtils.startsWith(value, "any ");
            },

            getValue: function (value) {
                var values = Ext.net.FilterHeader.behaviour.getStrValue(value).substring(4).split(" "),
                    tmp = [];

                Ext.each(values, function (v) {
                    v = v.trim();
                    if (!Ext.isEmpty(v)) {
                        tmp.push(v);
                    }
                });

                values = tmp;

                return { value: values, valid: values.length > 0 };
            },

            match: function (recordValue, matchValue) {
                for (var i = 0; i < matchValue.length; i++) {
                    if (recordValue === matchValue[i]) {
                        return true;
                    }
                }

                return false;
            },

            isValid: function (value) {
                return this.getValue(value, field).valid;
            },

            serialize: function (value) {
                return {
                    type: "string",
                    op: "any",
                    value: value
                };
            }
        });
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>Custom Behaviour for FilterHeader</h1>

        <p>This examples demonstrates how to add custom behaviour for filtering</p>
        <p>Custom behaviour: search any of values from list (string filter)</p>
        <p>Example: any C1 C2</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="400"
            Height="250"
            Closable="false"
            Title="Example"
            Layout="Fit">
            <Items>
                <ext:GridPanel runat="server">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server" IDProperty="Id">
                                    <Fields>
                                        <ext:ModelField Name="Id" Type="Int" />
                                        <ext:ModelField Name="Company" Type="String" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column
                                runat="server"
                                Text="ID"
                                DataIndex="Id"
                                Filterable="false"
                                Width="40"
                                />
                            <ext:Column
                                runat="server"
                                Text="Company"
                                DataIndex="Company"
                                Flex="1"
                                />
                        </Columns>
                    </ColumnModel>
                    <Plugins>
                        <ext:FilterHeader runat="server" />
                    </Plugins>
                    <BottomBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" Text="Filter Set 1" Handler="this.up('grid').filterHeader.setValue({Company: 'any C1 C3'});" />
                                <ext:Button runat="server" Text="Filter Set 2" Handler="this.up('grid').filterHeader.setValue({Company: 'any C2 C4'});" />
                            </Items>
                        </ext:Toolbar>
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
