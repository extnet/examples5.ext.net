<%@ Page Language="C#" %>

<%@ Import Namespace="ListItem=Ext.Net.ListItem" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack && ThemeSelector.SelectedItems.Count > 0)
        {
            ListItem themeItem = ThemeSelector.SelectedItem;

            switch (themeItem.Value)
            {
                case "0":
                    this.ResourceManager1.Theme = Ext.Net.Theme.Default;
                    break;
                case "1":
                    this.ResourceManager1.Theme = Ext.Net.Theme.Gray;
                    break;
                case "2":
                    this.ResourceManager1.Theme = Ext.Net.Theme.Neptune;
                    break;
                case "3":
                    this.ResourceManager1.Theme = Ext.Net.Theme.NeptuneTouch;
                    break;
                case "4":
                    this.ResourceManager1.Theme = Ext.Net.Theme.Crisp;
                    break;
                case "5":
                    this.ResourceManager1.Theme = Ext.Net.Theme.CrispTouch;
                    break;
            }
        }
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

        <ext:ComboBox ID="ThemeSelector" runat="server" FieldLabel="Theme" AutoPostBack="true">
            <Items>
                <ext:ListItem Text="Classic" Value="0" />
                <ext:ListItem Text="Gray" Value="1" />
                <ext:ListItem Text="Neptune" Value="2" />
                <ext:ListItem Text="Neptune Touch" Value="3" />
                <ext:ListItem Text="Crisp" Value="4" />
                <ext:ListItem Text="Crisp Touch" Value="5" />
            </Items>
        </ext:ComboBox>


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