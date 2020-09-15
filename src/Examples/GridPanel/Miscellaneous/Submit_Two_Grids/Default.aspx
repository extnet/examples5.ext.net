<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", 71.72, 0.02},
                new object[] { "Alcoa Inc", 29.01, 0.42},
                new object[] { "Altria Group Inc", 83.81, 0.28}
            };

            this.Store1.DataBind();

            this.Store2.DataSource = new object[]
            {
                new object[] { "American Express Company", 52.55, 0.01},
                new object[] { "American International Group, Inc.", 64.13, 0.31},
                new object[] { "AT&T Inc.", 31.61, -0.48}
            };

            this.Store2.DataBind();
        }
    }

    protected void SubmitGrids(object sender, DirectEventArgs e)
    {
        //JSON representation
        string grid1Json = e.ExtraParams["Grid1"];
        string grid2Json = e.ExtraParams["Grid2"];

        //XML representation
        XmlNode grid1Xml = JSON.DeserializeXmlNode("{records:{record:" + grid1Json + "}}");
        XmlNode grid2Xml = JSON.DeserializeXmlNode("{records:{record:" + grid2Json + "}}");

        //array of Dictionaries
        Dictionary<string, string>[] grid1Data = JSON.Deserialize<Dictionary<string, string>[]>(grid1Json);
        Dictionary<string, string>[] grid2Data = JSON.Deserialize<Dictionary<string, string>[]>(grid2Json);

        X.Msg.Alert("Submit", "Please see SubmitGrids Event Handler in source code").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Submit Two GridPanels In One Request</h1>

        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="company" />
                        <ext:ModelField Name="price" Type="Float" />
                        <ext:ModelField Name="change" Type="Float" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Store ID="Store2" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="company" />
                        <ext:ModelField Name="price" Type="Float" />
                        <ext:ModelField Name="change" Type="Float" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            StoreID="Store1"
            Title="Grid"
            Width="960"
            Height="250">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company"
                        Width="160"
                        DataIndex="company"
                        Flex="1"
                        />
                    <ext:Column
                        runat="server"
                        Text="Price"
                        Width="75"
                        DataIndex="price"
                        />
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="change"
                        />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>

         <ext:GridPanel
            ID="GridPanel2"
            runat="server"
            StoreID="Store2"
            Title="Grid"
            Width="960"
            Height="250">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company"
                        Width="160"
                        DataIndex="company"
                        Flex="1"
                        />
                    <ext:Column
                        runat="server"
                        Text="Price"
                        Width="75"
                        DataIndex="price"
                        />
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="change"
                        />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>

        <ext:Button ID="Button1" runat="server" Text="Submit Two GridPanels">
            <DirectEvents>
                <Click OnEvent="SubmitGrids">
                    <ExtraParams>
                        <ext:Parameter Name="Grid1" Value="Ext.encode(#{GridPanel1}.getRowsValues({selectedOnly : false}))" Mode="Raw" />
                        <ext:Parameter Name="Grid2" Value="Ext.encode(#{GridPanel2}.getRowsValues({selectedOnly : false}))" Mode="Raw" />
                    </ExtraParams>
                </Click>
            </DirectEvents>
        </ext:Button>
    </form>
</body>
</html>