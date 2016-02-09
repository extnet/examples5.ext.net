<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.Data = new object[]
            {
                new object[] { 0, 1 },
                new object[] { 1, "text" },
                new object[] { 2, DateTime.Now },
                new object[] { 3, "Item4" },
                new object[] { 4, true }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multiple Editors - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Multiple Editors</h1>        

        <ext:GridPanel 
            runat="server" 
            Title="Multiple Editors" 
            Width="400">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Index" Type="Int" />
                                <ext:ModelField Name="Value">
                                    <Convert Handler="if (record.data.Index == 2) { return Ext.Date.parse(value, 'c'); } else { return value; }" />
                                </ext:ModelField>
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Reader>
                        <ext:ArrayReader />
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                     <ext:RowNumbererColumn runat="server" />

                     <ext:ComponentColumn runat="server" Flex="1" Editor="true" DataIndex="Value">
                        <Component>
                            <ext:NumberField runat="server" />
                            <ext:TextField runat="server" />
                            <ext:DateField runat="server" />
                            <ext:ComboBox runat="server">
                                <Items>
                                    <ext:ListItem Text="Item1" />
                                    <ext:ListItem Text="Item2" />
                                    <ext:ListItem Text="Item3" />
                                    <ext:ListItem Text="Item4" />
                                    <ext:ListItem Text="Item5" />
                                </Items>
                            </ext:ComboBox>
                            <ext:Checkbox runat="server" />
                        </Component>
                        <Listeners>
                            <BeforeBind Handler="e.config = e.config[e.record.data.Index];" />
                        </Listeners>
                        <Renderer Handler="metadata.style='color:gray;'; return '[none]';" />
                     </ext:ComponentColumn>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>  
    </form>
</body>
</html>