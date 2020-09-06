<%@ Page Language="C#" Culture="en-US" UICulture="en-US" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormLayouts built in markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>FormLayouts built in markup</h1>

        <h2>Form1 - Very Simple</h2>

        <ext:FormPanel
            ID="Panel1"
            runat="server"
            Title="Simple Form"
            BodyPaddingSummary="5 5 0"
            Width="360"
            Frame="true"
            ButtonAlign="Center"
            Layout="Form">
            <FieldDefaults MsgTarget="Side" LabelWidth="75" />
            <Plugins>
                <ext:DataTip runat="server" />
            </Plugins>
            <Items>
                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your first name" />
                    </CustomConfig>
                    <AfterLabelTextTpl runat="server">
                        <Html>
                            <span style="color:red;font-weight:bold" data-qtip="Required">*</span>
                        </Html>
                    </AfterLabelTextTpl>
                </ext:TextField>
                <ext:TextField runat="server" FieldLabel="Last Name" AllowBlank="false">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your last name" />
                    </CustomConfig>
                    <AfterLabelTextTpl runat="server">
                        <Html>
                            <span style="color:red;font-weight:bold" data-qtip="Required">*</span>
                        </Html>
                    </AfterLabelTextTpl>
                </ext:TextField>
                <ext:TextField runat="server" FieldLabel="Company">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your employer's name" />
                    </CustomConfig>
                </ext:TextField>
                <ext:TextField runat="server" FieldLabel="Email" Vtype="email" AllowBlank="false">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your email address" />
                    </CustomConfig>
                    <AfterLabelTextTpl runat="server">
                        <Html>
                            <span style="color:red;font-weight:bold" data-qtip="Required">*</span>
                        </Html>
                    </AfterLabelTextTpl>
                </ext:TextField>
                <ext:DateField runat="server" FieldLabel="DOB">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your date of birth" />
                    </CustomConfig>
                </ext:DateField>
                <ext:NumberField runat="server" MinValue="0" MaxValue="100" FieldLabel="Age">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter your age" />
                    </CustomConfig>
                </ext:NumberField>
                <ext:TimeField runat="server" FieldLabel="Time" MinTime="08:00" MaxTime="18:00">
                    <CustomConfig>
                        <ext:ConfigItem Name="tooltip" Value="Enter a time" />
                    </CustomConfig>
                    <ListConfig>
                        <Plugins>
                            <ext:DataTip runat="server">
                                <Tpl runat="server">
                                    <Html>
                                        Select time {date:date("G:i")}
                                    </Html>
                                </Tpl>
                            </ext:DataTip>
                        </Plugins>
                    </ListConfig>
                </ext:TimeField>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" Handler="this.up('form').getForm().isValid();" />
                <ext:Button runat="server" Text="Cancel" Handler="this.up('form').getForm().reset();" />
            </Buttons>
        </ext:FormPanel>

        <h2>Form 2 - Adding fieldsets</h2>

        <ext:Panel
            ID="Panel2"
            runat="server"
            Title="Simple Form with FieldSets"
            PaddingSummary="5px 5px 0"
            Width="360"
            Frame="true"
            ButtonAlign="Center">
            <Items>
                <ext:FieldSet
                    runat="server"
                    CheckboxToggle="true"
                    Title="User Information"
                    Collapsed="true"
                    Layout="Form">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" />
                        <ext:TextField runat="server" FieldLabel="Last Name" />
                        <ext:TextField runat="server" FieldLabel="Company" />
                        <ext:TextField runat="server" FieldLabel="Email" />
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet
                    runat="server"
                    Collapsible="true"
                    Title="Phone Number"
                    Layout="Form">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" />
                        <ext:TextField runat="server" FieldLabel="Business" />
                        <ext:TextField runat="server" FieldLabel="Mobile" />
                        <ext:TextField runat="server" FieldLabel="Fax" />
                    </Items>
                </ext:FieldSet>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>

        <h2>Form 3 - A little more complex</h2>

        <ext:Panel
            ID="Panel3"
            runat="server"
            Title="Multi Column, Nested Layouts and Anchoring"
            Frame="true"
            PaddingSummary="5px 5px 0"
            Width="960"
            ButtonAlign="Center">
            <Items>
                <ext:Container runat="server" Layout="Column">
                    <Items>
                        <ext:Container runat="server" Layout="Form" ColumnWidth=".5" Padding="5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Company" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="Form" ColumnWidth=".5" Padding="5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Last Name" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Email" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="Anchor">
                    <Items>
                        <ext:HtmlEditor runat="server" Height="180" FieldLabel="Biography" LabelAlign="Top" Padding="10" />
                    </Items>
                </ext:Container>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>

        <h2>Form 4 - Forms can be a TabPanel...</h2>

        <ext:Panel
            ID="Panel4"
            runat="server"
            Border="false"
            Width="360"
            ButtonAlign="Center"
            Layout="Fit">
            <Items>
                <ext:TabPanel runat="server" ActiveTabIndex="0">
                    <Items>
                        <ext:Panel
                            runat="server"
                            Title="Personal Details"
                            BodyPadding="18"
                            Layout="Form">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" />
                                <ext:TextField runat="server" FieldLabel="Last Name" />
                                <ext:TextField runat="server" FieldLabel="Company" />
                                <ext:TextField runat="server" FieldLabel="Email" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Phone Numbers"
                            BodyPadding="18"
                            Layout="Form">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" />
                                <ext:TextField runat="server" FieldLabel="Business" />
                                <ext:TextField runat="server" FieldLabel="Mobile" />
                                <ext:TextField runat="server" FieldLabel="Fax" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>

        <h2>Form 5 - Form with TabPanel</h2>

        <ext:Panel
            ID="Panel5"
            runat="server"
            Title="Inner Tabs"
            Width="960"
            BodyPadding="18"
            ButtonAlign="Center">
            <Items>
                <ext:Container runat="server">
                    <Items>
                        <ext:Container runat="server" Layout="Form" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Company" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="Form" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Last Name" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Email" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:Container>
                <ext:TabPanel
                    runat="server"
                    MarginSpec="5px 0px 0px 0px"
                    ActiveTabIndex="0"
                    Plain="true"
                    Height="235">
                    <Items>
                        <ext:Panel
                            runat="server"
                            Title="Personal Details"
                            BodyPadding="18"
                            Layout="Form">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Last Name" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Company" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Email" Width="230" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Phone Numbers"
                            BodyPadding="18"
                            Layout="Form">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Business" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Mobile" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Fax" Width="230" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Biography"
                            BodyPadding="18"
                            Layout="Fit">
                            <Items>
                                <ext:HtmlEditor runat="server" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            ID="Tab4"
                            runat="server"
                            Title="Tab 4"
                            Layout="Form"
                            BodyPadding="18" >
                             <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Name" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Age" Width="230" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>