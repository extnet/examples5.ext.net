<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            //We do not need to DataBind on an DirectEvent
            return;
        }

        List<object> data = new List<object>();

        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = "S" + i, Name = "Supplier " + i});
        }

        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }

    [DirectMethod]
    public static string GetGrid(Dictionary<string, string> parameters)
    {
        // string id = parameters["id"];

        List<object> data = new List<object>();

        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = "P" + i, Name = "Product " + i });
        }

        GridPanel grid = new GridPanel
        {
            Height = 200,
            EnableColumnHide = false,
            Store =
            {
                new Store
                {
                    Model = {
                        new Model {
                            IDProperty = "ID",
                            Fields =
                            {
                                new ModelField("ID"),
                                new ModelField("Name")
                            }
                        }
                    },
                    DataSource = data
                }
            },
            ColumnModel =
            {
                Columns =
                {
                    new Column { Text = "Products's Name", DataIndex = "Name", Width = 150 }
                }
            }
        };

        return ComponentLoader.ToConfig(grid);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RowExpander with GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Row Expander Plugin with GridPanel</h1>

        <p>The caching is presented, GridPanel renders once only (until view refresh)</p>

        <p>The nested GridPanels support is limited.</p>

        <p>Here are some known issues:</p>

        <ul>
            <li>1. No horizontal lines and no stripeRows effect in nested GridPanels (unless a nested GridPanel contains a RowExpander).<br /></li>
            <li>2. No tracking mouse over functionality for nested GridPanels. So, for instance, the rows are not highlighted when the mouse hovers them.<br /></li>
            <li>3. A parent and a nested GridPanels must not use row and checkbox selection models at the same time.<br /></li>
            <li>4. The Columns option of a header menu of nested GridPanels doesn't work. It must be disabled. To disable set the GridPanel's EnableColumnHide property to false.<br /></li>
            <li>5. No auto height for nested GridPanels.<br /></li>
            <li>6. If a nested GridPanel has a RowExpander, then over mouse CSS rules from a parent GridPanel will be applied to a nested GridPanel.</li>
            <li>etc. More issues are possible.<br /></li>
        </ul>

        <br />

        <ext:GridPanel
            runat="server"
            Title="Expander Rows with GridPanel"
            Collapsible="true"
            AnimCollapse="true"
            IconCls="x-md md-icon-grid-on"
            Width="960"
            Height="480"
            DisableSelection="true">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="ID">
                            <Fields>
                                <ext:ModelField Name="ID" />
                                <ext:ModelField Name="Name" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Supplier" DataIndex="Name" Flex="1" Hideable="false" />
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:RowExpander runat="server">
                    <Loader runat="server" DirectMethod="#{DirectMethods}.GetGrid" Mode="Component">
                        <LoadMask ShowMask="true" />
                        <Params>
                            <ext:Parameter Name="id" Value="this.record.getId()" Mode="Raw" />
                        </Params>
                    </Loader>
                </ext:RowExpander>
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>