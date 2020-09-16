<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples.Northwind"%>

<%@ Register src="WindowEditor.ascx" tagname="WindowEditor" tagprefix="uc1" %>

<script runat="server">
    protected void Page_Init(object sender, EventArgs e)
    {
        this.WindowEditor1.GridStore = this.Store1;
    }

    protected void ShowDetails(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["id"];
        this.WindowEditor1.SetEmployee(Employee.GetEmployee(int.Parse(id)));
        this.WindowEditor1.Show();
    }

    protected void Store1_RefreshData(object sender, StoreReadDataEventArgs e)
    {
        int count;
        this.Store1.DataSource = Employee.GetEmployeesFilter(e.Start, e.Limit, e.Sort.Length > 0 ? e.Sort[0] : null, out count);
        e.Total = count;

        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var employeeDetailsRender = function () {
            return '<img class="imgEdit" ext:qtip="Click to view/edit additional details" style="cursor:pointer;" src="vcard_edit.png" />';
        };

        var cellClick = function (view, cell, columnIndex, record, row, rowIndex, e) {
            var t = e.getTarget(),
                columnId = this.columns[columnIndex].id; // Get column id

            if (t.className == "imgEdit" && columnId == "Details") {
                //the ajax call is allowed
                return true;
            }

            //forbidden
            return false;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Window with Record Details (AJAX Version)</h1>

        <p>For view/edit additional properties please click on the image in last column</p>

        <ext:Store
            ID="Store1"
            runat="server"
            RemoteSort="true"
            OnReadData="Store1_RefreshData"
            PageSize="5">
            <Proxy>
                <ext:PageProxy>
                    <Listeners>
                        <Exception Handler="Ext.MessageBox.alert('Load failed', response.statusText);" />
                    </Listeners>
                </ext:PageProxy>
            </Proxy>
            <Model>
                <ext:Model runat="server" IDProperty="EmployeeID">
                    <Fields>
                        <ext:ModelField Name="EmployeeID" />
                        <ext:ModelField Name="FirstName" />
                        <ext:ModelField Name="LastName" />
                        <ext:ModelField Name="Title" />
                        <ext:ModelField Name="BirthDate" Type="Date" />
                        <ext:ModelField Name="City" />
                        <ext:ModelField Name="Address" />
                    </Fields>
                </ext:Model>
            </Model>
            <Sorters>
                <ext:DataSorter Property="LastName" Direction="ASC" />
            </Sorters>
        </ext:Store>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            StoreID="Store1"
            Title="Employees"
            Height="250">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Full Name"
                        DataIndex="LastName"
                        Flex="1">
                        <Renderer Handler="return '<b>' + record.data['LastName'] + '</b>,' + record.data['FirstName']" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Title"
                        DataIndex="Title"
                        Width="150"
                        />
                    <ext:DateColumn
                        runat="server"
                        Text="Birth Date"
                        DataIndex="BirthDate"
                        Format="yyyy-MM-dd"
                        />
                    <ext:Column
                        runat="server"
                        Text="City"
                        DataIndex="City"
                        Width="100"
                        />
                    <ext:Column
                        runat="server"
                        Text="Address"
                        DataIndex="Address"
                        Width="250"
                        />
                    <ext:Column
                        ID="Details"
                        runat="server"
                        Text="Details"
                        Width="50"
                        Align="Center"
                        Fixed="true"
                        MenuDisabled="true"
                        Resizable="false">
                        <Renderer Fn="employeeDetailsRender" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <BottomBar>
                <ext:PagingToolbar
                    runat="server"
                    DisplayInfo="true"
                    DisplayMsg="Displaying employees {0} - {1} of {2}"
                    EmptyMsg="No employees to display"
                    />
            </BottomBar>
            <Listeners>
                <Render Handler="this.on('cellclick', cellClick);" />
            </Listeners>
            <DirectEvents>
                <CellClick  OnEvent="ShowDetails">
                    <EventMask ShowMask="true" CustomTarget="={#{GridPanel1}.body}" />
                    <ExtraParams>
                        <ext:Parameter Name="id" Value="record.getId()" Mode="Raw" />
                    </ExtraParams>
                </CellClick>
            </DirectEvents>
            <View>
                <ext:GridView runat="server" />
            </View>
        </ext:GridPanel>

        <uc1:WindowEditor ID="WindowEditor1" runat="server" />
    </form>
</body>
</html>