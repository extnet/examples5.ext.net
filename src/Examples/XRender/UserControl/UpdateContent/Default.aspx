<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>
<%@ Import Namespace="Ext.Net.Examples"%>

<script runat="server">
    UserControl currentUC;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(CurrentControl.Text))
        {
            this.LoadUserControl(CurrentControl.Text);
        }
    }

    private void LoadUserControl(string num, bool update = false)
    {
        if (update && currentUC != null)
        {
            this.Panel1.ContentControls.Clear();
        }

        currentUC = (UserControl)this.LoadControl(string.Format("UserControl{0}.ascx", num));
        currentUC.ID = "UC" + num;
        this.Panel1.ContentControls.Add(currentUC);

        if (update)
        {
            CurrentControl.Text = num;
            this.Panel1.UpdateContent();
        }
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        this.LoadUserControl("1", true);

        this.Button1.Disable();
        this.Button2.Enable();
    }

    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        this.LoadUserControl("2", true);

        this.Button2.Disable();
        this.Button1.Enable();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Update Controls and Content during a DirectEvent - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Update Controls and Content during a DirectEvent</h1>

        <h3>Load UserControls</h3>

        <ext:Hidden ID="CurrentControl" runat="server" />

        <ext:Panel
            ID="Panel1"
            runat="server"
            Title="User Controls"
            Width="500"
            Height="220"
            BodyPadding="18">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            ID="Button1"
                            runat="server"
                            Text="Load 1"
                            OnDirectClick="Button1_Click"
                            />
                        <ext:Button
                            ID="Button2"
                            runat="server"
                            Text="Load 2"
                            OnDirectClick="Button2_Click"
                            Disabled="true"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
    </form>
</body>
</html>