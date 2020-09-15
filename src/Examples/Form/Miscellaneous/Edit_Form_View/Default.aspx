<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    private static List<Data> dataSource;

    public static List<Data> DataSource
    {
        get
        {
            if (dataSource == null || dataSource.Count == 0)
            {
                dataSource = new List<Data>(5);

                for (int i = 1; i <= 5; i++)
                {
                    Data data = new Data();
                    data.ID = i;
                    data.Company = "Company" + i;
                    data.Price = i * 10;
                    data.Change = i;
                    data.LastChange = DateTime.Now.AddDays(i);
                    dataSource.Add(data);
                }
            }

            return dataSource;
        }
    }

    private Data GetByID(int id)
    {
        foreach (Data data in DataSource)
        {
            if (data.ID == id)
            {
                return data;
            }
        }

        return null;
    }

    private int GetMaxID()
    {
        int id = 0;

        foreach (Data data in DataSource)
        {
            if (data.ID > id)
            {
                id = data.ID;
            }
        }

        return id + 1;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void FetchRecord(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.DataSource = new List<Data> { DataSource[e.Start] };
        this.Store1.DataBind();

        e.Total = DataSource.Count;
    }

    protected void DeleteClick(object sender, DirectEventArgs e)
    {
        int id = int.Parse(e.ExtraParams["recordId"]);
        Data data = this.GetByID(id);

        int index = DataSource.IndexOf(data);
        DataSource.Remove(data);

        if (index == DataSource.Count)
        {
            index--;
        }

        if (index >= 0)
        {
            Store1.LoadPage(index + 1);
        }
    }

    protected void AddClick(object sender, DirectEventArgs e)
    {
        Data data = new Data();
        data.ID = this.GetMaxID();
        DataSource.Add(data);
        Store1.LoadPage(DataSource.Count);
    }

    protected void SaveClick(object sender, DirectEventArgs e)
    {
        int id = int.Parse(e.ExtraParams["recordId"]);

        Data data = this.GetByID(id);

        data.Company = this.CompanyField.Text;
        data.Price = (float)this.PriceField.Number;
        data.Change = (float)this.ChangeField.Number;
        data.LastChange = this.LastChangeField.SelectedDate;
    }

    public class Data
    {
        public int ID
        {
            get;
            set;
        }
        public string Company
        {
            get;
            set;
        }
        public float Price
        {
            get;
            set;
        }
        public float Change
        {
            get;
            set;
        }
        public DateTime LastChange
        {
            get;
            set;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Edit Form View - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Store
            ID="Store1"
            runat="server"
            OnReadData="FetchRecord"
            PageSize="1">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="ID" />
                        <ext:ModelField Name="Company" />
                        <ext:ModelField Name="Price" Type="Float" />
                        <ext:ModelField Name="Change" Type="Float" />
                        <ext:ModelField Name="LastChange" Type="Date" />
                    </Fields>
                </ext:Model>
            </Model>
            <Listeners>
                <DataChanged Handler="var record = this.getAt(0) || {};#{FormPanel1}.getForm().loadRecord(record);#{FormPanel1}.clearInvalid();" />
                <BeforeLoad Handler="#{FormWindow}.body.mask('Loading...', 'x-mask-loading');" />
                <Load Handler="#{FormWindow}.body.unmask();" />
                <Exception Handler="#{FormWindow}.body.unmask();" />
            </Listeners>
        </ext:Store>

        <ext:Window
            ID="FormWindow"
            runat="server"
            Title="Form View"
            Width="420"
            Height="245"
            BodyPadding="18"
            Resizable="false"
            Closable="false"
            Layout="Fit">
            <Items>
                <ext:FormPanel
                    ID="FormPanel1"
                    runat="server"
                    Border="false"
                    BodyStyle="background-color:transparent;"
                    DefaultAnchor="-10"
                    Layout="Form">
                    <Items>
                        <ext:TextField
                            ID="CompanyField"
                            runat="server"
                            Name="Company"
                            MsgTarget="Side"
                            AllowBlank="false"
                            FieldLabel="Company"
                            />
                        <ext:NumberField
                            ID="PriceField"
                            runat="server"
                            Name="Price"
                            MsgTarget="Side"
                            AllowBlank="false"
                            FieldLabel="Price"
                            />
                        <ext:NumberField
                            ID="ChangeField"
                            runat="server"
                            Name="Change"
                            MsgTarget="Side"
                            AllowBlank="false"
                            FieldLabel="Change"
                            />
                        <ext:DateField
                            ID="LastChangeField"
                            runat="server"
                            Name="LastChange"
                            MsgTarget="Side"
                            AllowBlank="false"
                            FieldLabel="Last change"
                            />
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnSaveRecord}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" IconCls="x-md md-icon-add-circle-outline" Text="Add">
                            <DirectEvents>
                                <Click OnEvent="AddClick" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" IconCls="x-md md-icon-remove-circle-outline" Text="Delete">
                            <DirectEvents>
                                <Click OnEvent="DeleteClick" Success="Ext.Msg.alert('Action', 'Deleted');">
                                    <ExtraParams>
                                        <ext:Parameter Name="recordId" Value="#{Store1}.getAt(0).data.ID" Mode="Raw" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button
                            ID="btnSaveRecord"
                            runat="server"
                            IconCls="x-md md-icon-save"
                            Text="Save"
                            Disabled="true">
                            <DirectEvents>
                                <Click
                                    OnEvent="SaveClick"
                                    Before="return #{FormPanel1}.getForm().isValid();"
                                    Success="Ext.Msg.alert('', 'Saved');">
                                    <ExtraParams>
                                        <ext:Parameter Name="recordId" Value="#{Store1}.getAt(0).data.ID" Mode="Raw" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar
                    ID="Pager1"
                    runat="server"
                    StoreID="Store1"
                    DisplayInfo="false" />
            </BottomBar>
        </ext:Window>
    </form>
</body>
</html>