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
        public Department Department { get; set; }

        public int DepartmentId
        {
            get { return this.Department != null ? this.Department.ID : -1; }
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
                    Department = Department.GetAll()[0]
                },
                new Employee
                {
                    ID = 2,
                    Name = "Andrew",
                    Surname = "Fuller",
                    Department = Department.GetAll()[2]
                },
                new Employee
                {
                    ID = 3,
                    Name = "Matthew",
                    Surname = "Skulason",
                    Department = Department.GetAll()[1]
                },
                new Employee
                {
                    ID = 4,
                    Name = "Sidney",
                    Surname = "Scott",
                    Department = Department.GetAll()[0]
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
    <title>Mapped Field Filtering - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var departmentRenderer = function (value) {
            var r = App.StoreCombo.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.Name;
        };

        Ext.net.FilterHeader.behaviour.addBehaviour("string", {
            name: "comboMap",

            cropStr: "Department ",

            // Always use this approach
            is: function (value) {
                return true;
            },

            getValue: function (value) {
                console.log("filter get value");

                return { value: value, valid: value.length >= 0 };
            },

            // Map the record to the corresponding department text before comparing with the filter string
            match: function (recordValue, matchValue) {
                console.log("match filter Header");

                if (matchValue.length == 0) {
                    return true;
                }

                if (recordValue != null) {
                    // This is a more "robust" approach, but if performance is preferred,
                    // ensure the field is set up as the store combo's IdProperty, then use findById().
                    var recordIdx = App.StoreCombo.find('ID', recordValue);

                    // only try matching if a record could actually be mapped into the combo store.
                    if (recordIdx >= 0) {
                        var mappedRecord = App.StoreCombo.getAt(recordIdx);
                        var mappedValue = mappedRecord.data.Name;

                        if (mappedValue.startsWith(this.cropStr)) {
                            mappedValue = mappedValue.substring(this.cropStr.length);
                        }

                        regexp = new RegExp(matchValue, 'gi');

                        if (mappedValue.match(regexp)) {
                            return true;
                        }
                    }
                }
                
                return false;
            }
        });
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

        <h1>Mapped field for FilterHeader</h1>

        <p>This examples demonstrates how to add custom behaviour for filtering a field that is mapped from numbers to text values.</p>
        <p>Custom behaviour: match only the department names (A, B, C, D)</p>
        <p>Example: A</p>

        <p>The filter crops off the 'Department ' string from the name, so anything different from A B C D will not return any value.</p>
        <p>The department cells can be edited and switched over other values, from which they will be taken away or included depending on the active filter.</p>

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
                                <ext:ModelField Name="DepartmentId" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="ID" DataIndex="ID" Filterable="false" />
                    <ext:Column runat="server" Text="NAME" DataIndex="Name" Filterable="false" />
                    <ext:Column runat="server" Text="SURNAME" DataIndex="Surname" Filterable="false" />
                    <ext:Column runat="server" Text="DEPARTMENT" DataIndex="DepartmentId" Width="240">
                        <Renderer Fn="departmentRenderer" />
                        <Editor>
                            <ext:ComboBox
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
                <ext:FilterHeader runat="server" />
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>