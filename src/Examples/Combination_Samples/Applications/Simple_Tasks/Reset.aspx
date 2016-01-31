<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Request["reset"] == "true")
        {
            new Ext.Net.Examples.SimpleTasks.SimpleTasksDataContext().Reset();
            new Ext.Net.Examples.Northwind.NorthwindDataContext().Reset();
        }

        this.Response.Write("Done");
    }
</script>