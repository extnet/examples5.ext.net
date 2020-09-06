<%@ Page Language="C#" %>

<script runat="server">
    private object TestData
    {
        get
        {
            return new object[]
            {
                new object[] { "AL", "Alabama", "The Heart of Dixie" },
                new object[] { "AK", "Alaska", "The Land of the Midnight Sun" },
                new object[] { "AZ", "Arizona", "The Grand Canyon State" },
                new object[] { "AR", "Arkansas", "The Natural State" },
                new object[] { "CA", "California", "The Golden State" },
                new object[] { "CO", "Colorado", "The Mountain State" },
                new object[] { "CT", "Connecticut", "The Constitution State" },
                new object[] { "DE", "Delaware", "The First State" },
                new object[] { "DC", "District of Columbia", "The Nation's Capital" },
                new object[] { "FL", "Florida", "The Sunshine State" },
                new object[] { "GA", "Georgia", "The Peach State" },
                new object[] { "HI", "Hawaii", "The Aloha State" },
                new object[] { "ID", "Idaho", "Famous Potatoes" },
                new object[] { "IL", "Illinois", "The Prairie State" },
                new object[] { "IN", "Indiana", "The Hospitality State" },
                new object[] { "IA", "Iowa", "The Corn State" },
                new object[] { "KS", "Kansas", "The Sunflower State" },
                new object[] { "KY", "Kentucky", "The Bluegrass State" },
                new object[] { "LA", "Louisiana", "The Bayou State" },
                new object[] { "ME", "Maine", "The Pine Tree State" },
                new object[] { "MD", "Maryland", "Chesapeake State" },
                new object[] { "MA", "Massachusetts", "The Spirit of America" },
                new object[] { "MI", "Michigan", "Great Lakes State" },
                new object[] { "MN", "Minnesota", "North Star State" },
                new object[] { "MS", "Mississippi", "Magnolia State" },
                new object[] { "MO", "Missouri", "Show Me State" },
                new object[] { "MT", "Montana", "Big Sky Country" },
                new object[] { "NE", "Nebraska", "Beef State" },
                new object[] { "NV", "Nevada", "Silver State" },
                new object[] { "NH", "New Hampshire", "Granite State" },
                new object[] { "NJ", "New Jersey", "Garden State" },
                new object[] { "NM", "New Mexico", "Land of Enchantment" },
                new object[] { "NY", "New York", "Empire State" },
                new object[] { "NC", "North Carolina", "First in Freedom" },
                new object[] { "ND", "North Dakota", "Peace Garden State" },
                new object[] { "OH", "Ohio", "The Heart of it All" },
                new object[] { "OK", "Oklahoma", "Oklahoma is OK" },
                new object[] { "OR", "Oregon", "Pacific Wonderland" },
                new object[] { "PA", "Pennsylvania", "Keystone State" },
                new object[] { "RI", "Rhode Island", "Ocean State" },
                new object[] { "SC", "South Carolina", "Nothing Could be Finer" },
                new object[] { "SD", "South Dakota", "Great Faces, Great Places" },
                new object[] { "TN", "Tennessee", "Volunteer State" },
                new object[] { "TX", "Texas", "Lone Star State" },
                new object[] { "UT", "Utah", "Salt Lake State" },
                new object[] { "VT", "Vermont", "Green Mountain State" },
                new object[] { "VA", "Virginia", "Mother of States" },
                new object[] { "WA", "Washington", "Green Tree State" },
                new object[] { "WV", "West Virginia", "Mountain State" },
                new object[] { "WI", "Wisconsin", "America's Dairyland" },
                new object[] { "WY", "Wyoming", "Like No Place on Earth" }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Combo Boxes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .example {
            width: 600px;
            border: 1px solid #CCC;
            padding: 0px 10px 10px 10px;
            margin: 0 0 10px;
        }

        #transformCombo label {
            display: block;
            margin: 1em 0 2px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ObjectHolder ID="DataHolder" runat="server" />

        <h1>Combo Boxes</h1>

        <div class="example">
            <h2>Data Sources</h2>
            <p>The combo box can use any type of Ext.Net.Store as its data source.
            This means your data can be XML, JSON, arrays or any other supported format. It can be loaded using
            Ajax, via script tags or locally. This combo uses local data:</p>

            <ext:ComboBox
                runat="server"
                FieldLabel="Select a single state"
                DisplayField="name"
                Width="320"
                LabelWidth="130"
                QueryMode="Local"
                TypeAhead="true">
                <Store>
                    <ext:Store runat="server" Data="<%# TestData %>" AutoDataBind="true">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="abbr" />
                                    <ext:ModelField Name="name" />
                                    <ext:ModelField Name="slogan" />
                                </Fields>
                            </ext:Model>
                        </Model>

                        <Reader>
                            <ext:ArrayReader />
                        </Reader>
                    </ext:Store>
                </Store>
            </ext:ComboBox>
        </div>

        <div class="example">
            <h2>Custom Item Templates</h2>
            <p>The combo below uses the same data, but also illustrates how to use an optional
            custom template to create custom UI renditions for list items by overriding the getInnerTpl method. In this case
            each item shows the state's abbreviation, and has a QuickTip which displays the state's nickname when hovered over.</p>

            <ext:ComboBox
                runat="server"
                FieldLabel="Select a single state"
                DisplayField="name"
                Width="320"
                LabelWidth="130"
                QueryMode="Local">

                <Store>
                    <ext:Store runat="server" Data="<%# TestData %>" AutoDataBind="true">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="abbr" />
                                    <ext:ModelField Name="name" />
                                    <ext:ModelField Name="slogan" />
                                </Fields>
                            </ext:Model>
                        </Model>

                        <Reader>
                            <ext:ArrayReader />
                        </Reader>
                    </ext:Store>
                </Store>

                <ListConfig>
                    <ItemTpl runat="server">
                        <Html>
                            <div data-qtip="{name}. {slogan}">
                                {name} ({abbr})
                            </div>
                        </html>                    </ItemTpl>
                </ListConfig>
            </ext:ComboBox>
        </div>

        <div class="example">
            <h2>Multiple Selection</h2>
            <p>The combo below uses the same data once again, but allows selecting multiple values.</p>

            <ext:ComboBox
                runat="server"
                FieldLabel="Select multiple states"
                MultiSelect="true"
                DisplayField="name"
                Width="320"
                LabelWidth="130"
                QueryMode="Local">
                <Store>
                    <ext:Store runat="server" Data="<%# TestData %>" AutoDataBind="true">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="abbr" />
                                    <ext:ModelField Name="name" />
                                    <ext:ModelField Name="slogan" />
                                </Fields>
                            </ext:Model>
                        </Model>

                        <Reader>
                            <ext:ArrayReader />
                        </Reader>
                    </ext:Store>
                </Store>
            </ext:ComboBox>
        </div>

        <div class="example">
            <h2>Transformation</h2>
            <p>ComboBoxes can also be created from existing HTML <code>&lt;select&gt;</code> elements on the page by
            specifying the <code>transform</code> config. This allows creation of rich ComboBox fields with autocompletion
            and list filtering, in an unobtrusive way.</p>

            <ext:ComboBox
                runat="server"
                TypeAhead="true"
                Transform="stateSelect"
                Width="135"
                ForceSelection="true" />

            <div id="transformCombo">
                <label for="stateSelect">Transformed select:</label>
                <select name="state" id="stateSelect">
                    <option value="AL">Alabama</option>
                    <option value="AK">Alaska</option>
                    <option value="AZ">Arizona</option>
                    <option value="AR">Arkansas</option>
                    <option value="CA">California</option>
                    <option value="CO">Colorado</option>
                    <option value="CT">Connecticut</option>
                    <option value="DE">Delaware</option>
                    <option value="FL">Florida</option>
                    <option value="GA">Georgia</option>
                    <option value="HI">Hawaii</option>
                    <option value="ID">Idaho</option>
                    <option value="IL">Illinois</option>
                    <option value="IN">Indiana</option>
                    <option value="IA">Iowa</option>
                    <option value="KS">Kansas</option>
                    <option value="KY">Kentucky</option>
                    <option value="LA">Louisiana</option>
                    <option value="ME">Maine</option>
                    <option value="MD">Maryland</option>
                    <option value="MA">Massachusetts</option>
                    <option value="MI">Michigan</option>
                    <option value="MN">Minnesota</option>
                    <option value="MS">Mississippi</option>
                    <option value="MO">Missouri</option>
                    <option value="MT">Montana</option>
                    <option value="NE">Nebraska</option>
                    <option value="NV">Nevada</option>
                    <option value="NH">New Hampshire</option>
                    <option value="NJ">New Jersey</option>
                    <option value="NM">New Mexico</option>
                    <option value="NY">New York</option>
                    <option value="NC">North Carolina</option>
                    <option value="ND">North Dakota</option>
                    <option value="OH" selected="selected">Ohio</option>
                    <option value="OK">Oklahoma</option>
                    <option value="OR">Oregon</option>
                    <option value="PA">Pennsylvania</option>
                    <option value="RI">Rhode Island</option>
                    <option value="SC">South Carolina</option>
                    <option value="SD">South Dakota</option>
                    <option value="TN">Tennessee</option>
                    <option value="TX">Texas</option>
                    <option value="UT">Utah</option>
                    <option value="VT">Vermont</option>
                    <option value="VA">Virginia</option>
                    <option value="WA">Washington</option>
                    <option value="WV">West Virginia</option>
                    <option value="WI">Wisconsin</option>
                    <option value="WY">Wyoming</option>
                </select>

                <label for="stateSelectOrig">Originally looked like:</label>
                <select name="state-orig" id="stateSelectOrig">
                    <option value="AL">Alabama</option>
                    <option value="AK">Alaska</option>
                    <option value="AZ">Arizona</option>
                    <option value="AR">Arkansas</option>
                    <option value="CA">California</option>
                    <option value="CO">Colorado</option>
                    <option value="CT">Connecticut</option>
                    <option value="DE">Delaware</option>
                    <option value="FL">Florida</option>
                    <option value="GA">Georgia</option>
                    <option value="HI">Hawaii</option>
                    <option value="ID">Idaho</option>
                    <option value="IL">Illinois</option>
                    <option value="IN">Indiana</option>
                    <option value="IA">Iowa</option>
                    <option value="KS">Kansas</option>
                    <option value="KY">Kentucky</option>
                    <option value="LA">Louisiana</option>
                    <option value="ME">Maine</option>
                    <option value="MD">Maryland</option>
                    <option value="MA">Massachusetts</option>
                    <option value="MI">Michigan</option>
                    <option value="MN">Minnesota</option>
                    <option value="MS">Mississippi</option>
                    <option value="MO">Missouri</option>
                    <option value="MT">Montana</option>
                    <option value="NE">Nebraska</option>
                    <option value="NV">Nevada</option>
                    <option value="NH">New Hampshire</option>
                    <option value="NJ">New Jersey</option>
                    <option value="NM">New Mexico</option>
                    <option value="NY">New York</option>
                    <option value="NC">North Carolina</option>
                    <option value="ND">North Dakota</option>
                    <option value="OH" selected="selected">Ohio</option>
                    <option value="OK">Oklahoma</option>
                    <option value="OR">Oregon</option>
                    <option value="PA">Pennsylvania</option>
                    <option value="RI">Rhode Island</option>
                    <option value="SC">South Carolina</option>
                    <option value="SD">South Dakota</option>
                    <option value="TN">Tennessee</option>
                    <option value="TX">Texas</option>
                    <option value="UT">Utah</option>
                    <option value="VT">Vermont</option>
                    <option value="VA">Virginia</option>
                    <option value="WA">Washington</option>
                    <option value="WV">West Virginia</option>
                    <option value="WI">Wisconsin</option>
                    <option value="WY">Wyoming</option>
                </select>
            </div>
    </div>
    </form>
</body>
</html>