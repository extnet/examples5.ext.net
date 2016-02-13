<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = new object[]
        {
            new object[]{"AL", "Alabama", "The Heart of Dixie"},
            new object[] { "AK", "Alaska", "The Land of the Midnight Sun"},
            new object[] { "AZ", "Arizona", "The Grand Canyon State"},
            new object[] { "AR", "Arkansas", "The Natural State"},
            new object[] { "CA", "California", "The Golden State"},
            new object[] { "CO", "Colorado", "The Mountain State"},
            new object[] { "CT", "Connecticut", "The Constitution State"},
            new object[] { "DE", "Delaware", "The First State"},
            new object[] { "DC", "District of Columbia", "The Nation's Capital"},
            new object[] { "FL", "Florida", "The Sunshine State"},
            new object[] { "GA", "Georgia", "The Peach State"},
            new object[] { "HI", "Hawaii", "The Aloha State"},
            new object[] { "ID", "Idaho", "Famous Potatoes"},
            new object[] { "IL", "Illinois", "The Prairie State"},
            new object[] { "IN", "Indiana", "The Hospitality State"},
            new object[] { "IA", "Iowa", "The Corn State"},
            new object[] { "KS", "Kansas", "The Sunflower State"},
            new object[] { "KY", "Kentucky", "The Bluegrass State"},
            new object[] { "LA", "Louisiana", "The Bayou State"},
            new object[] { "ME", "Maine", "The Pine Tree State"},
            new object[] { "MD", "Maryland", "Chesapeake State"},
            new object[] { "MA", "Massachusetts", "The Spirit of America"},
            new object[] { "MI", "Michigan", "Great Lakes State"},
            new object[] { "MN", "Minnesota", "North Star State"},
            new object[] { "MS", "Mississippi", "Magnolia State"},
            new object[] { "MO", "Missouri", "Show Me State"},
            new object[] { "MT", "Montana", "Big Sky Country"},
            new object[] { "NE", "Nebraska", "Beef State"},
            new object[] { "NV", "Nevada", "Silver State"},
            new object[] { "NH", "New Hampshire", "Granite State"},
            new object[] { "NJ", "New Jersey", "Garden State"},
            new object[] { "NM", "New Mexico", "Land of Enchantment"},
            new object[] { "NY", "New York", "Empire State"},
            new object[] { "NC", "North Carolina", "First in Freedom"},
            new object[] { "ND", "North Dakota", "Peace Garden State"},
            new object[] { "OH", "Ohio", "The Heart of it All"},
            new object[] { "OK", "Oklahoma", "Oklahoma is OK"},
            new object[] { "OR", "Oregon", "Pacific Wonderland"},
            new object[] { "PA", "Pennsylvania", "Keystone State"},
            new object[] { "RI", "Rhode Island", "Ocean State"},
            new object[] { "SC", "South Carolina", "Nothing Could be Finer"},
            new object[] { "SD", "South Dakota", "Great Faces, Great Places"},
            new object[] { "TN", "Tennessee", "Volunteer State"},
            new object[] { "TX", "Texas", "Lone Star State"},
            new object[] { "UT", "Utah", "Salt Lake State"},
            new object[] { "VT", "Vermont", "Green Mountain State"},
            new object[] { "VA", "Virginia", "Mother of States"},
            new object[] { "WA", "Washington", "Green Tree State"},
            new object[] { "WV", "West Virginia", "Mountain State"},
            new object[] { "WI", "Wisconsin", "America's Dairyland"},
            new object[] { "WY", "Wyoming", "Like No Place on Earth"}
        };

        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Comboboxes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .cbStates-list {
            width : 298px;
            font  : 11px tahoma,arial,helvetica,sans-serif;
        }

        .cbStates-list th {
            font-weight : bold;
        }

        .cbStates-list td, .cbStates-list th {
            padding : 3px;
        }

        .list-item {
            cursor : pointer;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ComboBox
            ID="cbStates"
            runat="server"
            EmptyText="Select State"
            TypeAhead="true"
            ForceSelection="true"
            DisplayField="state"
            ValueField="abbr"
            MinChars="1"
            MatchFieldWidth="false"
            PageSize="10">
            <Store>
                <ext:Store ID="Store1" runat="server" IsPagingStore="true" PageSize="10">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="abbr" />
                                <ext:ModelField Name="state" />
                                <ext:ModelField Name="nick" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ListConfig Width="320" Height="300" ItemSelector=".x-boundlist-item">
                <Tpl runat="server">
                    <Html>
                        <tpl for=".">
                            <tpl if="[xindex] == 1">
                                <table class="cbStates-list">
                                    <tr>
                                        <th>State</th>
                                        <th>Nick</th>
                                    </tr>
                            </tpl>
                            <tr class="x-boundlist-item">
                                <td>{state}</td>
                                <td>{nick}</td>
                            </tr>
                            <tpl if="[xcount-xindex]==0">
                                </table>
                            </tpl>
                        </tpl>
                    </html>                </Tpl>
            </ListConfig>
            <Triggers>
                <ext:FieldTrigger Icon="Clear" Hidden="true" />
            </Triggers>
            <Listeners>
                <BeforeQuery Handler="this.getTrigger(0)[this.getRawValue().toString().length == 0 ? 'hide' : 'show']();" />
                <TriggerClick Handler="if (index == 0) {
                                           this.focus().clearValue();
                                           trigger.hide();
                                       }" />
                <Select Handler="this.getTrigger(0).show();" />
            </Listeners>
        </ext:ComboBox>
    </form>
</body>
</html>