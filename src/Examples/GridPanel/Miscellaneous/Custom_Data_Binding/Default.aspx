<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Customer> list = new List<Customer>(5);

        for (int i = 1; i <= 5; i++)
        {
            Customer customer = new Customer
            {
                ID = i,
                FirstName = ("FirstName" + i),
                LastName = ("LastName" + i)
            };

            Address address = new Address
            {
                Street = ("Street" + i),
                City = ("City" + i),
                SomeAdditionalInfo = "SomeAdditionalInfo" // it comes from a database, for example
            };

            customer.Address = address;

            list.Add(customer);
        }

        this.Store1.DataSource = list;
    }


    public class Customer
    {
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public Address Address { get; set; }
    }

    public class Address
    {
        public string City { get; set; }
        public string Street { get; set; }
        public string SomeAdditionalInfo { get; set; } // we would like to exclude that property from binding
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Data Binding - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Data Binding using a ModelField's Model</h1>
        <p>The example demonstrates a possibility to customize binding the data to the Store using a ModelField's Model.</p>
        <p>More details you can find <a href="http://forums.ext.net/showthread.php?26837">here</a>.</p>

        <ext:GridPanel
            runat="server"
            Title="Customers"
            Width="630"
            Height="300">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="FirstName" />
                                <ext:ModelField Name="LastName" />
                                <ext:ModelField Name="Address">
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="City" />
                                                <ext:ModelField Name="Street" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:ModelField>
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="ID" DataIndex="ID" />
                    <ext:Column runat="server" Text="FirstName" DataIndex="FirstName" />
                    <ext:Column runat="server" Text="LastName" DataIndex="LastName" />
                    <ext:Column runat="server" Text="City" DataIndex="Address">
                        <Renderer Handler="return value.City;" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Street" DataIndex="Address">
                        <Renderer Handler="return value.Street;" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>