<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>XML Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Loading/Saving a Dynamic Form using XML</h1>
        <p>
            This is a very simple example of using XML for load and submit of data with an Ext dynamic form.
        </p>
        <p>
            Click "Load" to load the <a href="xml-form-data.xml">dummy XML data</a> from the server using an XmlReader.
        </p>
        <p>
            After loading the form, you will be able to hit submit. The submit action will make a post to the server,
            and the <a href="xml-form-errors.xml">dummy XML file</a> on the server with test server-side validation
            failure messages will be sent back. Those messages will be applied to the appropriate fields in the form.
        </p>

        <ext:Model runat="server" Name="example.contact">
            <Fields>
                <ext:ModelField Name="first" Mapping="name > first" />
                <ext:ModelField Name="last" Mapping="name > last" />
                <ext:ModelField Name="company" />
                <ext:ModelField Name="email" />
                <ext:ModelField Name="state" />
                <ext:ModelField Name="dob" Type="Date" DateFormat="MM/dd/yyyy" />
            </Fields>
        </ext:Model>

        <ext:Model runat="server" Name="example.fielderror">
            <Fields>
                <ext:ModelField Name="id" />
                <ext:ModelField Name="msg" />
            </Fields>
        </ext:Model>

        <ext:FormPanel
            runat="server"
            Frame="true"
            Title="XML Form"
            Width="340"
            BodyPadding="18">

            <FieldDefaults LabelAlign="Right" LabelWidth="85" MsgTarget="Side" />

            <Reader>
                <ext:XmlReader ModelName="example.contact" Record="contact" SuccessProperty="@success" />
            </Reader>

            <ErrorReader>
                <ext:XmlReader ModelName="example.fielderror" Record="field" SuccessProperty="@success" />
            </ErrorReader>

            <Items>
                <ext:FieldSet
                    runat="server"
                    Title="Contact Information">
                    <Defaults>
                        <ext:Parameter Name="width" Value="280" />
                    </Defaults>

                    <Items>
                        <ext:TextField runat="server" FieldLabel="First Name" EmptyText="First Name" Name="first" />
                        <ext:TextField runat="server" FieldLabel="Last Name" EmptyText="Last Name" Name="last" />
                        <ext:TextField runat="server" FieldLabel="Company" Name="company" />
                        <ext:TextField runat="server" FieldLabel="Email" Name="email" Vtype="email" />
                        <ext:ComboBox
                            runat="server"
                            FieldLabel="State"
                            Name="state"
                            EmptyText="Select a state...">
                            <Items>
                                <ext:ListItem Text="Ohio" Value="OH" />
                            </Items>
                        </ext:ComboBox>
                        <ext:DateField runat="server" FieldLabel="Date of Birth" Name="dob" AllowBlank="false" MaxDate="<%# DateTime.Now.Date %>" AutoDataBind="true" />
                    </Items>
                </ext:FieldSet>
            </Items>

            <Buttons>
                <ext:Button runat="server" Text="Load">
                    <Listeners>
                        <Click Handler="this.up('form').getForm().load({url: 'xml-form-data.xml', waitMsg: 'Loading...', method: 'GET' });" />
                    </Listeners>
                </ext:Button>

                <ext:Button runat="server" Text="Submit" Disabled="true" FormBind="true">
                    <Listeners>
                        <Click Handler="this.up('form').getForm().submit({ url: 'xml-form-errors.xml', submitEmptyText: false, waitMsg: 'Saving Data...', method: 'GET' });" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>