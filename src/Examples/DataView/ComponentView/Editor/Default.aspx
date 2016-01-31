<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new List<object> 
            { 
                new { Number = 1, Text = "Text 1", Date = DateTime.Now, Combo = 1, Bool = true  },
                new { Number = 2, Text = "Text 2", Date = DateTime.Now, Combo = 2, Bool = false },
                new { Number = 3, Text = "Text 3", Date = DateTime.Now, Combo = 3, Bool = true  }
            };

            this.ComboStore.DataSource = new List<object> 
            { 
                new { Value = 1, Text = "Item1" },
                new { Value = 2, Text = "Item2" },
                new { Value = 3, Text = "Item3" },
                new { Value = 4, Text = "Item4" },
                new { Value = 5, Text = "Item5" }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComponentView Overview - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script type="text/javascript">
        var renderText = function (value) {
            return App.ComboStore.getById(value).data.Text;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ComponentView Editing</h1>

        <br />

        <ext:Store ID="ComboStore" runat="server">
            <Model>
                <ext:Model runat="server" IDProperty="Value">
                    <Fields>
                        <ext:ModelField Name="Value" Type="Int" />
                        <ext:ModelField Name="Text" Type="String" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:DataView runat="server" Padding="6" DisableSelection="true" Width="450">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Number" Type="Int" />
                                <ext:ModelField Name="Text" Type="String" />
                                <ext:ModelField Name="Date" Type="Date" />
                                <ext:ModelField Name="Combo" Type="Int" />
                                <ext:ModelField Name="Bool" Type="Boolean" />
                                <ext:ModelField Name="editing" Type="Boolean" DefaultValue="false" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ItemTpl runat="server">
                <Html>
                    <tpl if="!editing">
                        <div style="position:relative; border: solid gray 1px; padding:6px; margin-bottom:6px;">
                            <p>Number: {Number}</p>
                            <p>Text: {Text}</p>
                            <p>Date: {Date:date("d\-m\-Y")}</p>
                            <p>Combo: {[renderText(values.Combo)]}</p>
                            <p>Bool: {Bool}</p>
                            <div class="edit-button" style="position:absolute; right: 10px; bottom:10px;"></div>
                        </div>                        
                    </tpl>

                    <tpl if="editing">
                        <div style="position:relative; border: solid gray 1px; padding:6px; margin-bottom:6px;">
                            <p>{NumberField}</p>
                            <p>{TextField}</p>
                            <p>{DateField}</p>
                            <p>{ComboField}</p>
                            <p>{BoolField}</p>
                            <div class="edit-button" style="position:absolute; right: 10px; bottom:35px;"></div>
                            <div class="cancel-button" style="position:absolute; right: 10px; bottom:10px;"></div>
                        </div>                        
                    </tpl>
                </Html>
            </ItemTpl>
            <Plugins>
                <ext:ComponentView runat="server">
                    <Items>
                        <ext:ViewItem Selector="div.edit-button" Tag="editing">
                            <Component>
                                <ext:Button
                                    runat="server"
                                    Icon="NoteEdit"
                                    Handler="var record = this.record, editing = record.get('editing'); record.set('editing', !editing); if (editing) {record.commit(true);} " />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Selector="div.cancel-button">
                            <Component>
                                <ext:Button runat="server" Icon="Decline" Text="Cancel" Handler="this.record.reject();" />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Value="NumberField" BoundField="Number">
                            <Component>
                                <ext:NumberField runat="server" FieldLabel="Number" />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Value="TextField" BoundField="Text">
                            <Component>
                                <ext:TextField runat="server" FieldLabel="Text" />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Value="DateField" BoundField="Date">
                            <Component>
                                <ext:DateField runat="server" FieldLabel="Date" Format="d\-m\-Y" />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Value="ComboField" BoundField="Combo">
                            <Component>
                                <ext:ComboBox
                                    runat="server"
                                    FieldLabel="Combo"
                                    StoreID="ComboStore"
                                    Editable="false"
                                    DisplayField="Text"
                                    ValueField="Value" />
                            </Component>
                        </ext:ViewItem>

                        <ext:ViewItem Value="BoolField" BoundField="Bool">
                            <Component>
                                <ext:Checkbox runat="server" FieldLabel="Bool" />
                            </Component>
                        </ext:ViewItem>
                    </Items>
                    <Listeners>
                        <BeforeComponentBind Handler="if (item.tag == 'editing') { component.text = record.data.editing ? 'Save' : 'Edit'; }" />
                    </Listeners>
                </ext:ComponentView>
            </Plugins>
        </ext:DataView>
    </form>
</body>
</html>
