<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.HtmlEditor1.Text = "<b>Some Initial HTML. You can edit it and submit to server.</b>";
        }
    }

    protected void Submit(object sender, DirectEventArgs e)
    {
        X.Msg.Alert("Submit", "The following has been submitted:<br/><br/>" + this.HtmlEditor1.Text).Show();
    }
</script>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>HtmlEditor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>HtmlEditor</h1>

        <p>Provides a lightweight HTML Editor component.</p>

        <p>
            For more details, we would strongly recommend to read
            <a href="http://docs.sencha.com/extjs/6.7.0/classic/Ext.form.field.HtmlEditor.html">the HtmlEditor ExtJS docs article</a>
            and
            <a href="https://forums.ext.net/showthread.php?20425&p=88270&viewfull=1#post88270">this Ext.NET forums thread</a>
            about possible problems with HtmlEditor.
        </p>

        <br/>

        <ext:HtmlEditor
            ID="HtmlEditor1"
            runat="server"
            Width="600"
            Height="200"
            EnableAlignments="false"
            EnableFontSize="false"
            CreateLinkText="My CreateLinkText">
            <ButtonTips>
                <BackColor Text="My BackColor Tip" />
                <Bold Text="My Bold Tip" />
            </ButtonTips>
        </ext:HtmlEditor>

        <ext:Button runat="server" Text="Submit" OnDirectClick="Submit" />
    </form>
</body>
</html>
