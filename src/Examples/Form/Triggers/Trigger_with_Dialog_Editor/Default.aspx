<%@ Page Language="C#" %>
  
<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", "A" },
                new object[] { "Alcoa Inc", "B" },
                new object[] { "Altria Group Inc", "C" },
                new object[] { "American Express Company", "D" },
                new object[] { "American International Group", "E" }
            };

            this.Store2.DataSource = new object[]
            {
                new object[] { "A", "Excelent" },
                new object[] { "B", "Good" },
                new object[] { "C", "Average" },
                new object[] { "D", "Poor" },
                new object[] { "E", "Bad" }
            };

            this.FillRadioGroup(RatingChoose);
            this.FillRadioGroup(CompanyRating);
        }
    }
    
    private void FillRadioGroup(RadioGroup group)
    {
        foreach (object[] rating in (object[])this.Store2.DataSource)
        {
            group.Items.Add(new Radio
            {
                Tag = rating[0].ToString(),
                BoxLabel = rating[1].ToString()
            });
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>EditorGrid with TextField Editor and Dialog - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>
        var triggerClick = function (el, trigger, tag, auto, index) {            
            switch(tag) {
                case "pick":
                    var w = App.PickWindow;
                    w.editor = el;
                    w.autoComplete = auto;
                                        
                    w.show(trigger, function () {
                        w.layout.setActiveItem(index);
                        w.layout.activeItem.initValue(w);
                    });
                    break;                    
                case "complete":
                    App.CellEditing1.completeEdit();
                    break;
            }
        };
        
        var ratingRenderer = function (value) {
            var r = App.Store2.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.description;
        };
        
        var setActiveRating = function (w) {
            var value = w.editor.getValue();
            App.RatingChoose.items.each(function (item) {
                if (item.tag == value) {
                    item.setValue(true);
                    return false;
                }   
            });
        };
        
        var saveRating = function (w) {
            w.editor.setValue(App.RatingChoose.getChecked()[0].tag);
        };
        
        var setCompany = function (w) {
            var record = App.CellEditing1.getActiveRecord(),
                company = w.editor.getValue(),
                rating = record.get("rating");
            
            App.CompanyName.setValue(company);                
            App.CompanyRating.items.each(function (item) {
                if (item.tag == rating) {
                    item.setValue(true);
                    return false;
                }   
            });
        };
        
        var saveCompany = function (w) {
            w.editor.setValue(App.CompanyName.getValue());
            App.CellEditing1.getActiveRecord().set("rating", App.CompanyRating.getChecked()[0].tag);
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>EditorGrid with TextField Editor and Dialog</h1>
    
    <p>Company column: auto complete edit after window hiding</p>
    <p>Rating column: should confirm value by clicking on the 'tick' trigger button</p>
    
    <ext:Store ID="Store1" runat="server" AutoLoad="false">
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="company" />
                    <ext:ModelField Name="rating" />
                </Fields>
            </ext:Model>
        </Model>
    </ext:Store>
    
    <ext:Store ID="Store2" runat="server">
        <Model>
            <ext:Model runat="server" IDProperty="rating">
                <Fields>
                    <ext:ModelField Name="rating" />
                    <ext:ModelField Name="description" />
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="App.Store1.load();" />
        </Listeners>
    </ext:Store>
    
    <ext:GridPanel 
        ID="GridPanel1" 
        runat="server" 
        StoreID="Store1" 
        Title="Grid" 
        Width="500">
        <ColumnModel runat="server">
            <Columns>
                <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1">
                    <Editor>
                        <ext:TextField runat="server">
                            <Triggers>
                                <ext:FieldTrigger Icon="SimpleEllipsis" Tag="pick" />
                                <ext:FieldTrigger Icon="SimpleTick" Tag="complete" />
                            </Triggers>
                            <Listeners>
                                <TriggerClick Handler="triggerClick(this, trigger, tag, true, 0);" />
                            </Listeners>
                        </ext:TextField>
                    </Editor>
                    <EditorOptions AllowBlur="false" />
                </ext:Column>
                
                <ext:Column runat="server" Text="Rating" DataIndex="rating" Flex="1">
                    <Editor>
                        <ext:ComboBox 
                            runat="server" 
                            StoreID="Store2"
                            DisplayField="description"
                            ValueField="rating"
                            QueryMode="Local"
                            TriggerAction="All"
                            MinChars="100"
                            HideBaseTrigger="true"
                            Editable="false">
                            <Triggers>
                                <ext:FieldTrigger Icon="SimpleEllipsis" Tag="pick" />
                                <ext:FieldTrigger Icon="SimpleTick" Tag="complete" />
                            </Triggers>
                            <Listeners>
                                <TriggerClick Handler="triggerClick(this, trigger, tag, false, 1);" />                                
                            </Listeners>
                        </ext:ComboBox>
                    </Editor>
                    <EditorOptions AllowBlur="false" />
                    <Renderer Fn="ratingRenderer" />
                </ext:Column>
            </Columns>
        </ColumnModel>
        <View>
            <ext:GridView runat="server" StripeRows="true" />
        </View>
        <Plugins>
            <ext:CellEditing ID="CellEditing1" runat="server" />
        </Plugins>
    </ext:GridPanel>
    
    <ext:Window 
        ID="PickWindow" 
        runat="server"
        Hidden="true"        
        Title="Pick a Value"
        Width="300"
        Height="250"
        Modal="true"
        Layout="card"
        Closable="false">
        <Items>
            <ext:Panel 
                runat="server" 
                BodyPadding="5" 
                Layout="anchor"
                Border="false">
                <Items>
                    <ext:TextField 
                        ID="CompanyName" 
                        runat="server" 
                        Anchor="100%"
                        FieldLabel="Own value" 
                        />
                    
                    <ext:RadioGroup 
                        ID="CompanyRating" 
                        runat="server" 
                        Anchor="100%"
                        FieldLabel="Rating" 
                        Vertical="true" 
                        ColumnsNumber="1"
                        />                    
                </Items>
                <CustomConfig>
                    <ext:ConfigItem Name="initValue" Value="setCompany" Mode="Raw" />
                    <ext:ConfigItem Name="saveValue" Value="saveCompany" Mode="Raw" />
                </CustomConfig>
            </ext:Panel>
        
            <ext:Panel runat="server" Layout="Fit" BodyPadding="5">
                <Items>
                    <ext:RadioGroup ID="RatingChoose" runat="server" Vertical="true" ColumnsNumber="1" />                    
                </Items>
                <CustomConfig>
                    <ext:ConfigItem Name="initValue" Value="setActiveRating" Mode="Raw" />
                    <ext:ConfigItem Name="saveValue" Value="saveRating" Mode="Raw" />
                </CustomConfig>
            </ext:Panel>
        </Items>
        
        <Buttons>
            <ext:Button runat="server" Text="OK">
                <Listeners>
                    <Click Handler="#{PickWindow}.hide(); #{PickWindow}.layout.activeItem.saveValue(#{PickWindow}); if (#{PickWindow}.autoComplete) {#{CellEditing1}.completeEdit();}" />
                </Listeners>
            </ext:Button>
            <ext:Button runat="server" Text="Cancel">
                <Listeners>
                    <Click Handler="#{PickWindow}.hide(); if (#{PickWindow}.autoComplete) {#{CellEditing1}.cancelEdit();}" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
</body>
</html>
