<%@ Page Language="C#" %>

<%@ Import Namespace="ListItem=Ext.Net.ListItem" %>
<%@ Import Namespace="Ext.Net.Examples.Examples.Miscellaneous.UI.Shared" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack && ThemeSelector.SelectedItems.Count > 0)
        {
            this.ResourceManager1.Theme = ThemeListHandler.GetThemeFromId(ThemeSelector.SelectedItem.Value);
        }

        ThemeListHandler.AddThemeListTo(ref this.ThemeSelector);

        // Set the selected theme as the current one without issuing an auto-postback.
        this.ThemeSelector.SelectedItem.Text = this.ResourceManager1.Theme.ToString();
        this.ThemeSelector.SelectedItem.Value = ((int)this.ResourceManager1.Theme).ToString();
        this.ThemeSelector.Text = this.ThemeSelector.SelectedItem.Text;

        ResourceManager.RegisterUI();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Window UI Styles - Ext.NET Examples</title>
</head>
<body style="padding:30px;">
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:ComboBox
            ID="ThemeSelector"
            runat="server"
            FieldLabel="Theme"
            AutoPostBack="true" />

        <h3>Window UI</h3>

        <ext:Window
            ID="Window1"
            runat="server"
            Title="Window"
            Width="600"
            Height="300"
            BodyPadding="10">
            <Tools>
                <ext:Tool Type="Toggle" />
                <ext:Tool Type="Close" />
                <ext:Tool Type="Minimize" />
                <ext:Tool Type="Maximize" />
                <ext:Tool Type="Restore" />
                <ext:Tool Type="Gear" />
                <ext:Tool Type="Pin" />
                <ext:Tool Type="Unpin" />
                <ext:Tool Type="Right" />
                <ext:Tool Type="Left" />
                <ext:Tool Type="Up" />
                <ext:Tool Type="Down" />
                <ext:Tool Type="Refresh" />
                <ext:Tool Type="Plus" />
                <ext:Tool Type="Help" />
                <ext:Tool Type="Search" />
                <ext:Tool Type="Save" />
                <ext:Tool Type="Print" />
            </Tools>
            <Items>
                <ext:ComboBox runat="server" FieldLabel="Choose UI" Editable="false">
                    <Items>
                        <ext:ListItem Text="default" />
                        <ext:ListItem Text="primary" />
                        <ext:ListItem Text="success" />
                        <ext:ListItem Text="info" />
                        <ext:ListItem Text="danger" />
                        <ext:ListItem Text="warning" />
                    </Items>
                    <Listeners>
                        <Change Handler="this.up('window').setUI(this.getValue());" />
                    </Listeners>
                </ext:ComboBox>
            </Items>
        </ext:Window>
    </form>
</body>
</html>