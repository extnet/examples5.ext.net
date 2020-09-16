<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Store1.Data = this.Users;
    }

    public List<User> Users
    {
        get
        {
            return new List<User>
            {
                new User(1, "User1", new List<Product>{
                    new Product(1, "Product1 of User1"),
                    new Product(2, "Product2 of User1"),
                    new Product(3, "Product3 of User1")
                }),

                new User(2, "User2", new List<Product>{
                    new Product(4, "Product1 of User2"),
                    new Product(5, "Product2 of User2"),
                    new Product(6, "Product3 of User2")
                }),

                new User(3, "User3", new List<Product>{
                    new Product(7, "Product1 of User3"),
                    new Product(8, "Product2 of User3"),
                    new Product(9, "Product3 of User3")
                })
            };
        }
    }

    public class Product
    {
        public Product(int id, string name)
        {
            this.Id = id;
            this.Name = name;
        }

        public int Id
        {
            get;
            private set;
        }

        public string Name
        {
            get;
            private set;
        }
    }

    public class User
    {
        public User(int id, string name, List<Product> products)
        {
            this.Id = id;
            this.Name = name;
            this.Products = products;
        }

        public int Id
        {
            get;
            private set;
        }

        public string Name
        {
            get;
            private set;
        }

        public List<Product> Products
        {
            get;
            private set;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple HasMany Association - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Simple HasMany Association</h1>

    <ext:Model runat="server" Name="Product" IDProperty="Id">
        <Fields>
            <ext:ModelField Name="Id" Type="Int" />
            <ext:ModelField Name="Name" Type="String" />
        </Fields>
    </ext:Model>

    <ext:Store ID="Store1" runat="server">
        <Model>
            <ext:Model runat="server" Name="User" IDProperty="Id">
                <Fields>
                    <ext:ModelField Name="Id" Type="Int" />
                    <ext:ModelField Name="Name" Type="String" />
                </Fields>
                <Associations>
                    <ext:HasManyAssociation Model="Product" Name="products" AssociationKey="Products" />
                </Associations>
            </ext:Model>
        </Model>
    </ext:Store>

    <ext:Panel
        runat="server"
        Border="false"
        Width="500"
        Height="250">
        <LayoutConfig>
            <ext:HBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Defaults>
            <ext:Parameter Name="margin" Value="5" Mode="Raw" />
        </Defaults>
        <Items>
            <ext:GridPanel
                runat="server"
                StoreID="Store1"
                Title="Users (select a row to see products)"
                Flex="1">
                <ColumnModel>
                    <Columns>
                        <ext:Column
                            runat="server"
                            Text="Name"
                            DataIndex="Name"
                            Flex="1"
                            />
                    </Columns>
                </ColumnModel>
                <Listeners>
                    <SelectionChange Handler="selected.length && #{ProductsGrid}.bindStore(selected[0].products());" />
                </Listeners>
            </ext:GridPanel>

            <ext:GridPanel
                ID="ProductsGrid"
                runat="server"
                Title="Products"
                Flex="1">
                <Store>
                    <ext:Store runat="server" ModelName="Product" />
                </Store>
                <ColumnModel>
                    <Columns>
                        <ext:Column
                            runat="server"
                            Text="Name"
                            DataIndex="Name"
                            Flex="1"
                            />
                    </Columns>
                </ColumnModel>
            </ext:GridPanel>
        </Items>
    </ext:Panel>

    <br />

    <ext:GridPanel
        runat="server"
        StoreID="Store1"
        Title="Users with RowExpander"
        Width="500"
        Height="250">
        <ColumnModel>
            <Columns>
                <ext:Column
                    runat="server"
                    Text="Name"
                    DataIndex="Name"
                    Flex="1"
                    />
            </Columns>
        </ColumnModel>
        <Plugins>
            <ext:RowExpander runat="server" SingleExpand="false">
                <Component>
                    <ext:GridPanel runat="server" Title="Products">
                        <Store>
                            <ext:Store runat="server" ModelName="Product" />
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column
                                    runat="server"
                                    Text="Name"
                                    DataIndex="Name"
                                    Flex="1"
                                    />
                            </Columns>
                        </ColumnModel>
                        <Listeners>
                            <ViewReady Handler="this.bindStore(this.record.products());" Delay="1" />
                        </Listeners>
                    </ext:GridPanel>
                </Component>
            </ext:RowExpander>
        </Plugins>
    </ext:GridPanel>
</body>
</html>
