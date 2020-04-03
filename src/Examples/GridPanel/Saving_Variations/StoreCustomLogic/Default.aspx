<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples.Northwind" %>
<%@ Import Namespace="System.Data.Linq" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new NorthwindDataContext().Suppliers.ToList();
        }
    }

    protected void Store1_BeforeChange(object sender, BeforeStoreChangedEventArgs e)
    {
        string json = e.DataHandler.JsonData;

        NorthwindDataContext db = new NorthwindDataContext();

        StoreDataHandler dataHandler = new StoreDataHandler(json);
        List<Supplier> data = dataHandler.ObjectData<Supplier>();

        foreach (Supplier supplier in data)
        {
            switch (e.Action)
            {
                case StoreAction.Destroy:
                    db.Suppliers.Attach(supplier);
                    db.Suppliers.DeleteOnSubmit(supplier);
                    break;
                case StoreAction.Update:
                    db.Suppliers.Attach(supplier);
                    db.Refresh(RefreshMode.KeepCurrentValues, supplier);
                    break;
                case StoreAction.Create:
                    db.Suppliers.InsertOnSubmit(supplier);
                    break;
            }
        }

        db.SubmitChanges();

        if (e.Action != StoreAction.Destroy)
        {
            foreach (Supplier supplier in data)
            {
                e.ResponseRecords.Add(supplier);
            }
        }

        e.Cancel = true;
    }

    protected void Store1_ReadData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = new NorthwindDataContext().Suppliers.ToList();
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with CRUD - Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function insertRecord(grid) {
            var store = grid.store,
                row = store.indexOf(store.insert(0, { CompanyName: "" })[0]);

            Ext.defer(function () {
                grid.editingPlugin.startEditByPosition({ row: row, column: 0 });
            }, 100);
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    runat="server"
                    Region="North"
                    Border="false"
                    Height="120"
                    BodyPadding="6">
                    <Content>
                        <h1>CRUD Grid Example</h1>
                        <p>Demonstrates how to get data from a page and save using Store (with custom logic).</p>
                    </Content>
                </ext:Panel>
                <ext:GridPanel
                    ID="GridPanel1"
                    runat="server"
                    Region="Center"
                    Title="Suppliers"
                    Icon="Lorry"
                    Frame="true">
                    <Store>
                        <ext:Store
                            ID="Store1"
                            runat="server"
                            OnReadData="Store1_ReadData"
                            OnBeforeStoreChanged="Store1_BeforeChange">
                            <Model>
                                <ext:Model runat="server" IDProperty="SupplierID">
                                    <Fields>
                                        <ext:ModelField Name="SupplierID" />
                                        <ext:ModelField Name="CompanyName" />
                                        <ext:ModelField Name="ContactName" />
                                        <ext:ModelField Name="ContactTitle" />
                                        <ext:ModelField Name="Address" />
                                        <ext:ModelField Name="City" />
                                        <ext:ModelField Name="Region" />
                                        <ext:ModelField Name="PostalCode" />
                                        <ext:ModelField Name="Country" />
                                        <ext:ModelField Name="Phone" />
                                        <ext:ModelField Name="Fax" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <ServerProxy>
                                <ext:PageProxy>
                                    <RequestConfig>
                                        <EventMask ShowMask="true" CustomTarget="App.GridPanel1.getView().el" />
                                    </RequestConfig>
                                </ext:PageProxy>
                            </ServerProxy>
                            <Sorters>
                                <ext:DataSorter Property="CompanyName" Direction="ASC" />
                            </Sorters>
                            <Listeners>
                                <Write Handler="Ext.Msg.alert('Success', 'The suppliers have been saved');" />
                            </Listeners>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" DataIndex="CompanyName" Text="Company Name" Flex="1">
                                <Editor>
                                    <ext:TextField ID="TextField1" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="ContactName" Text="Contact Name">
                                <Editor>
                                    <ext:TextField ID="TextField2" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="ContactTitle" Text="Contact Title">
                                <Editor>
                                    <ext:TextField ID="TextField3" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="Address" Text="Address">
                                <Editor>
                                    <ext:TextField ID="TextField4" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="City" Text="City">
                                <Editor>
                                    <ext:TextField ID="TextField5" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="Region" Text="Region">
                                <Editor>
                                    <ext:TextField ID="TextField6" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="PostalCode" Text="Postal Code">
                                <Editor>
                                    <ext:TextField ID="TextField7" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="Country" Text="Country">
                                <Editor>
                                    <ext:TextField ID="TextField8" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="Phone" Text="Phone">
                                <Editor>
                                    <ext:TextField ID="TextField9" runat="server" />
                                </Editor>
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="Fax" Text="Fax">
                                <Editor>
                                    <ext:TextField ID="TextField10" runat="server" />
                                </Editor>
                            </ext:Column>
                        </Columns>
                    </ColumnModel>

                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Multi">
                            <Listeners>
                                <Select Handler="#{btnDelete}.enable();" />
                                <Deselect Handler="if (!#{GridPanel1}.selModel.hasSelection()) {
                                                       #{btnDelete}.disable();
                                                   }" />
                            </Listeners>
                        </ext:RowSelectionModel>
                    </SelectionModel>

                    <Plugins>
                        <ext:CellEditing runat="server" />
                    </Plugins>

                    <Buttons>
                        <ext:Button runat="server" Text="Insert" Icon="Add">
                            <Listeners>
                                <Click Handler="insertRecord(#{GridPanel1});" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="btnDelete" runat="server" Text="Delete" Icon="Delete" Disabled="true">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.deleteSelected();
                                                if (!#{GridPanel1}.hasSelection()) {
                                                    #{btnDelete}.disable();
                                                }" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Save" Icon="Disk">
                            <Listeners>
                                <Click Handler="#{Store1}.sync();" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Clear" Icon="Cancel">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.getSelectionModel().deselectAll();;
                                                if (!#{GridPanel1}.hasSelection()) {
                                                    #{btnDelete}.disable();
                                                }" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Refresh" Icon="ArrowRefresh">
                            <Listeners>
                                <Click Handler="#{Store1}.reload();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
