<%@ Page Language="C#" %>

<script runat="server">
    private static string[] LAST_NAMES = new string[] { "Jones", "Smith", "Lee", "Wilson", "Black", "Williams", "Lewis", "Johnson", "Foot", "Little", "Vee", "Train", "Hot", "Mutt" };
    private static string[] FIRST_NAMES = new string[] { "Fred", "Julie", "Bill", "Ted", "George", "John", "Mark", "Mike", "Chris", "Bob", "Travis", "Kelly", "Sara" };
    private static string[] CITIES = new string[] { "New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose" };
    private static string[] DEPARTMENTS = new string[] { "Development", "QA", "Marketing", "Accounting", "Sales" };
    private static Random RANDOM = new Random();

    public class Office
    {
        public string City { get; set; }
        public string Manager { get; set; }
        public int TotalEmployees { get; set; }
    }

    public class Employee
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int No { get; set; }
        public string Department { get; set; }
    }

    private string GetUnigueCity(List<string> usedCities)
    {
        string city = CITIES[RANDOM.Next(CITIES.Length)];
        if (usedCities.Contains(city))
        {
            return this.GetUnigueCity(usedCities);
        }
        else
        {
            usedCities.Add(city);
            return city;
        }
    }

    private string[] GetUnigueName(List<string> usedNames)
    {
        string firstName = FIRST_NAMES[RANDOM.Next(FIRST_NAMES.Length)];
        string lastName = LAST_NAMES[RANDOM.Next(LAST_NAMES.Length)];
        string[] name = new string[] { firstName, lastName };
        string key = firstName + lastName;

        if (usedNames.Contains(key))
        {
            return this.GetUnigueName(usedNames);
        }
        else
        {
            usedNames.Add(key);
            return name;
        }
    }

    private object[] GetOfficesData()
    {
        Office[] data = new Office[7];
        List<string> usedNames = new List<string>();
        List<string> usedCities = new List<string>();

        for (int i = 0; i < 7; i++)
        {
            string[] name = this.GetUnigueName(usedNames);
            data[i] = new Office()
            {
                City = this.GetUnigueCity(usedCities),
                Manager = name[0] + " " +  name[1],
                TotalEmployees = RANDOM.Next(10, 25)
            };
        }

        return data;
    }

    private object[] GetEmployeesData()
    {
        Employee[] data = new Employee[20];
        List<string> usedNames = new List<string>();

        for (int i = 0; i < 20; i++)
        {
            string[] name = this.GetUnigueName(usedNames);
            data[i] = new Employee()
            {
                FirstName = name[0],
                LastName = name[1],
                No = int.Parse(RANDOM.Next(100, 200).ToString() + RANDOM.Next(100, 200).ToString()),
                Department = DEPARTMENTS[RANDOM.Next(DEPARTMENTS.Length)]
            };
        }

        return data;
    }

    private AbstractStore GetOfficeStore()
    {
        Store store = new Store();
        store.Data = this.GetOfficesData();
        store.Fields.Add("City", "TotalEmployees", "Manager");

        return store;
    }

    private AbstractStore GetEmployeesStore()
    {
        Store store = new Store();
        store.Data = this.GetEmployeesData();
        store.Fields.Add("FirstName", "LastName", "No", "Department");

        return store;
    }

    private ColumnBase[] GetOfficesColumns()
    {
        return new ColumnBase[]
        {
            new Column()
            {
                Text = "City",
                DataIndex = "City",
                Flex = 1
            },
            new Column()
            {
                Text = "Total Employees",
                DataIndex = "TotalEmployees",
                Width = 140
            },
            new Column()
            {
                Text = "Manager",
                DataIndex = "Manager",
                Width = 120
            }
        };
    }

    private ColumnBase[] GetEmployeesColumns()
    {
        return new ColumnBase[]
        {
            new Column()
            {
                Text = "First Name",
                DataIndex = "FirstName",
                Flex = 1
            },
            new Column()
            {
                Text = "Last Name",
                DataIndex = "LastName",
                Flex = 1
            },
            new Column()
            {
                Text = "Employee No.",
                DataIndex = "No",
                Width = 120
            },
            new Column()
            {
                Text = "Department",
                DataIndex = "Department",
                Flex = 1
            }
        };
    }

    protected void ShowOfficesButton_Click(object sender, DirectEventArgs e)
    {
        X.Js.Call("Ext.suspendLayouts");
        this.GridPanel1.Title = "Offices";
        this.GridPanel1.Reconfigure(this.GetOfficeStore(), this.GetOfficesColumns());
        this.ShowOfficesButton.Disabled = true;
        this.ShowEmployeesButton.Disabled = false;
        X.Js.Call("Ext.resumeLayouts", true);
    }

    protected void ShowEmployeesButton_Click(object sender, DirectEventArgs e)
    {
        X.Js.Call("Ext.suspendLayouts");
        this.GridPanel1.Title = "Employees";
        this.GridPanel1.Reconfigure(this.GetEmployeesStore(), this.GetEmployeesColumns());
        this.ShowEmployeesButton.Disabled = true;
        this.ShowOfficesButton.Disabled = false;
        X.Js.Call("Ext.resumeLayouts", true);
    }
</script>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Reconfigure GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server"  MarginSpec="0 0 10 0">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:Container runat="server" Width="500" Height="330">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Layout="HBox">
                            <Items>
                                <ext:Button
                                    ID="ShowOfficesButton"
                                    runat="server"
                                    Text="Show Offices"
                                    OnDirectClick="ShowOfficesButton_Click"
                                    />

                                <ext:Button
                                    ID="ShowEmployeesButton"
                                    runat="server"
                                    Text="Show Employees"
                                    OnDirectClick="ShowEmployeesButton_Click"
                                    MarginSpec="0 0 0 10"
                                    />
                            </Items>
                        </ext:Container>
                        <ext:GridPanel
                            ID="GridPanel1"
                            runat="server"
                            MarginSpec="10 0 0 0"
                            Flex="1">
                            <ViewConfig EmptyText="Click a button to show a dataset" DeferEmptyText="false" />
                        </ext:GridPanel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>