<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities"%>
<%@ Import Namespace="System.Collections.Generic"%>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            //We do not need to DataBind on an DirectEvent
            return;
        }

        //Build first level
        this.BuildLevel(null);
    }

    [DirectMethod]
    public string BuildLevel(Dictionary<string, string> parameters)
    {
        int level = parameters != null && parameters.ContainsKey("level") ? int.Parse(parameters["level"]) : 1;

        // bind store
        List<object> data = new List<object>();

        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = i, Name = "Level".ConcatWith(level, ": Row " + i) });
        }

        //build grid
        GridPanel grid = new GridPanel
            {
                Height = 215,
                HideHeaders = level != 1,
                DisableSelection = true,
                Store =
                {
                    new Store
                    {
                        Model =
                        {
                            new Model
                            {
                                IDProperty = "ID",
                                Fields =
                                {
                                    new ModelField("ID"),
                                    new ModelField("Name"),
                                    new ModelField
                                    {
                                        Name = "Level",
                                        DefaultValue = level.ToString()
                                    }
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
                        new Column { DataIndex = "Name", Text = "Name", Flex = 1 }
                    }
                },
                View =
                {
                    new Ext.Net.GridView()
                    {
                        OverItemCls = " " //to avoid the known issue #6
                    }
                }
            };

        // add expander for all levels except last (last level is 5)
        if (level < 5)
        {
            RowExpander re = new RowExpander
            {
                ScrollOffset = 10,
                Loader = new ComponentLoader
                {
                    Mode = LoadMode.Component,
                    DirectMethod = "#{DirectMethods}.BuildLevel",
                    LoadMask =
                    {
                        ShowMask = true
                    },
                    Params =
                    {
                        new Ext.Net.Parameter("level", (level + 1).ToString(), ParameterMode.Raw),
                        new Ext.Net.Parameter("id", "this.record.getId()", ParameterMode.Raw)
                    }
                }
            };

            grid.Plugins.Add(re);
        }

        if (level == 1)
        {
            grid.Title = "MultiLevel grid";
            grid.Width = 600;
            grid.Height = 600;
            grid.ResizableConfig = new Resizer { Handles = ResizeHandle.South };
            this.Form.Controls.Add(grid);
        }
        else
        {
            grid.EnableColumnHide = false;
            return ComponentLoader.ToConfig(grid);
        }

        return null;
    }
</script>

<html>
<head runat="server">
    <title>MultiLevel GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>MultiLevel GridPanel</h1>

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
    </form>
</body>
</html>