<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.StoreCombo.DataSource = Department.GetAll();
        this.StoreCombo.DataBind();

        this.Store1.DataSource = Employee.GetAll();
        this.Store1.DataBind();
    }

    public class Employee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public Department[] Departments { get; set; }

        public int[] DepartmentIds
        {
            get
            {
                var retVal = new List<int>();

                if (this.Departments != null && this.Departments.Length > 0)
                {
                    retVal.AddRange(this.Departments.Select(d => d.ID));
                }
                else
                {
                    retVal.Add(-1);
                }
                return retVal.ToArray();
            }
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
                    Departments = new [] {
                        Department.GetAll()[0]
                    }
                },
                new Employee
                {
                    ID = 2,
                    Name = "Andrew",
                    Surname = "Fuller",
                    Departments = new [] {
                        Department.GetAll()[0],
                        Department.GetAll()[2]
                    }
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
    <title>Editor Field Mapping for MultiCombo Editor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var departmentRenderer = function (value) {
            var cell, rarr, rec;

            if (Ext.isString(value) && value.match(/,/)) {
                value = value.split(",");
            }

            if (Ext.isArray(value)) {
                var rarr = [];
                Ext.each(value, function (record_id) {
                    var rec = App.StoreCombo.getById(record_id);
                    if (!Ext.isEmpty(rec)) {
                        rarr.push(rec.data.Name);
                    }
                });
                cell = rarr.join(", ");
            } else {
                rec = App.StoreCombo.getById(value);
                cell = Ext.isEmpty(rec) ? "" : rec.data.Name;
            }

            return cell;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Store ID="StoreCombo" runat="server">
            <Model>
                <ext:Model runat="server" IDProperty="ID">
                    <Fields>
                        <ext:ModelField Name="ID" />
                        <ext:ModelField Name="Name" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:GridPanel
            runat="server"
            Title="List"
            Icon="Application">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="ID">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="Surname" />
                                <ext:ModelField Name="DepartmentIds" Type="Object" />
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
                    <ext:Column runat="server" Text="DEPARTMENT" DataIndex="DepartmentIds" Width="320">
                        <Renderer Fn="departmentRenderer" />
                        <Editor>
                            <%-- Here, a ComboBox with MultiSelect="True" would also work --%>
                            <ext:MultiCombo
                                runat="server"
                                QueryMode="Local"
                                Editable="false"
                                StoreID="StoreCombo"
                                DisplayField="Name"
                                ValueField="ID"
                                />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>