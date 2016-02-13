<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Request.IsLocal && this.Request.QueryString["refreshMap"] != null)
        {
            UIHelpers.BuildTreeNodes(true);
            this.Response.Redirect("~/");
        }
    }
</script>