<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        StringBuilder sb = new StringBuilder(255);

        sb.Append("<h1>Checked Items</h1>");
        sb.Append("<h2>CheckboxGroups</h2>");
        sb.Append("<blockquote>");

        List<CheckboxGroup> groups1 = Ext.Net.Utilities.ControlUtils.FindChildControls<CheckboxGroup>(this.Page.Form);

        groups1.ForEach(delegate(CheckboxGroup group) {
            int count = 0;

            group.CheckedItems.ForEach(delegate(Checkbox checkbox)
            {
                if (count == 0)
                {
                    sb.AppendFormat("<h3>{0}</h3>", group.FieldLabel);
                    sb.Append("<blockquote>");
                }
                sb.AppendFormat("{0}<br />", checkbox.BoxLabel);
                count++;
            });

            if (count > 0)
            {
                sb.Append("</blockquote>");
            }
        });

        sb.Append("</blockquote>");

        sb.Append("<h2>RadioGroups</h2>");
        sb.Append("<blockquote>");

        List<RadioGroup> groups2 = Ext.Net.Utilities.ControlUtils.FindControls<RadioGroup>(this.Page.Form);

        groups2.ForEach(delegate(RadioGroup group)
        {
            int count = 0;

            group.CheckedItems.ForEach(delegate(Radio radio)
            {
                if (count == 0)
                {
                    sb.AppendFormat("<h3>{0}</h3>", group.FieldLabel);
                    sb.Append("<blockquote>");
                }
                sb.AppendFormat("{0}<br />", radio.BoxLabel);
                count++;
            });

            if (count > 0)
            {
                sb.Append("</blockquote>");
            }
        });

        sb.Append("</blockquote>");

        this.Label1.Html = sb.ToString();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>CheckboxGroup and RadioGroup Configuration Options - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-label h1 {
            margin-top: 20px;
        }
    </style>

    <script>
        var showValues = function () {
            var form = this.up("form"),
                values,
                text = "<h1>Values:</h1>"

            if (form.isValid()) {
                values = form.getForm().getFieldValues();
                text += Ext.encode(values).replace(/,/g, ",<br>")
                App.Label1.setText(text, false);
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Checkbox / Radio Groups</h1>

        <p>This demonstrates the flexible layout capabilities of the CheckboxGroup and RadioGroup classes. It also
        shows that you can validate checkboxes/radios as a group &mdash; try submitting the form before changing
        any values to see this.</p>
        <p>This illustrates the cascading configuration <code>fieldDefaults</code>. At the Panel level, it sets the field label
        color to green, so all ancestor fields have green labels.</p>

        <ext:FormPanel
            ID="FormPanel1"
            runat="server"
            Title="Check/Radio Groups Example"
            Frame="true"
            Width="600"
            BodyPadding="10">
            <FieldDefaults LabelWidth="110" LabelStyle="color:green;padding-left:4px;" />
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="Save" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" Before="return this.up('form').isValid();" />
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="Show values" Handler="showValues" />

                <ext:Button runat="server" Text="Reset" Handler="this.up('form').reset();" />
            </Buttons>
            <Items>
                <ext:Container runat="server" Layout="HBoxLayout" MarginSpec="0 0 10">
                    <Items>
                        <ext:FieldSet
                            runat="server"
                            Flex="1"
                            Title="Individual Checkboxes"
                            Layout="AnchorLayout"
                            DefaultAnchor="100%">

                            <Defaults>
                                <ext:Parameter Name="HideEmptyLabel" Value="false" Mode="Raw" />
                            </Defaults>

                            <Items>
                                <ext:TextField ID="TextField1" runat="server" FieldLabel="Alignment Test" />
                                <ext:Checkbox ID="CheckboxDog" runat="server" BoxLabel="Dog" FieldLabel="Favorite Animals" />
                                <ext:Checkbox ID="CheckboxCat" runat="server" BoxLabel="Cat" />
                                <ext:Checkbox ID="CheckboxMonkey" runat="server" BoxLabel="Monkey" Checked="true" />
                            </Items>
                        </ext:FieldSet>

                        <ext:Component runat="server" Width="10" />

                        <ext:FieldSet
                            runat="server"
                            Flex="1"
                            Title="Individual Radios"
                            Layout="AnchorLayout"
                            DefaultAnchor="100%">

                            <Defaults>
                                <ext:Parameter Name="HideEmptyLabel" Value="false" Mode="Raw" />
                            </Defaults>

                            <Items>
                                <ext:TextField ID="TextField2" runat="server" FieldLabel="Alignment Test" />
                                <ext:Radio runat="server" BoxLabel="Red" InputValue="Red" Name="fav-color" FieldLabel="Favorite Color" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Blue" InputValue="Blue" Name="fav-color" />
                                <ext:Radio runat="server" BoxLabel="Green" InputValue="Green" Name="fav-color" />
                            </Items>
                        </ext:FieldSet>
                    </Items>
                </ext:Container>

                <ext:FieldSet
                    runat="server"
                    Title="Checkbox Groups (initially collapsed)"
                    Layout="AnchorLayout"
                    Collapsible="true"
                    Collapsed="true"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:TextField ID="TextField3" runat="server" FieldLabel="Alignment Test" />

                        <ext:CheckboxGroup
                            ID="CheckboxGroup1"
                            runat="server"
                            Cls="x-check-group-alt"
                            FieldLabel="Auto Layout">
                            <Items>
                                <ext:Checkbox ID="Checkbox4" runat="server" BoxLabel="Item 1" />
                                <ext:Checkbox ID="Checkbox5" runat="server" BoxLabel="Item 2" Checked="true" />
                                <ext:Checkbox ID="Checkbox6" runat="server" BoxLabel="Item 3" />
                                <ext:Checkbox ID="Checkbox7" runat="server" BoxLabel="Item 4" />
                                <ext:Checkbox ID="Checkbox8" runat="server" BoxLabel="Item 5" />
                            </Items>
                        </ext:CheckboxGroup>

                        <ext:CheckboxGroup
                            ID="CheckboxGroup2"
                            runat="server"
                            FieldLabel="Single Column"
                            ColumnsNumber="1">
                            <Items>
                                <ext:Checkbox ID="Checkbox9" runat="server" BoxLabel="Item 1" />
                                <ext:Checkbox ID="Checkbox10" runat="server" BoxLabel="Item 2" Checked="true" />
                                <ext:Checkbox ID="Checkbox11" runat="server" BoxLabel="Item 3" />
                            </Items>
                        </ext:CheckboxGroup>

                        <ext:CheckboxGroup
                            ID="CheckboxGroup3"
                            runat="server"
                            FieldLabel="Multi-Column (Horizontal)"
                            ColumnsNumber="3"
                            Cls="x-check-group-alt">
                            <Items>
                                <ext:Checkbox ID="Checkbox12" runat="server" BoxLabel="Item 1" />
                                <ext:Checkbox ID="Checkbox13" runat="server" BoxLabel="Item 2" Checked="true" />
                                <ext:Checkbox ID="Checkbox14" runat="server" BoxLabel="Item 3" />
                                <ext:Checkbox ID="Checkbox15" runat="server" BoxLabel="Item 4" />
                                <ext:Checkbox ID="Checkbox16" runat="server" BoxLabel="Item 5" />
                            </Items>
                        </ext:CheckboxGroup>

                        <ext:CheckboxGroup
                            ID="CheckboxGroup4"
                            runat="server"
                            FieldLabel="Multi-Column (Vertical)"
                            ColumnsNumber="3"
                            Vertical="true">
                            <Items>
                                <ext:Checkbox ID="Checkbox17" runat="server" BoxLabel="Item 1" />
                                <ext:Checkbox ID="Checkbox18" runat="server" BoxLabel="Item 2" Checked="true" />
                                <ext:Checkbox ID="Checkbox19" runat="server" BoxLabel="Item 3" />
                                <ext:Checkbox ID="Checkbox20" runat="server" BoxLabel="Item 4" />
                                <ext:Checkbox ID="Checkbox21" runat="server" BoxLabel="Item 5" />
                            </Items>
                        </ext:CheckboxGroup>

                        <ext:CheckboxGroup
                            ID="CheckboxGroup5"
                            runat="server"
                            FieldLabel="Multi-Column<br />(Custom Widths)"
                            ColumnsWidths="100,100"
                            Vertical="true"
                            Cls="x-check-group-alt">
                            <Items>
                                <ext:Checkbox ID="Checkbox22" runat="server" BoxLabel="Item 1" />
                                <ext:Checkbox ID="Checkbox23" runat="server" BoxLabel="Item 2" Checked="true" />
                                <ext:Checkbox ID="Checkbox24" runat="server" BoxLabel="Item 3" />
                                <ext:Checkbox ID="Checkbox25" runat="server" BoxLabel="Item 4" />
                                <ext:Checkbox ID="Checkbox26" runat="server" BoxLabel="Item 5" />
                            </Items>
                        </ext:CheckboxGroup>

                        <ext:CheckboxGroup
                            ID="CheckboxGroup6"
                            runat="server"
                            MsgTarget="Side"
                            FieldLabel="Custom Layout<br />(w/ validation)"
                            AllowBlank="false"
                            AutoFitErrors="false"
                            Layout="ColumnLayout"
                            AnchorHorizontal="-18">
                            <Items>
                                <ext:Container runat="server" ColumnWidth="0.25">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 1" Cls="x-form-check-group-label" />
                                        <ext:Checkbox ID="Checkbox27" runat="server" BoxLabel="Item 1" Checked="true" />
                                        <ext:Checkbox ID="Checkbox28" runat="server" BoxLabel="Item 2" Checked="true" />
                                    </Items>
                                </ext:Container>
                                <ext:Container runat="server" ColumnWidth="0.5">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 2" Cls="x-form-check-group-label" />
                                        <ext:Checkbox
                                            ID="Checkbox29"
                                            runat="server"
                                            BoxLabel="A long item just for fun"
                                            />
                                    </Items>
                                </ext:Container>
                                <ext:Container runat="server" ColumnWidth="0.25">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 3" Cls="x-form-check-group-label" />
                                        <ext:Checkbox ID="Checkbox1" runat="server" BoxLabel="Item 4" Checked="true" />
                                        <ext:Checkbox ID="Checkbox2" runat="server" BoxLabel="Item 5" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:CheckboxGroup>
                    </Items>
                </ext:FieldSet>

                <ext:FieldSet
                    runat="server"
                    Title="Radio Groups"
                    Layout="AnchorLayout"
                    Collapsible="true"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:TextField ID="TextField4" runat="server" FieldLabel="Alignment Test" />

                        <ext:RadioGroup
                            ID="RadioGroup1"
                            runat="server"
                            GroupName="RadioGroup1"
                            FieldLabel="Auto Layout"
                            Cls="x-check-group-alt">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Item 3" InputValue="3" />
                                <ext:Radio runat="server" BoxLabel="Item 4" InputValue="4" />
                                <ext:Radio runat="server" BoxLabel="Item 5" InputValue="5" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:RadioGroup
                            ID="RadioGroup2"
                            runat="server"
                            GroupName="RadioGroup2"
                            FieldLabel="Single Column"
                            ColumnsNumber="1">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Item 3" InputValue="3" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:RadioGroup
                            ID="RadioGroup3"
                            runat="server"
                            GroupName="RadioGroup3"
                            FieldLabel="Multi-Column (Horizontal)"
                            ColumnsNumber="3"
                            Cls="x-check-group-alt">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Item 3" InputValue="3" />
                                <ext:Radio runat="server" BoxLabel="Item 4" InputValue="4" />
                                <ext:Radio runat="server" BoxLabel="Item 5" InputValue="5" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:RadioGroup
                            ID="RadioGroup4"
                            runat="server"
                            GroupName="RadioGroup4"
                            FieldLabel="Multi-Column(Vertical)"
                            ColumnsNumber="3"
                            Vertical="true">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Item 3" InputValue="3" />
                                <ext:Radio runat="server" BoxLabel="Item 4" InputValue="4" />
                                <ext:Radio runat="server" BoxLabel="Item 5" InputValue="5" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:RadioGroup
                            ID="RadioGroup5"
                            runat="server"
                            GroupName="RadioGroup5"
                            FieldLabel="Multi-Column<br />(Custom Widths)"
                            ColumnsWidths="100,100"
                            Vertical="true"
                            Cls="x-check-group-alt">
                            <Items>
                                <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Item 3" InputValue="3" />
                                <ext:Radio runat="server" BoxLabel="Item 4" InputValue="4" />
                                <ext:Radio runat="server" BoxLabel="Item 5" InputValue="5" />
                            </Items>
                        </ext:RadioGroup>

                        <ext:RadioGroup
                            ID="RadioGroup6"
                            runat="server"
                            GroupName="RadioGroup6"
                            MsgTarget="Side"
                            FieldLabel="Custom Layout<br />(w/ validation)"
                            AllowBlank="false"
                            AutoFitErrors="false"
                            Layout="ColumnLayout"
                            AnchorHorizontal="-18">
                            <Items>
                                <ext:Container runat="server" ColumnWidth="0.25">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 1" Cls="x-form-check-group-label" />
                                        <ext:Radio runat="server" BoxLabel="Item 1" InputValue="1" />
                                        <ext:Radio runat="server" BoxLabel="Item 2" InputValue="2" Checked="true" />
                                    </Items>
                                </ext:Container>

                                <ext:Container runat="server" ColumnWidth="0.5">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 2" Cls="x-form-check-group-label" />
                                        <ext:Radio runat="server" BoxLabel="A long item just for fun" InputValue="3" />
                                    </Items>
                                </ext:Container>

                                <ext:Container runat="server" ColumnWidth="0.25">
                                    <Items>
                                        <ext:Component runat="server" Html="Heading 3" Cls="x-form-check-group-label" />
                                        <ext:Radio runat="server" BoxLabel="Item 4" InputValue="4" />
                                        <ext:Radio runat="server" BoxLabel="Item 5" InputValue="5" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:RadioGroup>
                    </Items>
                </ext:FieldSet>
            </Items>
        </ext:FormPanel>

        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>