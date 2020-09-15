<%@ Page Language="C#" %>

<script runat="server">
    public class Department
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public string GetIdPlusName()
        {
            return this.ID + ": " + this.Name;
        }

        public static List<Department> GetAll()
        {
            return new List<Department>
            {
                new Department { ID = 1, Name = "Department A" },
                new Department { ID = 2, Name = "Department B" },
                new Department { ID = 3, Name = "Department C" }
            };
        }
    }

    public class Employee
    {
        public int ID { get; set; }
        public string GUID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public Department Department { get; set; }
        public string[] Phone { get; set; }

        public string GetFullName()
        {
            return this.Name + " " + this.Surname;
        }

        public static List<Employee> GetAll()
        {
            return new List<Employee>
            {
                new Employee
                {
                    ID = 1,
                    Name = "Nancy",
                    Surname = "Davolio",
                    Department = Department.GetAll()[0],
                    Phone = new string[] { "555-555-555", "777-777-777" }
                },
                new Employee
                {
                    ID = 2,
                    Name = "Andrew",
                    Surname = "Fuller",
                    Department = Department.GetAll()[2],
                    Phone = new string[] { "333-333-333", "111-111-111" }
                }
            };
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Store store = this.GridPanel1.GetStore();

        store.DataSource = Employee.GetAll();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Server Mapping - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="List"
            IconCls="x-md md-icon-open-in-new">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="Surname" ServerMapping="Surname.ToUpper()" />
                                <ext:ModelField Name="Fullname" ServerMapping="GetFullName()" />
                                <ext:ModelField Name="Department" ServerMapping="Department.Name" />
                                <ext:ModelField Name="DepartmentIdPlusName" ServerMapping="Department.GetIdPlusName()" />
                                <ext:ModelField Name="PhoneHome" ServerMapping="Phone[0]" />
                                <ext:ModelField Name="PhoneWork" ServerMapping="Phone[1]" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="ID" DataIndex="ID" />
                    <ext:Column runat="server" Text="NAME" DataIndex="Name" />
                    <ext:Column runat="server" Text="SURNAME" DataIndex="Surname" />
                    <ext:Column runat="server" Text="FULL NAME" DataIndex="Fullname" />
                    <ext:Column runat="server" Text="DEPARTMENT" DataIndex="Department" />
                    <ext:Column runat="server" Text="DEPARTMENT ID:NAME" DataIndex="DepartmentIdPlusName" Width="125" />
                    <ext:Column runat="server" Text="PHONE HOME" DataIndex="PhoneHome" />
                    <ext:Column runat="server" Text="PHONE WORK" DataIndex="PhoneWork" />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>