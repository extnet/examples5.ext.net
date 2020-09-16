<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void LoadData(object sender, DirectEventArgs e)
    {
         FormPanel1.SetValues(new {
            Email = "henry@example.com",
            Title = "Mr",
            FirstName = "Henry",
            LastName = "Example",
            StartDate = new DateTime(2003, 1, 10),
            EndDate = new DateTime(2009, 12,11),
            Phone1 = 555,
            Phone2 = 123,
            Phone3 = 4567,
            Hours = 7,
            Minutes = 15
         });
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
    <title>FieldContainer - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .dot-label {
            font-weight : bold;
            font-size   : 20px;
        }

        .note .x-form-item {
            margin-bottom : 0px;
        }

        .note .x-form-display-field {
            color : gray;
            padding-top   : 0px;
            padding-left  : 105px;
            margin-bottom : 5px;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:FormPanel
        runat="server"
        Height="480"
        Width="650"
        Title="Form Panel"
        BodyPadding="18"
        MonitorResize="true">
        <Items>
            <ext:FieldContainer
                runat="server"
                FieldLabel="Text fields"
                AnchorHorizontal="100%"
                Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:TextField runat="server" Width="150" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer
                runat="server"
                FieldLabel="50% / 50%"
                AnchorHorizontal="100%"
                Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Flex="1" MarginSpec="0 3 0 0" />
                    <ext:TextField runat="server" Flex="1" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer
                runat="server"
                FieldLabel="Fill"
                AnchorHorizontal="100%"
                Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" />
                    <ext:DisplayField runat="server" Flex="1" Html="&nbsp;" />
                    <ext:TextField runat="server" Width="150" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer
                runat="server"
                FieldLabel="150px / 100%"
                AnchorHorizontal="100%"
                Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:TextField runat="server" Flex="1" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Mix" Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:ComboBox runat="server" Width="150" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="With toolbar" Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:DateField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:Toolbar runat="server" Flex="1" Flat="true">
                        <Items>
                            <ext:Button runat="server" Text="Button" IconCls="x-md md-icon-add-circle-outline" />
                            <ext:SplitButton runat="server" Text="Split" IconCls="x-md md-icon-arrow-circle-down">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Item1" />
                                            <ext:MenuItem runat="server" Text="Item2" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:SplitButton>
                        </Items>
                    </ext:Toolbar>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="With button" Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:DateField runat="server" Width="150" MarginSpec="0 3 0 0" />
                    <ext:Button runat="server" Text="..." />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="IP Address" Layout="HBox">
                <Items>
                    <ext:NumberField
                        runat="server"
                        Width="40"
                        MarginSpec="0 3 0 0"
                        HideTrigger="true"
                        />
                    <ext:DisplayField runat="server" Text="." Cls="dot-label" />
                    <ext:NumberField
                        runat="server"
                        Width="40"
                        MarginSpec="0 3 0 3"
                        HideTrigger="true"
                        />
                    <ext:DisplayField runat="server" Text="." Cls="dot-label" />
                    <ext:NumberField
                        runat="server"
                        Width="40"
                        MarginSpec="0 3 0 3"
                        HideTrigger="true"
                        />
                    <ext:DisplayField runat="server" Text="." Cls="dot-label" />
                    <ext:NumberField
                        runat="server"
                        Width="40"
                        MarginSpec="0 0 0 3"
                        HideTrigger="true"
                        />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" Layout="Anchor" Cls="note">
                <Items>
                    <ext:FieldContainer runat="server" FieldLabel="Long note" Layout="HBox">
                        <Items>
                            <ext:TextField runat="server" MarginSpec="0 3 0 0" />
                            <ext:TextField runat="server" MarginSpec="0 3 0 0" />
                            <ext:TextField runat="server" MarginSpec="0 3 0 0" />
                        </Items>
                    </ext:FieldContainer>
                    <ext:DisplayField runat="server" Text="Lorem ipsum dolor sit amet, consectetuer adipiscing elit" />
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Several notes" Layout="HBox">
                <Items>
                    <ext:TextField runat="server" Note="Note" MarginSpec="0 3 0 0" />
                    <ext:TextField runat="server" Note="Note" MarginSpec="0 3 0 0" />
                    <ext:TextField runat="server" Note="Note" MarginSpec="0 3 0 0" />
                </Items>
            </ext:FieldContainer>
        </Items>
    </ext:FormPanel>

    <br />

    <ext:FormPanel
        ID="FormPanel1"
        runat="server"
        Title="FieldContainers"
        Width="650"
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
                    <ext:Parameter Name="Flex" Value="1" Mode="Raw" />
                    <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
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
                            <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
                            <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                        </Defaults>
                        <Items>
                            <ext:DisplayField runat="server" Text="(" />
                            <ext:TextField
                                runat="server"
                                Name="Phone1"
                                Width="29"
                                AllowBlank="false"
                                />
                            <ext:DisplayField runat="server" Text=")" />
                            <ext:TextField
                                runat="server"
                                Name="Phone2"
                                Width="29"
                                AllowBlank="false"
                                MarginSpec="0 5 0 0"
                                />
                            <ext:DisplayField runat="server" Text="-" />
                            <ext:TextField
                                runat="server"
                                Name="Phone3"
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
                            <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
                            <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                        </Defaults>
                        <Items>
                            <ext:NumberField
                                runat="server"
                                Name="Hours"
                                Width="51"
                                AllowBlank="false"
                                />
                            <ext:DisplayField runat="server" Text="hours" />
                            <ext:NumberField
                                runat="server"
                                Name="Minutes"
                                Width="51"
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
                            <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
                            <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                        </Defaults>
                        <Items>
                            <ext:ComboBox
                                runat="server"
                                Width="65"
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
            <ext:Button runat="server" Text="Load test data">
                <DirectEvents>
                    <Click OnEvent="LoadData" />
                </DirectEvents>
            </ext:Button>

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
</body>
</html>