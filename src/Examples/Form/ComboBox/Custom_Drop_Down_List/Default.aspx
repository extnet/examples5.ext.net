<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = new object[]
        {
            new object[] { "AL", "Alabama", "The Heart of Dixie", 5.99},
            new object[] { "AK", "Alaska", "The Land of the Midnight Sun", 5.99},
            new object[] { "AZ", "Arizona", "The Grand Canyon State", 5.99},
            new object[] { "AR", "Arkansas", "The Natural State", 5.99},
            new object[] { "CA", "California", "The Golden State", 5.99},
            new object[] { "CO", "Colorado", "The Mountain State", 5.99},
            new object[] { "CT", "Connecticut", "The Constitution State", 5.99},
            new object[] { "DE", "Delaware", "The First State", 5.99},
            new object[] { "DC", "District of Columbia", "The Nation's Capital", 5.99},
            new object[] { "FL", "Florida", "The Sunshine State", 5.99},
            new object[] { "GA", "Georgia", "The Peach State", 5.99},
            new object[] { "HI", "Hawaii", "The Aloha State", 5.99},
            new object[] { "ID", "Idaho", "Famous Potatoes", 5.99},
            new object[] { "IL", "Illinois", "The Prairie State", 5.99},
            new object[] { "IN", "Indiana", "The Hospitality State", 5.99},
            new object[] { "IA", "Iowa", "The Corn State", 5.99},
            new object[] { "KS", "Kansas", "The Sunflower State", 5.99},
            new object[] { "KY", "Kentucky", "The Bluegrass State", 5.99},
            new object[] { "LA", "Louisiana", "The Bayou State", 5.99},
            new object[] { "ME", "Maine", "The Pine Tree State", 5.99},
            new object[] { "MD", "Maryland", "Chesapeake State", 5.99},
            new object[] { "MA", "Massachusetts", "The Spirit of America", 5.99},
            new object[] { "MI", "Michigan", "Great Lakes State", 5.99},
            new object[] { "MN", "Minnesota", "North Star State", 5.99},
            new object[] { "MS", "Mississippi", "Magnolia State", 5.99},
            new object[] { "MO", "Missouri", "Show Me State", 5.99},
            new object[] { "MT", "Montana", "Big Sky Country", 5.99},
            new object[] { "NE", "Nebraska", "Beef State", 5.99},
            new object[] { "NV", "Nevada", "Silver State", 5.99},
            new object[] { "NH", "New Hampshire", "Granite State", 5.99},
            new object[] { "NJ", "New Jersey", "Garden State", 5.99},
            new object[] { "NM", "New Mexico", "Land of Enchantment", 5.99},
            new object[] { "NY", "New York", "Empire State", 5.99},
            new object[] { "NC", "North Carolina", "First in Freedom", 5.99},
            new object[] { "ND", "North Dakota", "Peace Garden State", 5.99},
            new object[] { "OH", "Ohio", "The Heart of it All", 5.99},
            new object[] { "OK", "Oklahoma", "Oklahoma is OK", 5.99},
            new object[] { "OR", "Oregon", "Pacific Wonderland", 5.99},
            new object[] { "PA", "Pennsylvania", "Keystone State", 5.99},
            new object[] { "RI", "Rhode Island", "Ocean State", 5.99},
            new object[] { "SC", "South Carolina", "Nothing Could be Finer", 5.99},
            new object[] { "SD", "South Dakota", "Great Faces, Great Places", 5.99},
            new object[] { "TN", "Tennessee", "Volunteer State", 5.99},
            new object[] { "TX", "Texas", "Lone Star State", 5.99},
            new object[] { "UT", "Utah", "Salt Lake State", 5.99},
            new object[] { "VT", "Vermont", "Green Mountain State", 5.99},
            new object[] { "VA", "Virginia", "Mother of States", 5.99},
            new object[] { "WA", "Washington", "Green Tree State", 5.99},
            new object[] { "WV", "West Virginia", "Mountain State", 5.99},
            new object[] { "WI", "Wisconsin", "America's Dairyland", 5.99},
            new object[] { "WY", "Wyoming", "Like No Place on Earth", 5.99}
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Comboboxes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .list-item {
            font:normal 11px tahoma, arial, helvetica, sans-serif;
            padding:3px 10px 3px 10px;
            border:1px solid #fff;
            border-bottom:1px solid #eeeeee;
            white-space:normal;
            color:#555;
        }

        .list-item h3 {
            display:block;
            font:inherit;
            font-weight:bold;
            margin:0px;
            color:#222;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ComboBox
            runat="server"
            Width="250"
            Editable="false"
            DisplayField="state"
            ValueField="abbr"
            QueryMode="Local"
            ForceSelection="true"
            TriggerAction="All"
            EmptyText="Select a state...">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="abbr" />
                                <ext:ModelField Name="state" />
                                <ext:ModelField Name="nick" />
                                <ext:ModelField Name="price" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ListConfig>
                <ItemTpl runat="server">
                    <Html>
                        <div class="list-item">
                                <h3>{state}</h3>
                                {nick:ellipsis(15)}, {price:usMoney}
                        </div>
                    </Html>
                </ItemTpl>
            </ListConfig>
        </ext:ComboBox>
    </form>
</body>
</html>