<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    public class FieldDescription
    {
        public FieldDescription(ModelFieldType type, Field field)
        {
            this.Type = type;
            this.Field = field;
        }

        public ModelFieldType Type
        {
            get;
            set;
        }

        public Field Field
        {
            get;
            set;
        }
    }

    Random rand;

    protected void ReadData(object sender, StoreReadDataEventArgs e)
    {
        rand = new Random();
        int rowCount = rand.Next(10, 31);
        int colCount = rand.Next(5, 11);
        List<FieldDescription> types = new List<FieldDescription>();
        List<object> data = new List<object>();
        List<ModelField> fields = new List<ModelField>();
        List<ColumnBase> columns = new List<ColumnBase>();
        bool defineFields = true;

        for (int i = 0; i < rowCount; i++)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();

            for (int j = 0; j < colCount; j++)
            {
                if (defineFields)
                {
                    var type = this.GenerateType(j);
                    types.Add(type);

                    ModelField field = new ModelField
                    {
                        Name = "field-" + (j + 1),
                        Type = type.Type
                    };

                    fields.Add(field);

                    ColumnBase column;

                    switch (type.Type)
                    {
                        case ModelFieldType.Date:
                            column = new DateColumn { Format = "yyyy-d-MM" };
                            break;
                        case ModelFieldType.Float:
                            column = new NumberColumn { Format = "$0.00" };
                            break;
                        case ModelFieldType.Boolean:
                            column = new Column();
                            break;
                        default:
                            column = new Column();
                            break;
                    }

                    column.DataIndex = "field-" + (j + 1);
                    if (j == 0)
                    {
                        column.Text = "ID";
                        column.Width = 40;
                    }
                    else
                    {
                        column.Text = string.Concat("Field ", j + 1, " (", type.Type, ")");
                        column.Editor.Add(type.Field);
                        column.Flex = 1;
                    }

                    columns.Add(column);
                }

                if (j == 0)
                {
                    row["field-" + (j + 1)] = i + 1;
                }
                else
                {
                    row["field-" + (j + 1)] = GetDataValue(types[j]);
                }
            }

            defineFields = false;
            data.Add(row);
        }

        MetaConfig meta = new MetaConfig();
        meta.IsRowEditing = true;
        meta.Fields.AddRange(fields);
        meta.Columns.AddRange(columns);
        meta.IDProperty = "field-1";

        e.Total = rowCount;
        e.MetaData = meta;
        GridPanel1.GetStore().Data = data;

        // if PageProxy uses direct method then use
        // return new { data, total = rowCount, metaData = JRawValue.From(meta.Serialize()) };
    }

    private FieldDescription GenerateType(int index)
    {
        switch (index == 0 ? 1 : rand.Next(0, 5))
        {
            case 0:
                return new FieldDescription(
                    ModelFieldType.String,
                    new TextField { AllowBlank = false }
                );
            case 1:
                return new FieldDescription(
                    ModelFieldType.Int,
                    new NumberField { MinValue = 1, MaxValue = 200 }
                );
            case 2:
                return new FieldDescription(
                    ModelFieldType.Date,
                    new DateField { Format = "yyyy-d-MM" }
                );
            case 3:
                return new FieldDescription(
                    ModelFieldType.Float,
                    new NumberField { MinValue = 400, MaxValue = 800 }
                );
            case 4:
                return new FieldDescription(
                    ModelFieldType.Boolean,
                    new Ext.Net.Checkbox()
                );
        }

        return null;
    }

    private object GetDataValue(FieldDescription type)
    {
        switch (type.Type)
        {
            case ModelFieldType.String:
                return "data";
            case ModelFieldType.Int:
                return 123;
            case ModelFieldType.Date:
                return DateTime.Now;
            case ModelFieldType.Float:
                return 456.78;
            case ModelFieldType.Boolean:
                return true;
        }
        return null;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Meta config - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Basic Meta Configuration</h1>
        <p>
            This example demonstrates reconfiguring a grid dynamically based on the metadata returned by the server.<br>
            Click the "Reload Metadata" button to see a new randomized column set and data in the grid.
        </p>
        <p>Note also that the grid is editable on double-click, and that the editors automatically update as well. See below for additional details.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Meta Grid"
            Width="960"
            Height="480">
            <Store>
                <ext:Store runat="server" OnReadData="ReadData">
                    <Model>
                        <ext:Model runat="server" Name="MetaModel" />
                    </Model>
                    <Proxy>
                        <ext:PageProxy />
                    </Proxy>
                    <Listeners>
                        <MetaChange Handler="#{GridPanel1}.reconfigure(store, meta.columns);" />
                        <%-- if you use controls with additional resources (like RatingColumn) then use the following handler
                            this handler is universal and can be used always--%>
                        <%--<MetaChange Handler="Ext.net.loadResources(meta.columns, function (columns) { #{GridPanel1}.reconfigure(store, columns);} );" />--%>
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" />
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:RowEditing runat="server" ClicksToMoveEditor="1" AutoCancel="false" />
            </Plugins>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            runat="server"
                            Text="Reload Metadata"
                            Handler="#{GridPanel1}.editingPlugin.completeEdit();
                                     #{GridPanel1}.editingPlugin.editor = null; // workaround for the GitHub issue #303. Remove after Sencha fix.
                                     #{GridPanel1}.store.load();" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>

        <p style="margin-top: 30px;">The server response is in this format:</p>
    <pre>
    <code>{
        data: [{ ... }],
        msg: "...",
        total: 99,
        metaData: {
            fields: [{ ... }],
            columns: [{ ... }],
            idProperty: "id",
            messageProperty: "msg",
            root: "data"
        }
    }</code>
    </pre>
        <p>
            The store/model automatically read the <code>fields</code> config to reconfigure the data model, but you can add any
            additional custom data into the <code>metaData</code> that you need. In this example we've added a <code>columns</code>
            config that contains a grid-specific column configuration that can be passed to the <code>grid.reconfigure()</code> method
            in the store's load event handler. You could easily add other widget-specific configurations into the response as well.
        </p>
    </form>
</body>
</html>