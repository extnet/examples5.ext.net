<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { 1, 1, "Text 1", DateTime.Now.Date },
                new object[] { 2, 2, "Text 2", DateTime.Now.Date },
                new object[] { 3, 3, "Text 3", DateTime.Now.Date },
                new object[] { 4, 4, "Text 4", DateTime.Now.Date },
                new object[] { 5, 5, "Text 5", DateTime.Now.Date },
                new object[] { 6, 6, "Text 6", DateTime.Now.Date },
                new object[] { 7, 7, "Text 7", DateTime.Now.Date },
                new object[] { 8, 8, "Text 8", DateTime.Now.Date },
                new object[] { 9, 9, "Text 9", DateTime.Now.Date }
            };

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComponentColumn Over Editor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
    
    <style>
        .x-over-editor-grid tr.x-grid-row {
            height: 22px;
        }
    </style>   
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>ComponentColumn as Over Editor</h1>        

        <ext:GridPanel 
            runat="server" 
            Title="ComponentColumn Over Editor" 
            Cls="x-over-editor-grid"
            Width="600" 
            Height="300">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="IntField" Type="Int" />
                                <ext:ModelField Name="ComboField" Type="Int" />
                                <ext:ModelField Name="TextField" Type="String" />
                                <ext:ModelField Name="DateField" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:ComponentColumn 
                        runat="server" 
                        Editor="true"
                        OverOnly="true"
                        DataIndex="IntField"
                        Flex="1"
                        Text="Integer">
                        <Component>
                            <ext:NumberField runat="server" />
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn 
                        runat="server" 
                        Editor="true"
                        OverOnly="true"
                        DataIndex="ComboField"
                        Flex="1"
                        PinEvents="expand"
                        UnpinEvents="collapse"
                        Text="ComboBox">
                        <Component>
                            <ext:ComboBox runat="server">
                                <Items>
                                    <ext:ListItem Text="Item 1" Value="1" Mode="Raw" />
                                    <ext:ListItem Text="Item 2" Value="2" Mode="Raw" />
                                    <ext:ListItem Text="Item 3" Value="3" Mode="Raw" />
                                    <ext:ListItem Text="Item 4" Value="4" Mode="Raw" />
                                    <ext:ListItem Text="Item 5" Value="5" Mode="Raw" />
                                    <ext:ListItem Text="Item 6" Value="6" Mode="Raw" />
                                    <ext:ListItem Text="Item 7" Value="7" Mode="Raw" />
                                    <ext:ListItem Text="Item 8" Value="8" Mode="Raw" />
                                    <ext:ListItem Text="Item 9" Value="9" Mode="Raw" />
                                </Items>
                            </ext:ComboBox>
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn 
                        runat="server" 
                        Editor="true"
                        OverOnly="true"
                        DataIndex="TextField"
                        Flex="1"
                        Text="Text">
                        <Component>
                            <ext:TextField runat="server" />
                        </Component>
                    </ext:ComponentColumn>

                    <ext:ComponentColumn 
                        runat="server" 
                        Editor="true"
                        OverOnly="true"
                        DataIndex="DateField"
                        Flex="1"
                        PinEvents="expand"
                        UnpinEvents="collapse"
                        Text="Date">
                        <Renderer Format="Date" FormatArgs="'d/m/Y'" />                            
                        <Component>
                            <ext:DateField runat="server" Format="dd/MM/yyyy" />
                        </Component>
                    </ext:ComponentColumn>
                </Columns>
            </ColumnModel>          
        </ext:GridPanel>  
    </form>
</body>
</html>