<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.GetDataReader();
            this.Store1.DataBind();
        }
    }

    protected void Store1_RefreshData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = this.GetDataReader();
        this.Store1.DataBind();
    }

    private SqlDataReader GetDataReader()
    {
        SqlConnection myConnection;
        SqlCommand myCommand;
        SqlDataReader myDataReader;

        string strConn = System.Configuration.ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString;

        myConnection = new SqlConnection(strConn);
        myConnection.Open();

        myCommand = new SqlCommand("SELECT * FROM Suppliers", myConnection);
        myDataReader = myCommand.ExecuteReader();

        return myDataReader;
    }
</script>

<html>
<head runat="server">
    <title>GridPanel using DataReader with Local Paging and Remote Reloading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        }

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>GridPanel using DataReader with Local Paging and Remote Reloading</h1>

        <ext:Store
            ID="Store1"
            runat="server"
            OnReadData="Store1_RefreshData"
            PageSize="10">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="SupplierID" />
                        <ext:ModelField Name="CompanyName" />
                        <ext:ModelField Name="ContactName" />
                        <ext:ModelField Name="ContactTitle" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:GridPanel
            id="GridPanel1"
            runat="server"
            StoreID="Store1"
            Title="DataReader Grid"
            Width="960"
            Height="320">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Supplier ID" DataIndex="SupplierID" />
                    <ext:Column
                        runat="server"
                        Text="Company Name"
                        DataIndex="CompanyName"
                        Flex="1"
                        />
                    <ext:Column runat="server" Text="Contact Name" DataIndex="ContactName" />
                    <ext:Column runat="server" Text="Contact Title" DataIndex="ContactTitle" />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <BottomBar>
                <ext:PagingToolbar runat="server" StoreID="Store1" />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>