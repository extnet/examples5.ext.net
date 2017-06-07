<%@ Control Language="C#" %>

<script runat="server">
    public class Customer
    {       
        public int Id
        {
            get;
            set;
        }

        public string Phone
        {
            get;
            set;
        }

        public string Name
        {
            get;
            set;
        }
    }

    public class Order
    {
        public int Id
        {
            get;
            set;
        }

        public int CustomerId
        {
            get;
            set;
        }

        public DateTime Date
        {
            get;
            set;
        }
    }

    public class OrderItem
    {
        public int Id
        {
            get;
            set;
        }

        public int OrderId
        {
            get;
            set;
        }

        public string Product
        {
            get;
            set;
        }

        public int Quantity
        {
            get;
            set;
        }

        public double Price
        {
            get;
            set;
        }
    }

    public List<Customer> Customers
    {
        get
        {
            return new List<Customer> 
            { 
                new Customer{Id = 1, Name = "Bread Barn", Phone = "8436-365-256"},
                new Customer{Id = 2, Name = "Icecream Island", Phone = "8452-389-719"},
                new Customer{Id = 3, Name = "Pizza Palace", Phone = "9378-255-743"}
            };
        }
    }

    public List<Order> Orders
    {
        get
        {
            return new List<Order> 
            { 
                new Order{Id = 1, CustomerId = 1, Date = new DateTime(2010, 8, 13)},
                new Order{Id = 2, CustomerId = 1, Date = new DateTime(2010, 7, 14)},
                new Order{Id = 3, CustomerId = 2, Date = new DateTime(2010, 1, 22)},
                new Order{Id = 4, CustomerId = 2, Date = new DateTime(2010, 11, 6)},
                new Order{Id = 5, CustomerId = 3, Date = new DateTime(2010, 12, 29)},
                new Order{Id = 6, CustomerId = 3, Date = new DateTime(2010, 3, 3)}
            };
        }
    }

    public List<OrderItem> OrderItems
    {
        get
        {
            return new List<OrderItem> 
            { 
                new OrderItem{Id = 1, OrderId = 1, Product = "Chair", Price = 13.43, Quantity = 1},
                new OrderItem{Id = 2, OrderId = 1, Product = "Stool", Price = 14.55, Quantity = 2},
                new OrderItem{Id = 3, OrderId = 1, Product = "Table", Price = 44.2, Quantity = 1},
                new OrderItem{Id = 4, OrderId = 2, Product = "Chair", Price = 13.43, Quantity = 3},
                new OrderItem{Id = 5, OrderId = 2, Product = "Stool", Price = 14.55, Quantity = 6},
                new OrderItem{Id = 6, OrderId = 2, Product = "Table", Price = 44.2, Quantity = 2},
                new OrderItem{Id = 7, OrderId = 3, Product = "Chair", Price = 13.43, Quantity = 1},
                new OrderItem{Id = 8, OrderId = 3, Product = "Stool", Price = 14.55, Quantity = 2},
                new OrderItem{Id = 9, OrderId = 4, Product = "Table", Price = 44.2, Quantity = 1},
                new OrderItem{Id = 10, OrderId = 5, Product = "Stool", Price = 14.55, Quantity = 2},
                new OrderItem{Id = 11, OrderId = 5, Product = "Table", Price = 44.2, Quantity = 2},
                new OrderItem{Id = 12, OrderId = 6, Product = "Chair", Price = 13.43, Quantity = 2},
                new OrderItem{Id = 13, OrderId = 6, Product = "Stool", Price = 14.55, Quantity = 4},
                new OrderItem{Id = 14, OrderId = 6, Product = "Table", Price = 44.2, Quantity = 1}
            };
        }
    }

    [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
    public object GetCustomers(string action, Dictionary<string,object> extraParams)
    {
        if (extraParams.ContainsKey("id"))
        {
            int id = Convert.ToInt32(extraParams["id"]);
            return this.Customers.Where(c => c.Id == id);
        }
        
        return this.Customers;
    }

    [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
    public object GetOrders(string action, Dictionary<string, object> extraParams)
    {
        if (extraParams.ContainsKey("id"))
        {
            int id = Convert.ToInt32(extraParams["id"]);
            return this.Orders.Where(o => o.Id == id);
        }
        
        int customerId = -1;

        StoreRequestParameters prms = new StoreRequestParameters(extraParams);
        DataFilter[] filter = prms.Filter;
        if (filter.Length > 0 && filter[0].Property == "CustomerId")
        {
            customerId = Convert.ToInt32(filter[0].Value);
        }

        return this.Orders.Where(o => o.CustomerId == customerId);
    }

    [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
    public object GetOrderItems(string action, Dictionary<string, object> extraParams)
    {
        if (extraParams.ContainsKey("id"))
        {
            int id = Convert.ToInt32(extraParams["id"]);
            return this.OrderItems.Where(oi => oi.Id == id);
        }
        
        int orderId = -1;

        StoreRequestParameters prms = new StoreRequestParameters(extraParams);
        DataFilter[] filter = prms.Filter;
        if (filter.Length > 0 && filter[0].Property == "OrderId")
        {
            orderId = Convert.ToInt32(filter[0].Value);
        }

        return this.OrderItems.Where(oi => oi.OrderId == orderId);
    }    
</script>

<ext:Model runat="server" Name="Customer" IDProperty="Id">
    <Fields>
        <ext:ModelField Name="Id" Type="Int" />
        <ext:ModelField Name="Name" />
        <ext:ModelField Name="Phone" />
    </Fields>
    <Associations>
        <ext:HasManyAssociation Model="Order" AutoLoad="true" PrimaryKey="Id" ForeignKey="CustomerId" />
    </Associations>
    <Proxy>
        <ext:PageProxy DirectFn="App.direct.GetCustomers" />
    </Proxy>
</ext:Model>

<ext:Model runat="server" Name="Order" IDProperty="Id">
    <Fields>
        <ext:ModelField Name="Id" Type="Int" />
        <ext:ModelField Name="CustomerId" Type="Int" />
        <ext:ModelField Name="Date" Type="Date" />
    </Fields>
    <Associations>
        <%--
            Alternatively to HasMany from Customer model to Order model,
            a BelongsTo from Order to Customer would also work.
        --%>
        <%--<ext:BelongsToAssociation Model="Customer" ForeignKey="CustomerId" PrimaryKey="Id" />--%>
        <ext:HasManyAssociation Model="OrderItem" AutoLoad="true" PrimaryKey="Id" ForeignKey="OrderId" />
    </Associations>
    <Proxy>
        <ext:PageProxy DirectFn="App.direct.GetOrders" />
    </Proxy>
</ext:Model>

<ext:Model runat="server" Name="OrderItem" IDProperty="Id">
    <Fields>
        <ext:ModelField Name="Id" Type="Int" />
        <ext:ModelField Name="OrderId" Type="Int" />
        <ext:ModelField Name="Product" />
        <ext:ModelField Name="Quantity" Type="Int" />
        <ext:ModelField Name="Price" Type="Float" />
    </Fields>

    <%--
        Alternatively to HasMany from Order model to OrderItem model,
        a BelongsTo from OrderItem to Order would also work.
    --%>
    <%--<Associations>
        <ext:BelongsToAssociation Model="Order" ForeignKey="OrderId" PrimaryKey="Id" />
    </Associations>--%>
    <Proxy>
        <ext:PageProxy DirectFn="App.direct.GetOrderItems" />
    </Proxy>
</ext:Model>