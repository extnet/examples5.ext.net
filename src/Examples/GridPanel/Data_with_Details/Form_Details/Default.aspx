<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples"%>
<%@ Import Namespace="Ext.Net.Examples.Northwind" %>

<script runat="server">
    protected void RowSelect(object sender, DirectEventArgs e)
    {
        string employeeID = e.ExtraParams["EmployeeID"];

        Employee empl = Employee.GetEmployee(int.Parse(employeeID));

        this.FormPanel1.SetValues(new {
            empl.EmployeeID,
            empl.FirstName,
            empl.LastName,
            empl.Title,
            ReportsTo = empl.ReportsTo.HasValue ? (Employee.GetEmployee(empl.ReportsTo.Value).LastName) : "",
            empl.HireDate,
            empl.Extension,
            empl.Address,
            empl.City,
            empl.PostalCode,
            empl.HomePhone,
            empl.TitleOfCourtesy,
            empl.BirthDate,
            empl.Region,
            empl.Country,
            empl.Notes
        });
    }

    protected void Store1_Refresh(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with Form Details - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:LinqDataSource
            ID="LinqDataSource1"
            runat="server"
            ContextTypeName="Ext.Net.Examples.Northwind.NorthwindDataContext"
            Select="new (EmployeeID, LastName, FirstName)"
            TableName="Employees"
            />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel
                    runat="server"
                    Region="North"
                    MarginSpec="5 5 5 5"
                    Title="Description"
                    Height="100"
                    BodyPadding="18"
                    Frame="true"
                    IconCls="x-md md-icon-info">
                    <Content>
                        <b>GridPanel with Form Details</b>
                        <p>Click on any record with the GridPanel and the record details will be loaded into the Details Form.</p>
                    </Content>
                </ext:Panel>
                <ext:GridPanel
                    runat="server"
                    Title="Employees"
                    MarginSpec="0 0 5 5"
                    IconCls="x-md md-icon-person"
                    Region="Center"
                    Frame="true">
                    <Store>
                        <ext:Store
                            ID="Store1"
                            runat="server"
                            DataSourceID="LinqDataSource1"
                            OnReadData="Store1_Refresh">
                            <Model>
                                <ext:Model runat="server" IDProperty="EmployeeID">
                                    <Fields>
                                        <ext:ModelField Name="EmployeeID" />
                                        <ext:ModelField Name="LastName" />
                                        <ext:ModelField Name="FirstName" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" DataIndex="LastName" Text="Last Name" Flex="1" />
                            <ext:Column runat="server" DataIndex="FirstName" Text="First Name" Width="150" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Single">
                            <DirectEvents>
                                <Select OnEvent="RowSelect" Buffer="250">
                                    <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="#{FormPanel1}" />
                                    <ExtraParams>
                                        <%--or can use params[2].id as value--%>
                                        <ext:Parameter Name="EmployeeID" Value="record.getId()" Mode="Raw" />
                                    </ExtraParams>
                                </Select>
                            </DirectEvents>
                        </ext:RowSelectionModel>
                    </SelectionModel>
                    <BottomBar>
                        <ext:PagingToolbar runat="server" />
                    </BottomBar>
                </ext:GridPanel>
                <ext:FormPanel
                    ID="FormPanel1"
                    runat="server"
                    Region="East"
                    Split="true"
                    MarginSpec="0 5 5 5"
                    BodyPadding="18"
                    Frame="true"
                    Title="Employee Details"
                    Width="280"
                    IconCls="x-md md-icon-person"
                    DefaultAnchor="100%"
                    Scrollable="Both">
                    <FieldDefaults ReadOnly="true" />
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Employee ID" Name="EmployeeID" />
                        <ext:TextField runat="server" FieldLabel="First Name" Name="FirstName" />
                        <ext:TextField runat="server" FieldLabel="Last Name" Name="LastName" />
                        <ext:TextField runat="server" FieldLabel="Title" Name="Title" />
                        <ext:TextField runat="server" FieldLabel="Reports to" Name="ReportsTo" />
                        <ext:DateField runat="server" FieldLabel="Hire date" Name="HireDate" Format="yyyy-MM-dd" />
                        <ext:TextField runat="server" FieldLabel="Extension" Name="Extension" />
                        <ext:TextField runat="server" FieldLabel="Address" Name="Address" />
                        <ext:TextField runat="server" FieldLabel="City" Name="City" />
                        <ext:TextField runat="server" FieldLabel="Post Code" Name="PostalCode" />
                        <ext:TextField runat="server" FieldLabel="Home Phone" Name="HomePhone" />
                        <ext:TextField runat="server" FieldLabel="Title Of Courtesy" Name="TitleOfCourtesy" />
                        <ext:DateField runat="server" FieldLabel="Birth date" Name="BirthDate" Format="yyyy-MM-dd" />
                        <ext:TextField runat="server" FieldLabel="Region" Name="Region" />
                        <ext:TextField runat="server" FieldLabel="Country" Name="Country" />
                        <ext:TextArea
                            runat="server"
                            FieldLabel="Note"
                            Height="50"
                            Name="Notes"
                            />
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>