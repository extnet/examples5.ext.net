<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    private void BindData()
    {
        string[] firstNames = new string[] { "Russel", "Clark", "Steve", "Sam", "Lance", "Robert", "Sean", "David", "Justin", "Nicolas", "Brent" };
        string[] lastNames = new string[] { "Wood", "Lewis", "Scott", "Parker", "Ross", "Garcia", "Bell", "Kelly", "Powell", "Moore", "Cook" };

        var data = new List<object>();
        var rand = 37;
        int k;
        int id = 0;

        for (int i = 0; i < lastNames.Length; ++i)
        {
            var map = new Dictionary<string, int>();

            var s = firstNames[i];

            data.Add(new
            {
                ID = ++id,
                Forename = s,
                Surname = lastNames[i]
            });

            map[s] = 1;

            for (int j = 0; j < 3; ++j)
            {
                do
                {
                    k = rand % firstNames.Length;
                    rand = rand * 1664525 + 1013904223; // basic LCG but repeatable
                    rand &= 0x7FFFFFFF;
                    s = firstNames[k];
                } while (map.ContainsKey(s));

                map[s] = 1;
                data.Add(new
                {
                    ID = ++id,
                    Forename = s,
                    Surname = lastNames[i]
                });
            }
        }

        this.Store1.DataSource = data;
        this.Store2.DataSource = data.GetRange(1, 3);
    }

    protected void OnClick(object sender, DirectEventArgs e)
    {
        var values = Selector1.Values;

        if (values != null && values.Keys.Count > 0)
        {
            StringBuilder sb = new StringBuilder();

            foreach (var empl in values)
            {
                sb.Append(empl.Value).Append("<br/>");
            }

            X.Msg.Alert("Selected employess", sb.ToString()).Show();
        }
        else
        {
            X.Msg.Alert("Selected employess", "No employees").Show();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MultiSelector - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>MultiSelector</h1>

        <ext:Model runat="server" Name="Employee" IDProperty="ID">
            <Fields>
                <ext:ModelField Name="ID" />
                <ext:ModelField Name="Forename" />
                <ext:ModelField Name="Surname" />
                <ext:ModelField Name="Name">
                    <Convert Handler="return record.get('Forename') + ' ' + record.get('Surname'); " />
                </ext:ModelField>
            </Fields>
        </ext:Model>

        <ext:MultiSelector
            ID="Selector1"
            runat="server"
            Width="400"
            Height="480"
            Title="Selected Employees"
            FieldName="Name">
            <Store>
                <ext:Store ID="Store2" runat="server" ModelName="Employee" />
            </Store>
            <ViewConfig DeferEmptyText="false" EmptyText="No employees selected" />
            <Search>
                <ext:MultiSelectorSearch runat="server" Field="Name">
                    <SearchGridConfig runat="server" BufferedRenderer="false" />
                    <Store>
                        <ext:Store ID="Store1" runat="server" ModelName="Employee">
                            <Sorters>
                                <ext:DataSorter Property="Name" />
                            </Sorters>
                        </ext:Store>
                    </Store>
                </ext:MultiSelectorSearch>
            </Search>

            <Buttons>
                <ext:Button runat="server" Text="Show value" OnDirectClick="OnClick" />
            </Buttons>
        </ext:MultiSelector>
    </form>
</body>
</html>