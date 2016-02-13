<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Session["TestPersons"] = null;
        }
        this.BindData();
    }

    public class TestPerson
    {
        public int? Id
        {
            get; set;
        }

        public string PhantomId
        {
            get;
            set;
        }

        public string Email
        {
            get; set;
        }

        public string First
        {
            get;
            set;
        }

        public string Last
        {
            get;
            set;
        }
    }

    //----------------Page------------------------
    private List<TestPerson> TestPersons
    {
        get
        {
            return new List<TestPerson>
               {
                   new TestPerson{Id=1, Email="fred@flintstone.com", First="Fred", Last="Flintstone"},
                   new TestPerson{Id=2, Email="wilma@flintstone.com", First="Wilma", Last="Flintstone"},
                   new TestPerson{Id=3, Email="pebbles@flintstone.com", First="Pebbles", Last="Flintstone"},
                   new TestPerson{Id=4, Email="barney@rubble.com", First="Barney", Last="Rubble"},
                   new TestPerson{Id=5, Email="betty@rubble.com", First="Betty", Last="Rubble"},
                   new TestPerson{Id=6, Email="bambam@rubble.com", First="BamBam", Last="Rubble"}
               };
        }
    }

    private static int curId = 7;
    private static object lockObj = new object();

    private int NewId
    {
        get
        {
            return System.Threading.Interlocked.Increment(ref curId);
        }
    }

    private List<TestPerson> CurrentData
    {
        get
        {
            object persons = this.Session["TestPersons"];

            if (persons == null)
            {
                persons = this.TestPersons;
                this.Session["TestPersons"] = persons;
            }

            return (List<TestPerson>)persons;
        }
    }

    private int? AddPerson(TestPerson person)
    {
        lock (lockObj)
        {
            List<TestPerson> persons = this.CurrentData;
            person.Id = this.NewId;
            persons.Add(person);
            this.Session["TestPersons"] = persons;

            return person.Id;
        }
    }

    private void DeletePerson(int id)
    {
        lock (lockObj)
        {
            List<TestPerson> persons = this.CurrentData;
            TestPerson person = null;

            foreach (TestPerson p in persons)
            {
                if (p.Id == id)
                {
                    person = p;
                    break;
                }
            }

            if (person == null)
            {
                throw new Exception("TestPerson not found");
            }

            persons.Remove(person);

            this.Session["TestPersons"] = persons;
        }
    }

    private void UpdatePerson(TestPerson person)
    {
        lock (lockObj)
        {
            List<TestPerson> persons = this.CurrentData;
            TestPerson updatingPerson = null;

            foreach (TestPerson p in persons)
            {
                if (p.Id == person.Id)
                {
                    updatingPerson = p;
                    break;
                }
            }

            if (updatingPerson == null)
            {
                throw new Exception("TestPerson not found");
            }

            updatingPerson.Email = person.Email;
            updatingPerson.Last = person.Last;
            updatingPerson.First = person.First;

            this.Session["TestPersons"] = persons;
        }
    }

    private void BindData()
    {
        if (X.IsAjaxRequest)
        {
            return;
        }

        this.Store1.DataSource = this.CurrentData;
        this.Store1.DataBind();
    }

    protected void SaveClick(object sender, DirectEventArgs e)
    {
        ChangeRecords<TestPerson> persons = new StoreDataHandler(e.ExtraParams["data"]).BatchObjectData<TestPerson>();

        foreach (TestPerson created in persons.Created)
        {
            this.AddPerson(created);

            ModelProxy record = Store1.GetByInternalId(created.PhantomId);

            //remember record instance in variable to avoid searching on each method calling
            record.CreateVariable = true;

            record.SetId(created.Id);
            record.Commit();
            created.PhantomId = null;
        }

        foreach (TestPerson deleted in persons.Deleted)
        {
            this.DeletePerson(deleted.Id.Value);
            Store1.CommitRemoving(deleted.Id.Value);
        }

        foreach (TestPerson updated in persons.Updated)
        {
            this.UpdatePerson(updated);
            Store1.GetById(updated.Id.Value).Commit();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Grid with batch saving - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script>
       var updateRecord = function (form) {
            if (form.getForm()._record == null) {
                return;
            }

            if (!form.getForm().isValid()) {
                Ext.net.Notification.show({
                    iconCls  : "icon-exclamation",
                    html     : "Form is invalid",
                    title    : "Error"
                });
                return false;
            }

            form.getForm().updateRecord();
       };

       var addRecord = function (form, grid) {
            if (!form.getForm().isValid()) {
                Ext.net.Notification.show({
                    iconCls  : "icon-exclamation",
                    html     : "Form is invalid",
                    title    : "Error"
                });

                return false;
            }

            grid.store.insert(0, new Person(form.getForm().getValues()));
            form.getForm().reset();
       };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Grid with batch saving</h1>

        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server" IDProperty="Id" Name="Person" ClientIdProperty="PhantomId">
                    <Fields>
                        <ext:ModelField Name="Id" Type="Int" AllowNull="true" />
                        <ext:ModelField Name="Email" />
                        <ext:ModelField Name="First" />
                        <ext:ModelField Name="Last" />
                    </Fields>
                    <Validators>
                        <ext:LengthValidator Field="Email" Min="1" />
                        <ext:LengthValidator Field="First" Min="1" />
                        <ext:LengthValidator Field="Last" Min="1" />
                    </Validators>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:FormPanel
            ID="UserForm"
            runat="server"
            Icon="User"
            Frame="true"
            LabelAlign="Right"
            Title="User -- All fields are required"
            Width="500">
            <Items>
                <ext:TextField runat="server"
                    FieldLabel="Email"
                    Name="Email"
                    AllowBlank="false"
                    Vtype="email"
                    AnchorHorizontal="100%"
                    />

                <ext:TextField runat="server"
                    FieldLabel="First"
                    Name="First"
                    AllowBlank="false"
                    AnchorHorizontal="100%"
                    />

                <ext:TextField runat="server"
                    FieldLabel="Last"
                    Name="Last"
                    AllowBlank="false"
                    AnchorHorizontal="100%"
                    />
            </Items>

            <Buttons>
                <ext:Button
                    runat="server"
                    Text="Save"
                    Icon="Disk">
                    <Listeners>
                        <Click Handler="updateRecord(#{UserForm});" />
                    </Listeners>
                </ext:Button>

                <ext:Button
                    runat="server"
                    Text="Create"
                    Icon="UserAdd">
                    <Listeners>
                        <Click Handler="addRecord(#{UserForm}, #{GridPanel1});" />
                    </Listeners>
                </ext:Button>

                <ext:Button
                    runat="server"
                    Text="Reset">
                    <Listeners>
                        <Click Handler="#{UserForm}.getForm().reset();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Icon="Table"
            Frame="true"
            Title="Users"
            Height="400"
            Width="500"
            StoreID="Store1"
            StyleSpec="margin-top: 10px">
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="ID" Width="40" DataIndex="Id">
                        <Renderer Handler="return record.phantom ? '' : value;" />
                    </ext:Column>

                    <ext:Column runat="server" Text="Email" Flex="1" DataIndex="Email">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>

                    <ext:Column runat="server" Text="First" Flex="1" DataIndex="First">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>

                    <ext:Column runat="server" Text="Last" Flex="1" DataIndex="Last">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>

                    <ext:CommandColumn runat="server" Width="70">
                        <Commands>
                            <ext:GridCommand Text="Reject" ToolTip-Text="Reject row changes" CommandName="reject" Icon="ArrowUndo" />
                        </Commands>
                        <PrepareToolbar Handler="toolbar.items.get(0).setVisible(record.dirty);" />
                        <Listeners>
                            <Command Handler="record.reject();" />
                        </Listeners>
                    </ext:CommandColumn>
                </Columns>
            </ColumnModel>

            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add" Icon="Add">
                            <Listeners>
                                <Click Handler="#{Store1}.insert(0, new Person());" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Delete" Icon="Exclamation">
                            <Listeners>
                                <Click Handler="var selection = #{GridPanel1}.getView().getSelectionModel().getSelection()[0];
                                                if (selection) {
                                                    #{GridPanel1}.store.remove(selection);
                                                    #{UserForm}.getForm().reset();
                                                }" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Single">
                    <Listeners>
                        <Select Handler="#{UserForm}.getForm().loadRecord(record);" />
                    </Listeners>
                </ext:RowSelectionModel>
            </SelectionModel>

            <Buttons>
                <ext:Button runat="server" Text="Sync" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="SaveClick" Before="return #{Store1}.isDirty();">
                            <ExtraParams>
                                <ext:Parameter Name="data" Value="#{Store1}.getChangedData()" Mode="Raw" Encode="true" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>

            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>