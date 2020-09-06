<%@ Page Language="C#" %>

<script runat="server">
    protected void Store2_Refresh(object sender, StoreReadDataEventArgs e)
    {
        string id = e.Parameters["SupplierID"];
        this.LinqDataSource2.WhereParameters["SupplierID"].DefaultValue = id ?? "-1";

        this.Store2.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>One to Many Data Relationship with GridPanels - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:LinqDataSource
            ID="LinqDataSource1"
            runat="server"
            ContextTypeName="Ext.Net.Examples.Northwind.NorthwindDataContext"
            Select="new (SupplierID,
                     CompanyName,
                     ContactName,
                     ContactTitle,
                     Address,
                     City,
                     Region,
                     PostalCode,
                     Country,
                     Phone,
                     Fax)"
            TableName="Suppliers"
            />

        <asp:LinqDataSource
            ID="LinqDataSource2"
            runat="server"
            ContextTypeName="Ext.Net.Examples.Northwind.NorthwindDataContext"
            Select="new (ProductName,
                     QuantityPerUnit,
                     UnitPrice,
                     UnitsInStock,
                     Discontinued,
                     UnitsOnOrder,
                     ReorderLevel,
                     ProductID,
                     SupplierID)"
            TableName="Products"
            AutoGenerateWhereClause="True">
            <WhereParameters>
                <asp:Parameter Name="SupplierID" Type="Int32" DefaultValue="-1" />
            </WhereParameters>
        </asp:LinqDataSource>

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    ID="Panel1"
                    runat="server"
                    Region="North"
                    Title="Description"
                    Height="100"
                    BodyPadding="18"
                    Frame="true"
                    Icon="Information"
                    MarginSpec="5 5 5 5">
                    <Content>
                        <p>One to Many Data Relationship with GridPanels. Click on any record within the parent GridPanel to load related data into second GridPanel.
                           If South Region is collapsed then Ajax load is not performed for the second GridPanel.
                           After South Region is expanded the Ajax request will be performed.</p>
                    </Content>
                </ext:Panel>
                <ext:Panel
                    runat="server"
                    Region="Center"
                    Frame="true"
                    Title="Suppliers"
                    Icon="Lorry"
                    Layout="Fit"
                    MarginSpec="0 5 0 5">
                    <Items>
                        <ext:GridPanel
                            ID="GridPanel1"
                            runat="server">
                            <Store>
                                <ext:Store
                                    ID="Store1"
                                    runat="server"
                                    DataSourceID="LinqDataSource1"
                                    PageSize="10">
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
                                                <ext:ModelField Name="HomePage" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel runat="server">
                                <Columns>
                                    <ext:Column runat="server" DataIndex="CompanyName" Text="Company Name" Flex="1" />
                                    <ext:Column runat="server" DataIndex="ContactName" Text="Contact Name" />
                                    <ext:Column runat="server" DataIndex="ContactTitle" Text="Contact Title" />
                                    <ext:Column runat="server" DataIndex="Address" Text="Address" />
                                    <ext:Column runat="server" DataIndex="City" Text="City" />
                                    <ext:Column runat="server" DataIndex="Region" Text="Region" Width="200" />
                                    <ext:Column runat="server" DataIndex="PostalCode" Text="Postal Code" />
                                    <ext:Column runat="server" DataIndex="Country" Text="Country" />
                                    <ext:Column runat="server" DataIndex="Phone" Text="Phone" />
                                    <ext:Column runat="server" DataIndex="Fax" Text="Fax" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="if (#{pnlSouth}.isVisible()) {#{Store2}.reload();}" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar runat="server" HideRefresh="true" />
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel
                    ID="pnlSouth"
                    runat="server"
                    Region="South"
                    Title="Products"
                    Height="180"
                    Icon="Basket"
                    Layout="Fit"
                    Collapsible="true"
                    Split="true"
                    MarginSpec="0 5 5 5">
                    <Items>
                        <ext:GridPanel
                            ID="GridPanel2"
                            runat="server"
                            Border="false">
                            <Store>
                                <ext:Store
                                    ID="Store2"
                                    runat="server"
                                    AutoLoad="false"
                                    DataSourceID="LinqDataSource2"
                                    OnReadData="Store2_Refresh">
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="ProductID" />
                                                <ext:ModelField Name="ProductName" />
                                                <ext:ModelField Name="QuantityPerUnit" />
                                                <ext:ModelField Name="UnitPrice" Type="Float" />
                                                <ext:ModelField Name="UnitsInStock" Type="Int" />
                                                <ext:ModelField Name="UnitsOnOrder" Type="Int" />
                                                <ext:ModelField Name="ReorderLevel" Type="Int" />
                                                <ext:ModelField Name="Discontinued" Type="Boolean" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Reader>
                                        <ext:JsonReader IDProperty="ProductID" />
                                    </Reader>
                                    <Parameters>
                                        <ext:StoreParameter
                                            Name="SupplierID"
                                            Value="#{GridPanel1}.getSelectionModel().hasSelection() ? #{GridPanel1}.getSelectionModel().getSelection()[0].data.SupplierID : -1"
                                            Mode="Raw"
                                            />
                                    </Parameters>
                                    <Listeners>
                                        <Exception Handler="Ext.Msg.alert('Products - Load failed', operation.getError());" />
                                    </Listeners>
                                </ext:Store>
                            </Store>
                            <ColumnModel runat="server">
                                <Columns>
                                    <ext:Column runat="server" DataIndex="ProductName" Text="Product Name" Flex="1" />
                                    <ext:Column runat="server" DataIndex="QuantityPerUnit" Text="Quantity Per Unit" Width="120" />
                                    <ext:Column runat="server" DataIndex="UnitPrice" Text="Unit Price" />
                                    <ext:Column runat="server" DataIndex="UnitsInStock" Text="Units In Stock" Width="110" />
                                    <ext:Column runat="server" DataIndex="UnitsOnOrder" Text="Units On Order" Width="110" />
                                    <ext:Column runat="server" DataIndex="ReorderLevel" Text="Reorder Level" />
                                    <ext:CheckColumn runat="server" DataIndex="Discontinued" Text="Discontinued" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel runat="server" Mode="Single" />
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                    <Listeners>
                        <Expand Handler="#{Store2}.reload();" />
                    </Listeners>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>