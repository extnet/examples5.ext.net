<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        ResourceManager.GetInstance(this.Page).RegisterIcon(Icon.Information);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RESTful Store - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onWrite = function (store, operation) {
            var record = operation.getRecords()[0],
                name = Ext.String.capitalize(operation.action),
                verb;

            if (name == 'Destroy') {
                verb = 'Destroyed';
            } else {
                verb = name + 'd';
            }

            Ext.net.Notification.show({ title: name, html: Ext.String.format("{0} user: {1}<br/>{2}", verb, record.getId(), operation.getResultSet().message) });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>RESTful Store</h1>

        <ext:GridPanel
            ID="UserGrid"
            runat="server"
            IconCls="x-md md-icon-grid-on"
            Frame="true"
            Title="Users"
            Height="480"
            Width="500"
            StyleSpec="margin-top: 10px">
            <Store>
                <ext:Store
                    runat="server"
                    AutoLoad="true"
                    AutoSync="true">
                    <Proxy>
                        <ext:RestProxy Url="RestfulPersons.ashx/person">
                            <Reader>
                                <ext:JsonReader RootProperty="data" MessageProperty="message" />
                            </Reader>
                            <Writer>
                                <ext:JsonWriter AllowSingle="true" />
                            </Writer>
                        </ext:RestProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="Id" Name="Person">
                            <Fields>
                                <ext:ModelField Name="Id" Type="Int" AllowNull="true" />
                                <ext:ModelField Name="Email" />
                                <ext:ModelField Name="First" />
                                <ext:ModelField Name="Last" />
                            </Fields>
                            <Validators>
                                <ext:LengthValidator Field="Email" Min="1" />
                                <ext:LengthValidator Field="First" Min="1" />
                                <ext:LengthValidator Field="Last" Min="1" />
                            </Validators>
                        </ext:Model>
                    </Model>
                    <Listeners>
                        <Write Fn="onWrite" Delay="1" />
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="ID" Width="40" DataIndex="Id">
                        <Renderer Handler="return record.phantom ? '' : value;" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Email" Flex="1" DataIndex="Email">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="First" Width="80" DataIndex="First">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Last" Width="80" DataIndex="Last">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add" IconCls="x-md md-icon-add-circle-outline">
                            <Listeners>
                                <Click Handler="var grid = #{UserGrid},
                                                    store = grid.getStore();

                                                store.getSorters().removeAll(); // We have to remove sorting to avoid auto-sorting on insert
                                                grid.getView().headerCt.setSortState(); // To update columns sort UI
                                                store.insert(0, new Person());
                                                grid.editingPlugin.startEdit(0, 0);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRemoveEmployee" runat="server" Text="Delete" IconCls="x-md md-icon-error">
                            <Listeners>
                                <Click Handler="var selection = #{UserGrid}.getView().getSelectionModel().getSelection()[0];
                                                if (selection) {
                                                    #{UserGrid}.store.remove(selection);
                                                }" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Plugins>
                <ext:RowEditing runat="server" />
            </Plugins>
            <Listeners>
                <SelectionChange Handler="#{btnRemoveEmployee}.setDisabled(!selected.length);" />
            </Listeners>
        </ext:GridPanel>
    </form>
</body>
</html>
