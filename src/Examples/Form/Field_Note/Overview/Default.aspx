<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // This page has no postback/ajax interactions so we don't test for it

        // the code below just binds a good height/width to the panel depending on the active theme
        var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

        switch (curTheme.Theme)
        {
            case Ext.Net.Theme.Triton:
            case Ext.Net.Theme.CrispTouch:
                FormPanel1.Width = 270;
                FormPanel1.Height = 234;
                break;
            case Ext.Net.Theme.Gray:
            case Ext.Net.Theme.Default:
                FormPanel1.Width = 223;
                FormPanel1.Height = 177;
                break;
            case Ext.Net.Theme.Crisp:
                FormPanel1.Width = 240;
                FormPanel1.Height = 188;
                break;
            case Ext.Net.Theme.Neptune:
            case Ext.Net.Theme.Aria:
                FormPanel1.Width = 245;
                FormPanel1.Height = 195;
                break;
            case Ext.Net.Theme.NeptuneTouch:
                FormPanel1.Width = 275;
                FormPanel1.Height = 242;
                break;
            default:
                // If ever any other theme take place, then use the biggest of the values above
                FormPanel1.Width = 275;
                FormPanel1.Height = 242;
                break;
        }
    }
</script>
<html>
<head runat="server">
    <title>Field Note - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .red-note {
            color: red !important;
        }

        /* this fixes height issues on fields with notes with Chrome 56 -- github issue #1428 */
        .x-form-item-body {
            height: initial
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h2>1. Simple note</h2>

        <ext:TextField runat="server" Note="Simple note" />

        <h2>2. Top note</h2>

        <ext:ComboBox runat="server" Note="Top note" NoteAlign="Top" />

        <h2>3. Custom note</h2>

        <ext:TextArea runat="server" BoxLabel="CheckBox" Note="Red note" NoteCls="red-note" />

        <h2>4. FormPanel with notes</h2>

        <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5" Frame="true">
            <FieldDefaults LabelWidth="50" />
            <Items>
                <ext:TextField runat="server" FieldLabel="Field1" Note="Description" />
                <ext:TextField runat="server" FieldLabel="Field2" Note="Description" />
                <ext:TextField runat="server" FieldLabel="Field3" Note="Description" />
                <ext:TextField runat="server" FieldLabel="Field4" Note="Description" />
            </Items>
        </ext:FormPanel>
    </form>
</body>
</html>