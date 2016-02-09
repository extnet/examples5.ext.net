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
    <title>Tip UI Styles - Ext.NET Examples</title>
</head>
<body style="padding: 30px;">
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

        <h3>Tooltip UI</h3>

        <ext:Container runat="server" Layout="HBoxLayout">
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Tooltip: Primary">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Primary'" UI="Primary" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Success">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Success'" UI="Success" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Info">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Info'" UI="Info" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Danger">
                    <ToolTips>
                        <ext:ToolTip runat="server" Title="Title" Html="UI = 'Danger'" UI="Danger" />
                    </ToolTips>
                </ext:Button>

                <ext:Button runat="server" Text="Tooltip: Warning">
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
