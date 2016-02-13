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
                LastName = ("LastName" + i),
                Company = ("Company" + i)
            };

            Address address = new Address
            {
                StreetAddress = ("Street" + i),
                City = ("City" + i)
            };

            customer.Address = address;

            list.Add(customer);
        }

        this.Store1.DataSource = list;
        this.Store1.DataBind();
    }

    public class Customer
    {
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Company { get; set; }
        public Address Address { get; set; }
    }

    public class Address
    {
        public string StreetAddress { get; set; }
        public string City { get; set; }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Data Prepare - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

     <script>
         var prepareCity = function (value, record) {
             return record.get('Address').City;
         };

         var prepareStreet = function (value, record) {
             return record.get('Address').StreetAddress;
         };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
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
                                <ext:ModelField Name="Company" />
                                <ext:ModelField Name="Address" Type="Object" />
                                <ext:ModelField Name="City">
                                    <Convert Fn="prepareCity" />
                                </ext:ModelField>
                                <ext:ModelField Name="Street">
                                    <Convert Fn="prepareStreet" />
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
                    <ext:Column runat="server" Text="Company" DataIndex="Company" />
                    <ext:Column runat="server" Text="City" DataIndex="City" />
                    <ext:Column runat="server" Text="Street" DataIndex="Street" />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>