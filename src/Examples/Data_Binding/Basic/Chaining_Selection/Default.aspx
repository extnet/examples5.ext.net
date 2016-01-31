<%@ Page Language="C#" %>

<script runat="server">    
    public class MyModel
    {
        public static object Model = new
        {
            stores = new
            {
                customers = new
                {
                    model = "Customer",
                    autoLoad = true
                }
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Chaining Selection - Ext.Net Examples</title>        
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .binding-selection-view .customer {
            float: left;
            width: 150px;
            padding: 8px;
            margin: 8px 8px 4px 8px;
        }

        .x-rtl .binding-selection-view .customer {
            float: right;
        }

        .binding-selection-view h1 {
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }

        .binding-selection-view .x-item-selected {
            color: black;
            background-color: #c1ddf1;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Chaining Selection</h1>

        <p>This example shows selection binding. The selection from each component <br />
           is bound to the same source and is automatically updated when a selection <br />
           in any component changes.
        </p>
        
       <ext:Model runat="server" Name="Customer">
            <Fields>
                <ext:ModelField Name="name" />
                <ext:ModelField Name="phone" />
            </Fields>
            <Proxy>
                <ext:AjaxProxy Url="customers.json" />
            </Proxy>
        </ext:Model>

        <ext:Panel 
            runat="server"
            Width="600"
            Height="270"
            Layout="VBoxLayout"
            ViewModel="<%# MyModel.Model %>" 
            AutoDataBind="true">
            <Items>
                <ext:ComboBox 
                    runat="server"
                    MarginSpec="10 0 0 10"
                    ForceSelection="true"
                    Editable="false"
                    DisplayField="name"
                    ValueField="id"
                    TriggerAction="All"
                    QueryMode="Local"
                    LabelWidth="160"
                    FieldLabel="Customer Combo">
                    <Bind>
                        <ext:Parameter Name="store" Value="{customers}" />
                        <ext:Parameter Name="selection" Value="{selectedCustomer}" />
                    </Bind>
                </ext:ComboBox>

                <ext:Container 
                    runat="server" 
                    Width="600" 
                    MarginSpec="15 0 0 0" 
                    Flex="1">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:GridPanel 
                            runat="server"
                            Title="Customers Grid"
                            Flex="1">
                            <Bind>
                                <ext:Parameter Name="store" Value="{customers}" />
                                <ext:Parameter Name="selection" Value="{selectedCustomer}" />
                            </Bind>
                            <ColumnModel>
                                <Columns>
                                    <ext:Column runat="server" Text="Name" DataIndex="name" Flex="1" />
                                    <ext:Column runat="server" Text="Phone" DataIndex="phone" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>

                        <ext:DataView 
                            runat="server"
                            Flex="1"
                            Cls="binding-selection-view"
                            ItemSelector=".customer">
                            <Tpl>
                                <Html>
                                    <h1>Customer View</h1><tpl for="."><div class="customer">{name}</div></tpl>
                                </Html>
                            </Tpl>
                            <Bind>
                                <ext:Parameter Name="store" Value="{customers}" />
                                <ext:Parameter Name="selection" Value="{selectedCustomer}" />
                            </Bind>
                        </ext:DataView>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>