<%@ Page Language="C#" %>

<script runat="server">
    public object States
    {
        get
        {
            return new object[]
            {
                new object[] { "AL" },
                new object[] { "AK" },
                new object[] { "AZ" },
                new object[] { "AR" },
                new object[] { "CA" },
                new object[] { "CO" },
                new object[] { "CT" },
                new object[] { "DE" },
                new object[] { "DC" },
                new object[] { "FL" },
                new object[] { "GA" },
                new object[] { "HI" },
                new object[] { "ID" },
                new object[] { "IL" },
                new object[] { "IN" },
                new object[] { "IA" },
                new object[] { "KS" },
                new object[] { "KY" },
                new object[] { "LA" },
                new object[] { "ME" },
                new object[] { "MD" },
                new object[] { "MA" },
                new object[] { "MI" },
                new object[] { "MN" },
                new object[] { "MS" },
                new object[] { "MO" },
                new object[] { "MT" },
                new object[] { "NE" },
                new object[] { "NV" },
                new object[] { "NH" },
                new object[] { "NJ" },
                new object[] { "NM" },
                new object[] { "NY" },
                new object[] { "NC" },
                new object[] { "ND" },
                new object[] { "OH" },
                new object[] { "OK" },
                new object[] { "OR" },
                new object[] { "PA" },
                new object[] { "RI" },
                new object[] { "SC" },
                new object[] { "SD" },
                new object[] { "TN" },
                new object[] { "TX" },
                new object[] { "UT" },
                new object[] { "VT" },
                new object[] { "VA" },
                new object[] { "WA" },
                new object[] { "WV" },
                new object[] { "WI" },
                new object[] { "WY" }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Checkout Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onMailingAddrFieldChange = function (field) {
            var formPanel = field.up("form"),
                copyToBilling = formPanel.down('[name=billingSameAsMailing]').getValue(),
                copyField = formPanel.down('[name=' + field.billingFieldName + ']');

            if (copyToBilling) {
                copyField.setValue(field.getValue());
            } else {
                copyField.clearInvalid();
            }
        }

        var toggleBillingAddressFields = function (cb, checked) {
            var fieldset = cb.ownerCt;
            Ext.Array.forEach(fieldset.previousSibling().query('textfield'), onMailingAddrFieldChange);
            Ext.Array.forEach(fieldset.query('textfield'), function (field) {
                field.setDisabled(checked);
                // Animate the opacity on each field. Would be more efficient to wrap them in a container
                // and animate the opacity on just the single container element, but IE has a bug where
                // the alpha filter does not get applied on position:relative children.
                // This must only be applied when it is not IE6, as it has issues with opacity when cleartype
                // is enabled
                if (!Ext.isIE6) {
                    field.el.animate({opacity: checked ? 0.3 : 1});
                }
            });
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Checkout Form</h1>

        <p>
            This shows an example of a common shopping cart checkout form. It demonstrates uses of FieldContainer
            and various layouts for arranging and aligning fields, ComboBox fields for state and month selection,
            and listening to change events to automatically copy values from Mailing Address to Billing Address fields.
        </p>

        <ext:FormPanel
            runat="server"
            Title="Complete Check Out"
            Frame="true"
            Width="640"
            BodyPadding="18">

            <FieldDefaults LabelAlign="Right" LabelWidth="90" MsgTarget="Qtip" />

            <Items>
                <ext:FieldSet
                    runat="server"
                    Title="Your Contact Information"
                    Layout="Anchor"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:FieldContainer
                            runat="server"
                            FieldLabel="Name"
                            Layout="HBox"
                            CombineErrors="true">
                            <FieldDefaults HideLabel="true" />
                            <Items>
                                <ext:TextField
                                    runat="server"
                                    Name="firstName"
                                    FieldLabel="First Name"
                                    Flex="2"
                                    EmptyText="First"
                                    AllowBlank="false"
                                    />

                                <ext:TextField
                                    runat="server"
                                    Name="lastName"
                                    FieldLabel="Last Name"
                                    Flex="3"
                                    MarginSpec="0 0 0 6"
                                    EmptyText="Last"
                                    AllowBlank="false"
                                    />
                            </Items>
                        </ext:FieldContainer>
                        <ext:Container runat="server" Layout="HBox" MarginSpec="0 0 5 0">
                            <Items>
                                <ext:TextField
                                    runat="server"
                                    FieldLabel="Email Address"
                                    Name="email"
                                    Vtype="email"
                                    Flex="1"
                                    AllowBlank="false">
                                </ext:TextField>

                                <ext:TextField
                                    runat="server"
                                    FieldLabel="Phone Number"
                                    LabelWidth="100"
                                    Name="phone"
                                    Width="190"
                                    EmptyText="xxx-xxx-xxxx"
                                    MaskRe="[\d\-]"
                                    Regex="^\d{3}-\d{3}-\d{4}$"
                                    RegexText="Must be in the format xxx-xxx-xxxx">
                                </ext:TextField>
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:FieldSet>

                <ext:FieldSet
                    runat="server"
                    Title="Mailing Address"
                    Layout="Anchor"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:TextField
                            runat="server"
                            FieldLabel="Street Address"
                            Name="mailingStreet"
                            AllowBlank="false"
                            BillingFieldName="billingStreet"><%--it is custom config property--%>
                            <Listeners>
                                <Change Fn="onMailingAddrFieldChange" />
                            </Listeners>
                        </ext:TextField>

                        <ext:Container runat="server" Layout="HBox" MarginSpec="0 0 5 0">
                            <Items>
                                <ext:TextField
                                    runat="server"
                                    FieldLabel="City"
                                    Name="mailingCity"
                                    Flex="1"
                                    AllowBlank="false"
                                    BillingFieldName="billingCity">
                                    <Listeners>
                                        <Change Fn="onMailingAddrFieldChange" />
                                    </Listeners>
                                </ext:TextField>

                                <ext:ComboBox
                                    runat="server"
                                    Name="mailingState"
                                    BillingFieldName="billingState"
                                    FieldLabel="State"
                                    LabelWidth="50"
                                    Width="110"
                                    ValueField="abbr"
                                    DisplayField="abbr"
                                    TypeAhead="true"
                                    QueryMode="Local"
                                    AllowBlank="false"
                                    ForceSelection="true">
                                    <Store>
                                        <ext:Store
                                            ID="StatesStore"
                                            runat="server"
                                            Data="<%# States %>"
                                            AutoDataBind="true">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="abbr" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Reader>
                                                <ext:ArrayReader />
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <Listeners>
                                        <Change Fn="onMailingAddrFieldChange" />
                                    </Listeners>
                                </ext:ComboBox>

                                <ext:TextField
                                    runat="server"
                                    FieldLabel="Postal Code"
                                    LabelWidth="80"
                                    Name="mailingPostalCode"
                                    BillingFieldName="billingPostalCode"
                                    Width="160"
                                    AllowBlank="false"
                                    MaxLength="10"
                                    EnforceMaxLength="true"
                                    MaskRe="[\d\-]"
                                    Regex="^\d{5}(\-\d{4})?$"
                                    RegexText="Must be in the format xxxxx or xxxxx-xxxx">
                                    <Listeners>
                                        <Change Fn="onMailingAddrFieldChange" />
                                    </Listeners>
                                </ext:TextField>
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:FieldSet>

                <ext:FieldSet
                    runat="server"
                    Title="Billing Address"
                    Layout="Anchor"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:Checkbox
                            runat="server"
                            Name="billingSameAsMailing"
                            BoxLabel="Same as Mailing Address?"
                            HideLabel="true"
                            Checked="true"
                            StyleSpec="margin-bottom:10px;"
                            Handler="toggleBillingAddressFields">
                        </ext:Checkbox>

                        <ext:TextField
                            runat="server"
                            FieldLabel="Street Address"
                            Name="billingStreet"
                            Disabled="true"
                            AllowBlank="false"
                            />

                        <ext:Container runat="server" Layout="HBox" MarginSpec="0 0 5 0">
                            <Items>
                                <ext:TextField
                                    runat="server"
                                    FieldLabel="City"
                                    Name="billingCity"
                                    StyleSpec='<%# !RequestManager.IsIE6 ? "opacity:.3" : "" %>'
                                    AutoDataBind="true"
                                    Flex="1"
                                    Disabled="true"
                                    AllowBlank="false"
                                    />

                                <ext:ComboBox
                                    runat="server"
                                    Name="billingState"
                                    StyleSpec='<%# !RequestManager.IsIE6 ? "opacity:.3" : "" %>'
                                    AutoDataBind="true"
                                    FieldLabel="State"
                                    LabelWidth="50"
                                    Width="110"
                                    StoreID="StatesStore"
                                    ValueField="abbr"
                                    DisplayField="abbr"
                                    TypeAhead="true"
                                    QueryMode="Local"
                                    Disabled="true"
                                    AllowBlank="false"
                                    ForceSelection="true"
                                    />

                                <ext:TextField
                                    runat="server"
                                    FieldLabel="Postal Code"
                                    LabelWidth="80"
                                    Name="billingPostalCode"
                                    StyleSpec='<%# !RequestManager.IsIE6 ? "opacity:.3" : "" %>'
                                    AutoDataBind="true"
                                    Width="160"
                                    Disabled="true"
                                    AllowBlank="false"
                                    MaxLength="10"
                                    EnforceMaxLength="true"
                                    MaskRe="[\d\-]"
                                    Regex="^\d{5}(\-\d{4})?$"
                                    RegexText="Must be in the format xxxxx or xxxxx-xxxx"
                                    />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:FieldSet>

                <ext:FieldSet
                    runat="server"
                    Title="Payment"
                    Layout="Anchor"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:RadioGroup runat="server" Anchor="none">
                            <LayoutConfig>
                                <ext:CheckboxGroupLayoutConfig AutoFlex="false" />
                            </LayoutConfig>
                            <Defaults>
                                <ext:Parameter Name="name" Value="ccType" />
                                <ext:Parameter Name="style" Value="margin-right:15px;" />
                            </Defaults>
                            <Items>
                                <ext:Radio
                                    runat="server"
                                    InputValue="visa"
                                    BoxLabel="VISA"
                                    Checked="true"
                                    />

                                <ext:Radio runat="server" InputValue="mastercard" BoxLabel="MasterCard" />

                                <ext:Radio runat="server" InputValue="amex" BoxLabel="American Express" />

                                <ext:Radio runat="server" InputValue="discover" BoxLabel="Discover" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:TextField
                            runat="server"
                            Name="ccName"
                            FieldLabel="Name On Card"
                            AllowBlank="false"
                            />

                        <ext:Container runat="server" Layout="HBox" MarginSpec="0 0 5 0">
                            <Items>
                                <ext:TextField
                                    runat="server"
                                    Name="ccNumber"
                                    FieldLabel="Card Number"
                                    Flex="1"
                                    AllowBlank="false"
                                    MinLength="15"
                                    MaxLength="16"
                                    EnforceMaxLength="true"
                                    MaskRe="\d"
                                    />

                                <ext:FieldContainer
                                    runat="server"
                                    FieldLabel="Expiration"
                                    LabelWidth="75"
                                    Layout="HBox"
                                    Width="250">
                                    <Items>
                                        <ext:ComboBox
                                            runat="server"
                                            Name="ccExpireMonth"
                                            EmptyText="Month"
                                            HideLabel="true"
                                            MarginSpec="0 6 0 0"
                                            Flex="1"
                                            AllowBlank="false"
                                            ForceSelection="true">
                                            <Items>
                                                <ext:ListItem Text="January" Value="1" />
                                                <ext:ListItem Text="February" Value="2" />
                                                <ext:ListItem Text="March" Value="3" />
                                                <ext:ListItem Text="April" Value="4" />
                                                <ext:ListItem Text="May" Value="5" />
                                                <ext:ListItem Text="June" Value="6" />
                                                <ext:ListItem Text="Jule" Value="7" />
                                                <ext:ListItem Text="August" Value="8" />
                                                <ext:ListItem Text="September" Value="9" />
                                                <ext:ListItem Text="October" Value="10" />
                                                <ext:ListItem Text="November" Value="11" />
                                                <ext:ListItem Text="December" Value="12" />
                                            </Items>
                                        </ext:ComboBox>

                                        <ext:NumberField
                                            runat="server"
                                            Name="ccExpireYear"
                                            HideLabel="true"
                                            Width="65"
                                            Number="<%# DateTime.Now.Year %>"
                                            MinValue="<%# DateTime.Now.Year %>"
                                            AutoDataBind="true"
                                            AllowBlank="false"
                                            />
                                    </Items>
                                </ext:FieldContainer>
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:FieldSet>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Reset">
                    <Listeners>
                        <Click Handler="this.up('form').getForm().reset();" />
                    </Listeners>
                </ext:Button>

                <ext:Button runat="server" Text="Complete Purchase" Width="150">
                    <Listeners>
                        <Click Handler="var form = this.up('form').getForm(); form.isValid() && Ext.MessageBox.alert('Submitted Values', form.getValues(true));" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>