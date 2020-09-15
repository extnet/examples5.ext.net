<%@ Page Language="C#" %>

<script runat="server">
    protected void LoadDataViaSetValues(object sender, DirectEventArgs e)
    {
        FormPanel1.SetValues(new
        {
            Email = "henry@example.com",
            Title = "mr",
            FirstName = "Henry",
            LastName = "Example",
            StartDate = new DateTime(2003, 1, 10),
            EndDate = new DateTime(2009, 12, 11),
            Phone = new
            {
                Home = 555,
                Work = 123,
                Other = 4567
            },
            Hours = 7,
            Minutes = 15
        });
    }

    protected void LoadDataViaStore(object sender, DirectEventArgs e)
    {
        this.Store1.DataSource = new object[]
        {
            new
            {
                Email = "john@example.com",
                Title = "mr",
                FirstName = "John",
                LastName = "Cook",
                StartDate = new DateTime(2003, 1, 10),
                EndDate = new DateTime(2009, 12, 11),
                Phone = new
                {
                    Home = 777,
                    Work = 321,
                    Other = 7654
                },
                Hours = 3,
                Minutes = 25
            }
        };
        this.Store1.DataBind();
    }

    protected void SaveData(object sender, DirectEventArgs e)
    {
        Dictionary<string, string> values = JSON.Deserialize<Dictionary<string, string>>(e.ExtraParams["values"]);
        StringBuilder sb = new StringBuilder();

        foreach (KeyValuePair<string, string> value in values)
        {
            sb.AppendFormat("{0} = {1}<br />", value.Key, value.Value);
        }

        X.Msg.Alert("Values", sb.ToString()).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Binding data to FormPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Binding data to FormPanel</h1>

        <p>
            The example demonstrates how to bind the data to the FormPanel
        </p>

        <ext:Store ID="Store1" runat="server" AutoLoad="false">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="Email" />
                        <ext:ModelField Name="Title" />
                        <ext:ModelField Name="FirstName" />
                        <ext:ModelField Name="LastName" />
                        <ext:ModelField Name="StartDate" Type="Date" />
                        <ext:ModelField Name="EndDate" Type="Date" />
                        <ext:ModelField Name="Phone" Type="Object" />
                        <ext:ModelField Name="Hours" />
                        <ext:ModelField Name="Minutes" />
                    </Fields>
                </ext:Model>
            </Model>
            <Listeners>
                <Load Handler="#{FormPanel1}.loadRecord(records[0]);" />
            </Listeners>
        </ext:Store>

        <ext:FormPanel
            ID="FormPanel1"
            runat="server"
            Title="Data binding"
            Width="960"
            BodyPadding="18"
            DefaultAnchor="100%">
            <Items>
                <ext:TextField
                    runat="server"
                    Name="Email"
                    FieldLabel="Email Address"
                    Vtype="email"
                    MsgTarget="Side"
                    AllowBlank="false"
                    />

                <ext:FieldContainer
                    runat="server"
                    MsgTarget="Side"
                    CombineErrors="true"
                    FieldLabel="Date Range"
                    Layout="HBox">
                    <Defaults>
                        <ext:Parameter Name="flex" Value="1" Mode="Raw" />
                        <ext:Parameter Name="hideLabel" Value="true" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:DateField
                            runat="server"
                            FieldLabel="Start"
                            Name="StartDate"
                            AllowBlank="false"
                            MarginSpec="0 5 0 0"
                            />

                        <ext:DateField runat="server" FieldLabel="End" Name="EndDate" />
                    </Items>
                </ext:FieldContainer>

                <ext:FieldSet
                    runat="server"
                    Title="Details"
                    Collapsible="true"
                    DefaultAnchor="100%">
                    <Defaults>
                        <ext:Parameter Name="labelWidth" Value="89" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:FieldContainer
                            runat="server"
                            FieldLabel="Phone"
                            CombineErrors="true"
                            MsgTarget="Under"
                            Layout="HBox">
                            <Defaults>
                                <ext:Parameter Name="hideLabel" Value="true" Mode="Raw" />
                                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:DisplayField runat="server" Text="(" />
                                <ext:TextField
                                    runat="server"
                                    Name="PhoneHome"
                                    DataIndex="Phone.Home"
                                    Width="29"
                                    AllowBlank="false"
                                    />
                                <ext:DisplayField runat="server" Text=")" />
                                <ext:TextField
                                    runat="server"
                                    Name="PhoneWork"
                                    DataIndex="Phone.Work"
                                    Width="29"
                                    AllowBlank="false"
                                    MarginSpec="0 5 0 0"
                                    />
                                <ext:DisplayField runat="server" Text="-" />
                                <ext:TextField
                                    runat="server"
                                    Name="PhoneOther"
                                    DataIndex="Phone.Other"
                                    Width="48"
                                    AllowBlank="false"
                                    />
                            </Items>
                        </ext:FieldContainer>

                        <ext:FieldContainer
                            runat="server"
                            FieldLabel="Time worked"
                            Layout="HBox"
                            CombineErrors="false">
                            <Defaults>
                                <ext:Parameter Name="hideLabel" Value="true" Mode="Raw" />
                                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:NumberField
                                    runat="server"
                                    Name="Hours"
                                    Width="48"
                                    AllowBlank="false"
                                    />
                                <ext:DisplayField runat="server" Text="hours" />
                                <ext:NumberField
                                    runat="server"
                                    Name="Minutes"
                                    Width="48"
                                    AllowBlank="false"
                                    />
                                <ext:DisplayField runat="server" Text="mins" />
                            </Items>
                        </ext:FieldContainer>

                        <ext:FieldContainer
                            runat="server"
                            CombineErrors="true"
                            MsgTarget="Side"
                            FieldLabel="Full Name"
                            Layout="HBox">
                            <Defaults>
                                <ext:Parameter Name="hideLabel" Value="true" Mode="Raw" />
                                <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:ComboBox
                                    ID="ComboBox1"
                                    runat="server"
                                    Width="50"
                                    Editable="false"
                                    Name="Title">
                                    <Items>
                                        <ext:ListItem Text="Mr" Value="mr" />
                                        <ext:ListItem Text="Mrs" Value="mrs" />
                                        <ext:ListItem Text="Miss" Value="miss" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="mr" />
                                    </SelectedItems>
                                </ext:ComboBox>

                                <ext:TextField
                                    runat="server"
                                    Flex="1"
                                    Name="FirstName"
                                    AllowBlank="false"
                                    />

                                <ext:TextField
                                    runat="server"
                                    Flex="1"
                                    Name="LastName"
                                    AllowBlank="false"
                                    />
                            </Items>
                        </ext:FieldContainer>
                    </Items>
                </ext:FieldSet>
            </Items>

            <Buttons>
                <ext:Button runat="server" Text="Load test data via SetValues" OnDirectClick="LoadDataViaSetValues" />

                <ext:Button runat="server" Text="Load test data via Store and loadRecord" OnDirectClick="LoadDataViaStore" />

                <ext:Button runat="server" Text="Save">
                    <DirectEvents>
                        <Click OnEvent="SaveData" Before="return #{FormPanel1}.isValid();">
                            <ExtraParams>
                                <ext:Parameter
                                    Name="values"
                                    Value="#{FormPanel1}.getForm().getValues()"
                                    Mode="Raw"
                                    Encode="true"
                                    />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="Reset">
                    <Listeners>
                        <Click Handler="#{FormPanel1}.getForm().reset();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>