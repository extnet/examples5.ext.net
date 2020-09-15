<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    public class Company
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public double Change { get; set; }
        public double PctChange { get; set; }
        public DateTime LastChange { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    private void BindData()
    {
        Store store = this.GridPanel1.GetStore();
        store.DataSource = this.GetData();
        store.DataBind();
    }

    private List<Company> GetData()
    {
        DateTime today = DateTime.Today;

        return new List<Company>
        {
            new Company { ID = 1, Name = "3m Co", Price = 71.72, Change = 0.02, PctChange = 0.03, LastChange = today },
            new Company { ID = 2, Name = "Alcoa Inc", Price = 29.01, Change = 0.42, PctChange = 1.47, LastChange = today },
            new Company { ID = 3, Name = "Altria Group Inc", Price = 83.81, Change = 0.28, PctChange = 0.34, LastChange = today },
            new Company { ID = 4, Name = "American Express Company", Price = 52.55, Change = 0.01, PctChange = 0.02, LastChange = today },
            new Company { ID = 5, Name = "American International Group, Inc.", Price = 64.13, Change = 0.31, PctChange = 0.49, LastChange = today },
            new Company { ID = 6, Name = "AT&T Inc.", Price = 31.61, Change = -0.48, PctChange = -1.54, LastChange = today },
            new Company { ID = 7, Name = "Boeing Co.", Price = 75.43, Change = 0.53, PctChange = 0.71, LastChange = today },
            new Company { ID = 8, Name = "Caterpillar Inc.", Price = 67.27, Change = 0.92, PctChange = 1.39, LastChange = today },
            new Company { ID = 9, Name = "Citigroup, Inc.", Price = 49.37, Change = 0.02, PctChange = 0.04, LastChange = today },
            new Company { ID = 10, Name = "E.I. du Pont de Nemours and Company", Price = 40.48, Change = 0.51, PctChange = 1.28, LastChange = today },
            new Company { ID = 11, Name = "Exxon Mobil Corp", Price = 68.1, Change = -0.43, PctChange = -0.64, LastChange = today },
            new Company { ID = 12, Name = "General Electric Company", Price = 34.14, Change = -0.08, PctChange = -0.23, LastChange = today },
            new Company { ID = 13, Name = "General Motors Corporation", Price = 30.27, Change = 1.09, PctChange = 3.74, LastChange = today },
            new Company { ID = 14, Name = "Hewlett-Packard Co.", Price = 36.53, Change = -0.03, PctChange = -0.08, LastChange = today },
            new Company { ID = 15, Name = "Honeywell Intl Inc", Price = 38.77, Change = 0.05, PctChange = 0.13, LastChange = today },
            new Company { ID = 16, Name = "Intel Corporation", Price = 19.88, Change = 0.31, PctChange = 1.58, LastChange = today },
            new Company { ID = 17, Name = "International Business Machines", Price = 81.41, Change = 0.44, PctChange = 0.54, LastChange = today },
            new Company { ID = 18, Name = "Johnson & Johnson", Price = 64.72, Change = 0.06, PctChange = 0.09, LastChange = today },
            new Company { ID = 19, Name = "JP Morgan & Chase & Co", Price = 45.73, Change = 0.07, PctChange = 0.15, LastChange = today },
            new Company { ID = 20, Name = "McDonald\"s Corporation", Price = 36.76, Change = 0.86, PctChange = 2.40, LastChange = today },
            new Company { ID = 21, Name = "Merck & Co., Inc.", Price = 40.96, Change = 0.41, PctChange = 1.01, LastChange = today },
            new Company { ID = 22, Name = "Microsoft Corporation", Price = 25.84, Change = 0.14, PctChange = 0.54, LastChange = today },
            new Company { ID = 23, Name = "Pfizer Inc", Price = 27.96, Change = 0.4, PctChange = 1.45, LastChange = today },
            new Company { ID = 24, Name = "The Coca-Cola Company", Price = 45.07, Change = 0.26, PctChange = 0.58, LastChange = today },
            new Company { ID = 25, Name = "The Home Depot, Inc.", Price = 34.64, Change = 0.35, PctChange = 1.02, LastChange = today },
            new Company { ID = 26, Name = "The Procter & Gamble Company", Price = 61.91, Change = 0.01, PctChange = 0.02, LastChange = today },
            new Company { ID = 27, Name = "United Technologies Corporation", Price = 63.26, Change = 0.55, PctChange = 0.88, LastChange = today },
            new Company { ID = 28, Name = "Verizon Communications", Price = 35.57, Change = 0.39, PctChange = 1.11, LastChange = today },
            new Company { ID = 29, Name = "Wal-Mart Stores, Inc.", Price = 45.45, Change = 0.73, PctChange = 1.63, LastChange = today }
        };
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void Edit(int id, string field, string oldValue, string newValue, object customer)
    {
        string message = "<b>Property:</b> {0}<br /><b>Field:</b> {1}<br /><b>Old Value:</b> {2}<br /><b>New Value:</b> {3}";

        // Send Message...
        X.Msg.Notify(new NotificationConfig()
        {
            Title = "Edit Record #" + id.ToString(),
            Html = string.Format(message, id, field, oldValue, newValue),
            Width = 250,
            Height = 150
        }).Show();

        this.GridPanel1.GetStore().GetById(id).Commit();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Editor with DirectMethod - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = 'color:{0};';

        var change = function (value, meta) {
            meta.style = Ext.String.format(template, (value > 0) ? "green" : "red");
            return value;
        };

        var pctChange = function (value, meta) {
            meta.style = Ext.String.format(template, (value > 0) ? "green" : "red");
            return value + "%";
        };

        var edit = function (editor, e) {
            /*
                "e" is an edit event with the following properties:

                    grid - The grid
                    record - The record that was edited
                    field - The field name that was edited
                    value - The value being set
                    originalValue - The original value for the field, before the edit.
                    row - The grid table row
                    column - The grid Column defining the column that was edited.
                    rowIdx - The row index that was edited
                    colIdx - The column index that was edited
            */

            // Call DirectMethod
            if (!(e.value === e.originalValue || (Ext.isDate(e.value) && Ext.Date.isEqual(e.value, e.originalValue)))) {
                CompanyX.Edit(e.record.data.ID, e.field, e.originalValue, e.value, e.record.data);
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Editable GridPanel With Save To [DirectMethod]</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Editable GridPanel"
            Width="720"
            Height="480">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="ID">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="Price" Type="Float" />
                                <ext:ModelField Name="Change" Type="Float" />
                                <ext:ModelField Name="PctChange" Type="Float" />
                                <ext:ModelField Name="LastChange" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="ID"
                        DataIndex="ID"
                        Width="35"
                        />
                    <ext:Column runat="server" Text="Name" DataIndex="Name" Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Price" DataIndex="Price">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:NumberField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" DataIndex="Change">
                        <Renderer Fn="change" />
                        <Editor>
                            <ext:NumberField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" DataIndex="PctChange">
                        <Renderer Fn="pctChange" />
                        <Editor>
                            <ext:NumberField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:DateColumn
                        runat="server"
                        Text="Last Updated"
                        DataIndex="LastChange"
                        Format="yyyy-MM-dd"
                        Width="120">
                        <Editor>
                            <ext:DateField runat="server" Format="yyyy-MM-dd" />
                        </Editor>
                    </ext:DateColumn>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:CellSelectionModel runat="server" />
            </SelectionModel>
            <Plugins>
                <ext:CellEditing runat="server">
                    <Listeners>
                        <Edit Fn="edit" />
                    </Listeners>
                </ext:CellEditing>
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>