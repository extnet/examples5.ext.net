<%@ Page Language="C#" %>

<%@ Register src="MyUserControl.ascx" tagname="MyUserControl" tagprefix="uc" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectMethod and UserControls - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" DirectMethodNamespace="CompanyX" />

        <h1>[DirectMethod] and UserControls</h1>

        <div class="information">
            <p>The <code>DirectMethodNamespace</code> property has been set to "<b>CompanyX</b>" on the &lt;ext:ResourceManager> which overrides the default <code>[DirectMethod]</code> Namespace value of "<b>App.direct</b>".</p>
        </div>

        <h2>UserControl with [DirectMethod]</h2>

        <p>An <code>[DirectMethod]</code> can be defined within a UserControl(.ascx) and called from within the UserControl or from the Parent Page.</p>

        <p>
            The following sample demonstrates adding a UserControl to the Page and setting a custom <code>Name</code> property for each.
            The UserControl defines an <code>[DirectMethod]</code> which is called when the Button is clicked.
        </p>

        <h3>Code</h3>

<pre class="code">&lt;uc:MyUserControl ID="UserControl1" runat="server" Name="Bob" />
&lt;uc:MyUserControl ID="UserControl2" runat="server" Name="Billy" /></pre>

         <h3>Code (.ascx)</h3>

<pre class="code">&lt;%@ Control Language="C#" %>

&lt;%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

&lt;script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Button1.Text = string.Concat("UserControl (", this.Name, ")");
        }
    }

    [DirectMethod]
    public void GetName()
    {
        Ext.Msg.Alert("Name", this.Name).Show();
    }

    public string Name
    {
        get;
        set;
    }
&lt;/script>

&lt;ext:Button ID="Button1" runat="server">
    &lt;Listeners>
        &lt;Click Handler="#{DirectMethods}.GetName();" />
    &lt;/Listeners>
&lt;/ext:Button></pre>

        <h3>Example</h3>

        <uc:MyUserControl ID="UserControl1" runat="server" Name="Bob" />
        <br />
        <uc:MyUserControl ID="UserControl2" runat="server" Name="Billy" />

        <h2>Calling UserControl [DirectMethod] from Parent .aspx Page</h2>

        <p>The following sample demonstrates manually calling the <code>[DirectMethod]</code> defined in the above UserControls from the parent Page.</p>

        <h3>Code</h3>

<pre class="code">&lt;ext:Button ID="Button1" runat="server" Text="Call UserControl DirectMethod (Bob)">
    &lt;Listeners>
        &lt;Click Handler="CompanyX.UserControl1.GetName();" />
    &lt;/Listeners>
&lt;/ext:Button>

&lt;ext:Button ID="Button2" runat="server" Text="Call UserControl DirectMethod (Billy)">
    &lt;Listeners>
        &lt;Click Handler="CompanyX.UserControl2.GetName();" />
    &lt;/Listeners>
&lt;/ext:Button></pre>

        <h3>Example</h3>

        <ext:Button runat="server" Text="Call UserControl DirectMethod (Bob)">
            <Listeners>
                <Click Handler="CompanyX.UserControl1.GetName();" />
            </Listeners>
        </ext:Button>
        <br />
        <ext:Button runat="server" Text="Call UserControl DirectMethod (Billy)">
            <Listeners>
                <Click Handler="CompanyX.UserControl2.GetName();" />
            </Listeners>
        </ext:Button>
    </form>
</body>
</html>