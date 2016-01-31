<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>

<script runat="server">
    
    private void AddField(ModelField field)
    {
        if (X.IsAjaxRequest)
        {
            this.Store1.AddField(field);
        }
        else
        {
            this.Store1.Model[0].Fields.Add(field);
        }
    }
     
    private void BindSet1()
    {
        string now = DateTime.Now.ToLongTimeString();
 
        this.Store1.DataSource = new List<object>
                                     {
                                         new {StringField = "Set1_1", IntField = 1, Timestamp = now},
                                         new {StringField = "Set1_2", IntField = 2, Timestamp = now},
                                         new {StringField = "Set1_3", IntField = 3, Timestamp = now}
                                     };
        this.Store1.DataBind();
    }
     
    private void BuildSet1()
    {
        if (X.IsAjaxRequest)
        {
            this.Store1.RemoveFields();
        }
 
        this.AddField(new ModelField("StringField"));
        this.AddField(new ModelField("IntField", ModelFieldType.Int));
        this.AddField(new ModelField("Timestamp"));
        this.Store1.RebuildMeta();
 
        this.BindSet1();
         
        this.GridPanel1.ColumnModel.Columns.Add(new Column{DataIndex = "StringField", Text = "String"});
        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "IntField", Text = "Int" });
        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "Timestamp", Text = "Timestamp" });
         
        if (X.IsAjaxRequest)
        {
            this.GridPanel1.Reconfigure();
        }
    }
 
    private void BindSet2()
    {
        string now = DateTime.Now.ToLongTimeString();
 
        this.Store1.DataSource = new List<object>
        {
            new { IntField1 = 1, StringField = "Set2_1", IntField2 = 1, Timestamp = now },
            new { IntField1 = 2, StringField = "Set2_2", IntField2 = 2, Timestamp = now },
            new { IntField1 = 3, StringField = "Set2_3", IntField2 = 3, Timestamp = now },
            new { IntField1 = 4, StringField = "Set2_4", IntField2 = 4, Timestamp = now },
            new { IntField1 = 5, StringField = "Set2_5", IntField2 = 5, Timestamp = now },
            new { IntField1 = 6, StringField = "Set2_6", IntField2 = 6, Timestamp = now }
        };
        
        this.Store1.DataBind();
    }
 
    private void BuildSet2()
    {
        if (X.IsAjaxRequest)
        {
           this.Store1.RemoveFields();
        }
 
        this.AddField(new ModelField("IntField1", ModelFieldType.Int));
        this.AddField(new ModelField("StringField"));
        this.AddField(new ModelField("IntField2", ModelFieldType.Int));
        this.AddField(new ModelField("Timestamp"));
        this.Store1.RebuildMeta();
 
        this.BindSet2();

        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "IntField1", Text = "Int1" });
        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "StringField", Text = "String" });
        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "IntField2", Text = "Int2" });
        this.GridPanel1.ColumnModel.Columns.Add(new Column { DataIndex = "Timestamp", Text = "Timestamp" });
 
        if (X.IsAjaxRequest)
        {
            this.GridPanel1.Reconfigure();
        }
    }
     
    private void RefreshSet()
    {
        switch (this.CurrentSet.Text)
        {
            case "1":
                this.BindSet1();
                break;
            case "2":
                this.BindSet2();
                break;
        }
    }
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BuildSet1();
        }
    }
 
    protected void RefreshDataSet(object sender, StoreReadDataEventArgs e)
    {
        switch (e.Parameters["set"])
        {
            case "1":
                this.BuildSet1();
                this.CurrentSet.Text = "1";
                break;
            case "2":
                this.BuildSet2();
                this.CurrentSet.Text = "2";
                break;   
            default:
                this.RefreshSet();
                break;
        }
    }
</script>

<!DOCTYPE html>
 
<html>
<head runat="server">
    <title>Grid and Store Reconfigure - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Grid and Store Reconfigure</h1>
         
        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Grid"
            Width="600"
            Height="350">
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server" 
                    OnReadData="RefreshDataSet" 
                    IgnoreExtraFields="false">
                    <Model>
                        <ext:Model runat="server" />
                    </Model>
                </ext:Store>
            </Store>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Single" />
            </SelectionModel>      
            <Buttons>
                <ext:Button 
                    runat="server" 
                    Text="Load Data1" 
                    EnableToggle="true" 
                    ToggleGroup="set" 
                    Pressed="true">
                    <Listeners>
                        <Click Handler="#{GridPanel1}.store.reload({params:{set:1}});" />
                    </Listeners>
                </ext:Button>
                 
                <ext:Button 
                    runat="server" 
                    Text="Load Data2" 
                    EnableToggle="true" 
                    ToggleGroup="set">
                    <Listeners>
                        <Click Handler="#{GridPanel1}.store.reload({params:{set:2}});" />
                    </Listeners>
                </ext:Button>
                 
                <ext:Button 
                    runat="server" 
                    Text="Refresh Current Data">
                    <Listeners>
                        <Click Handler="#{GridPanel1}.store.reload();" />
                    </Listeners>
                </ext:Button>
            </Buttons>      
        </ext:GridPanel>   
         
        <ext:Hidden ID="CurrentSet" runat="server" Text="1" />
    </form>
</body>
</html>