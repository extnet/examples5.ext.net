<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = this.Jobs;
        this.Store1.DataBind();
    }

    private List<Job> Jobs
    {
        get
        {
            List<Job> jobs = new List<Job>();

            for (int i = 1; i <= 50; i++)
            {
                jobs.Add(new Job(
                            i,
                            "Task" + i.ToString(),
                            DateTime.Today.AddDays(i),
                            DateTime.Today.AddDays(i + i),
                            (i%3 == 0)));
            }

            return jobs;
        }
    }

    public class Job
    {
        public Job(int id, string name, DateTime start, DateTime end, bool completed)
        {
            this.ID = id;
            this.Name = name;
            this.Start = start;
            this.End = end;
            this.Completed = completed;
        }

        public int ID { get; set; }
        public string Name { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public bool Completed { get; set; }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with FitLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            ID="Window1"
            runat="server"
            Collapsible="true"
            Maximizable="true"
            Icon="Lorry"
            Title="Job List"
            Width="600"
            Height="300"
            X="50"
            Y="50"
            Layout="Fit">
            <Items>
                <ext:GridPanel
                    runat="server"
                    Header="false"
                    Border="false">
                    <Store>
                        <ext:Store ID="Store1" runat="server" PageSize="10">
                            <Model>
                                <ext:Model runat="server" IDProperty="ID">
                                    <Fields>
                                        <ext:ModelField Name="ID" />
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Start" Type="Date" />
                                        <ext:ModelField Name="End" Type="Date" />
                                        <ext:ModelField Name="Completed" Type="Boolean" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server"
                                Text="ID"
                                Width="40"
                                Sortable="true"
                                DataIndex="ID">
                                <Filter>
                                    <ext:NumberFilter />
                                </Filter>
                            </ext:Column>
                            <ext:Column runat="server"
                                Text="Job Name"
                                Sortable="true"
                                DataIndex="Name"
                                Flex="1">
                                <Filter>
                                    <ext:StringFilter />
                                </Filter>
                            </ext:Column>
                            <ext:DateColumn runat="server"
                                Text="Start"
                                Width="120"
                                Sortable="true"
                                DataIndex="Start"
                                Format="yyyy-MM-dd">
                                <Filter>
                                    <ext:DateFilter>
                                        <DatePickerOptions runat="server" TodayText="Now" />
                                    </ext:DateFilter>
                                </Filter>
                            </ext:DateColumn>
                            <ext:DateColumn runat="server"
                                Text="End"
                                Width="120"
                                Sortable="true"
                                DataIndex="End"
                                Format="yyyy-MM-dd">
                                <Filter>
                                    <ext:DateFilter>
                                        <DatePickerOptions runat="server" TodayText="Now" />
                                    </ext:DateFilter>
                                </Filter>
                            </ext:DateColumn>
                            <ext:Column runat="server"
                                Text="Completed"
                                Width="80"
                                Sortable="true"
                                DataIndex="Completed">
                                <Renderer Handler="return (value) ? 'Yes':'No';" />
                                <Filter>
                                    <ext:BooleanFilter />
                                </Filter>
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView runat="server" LoadMask="false" />
                    </View>
                    <Plugins>
                        <ext:GridFilters runat="server" />
                    </Plugins>
                    <BottomBar>
                        <ext:PagingToolbar
                            runat="server"
                            DisplayInfo="true"
                            DisplayMsg="Displaying Jobs {0} - {1} of {2}"
                            />
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>