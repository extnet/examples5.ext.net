<%@ Control Language="C#" %>

<%@ Implements Interface="Ext.Net.IDynamicUserControl" %>

<script runat="server">
    public void BeforeRender()
    {
        this.Controls.Add(new Ext.Net.Panel { Title = "Item 1" });
        this.Controls.Add(new Ext.Net.Panel { Title = "Item 2" });
        this.Controls.Add(new Ext.Net.Panel { Title = "Item 3" });
    }
</script>