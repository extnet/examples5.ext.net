<%@ Control Language="C#" %>

<script runat="server">
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
       X.Msg.Alert("Name", this.Name).Show();
    }

    public string Name { get; set; }
</script>

<ext:Button ID="Button1" runat="server">
    <Listeners>
        <Click Handler="#{DirectMethods}.GetName();" />
    </Listeners>
</ext:Button>