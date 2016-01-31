<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            List<object> data = new List<object>
            {
                new {Country = "C1", State = "C1_S1", City = "C1_S1_C1", Region = "C1_S1_C1_R1"},
                new {Country = "C2", State = "C2_S1", City = "C2_S1_C1", Region = "C2_S1_C1_R1"},
                new {Country = "C3", State = "C3_S1", City = "C3_S1_C1", Region = "C3_S1_C1_R1"},
            };

            Store1.DataSource = data;

            List<object> countries = new List<object>(10);
            for (int i = 1; i <= 10; i++)
            {
                countries.Add(new { Text = "C" + i });
            }

            CountryStore.DataSource = countries;
        }
    }

    protected void StatesRefresh(object sender, StoreReadDataEventArgs e)
    {
        string country = e.Parameters["query"];

        List<object> states = new List<object>(10);
        for (int i = 1; i <= 10; i++)
        {
            states.Add(new { Text = country + "_S" + i });
        }

        StateStore.DataSource = states;
        StateStore.DataBind();
    }

    protected void CitiesRefresh(object sender, StoreReadDataEventArgs e)
    {
        string state = e.Parameters["query"];

        List<object> cities = new List<object>(10);
        for (int i = 1; i <= 10; i++)
        {
            cities.Add(new { Text = state + "_C" + i });
        }

        CityStore.DataSource = cities;
        CityStore.DataBind();
    }

    protected void RegionsRefresh(object sender, StoreReadDataEventArgs e)
    {
        string city = e.Parameters["query"];

        List<object> regions = new List<object>(10);
        for (int i = 1; i <= 10; i++)
        {
            regions.Add(new { Text = city + "_R" + i });
        }

        RegionStore.DataSource = regions;
        RegionStore.DataBind();
    }
    protected void Edit(object sender, DirectEventArgs e)
    {
        List<string> fields = new List<string> { "country", "state", "city", "region" };
        int startIndex = fields.IndexOf(e.ExtraParams["field"]);
        JsonObject data = JSON.Deserialize<JsonObject>(e.ExtraParams["record"]);
        ModelProxy record = this.Store1.GetAt(int.Parse(e.ExtraParams["index"]));

        for (int i = startIndex + 1; i < 4; i++)
        {
            switch (fields[i])
            {
                case "state":
                    record.Set(fields[i], data["country"] + "_S1");
                    data["state"] = data["country"] + "_S1";
                    break;
                case "city":
                    record.Set(fields[i], data["state"] + "_C1");
                    data["city"] = data["state"] + "_C1";
                    break;
                case "region":
                    record.Set(fields[i], data["city"] + "_R1");
                    break;
            }
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var beforeEdit = function (ed, e) {
            var field = this.getEditor(e.record, e.column).field;

            switch (e.field) {
                case "state":
                    field.allQuery = e.record.get('country');
                    break;
                case "city":
                    field.allQuery = e.record.get('state');
                    break;
                case "region":
                    field.allQuery = e.record.get('city');
                    break;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Store ID="CountryStore" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="text" Type="String" ServerMapping="Text" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Store ID="StateStore" runat="server" OnReadData="StatesRefresh">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="text" Type="String" ServerMapping="Text" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Store ID="CityStore" runat="server" OnReadData="CitiesRefresh">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="text" Type="String" ServerMapping="Text" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Store ID="RegionStore" runat="server" OnReadData="RegionsRefresh">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="text" Type="String" ServerMapping="Text" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Height="300"
            Width="600"
            Title="Grid"
            ForceFit="true">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="country" Type="String" ServerMapping="Country" />
                                <ext:ModelField Name="state" Type="String" ServerMapping="State" />
                                <ext:ModelField Name="city" Type="String" ServerMapping="City" />
                                <ext:ModelField Name="region" Type="String" ServerMapping="Region" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" DataIndex="country" Text="Country">
                        <Editor>
                            <ext:ComboBox
                                ID="CountryCombo"
                                runat="server"
                                QueryMode="Local"
                                TriggerAction="All"
                                StoreID="CountryStore"
                                ValueField="text"
                                DisplayField="text">
                            </ext:ComboBox>
                        </Editor>
                    </ext:Column>

                    <ext:Column runat="server" DataIndex="state" Text="State">
                        <Editor>
                            <ext:ComboBox
                                ID="StateCombo"
                                runat="server"
                                StoreID="StateStore"
                                ValueField="text"
                                DisplayField="text">
                                <CustomConfig>
                                    <ext:ConfigItem Name="initQuery" Value="Ext.emptyFn" Mode="Raw" />
                                </CustomConfig>
                            </ext:ComboBox>
                        </Editor>
                    </ext:Column>

                    <ext:Column runat="server" DataIndex="city" Text="City">
                        <Editor>
                            <ext:ComboBox
                                ID="CityCombo"
                                runat="server"
                                QueryMode="Remote"
                                StoreID="CityStore"
                                ValueField="text"
                                DisplayField="text">
                                <CustomConfig>
                                    <ext:ConfigItem Name="initQuery" Value="Ext.emptyFn" Mode="Raw" />
                                </CustomConfig>
                            </ext:ComboBox>
                        </Editor>
                    </ext:Column>

                    <ext:Column runat="server" DataIndex="region" Text="Region">
                        <Editor>
                            <ext:ComboBox
                                ID="regionCombo"
                                runat="server"
                                QueryMode="Remote"
                                StoreID="RegionStore"
                                ValueField="text"
                                DisplayField="text">
                                <CustomConfig>
                                    <ext:ConfigItem Name="initQuery" Value="Ext.emptyFn" Mode="Raw" />
                                </CustomConfig>
                            </ext:ComboBox>
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>

            <Plugins>
                <ext:CellEditing>
                    <Listeners>
                        <BeforeEdit Fn="beforeEdit" />
                    </Listeners>
                    <DirectEvents>
                        <Edit OnEvent="Edit" Before="return e.value !== e.originalValue;">
                            <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="App.GridPanel1" />
                            <ExtraParams>
                                <ext:Parameter Name="field" Value="e.field" Mode="Raw" />
                                <ext:Parameter Name="index" Value="e.rowIdx" Mode="Raw" />
                                <ext:Parameter Name="record" Value="e.record.data" Mode="Raw" Encode="true" />
                            </ExtraParams>
                        </Edit>
                    </DirectEvents>
                </ext:CellEditing>
            </Plugins>
        </ext:GridPanel>

    </form>
</body>
</html>
