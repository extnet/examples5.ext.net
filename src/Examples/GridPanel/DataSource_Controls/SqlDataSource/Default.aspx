<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with SqlDataSource - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-grid-cell-fullName .x-grid-cell-inner {
            font-family : tahoma, verdana;
            display     : block;
            font-weight : normal;
            font-style  : normal;
            color       : #385F95;
            white-space : normal;
        }

        .x-grid-rowbody div {
            margin : 2px 5px 20px 5px !important;
            width  : 99%;
            color  : gray;
        }

        .x-grid-row-expanded td.x-grid-cell{
            border-bottom-width:0px;
        }
    </style>

    <script>
        var fullName = function (value, metadata, record, rowIndex, colIndex, store) {
            return "<b>" + record.data.LastName + " " + record.data.FirstName + "</b>";
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:SqlDataSource
            ID="SqlDataSource1"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
            SelectCommand="
            SELECT
                [EmployeeID],
                [LastName],
                [FirstName],
                [Title],
                [TitleOfCourtesy],
                [BirthDate],
                [HireDate],
                [Address],
                [City],
                [Region],
                [PostalCode],
                [Country],
                [HomePhone],
                [Extension],
                [Notes]
            FROM [Employees]"
            />

        <ext:GridPanel
            runat="server"
            Title="Employees"
            Frame="true"
            Height="600">
            <Store>
                <ext:Store runat="server" DataSourceID="SqlDataSource1">
                    <Model>
                        <ext:Model runat="server" IDProperty="EmployeeID">
                            <Fields>
                                <ext:ModelField Name="FirstName" />
                                <ext:ModelField Name="LastName" />
                                <ext:ModelField Name="Title" />
                                <ext:ModelField Name="TitleOfCourtesy" />
                                <ext:ModelField Name="BirthDate" Type="Date" />
                                <ext:ModelField Name="HireDate" Type="Date" />
                                <ext:ModelField Name="Address" />
                                <ext:ModelField Name="City" />
                                <ext:ModelField Name="Region" />
                                <ext:ModelField Name="PostalCode" />
                                <ext:ModelField Name="Country" />
                                <ext:ModelField Name="HomePhone" />
                                <ext:ModelField Name="Extension" />
                                <ext:ModelField Name="Notes" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column ID="fullName" runat="server" Text="Full Name" Width="150" DataIndex="LastName">
                        <Renderer Fn="fullName" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        DataIndex="Title"
                        Text="Title"
                        Width="150"
                        />
                    <ext:Column runat="server" DataIndex="TitleOfCourtesy" Text="Title Of Courtesy" Width="150" />
                    <ext:DateColumn runat="server" DataIndex="BirthDate" Text="BirthDate" Width="110" Format="yyyy-MM-dd" />
                    <ext:DateColumn runat="server" DataIndex="HireDate" Text="HireDate" Width="110" Format="yyyy-MM-dd" />
                    <ext:Column
                        runat="server"
                        DataIndex="Address"
                        Text="Address"
                        Width="150"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="City"
                        Text="City"
                        Width="100"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="Region"
                        Text="Region"
                        Width="100"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="PostalCode"
                        Text="PostalCode"
                        Width="100"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="Country"
                        Text="Country"
                        Width="100"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="HomePhone"
                        Text="HomePhone"
                        Width="150"
                        />
                    <ext:Column
                        runat="server"
                        DataIndex="Extension"
                        Text="Extension"
                        Width="100"
                        />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <GetRowClass Handler="return 'x-grid-row-expanded';" />
                </ext:GridView>
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <Features>
                <ext:RowBody runat="server" >
                    <GetAdditionalData Handler="orig.rowBody = '<div>' + data.Notes + '</div>'; orig.rowBodyColspan = record.getFields().length;" />
                </ext:RowBody>
            </Features>
        </ext:GridPanel>
    </form>
</body>
</html>