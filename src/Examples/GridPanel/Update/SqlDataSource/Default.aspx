<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        XmlDocument xml = new XmlDocument();
        xml.Load(Server.MapPath("States.xml"));

        foreach (XmlNode state in xml.SelectNodes("states/state"))
        {
            this.cbStates.Items.Add(new Ext.Net.ListItem(state.Attributes["label"].InnerText, state.Attributes["data"].InnerText));
        }
    }

    private bool cancel;
    private string message;
    private int? insertedValue;

    protected void Store1_BeforeRecordInserted(object sender, BeforeRecordInsertedEventArgs e)
    {
        object region = e.NewValues["Region"];

        if (region == null || region.ToString() != "Alabama (AL)")
        {
            e.Cancel = true;
            this.cancel = true;
            this.message = "The Region must be 'AL'";
        }
    }

    protected void Store1_AfterRecordInserted(object sender, AfterRecordInsertedEventArgs e)
    {
        if (insertedValue.HasValue)
        {
            e.Keys.Add("SupplierID", insertedValue.Value);
            insertedValue = null;
        }
    }

    protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //use e.AffectedRows for ensure success action. The store read this value and set predefined Confirm depend on e.AffectedRows
        //The Confirm can be granted or denied in OnRecord....ed event
        if (e.AffectedRows > 0 && e.Command.Parameters["@newId"].Value != null)
        {
            insertedValue = (int)e.Command.Parameters["@newId"].Value;
        }
        else
        {
            insertedValue = null;
        }
    }

    protected void Store1_AfterDirectEvent(object sender, AfterDirectEventArgs e)
    {
        if (e.Response.Success)
        {
            // set to .Success to false if we want to return a failure
            e.Response.Success = !cancel;
            e.Response.Message = message;
        }
    }

    protected void Store1_BeforeDirectEvent(object sender, BeforeDirectEventArgs e)
    {
        string emulError = e.Parameters["EmulateError"];

        if (emulError == "1")
        {
            throw new Exception("Emulating error");
        }
    }

    protected void Store1_ReadData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AJAX GridPanel with Details - Ext.NET Examples</title>

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

        <asp:SqlDataSource
            ID="SqlDataSource1"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
            DeleteCommand="DELETE FROM Suppliers WHERE (SupplierID = @SupplierID)"
            InsertCommand="INSERT INTO Suppliers
                               (CompanyName,
                                ContactName,
                                ContactTitle,
                                Address,
                                City,
                                Region,
                                PostalCode,
                                Country,
                                Phone,
                                Fax)
                            VALUES
                                (@CompanyName,
                                 @ContactName,
                                 @ContactTitle,
                                 @Address,
                                 @City,
                                 @Region,
                                 @PostalCode,
                                 @Country,
                                 @Phone,
                                 @Fax);
                            SELECT @newId = @@Identity;"
            SelectCommand="SELECT
                                SupplierID,
                                CompanyName,
                                ContactName,
                                ContactTitle,
                                Address,
                                City,
                                Region,
                                PostalCode,
                                Country,
                                Phone,
                                Fax
                           FROM Suppliers"
            UpdateCommand="UPDATE Suppliers SET
                                CompanyName = @CompanyName,
                                ContactName = @ContactName,
                                ContactTitle = @ContactTitle,
                                Address = @Address,
                                City = @City,
                                Region = @Region,
                                PostalCode = @PostalCode,
                                Country = @Country,
                                Phone = @Phone,
                                Fax = @Fax
                           WHERE (SupplierID = @SupplierID)"
            OnInserted="SqlDataSource1_Inserted">

            <DeleteParameters>
                <asp:Parameter Name="SupplierID" Type="Int32" />
            </DeleteParameters>

            <UpdateParameters>
                <asp:Parameter Name="CompanyName" Type="String" />
                <asp:Parameter Name="ContactName" Type="String" />
                <asp:Parameter Name="ContactTitle" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="Region" Type="String" />
                <asp:Parameter Name="PostalCode" Type="String" />
                <asp:Parameter Name="Country" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Fax" Type="String" />
                <asp:Parameter Name="SupplierID" Type="Int32" />
            </UpdateParameters>

            <InsertParameters>
                <asp:Parameter Name="CompanyName" Type="String" />
                <asp:Parameter Name="ContactName" Type="String" />
                <asp:Parameter Name="ContactTitle" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="Region" Type="String" />
                <asp:Parameter Name="PostalCode" Type="String" />
                <asp:Parameter Name="Country" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Fax" Type="String" />
                <asp:Parameter Direction="Output" Name="newId" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>

        <ext:Store
            ID="Store1"
            runat="server"
            DataSourceID="SqlDataSource1"
            ShowWarningOnFailure="false"
            OnAfterDirectEvent="Store1_AfterDirectEvent"
            OnBeforeDirectEvent="Store1_BeforeDirectEvent"
            OnBeforeRecordInserted="Store1_BeforeRecordInserted"
            OnAfterRecordInserted="Store1_AfterRecordInserted"
            OnReadData="Store1_ReadData">
            <Model>
                <ext:Model runat="server" IDProperty="SupplierID" Name="Supplier">
                    <Fields>
                        <ext:ModelField Name="SupplierID" Type="Int" />
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
                <Exception Handler="Ext.Msg.alert('Operation failed', operation.getError());" />
                <Write Handler="Ext.Msg.alert('Write', 'The data successfully saved');" />
            </Listeners>
        </ext:Store>

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    runat="server"
                    Region="North"
                    Title="Description"
                    Height="100"
                    BodyPadding="18"
                    Frame="true"
                    IconCls="x-md md-icon-info"
                    MarginSpec="5 5 5 5">
                    <Content>
                        Example - Ajax update (insert/delete/update) with SqlDataSource.
                        <br />
                        For demo purpose when insert action perfoms, the Region must be &quot;AL&quot; otherwise
                        custom data validation will fail and return error message.
                    </Content>
                </ext:Panel>
                <ext:Panel
                    ID="Panel1"
                    runat="server"
                    Region="Center"
                    Height="480"
                    Header="false"
                    Layout="Fit"
                    MarginSpec="0 5 0 5">
                    <Items>
                        <ext:GridPanel
                            ID="GridPanel1"
                            runat="server"
                            Title="Suppliers"
                            StoreID="Store1"
                            Border="false"
                            IconCls="x-md md-icon-business-center">
                            <ColumnModel runat="server">
                                <Columns>
                                    <ext:Column
                                        runat="server"
                                        DataIndex="CompanyName"
                                        Text="Company Name"
                                        Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="ContactName" Text="Contact Name">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="ContactTitle" Text="Contact Title">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="Address" Text="Address">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="City" Text="City">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column
                                        runat="server"
                                        DataIndex="Region"
                                        Text="Region"
                                        Width="200">
                                        <Editor>
                                            <ext:ComboBox ID="cbStates" runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="PostalCode" Text="Postal Code">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="Country" Text="Country">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="Phone" Text="Phone">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column runat="server" DataIndex="Fax" Text="Fax">
                                        <Editor>
                                            <ext:TextField runat="server" />
                                        </Editor>
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar runat="server" StoreID="Store1" DisplayInfo="false" />
                            </BottomBar>
                            <SelectionModel>
                                <ext:RowSelectionModel runat="server" Mode="Multi" />
                            </SelectionModel>
                            <Plugins>
                                <ext:CellEditing runat="server" />
                            </Plugins>
                        </ext:GridPanel>
                    </Items>
                    <Buttons>
                        <ext:Button
                            ID="btnSave"
                            runat="server"
                            Text="Sync"
                            IconCls="x-md md-icon-save">
                            <Listeners>
                                <Click Handler="#{Store1}.sync();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button
                            ID="btnDelete"
                            runat="server"
                            Text="Delete selected records"
                            IconCls="x-md md-icon-remove-circle-outline">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.deleteSelected();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button
                            ID="btnInsert"
                            runat="server"
                            Text="Insert"
                            IconCls="x-md md-icon-add-circle-outline">
                            <Listeners>
                                <Click Handler="insertRecord(#{GridPanel1});" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button
                            ID="btnRefresh"
                            runat="server"
                            Text="Refresh"
                            IconCls="x-md md-icon-refresh">
                            <Listeners>
                                <Click Handler="#{Store1}.reload({params:{EmulateError: 0}});" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button
                            ID="btnEmulError"
                            runat="server"
                            Text="Refresh with Emulated error"
                            IconCls="x-md md-icon-error">
                            <Listeners>
                                <Click Handler="#{Store1}.reload({params:{EmulateError: 1}});" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
