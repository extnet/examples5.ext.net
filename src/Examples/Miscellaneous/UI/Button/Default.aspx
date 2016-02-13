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

        // Add context menu items to buttons -- except first three
        List<Container> cts = Ext.Net.Utilities.ControlUtils.FindControls<Container>(this.Page);

        foreach (Container ct in cts)
        {
            List<Ext.Net.ButtonBase> btns = Ext.Net.Utilities.ControlUtils.FindChildControls<Ext.Net.ButtonBase>(ct);
            btns.RemoveRange(0, 3);

            foreach (Ext.Net.ButtonBase btn in btns)
            {
                btn.Menu.Add(new Ext.Net.Menu
                {
                    Items =
                    {
                        new Ext.Net.MenuItem("Menu Item")
                    }
                });
            }
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Button UI Styles - Ext.NET Examples</title>
</head>
<body style="padding: 30px;">
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:ComboBox
            ID="ThemeSelector"
            runat="server"
            FieldLabel="Theme"
            AutoPostBack="true" />

        <p>To use color buttons styles just set UI property of Button: </p>

        <pre>
            &lt;ext:Button runat="server" Text="Small" UI="Primary" /&gt;
        </pre>

        <h1>Default</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" />
                <ext:Button runat="server" Text="Large" Scale="Large" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" />
            </Items>
        </ext:Container>

        <h1>Primary (UI="Primary")</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" UI="Primary" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" UI="Primary" />
                <ext:Button runat="server" Text="Large" Scale="Large" UI="Primary" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" UI="Primary" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" UI="Primary" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" UI="Primary" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" UI="Primary" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" UI="Primary" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" UI="Primary" />
            </Items>
        </ext:Container>

        <h1>Danger (UI="Danger")</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" UI="Danger" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" UI="Danger" />
                <ext:Button runat="server" Text="Large" Scale="Large" UI="Danger" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" UI="Danger" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" UI="Danger" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" UI="Danger" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" UI="Danger" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" UI="Danger" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" UI="Danger" />
            </Items>
        </ext:Container>

        <h1>Info (UI="Info")</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" UI="Info" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" UI="Info" />
                <ext:Button runat="server" Text="Large" Scale="Large" UI="Info" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" UI="Info" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" UI="Info" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" UI="Info" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" UI="Info" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" UI="Info" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" UI="Info" />
            </Items>
        </ext:Container>

        <h1>Success (UI="Success")</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" UI="Success" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" UI="Success" />
                <ext:Button runat="server" Text="Large" Scale="Large" UI="Success" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" UI="Success" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" UI="Success" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" UI="Success" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" UI="Success" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" UI="Success" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" UI="Success" />
            </Items>
        </ext:Container>

        <h1>Warning (UI="Warning")</h1>

        <ext:Container runat="server">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Middle" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:Button runat="server" Text="Small" UI="Warning" />
                <ext:Button runat="server" Text="Medium" Scale="Medium" UI="Warning" />
                <ext:Button runat="server" Text="Large" Scale="Large" UI="Warning" />

                <ext:Component runat="server" Width="50" />

                <ext:Button runat="server" Text="Menu Small" UI="Warning" />
                <ext:Button runat="server" Text="Menu Medium" Scale="Medium" UI="Warning" />
                <ext:Button runat="server" Text="Menu Large" Scale="Large" UI="Warning" />

                <ext:Component runat="server" Width="50" />

                <ext:SplitButton runat="server" Text="Split Small" UI="Warning" />
                <ext:SplitButton runat="server" Text="Split Medium" Scale="Medium" UI="Warning" />
                <ext:SplitButton runat="server" Text="Split Large" Scale="Large" UI="Warning" />
            </Items>
        </ext:Container>
    </form>
</body>
</html>
