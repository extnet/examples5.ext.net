<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            List<object> list = new List<object>
            {
                new {Text = "Text3", Value = 3},
                new {Text = "Text4", Value = 4},
                new {Text = "Text5", Value = 5}
            };

            this.Store1.DataSource = list;
            this.Store1.DataBind();

            //Please note that inner items will be above store's items
            this.ComboBox1.Items.Insert(0, new Ext.Net.ListItem("None", "-"));

            this.ComboBox1.SelectedItems.Add(new Ext.Net.ListItem("-"));
        }
    }

    protected void InsertRecord(object sender, DirectEventArgs e)
    {
        Dictionary<string, object> values = new Dictionary<string, object>(2);
        values.Add("Text", "Text0");
        values.Add("Value", "0");

        this.ComboBox1.InsertRecord(1, values);
        this.ComboBox1.SelectedItems.Clear();
        this.ComboBox1.SelectedItems.Add(new Ext.Net.ListItem { Value="0" });
        this.ComboBox1.UpdateSelectedItems();

        (sender as Ext.Net.Button).Disabled = true;
    }

    protected void InsertRecord2(object sender, DirectEventArgs e)
    {
        this.ComboBox2.InsertItem(0, "Text0", "0");
        this.ComboBox2.SelectedItems.Clear();
        this.ComboBox2.SelectedItems.Add(new Ext.Net.ListItem { Value = "0" });
        this.ComboBox2.UpdateSelectedItems();

        (sender as Ext.Net.Button).Disabled = true;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Items Actions - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <p>1. Combo with a store and inner items (merge mode)</p>
        <br />

        <ext:ComboBox
            ID="ComboBox1"
            runat="server"
            DisplayField="Text"
            ValueField="Value"
            QueryMode="Local">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="Value">
                            <Fields>
                                <ext:ModelField Name="Text" />
                                <ext:ModelField Name="Value" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <Items>
                <ext:ListItem Text="Text2" Value="2" />
            </Items>
            <Triggers>
                <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="this.removeByValue(this.getValue());
                                       this.clearValue();" />
            </Listeners>
        </ext:ComboBox>

        <br />

        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:Button runat="server" Text="Insert: client side">
                    <Listeners>
                        <Click Handler="#{ComboBox1}.insertRecord(1, {
                                            Text  : 'Text1',
                                            Value : 1
                                        });
                                        #{ComboBox1}.setValue(1);
                                        this.disable();" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Insert: server side">
                    <DirectEvents>
                        <Click OnEvent="InsertRecord" />
                    </DirectEvents>
                </ext:Button>
            </Items>
        </ext:Container>

        <br />
        <br />
        <p>2. Combo with inner items</p>
        <br />

        <%-- please note that the insertRecord function works with inner items also --%>
        <ext:ComboBox ID="ComboBox2" runat="server">
            <Items>
                <ext:ListItem Text="Text2" Value="2" />
                <ext:ListItem Text="Text3" Value="3" />
                <ext:ListItem Text="Text4" Value="4" />
                <ext:ListItem Text="Text5" Value="5" />
            </Items>
            <Triggers>
                <ext:FieldTrigger Icon="Clear" Qtip="Remove selected" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="this.removeByValue(this.getValue());
                                       this.clearValue();" />
            </Listeners>
        </ext:ComboBox>

        <br />

        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:Button runat="server" Text="Insert: client side">
                    <Listeners>
                        <Click Handler="#{ComboBox2}.insertItem(0, 'Text1', 1);
                                        #{ComboBox2}.setValue(1);
                                        this.disable();" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Insert: server side">
                    <DirectEvents>
                        <Click OnEvent="InsertRecord2" />
                    </DirectEvents>
                </ext:Button>
            </Items>
        </ext:Container>

        <br />

        <h2>Other functions:</h2>

        <ul>
            <li>addRecord: function (values)</li>
            <li>addItem: function (text, value)</li>
            <li>insertRecord: function (rowIndex, values)</li>
            <li>insertItem: function (rowIndex, text, value)</li>
            <li>removeByField: function (field, value)</li>
            <li>removeByIndex: function (index)</li>
            <li>removeByValue: function (value)</li>
            <li>removeByText: function (text)</li>
        </ul>
    </form>
</body>
</html>