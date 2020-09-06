<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HBox-Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>HBox Form Example</h1>

        <p>
            In the following example, the space needed for the email validation error message automatically taken form the field size when needed.  The mousedown event is being used for validation for more immediate feedback.  Also note that the FormPanel itself is using an hbox layout as we can use any layout for forms now.
        </p>

        <ext:FormPanel
            runat="server"
            Title="Form Panel"
            BodyStyle="padding:5px 5px 0;"
            Width="960"
            Layout="HBox">

            <FieldDefaults LabelAlign="Top" MsgTarget="Side" />

            <Defaults>
                <ext:Parameter Name="Border" Value="false" />
                <ext:Parameter Name="Flex" Value="1" />
                <ext:Parameter Name="Layout" Value="anchor" />
            </Defaults>

            <Items>
                <ext:Panel runat="server">
                    <Items>
                        <ext:TextField
                            runat="server"
                            FieldLabel="First Name"
                            AnchorHorizontal="-5"
                            Name="first"
                            />
                        <ext:TextField
                            runat="server"
                            FieldLabel="Company"
                            AnchorHorizontal="-5"
                            Name="company"
                            />
                    </Items>
                </ext:Panel>

                <ext:Panel runat="server">
                    <Items>
                        <ext:TextField
                            runat="server"
                            FieldLabel="Last Name"
                            AnchorHorizontal="100%"
                            Name="last"
                            />
                        <ext:TextField
                            runat="server"
                            FieldLabel="Email"
                            AnchorHorizontal="100%"
                            Name="email"
                            Vtype="email"
                            />
                    </Items>
                </ext:Panel>
            </Items>

            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>