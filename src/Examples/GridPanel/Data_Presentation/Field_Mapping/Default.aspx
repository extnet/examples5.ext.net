<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = Employee.GetAll();
        this.Store1.DataBind();
    }

    public class Employee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public Department Department { get; set; }

        public static List<Employee> GetAll()
        {
            return new List<Employee>
            {
                new Employee
                    {
                        ID = 1,
                        Name = "Nancy",
                        Surname = "Davolio",
                        Department = Department.GetAll()[0]
                    },
                new Employee
                    {
                        ID = 2,
                        Name = "Andrew",
                        Surname = "Fuller",
                        Department = Department.GetAll()[2]
                    }
            };
        }
    }

    public class Department
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public static List<Department> GetAll()
        {
            return new List<Department>
            {
                new Department {ID = 1, Name = "Department A"},
                new Department {ID = 2, Name = "Department B"},
                new Department {ID = 3, Name = "Department C"}
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Field Mapping - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var departmentRenderer = function (value) {
            if (!Ext.isEmpty(value)) {
                return value.Name;
            }

            return value;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel runat="server" Title="List" IconCls="x-md md-icon-open-in-new">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="Surname" />
                                <ext:ModelField Name="Department" Type="Object" />
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
                    <ext:Column
                        runat="server"
                        Text="DEPARTMENT"
                        DataIndex="Department"
                        Width="240">
                        <Renderer Fn="departmentRenderer" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>