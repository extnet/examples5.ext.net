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
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Tip UI Styles - Ext.NET Examples</title>
</head>
<body style="padding: 30px;">
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:ComboBox ID="ThemeSelector" runat="server" FieldLabel="Theme" AutoPostBack="true" />

        <h3>Tooltip UI</h3>

        <ext:Container runat="server" Layout="HBoxLayout">
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Tooltip: Primary" UI="Primary">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Primary'" UI="Primary" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Success" UI="Success">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Success'" UI="Success" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Info" UI="Info">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Info'" UI="Info" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Danger" UI="Danger">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Danger'" UI="Danger" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Warning" UI="Warning">
                    <ToolTips>
                        <ext:ToolTip
                            runat="server"
                            Title="Title"
                            Html="UI = 'Warning'"
                            UI="Warning"
                            AutoHide="false"
                            Closable="true" />
                    </ToolTips>
                </ext:Button>
            </Items>
        </ext:Container>
    </form>
</body>
</html>
