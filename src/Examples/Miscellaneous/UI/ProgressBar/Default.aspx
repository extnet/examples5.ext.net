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
    <title>ProgressBar UI Styles - Ext.NET Examples</title>

    <script type="text/javascript">
        var runProgressbar = function (bar) {
            bar.wait({
                interval: 500,
                duration: 50000,
                increment: 15,
                text: 'Updating...',
                scope: bar,
                fn: function () {
                    this.updateText('Done!');
                }
            });
        };
    </script>
</head>
<body style="padding:30px;">
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:ComboBox ID="ThemeSelector" runat="server" FieldLabel="Theme" AutoPostBack="true" />

        <h3>ProgressBar UI</h3>

        <ext:ProgressBar runat="server" Width="300" UI="Primary">
            <Listeners>
                <AfterRender Fn="runProgressbar" />
            </Listeners>
        </ext:ProgressBar>
        <br />

        <ext:ProgressBar runat="server" Width="300" UI="Success">
            <Listeners>
                <AfterRender Fn="runProgressbar" />
            </Listeners>
        </ext:ProgressBar>
        <br />

        <ext:ProgressBar runat="server" Width="300" UI="Info">
            <Listeners>
                <AfterRender Fn="runProgressbar" />
            </Listeners>
        </ext:ProgressBar>
        <br />

        <ext:ProgressBar runat="server" Width="300" UI="Danger">
            <Listeners>
                <AfterRender Fn="runProgressbar" />
            </Listeners>
        </ext:ProgressBar>
        <br />

        <ext:ProgressBar runat="server" Width="300" UI="Warning">
            <Listeners>
                <AfterRender Fn="runProgressbar" />
            </Listeners>
        </ext:ProgressBar>
        <br />
    </form>
</body>
</html>