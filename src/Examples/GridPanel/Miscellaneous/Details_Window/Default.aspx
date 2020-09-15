<%@ Page Language="C#" %>

<%@ Register Src="WindowEditor.ascx" TagName="WindowEditor" TagPrefix="uc1" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Window with Record Details - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var CompanyX = {
            _index : 0,

            getIndex : function () {
                return this._index;
            },

            setIndex : function (index) {
                if (index > -1 && index < App.GridPanel1.getStore().getCount()) {
                    this._index = index;
                }
            },

            getRecord : function () {
                var rec = App.GridPanel1.getStore().getAt(this.getIndex());  // Get the Record

                if (rec != null) {
                    return rec;
                }
            },

            edit : function (index) {
                this.setIndex(index);
                this.open();
            },

            next : function () {
                this.edit(this.getIndex() + 1);
            },

            previous : function () {
                this.edit(this.getIndex() - 1);
            },

            refresh : function () {
                App.GridPanel1.getView().refresh();
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Window with Record Details</h1>

        <p>For view/edit additional properties please click on the image in last column.</p>

        <ext:GridPanel
            runat="server"
            ID="GridPanel1"
            Title="Employees">
            <Store>
                <ext:Store runat="server" PageSize="5">
                    <Proxy>
                        <ext:AjaxProxy Url="../../Shared/EmployeesControler.ashx">
                            <ActionMethods Read="POST" />
                            <Reader>
                                <ext:JsonReader TotalProperty="total" RootProperty="data" />
                            </Reader>
                            <Listeners>
                                <Exception Handler="Ext.MessageBox.alert('Load failed', response.statusText);" />
                            </Listeners>
                        </ext:AjaxProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="EmployeeID">
                            <Fields>
                                <ext:ModelField Name="EmployeeID" />
                                <ext:ModelField Name="FirstName" />
                                <ext:ModelField Name="LastName" />
                                <ext:ModelField Name="Title" />
                                <ext:ModelField Name="TitleOfCourtesy" />
                                <ext:ModelField Name="BirthDate" Type="Date" />
                                <ext:ModelField Name="HireDate" Type="Date" />
                                <ext:ModelField Name="City" />
                                <ext:ModelField Name="Address" />
                                <ext:ModelField Name="Region" />
                                <ext:ModelField Name="PostalCode" />
                                <ext:ModelField Name="Country" />
                                <ext:ModelField Name="Homephone" />
                                <ext:ModelField Name="Extension" />
                                <ext:ModelField Name="Notes" />
                                <ext:ModelField Name="Photopath" />
                                <ext:ModelField Name="ReportsTo" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="LastName" Direction="ASC" />
                    </Sorters>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Full Name" DataIndex="LastName" Flex="1">
                        <Renderer Handler="return '<b>' + record.data['LastName'] + '</b>,' + record.data['FirstName']" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Title" DataIndex="Title" Width="150" />
                    <ext:DateColumn runat="server" Text="Birth Date" DataIndex="BirthDate" Format="yyyy-MM-dd" />
                    <ext:Column runat="server" Text="City" DataIndex="City" Width="100" />
                    <ext:Column runat="server" Text="Address" DataIndex="Address" Width="250" />
                    <ext:CommandColumn runat="server" Width="35">
                        <Commands>
                            <ext:GridCommand IconCls="x-md md-icon-edit" CommandName="Edit">
                                <ToolTip Text="Edit" />
                            </ext:GridCommand>
                        </Commands>
                        <Listeners>
                            <Command Handler="CompanyX.edit(recordIndex);" />
                        </Listeners>
                    </ext:CommandColumn>
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
        </ext:GridPanel>

        <uc1:WindowEditor ID="WindowEditor1" runat="server" />
    </form>
</body>
</html>