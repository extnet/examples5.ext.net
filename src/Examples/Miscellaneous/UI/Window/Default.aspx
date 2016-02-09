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
            AutoPostBack="true">
            <Items>
                <ext:ListItem Text="Classic" Value="0" />
                <ext:ListItem Text="Gray" Value="1" />
                <ext:ListItem Text="Neptune" Value="2" />
                 <ext:ListItem Text="Neptune Touch" Value="3" />
                <ext:ListItem Text="Crisp" Value="4" />
                <ext:ListItem Text="Crisp Touch" Value="5" />
            </Items>
        </ext:ComboBox>

        <h3>Window UI</h3>

        <ext:Window 
            ID="Window1" 
            runat="server" 
            Title="Window" 
            Width="500" 
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
                <ext:ComboBox runat="server" FieldLabel="UI" Editable="false">
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