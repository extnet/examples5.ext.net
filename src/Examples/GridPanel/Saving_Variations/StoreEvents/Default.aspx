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

    private NorthwindDataContext db;
    private List<object> responseRecords;

    protected void Store1_BeforeChanged(object sender, BeforeStoreChangedEventArgs e)
    {
        this.db = new NorthwindDataContext();
        this.responseRecords = new List<object>();
    }

    //This handler will be calling for each inserted record
    protected void Store1_BeforeInserted(object sender, BeforeRecordInsertedEventArgs e)
    {
        Supplier supplier = e.Object<Supplier>();
        db.Suppliers.InsertOnSubmit(supplier);
        this.responseRecords.Add(supplier);
    }

    //This handler will be calling for each changed record
    protected void Store1_BeforeUpdated(object sender, BeforeRecordUpdatedEventArgs e)
    {
        Supplier supplier = e.Object<Supplier>();
        this.db.Suppliers.Attach(supplier);
        this.db.Refresh(RefreshMode.KeepCurrentValues, supplier);
        this.responseRecords.Add(supplier);
    }

    //This handler will be calling for each deleted record
    protected void Store1_BeforeDeleted(object sender, BeforeRecordDeletedEventArgs e)
    {
        Supplier supplier = e.Object<Supplier>();
        this.db.Suppliers.Attach(supplier);
        this.db.Suppliers.DeleteOnSubmit(supplier);
    }

    protected void Store1_AfterChanged(object sender, AfterStoreChangedEventArgs e)
    {
        this.db.SubmitChanges();

        if (e.Action != StoreAction.Destroy)
        {
            e.ResponseRecords.AddRange(this.responseRecords);
        }
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
                    BodyPadding="18">
                    <Content>
                        <h1>CRUD Grid Example</h1>
                        <p>Demonstrates how to get data from a page and save using Store (with store events).</p>
                    </Content>
                </ext:Panel>
                <ext:GridPanel
                    ID="GridPanel1"
                    runat="server"
                    Region="Center"
                    Title="Suppliers"
                    IconCls="x-md md-icon-business-center"
                    Frame="true">
                    <Store>
                        <ext:Store
                            ID="Store1"
                            runat="server"
                            AutomaticResponseValues="false"
                            OnBeforeStoreChanged="Store1_BeforeChanged"
                            OnAfterStoreChanged="Store1_AfterChanged"
                            OnBeforeRecordInserted="Store1_BeforeInserted"
                            OnBeforeRecordUpdated="Store1_BeforeUpdated"
                            OnBeforeRecordDeleted="Store1_BeforeDeleted"
                            OnReadData="Store1_ReadData">
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
                            <ext:Column
                                runat="server"
                                DataIndex="CompanyName"
                                Text="Company Name"
                                Flex="1">
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
                        <ext:Button runat="server" Text="Insert" IconCls="x-md md-icon-add-circle-outline">
                            <Listeners>
                                <Click Handler="insertRecord(#{GridPanel1});" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button
                            ID="btnDelete"
                            runat="server"
                            Text="Delete"
                            IconCls="x-md md-icon-remove-circle-outline"
                            Disabled="true">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.deleteSelected();
                                                if (!#{GridPanel1}.hasSelection()) {
                                                    #{btnDelete}.disable();
                                                }" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Save" IconCls="x-md md-icon-save">
                            <Listeners>
                                <Click Handler="#{Store1}.sync();" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Clear" IconCls="x-md md-icon-cancel">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.getSelectionModel().deselectAll();;
                                                if (!#{GridPanel1}.hasSelection()) {
                                                    #{btnDelete}.disable();
                                                }" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Refresh" IconCls="x-md md-icon-refresh">
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
