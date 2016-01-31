<%@ Page Language="C#" %>

<script runat="server">
    public List<object> Data
    {
        get
        {
            string[] companies = new string[] 
            { 
                "3m Co",
                "Alcoa Inc",
                "Altria Group Inc",
                "American Express Company",
                "American International Group, Inc.",
                "AT&T Inc.",
                "Boeing Co.",
                "Caterpillar Inc.",
                "Citigroup, Inc.",
                "Microsoft",
                "Verizon",
                "Wal-Mart"
            };

            Random rand = new Random();
            List<object> data = new List<object>(companies.Length);
            
            for (int i = 0; i < companies.Length; i++)
            {
                data.Add(new { 
                    Company = companies[i],
                    Price = rand.Next(10000) / 100d,
                    Revenue = rand.Next(10000) / 100d,
                    Growth = rand.Next(10000) / 100d,
                    Product = rand.Next(10000) / 100d,
                    Market = rand.Next(10000) / 100d,
                });
            }

            return data;
        }
    }

    public List<object> RadarData
    {
        get
        {
            return new List<object> 
            { 
                new { Name = "Price", Data = 100 },
                new { Name = "Revenue %", Data = 100 },
                new { Name = "Growth %", Data = 100 },
                new { Name = "Product %", Data = 100 },
                new { Name = "Market %", Data = 100 }
            };
        }
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Chart Dashboard - Ext.NET Examples</title>
    <link href="../../../../resources/css/examples.css" rel="stylesheet" />

    <script>
        var form = false,
            rec = false,
            selectedStoreItem = false;

        var selectItem = function (storeItem) {
            var name = storeItem.get('company'),
                series = App.BarChart1.series[0],
                store = series.getStore();

            App.BarChart1.setHighlightItem(series.getItemByIndex(store.indexOf(storeItem)));
        };

        var updateRecord = function (rec) {
            var name,
                series,
                i,
                l,
                items,
                json = [{
                    'Name': 'Price',
                    'Data': rec.get('price')
                }, {
                    'Name': 'Revenue %',
                    'Data': rec.get('revenue')
                }, {
                    'Name': 'Growth %',
                    'Data': rec.get('growth')
                }, {
                    'Name': 'Product %',
                    'Data': rec.get('product')
                }, {
                    'Name': 'Market %',
                    'Data': rec.get('market')
                }];
            App.RadarStore.loadData(json);
            selectItem(rec);
        };

        var afterEdit = function (field, newValue, oldValue) {
            if (rec && form) {
                if (newValue > field.maxValue) {
                    field.setValue(field.maxValue);
                } else {
                    if (form.isValid()) {
                        form.updateRecord(rec);
                        updateRecord(rec);
                    }
                }
            }
        };

        var onMouseUp = function (series, item, event, evntOpts) {
            var index = item.index,
                selectionModel = App.CompanyGrid.getSelectionModel();

            selectedStoreItem = item.storeItem;
            selectionModel.select(index);
        };

        var onSelectionChange = function (model, records) {
            var json,
                    name,
                    i,
                    l,
                    items,
                    series,
                    fields;

            if (records[0]) {
                rec = records[0];
                if (!form) {
                    form = this.up('form').getForm();
                    fields = form.getFields();
                    fields.each(function (field) {
                        if (field.name != 'company') {
                            field.setDisabled(false);
                        }
                    });
                } else {
                    fields = form.getFields();
                }

                // prevent change events from firing
                fields.each(function (field) {
                    field.suspendEvents();
                });

                form.loadRecord(rec);
                this.up('panel').down('fieldset').setTitle(rec.get('company'));
                updateRecord(rec);

                fields.each(function (field) {
                    field.resumeEvents();
                });
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Dynamic Form, Grid and Charts</h1>

        <p>
            Showing companies information in a grid. Selecting a row will highlight
            the bar corresponding to that company and fill in the form with the company
            data. A radar chart will show the company information. You can update the
            information in the form to see it change live in the grid, bar chart and radar charts.
        </p>

        <ext:FormPanel 
            runat="server"
            Frame="true"
            BodyPadding="5"
            Width="870"
            Height="510">            
            <Bin>
                <ext:Store 
                    ID="CompanyStore" 
                    runat="server" 
                    Data="<%# Data %>" 
                    AutoDataBind="true">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" Mapping="Company" />
                                <ext:ModelField Name="price" Mapping="Price" Type="Float" />
                                <ext:ModelField Name="revenue" Mapping="Revenue" Type="Float" />
                                <ext:ModelField Name="growth" Mapping="Growth" Type="Float" />
                                <ext:ModelField Name="product" Mapping="Product" Type="Float" />
                                <ext:ModelField Name="market" Mapping="Market" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Bin>

            <FieldDefaults LabelAlign="Left" MsgTarget="Side" />
            
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />    
            </LayoutConfig>

            <Items>
                <ext:Panel runat="server" Height="250" MarginSpec="0 0 3 0">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:CartesianChart 
                            ID="BarChart1" 
                            runat="server"
                            Border="false"
                            Flex="1" 
                            StoreID="CompanyStore">
                            <Interactions>
                                <ext:ItemHighlightInteraction />
                            </Interactions>
                            <AnimationConfig Duration="300" Easing="EaseOut" />
                            <Axes>
                                <ext:NumericAxis Position="Left" Fields="price" Minimum="0" Hidden="true" />
                                <ext:CategoryAxis Position="Bottom" Fields="company">
                                    <Label Font="9px Arial" RotationDegrees="-45" />
                                    <Renderer Handler="return Ext.String.ellipsis(label, 15, false);" />
                                </ext:CategoryAxis>
                            </Axes> 

                            <Series>
                                <ext:BarSeries 
                                    Highlight="true" 
                                    XField="company" 
                                    YField="price">
                                    <StyleSpec>
                                        <ext:Sprite FillStyle="#456d9f" />
                                    </StyleSpec>
                                    <HighlightConfig>
                                        <ext:Sprite FillStyle="#619fff" StrokeStyle="black" />
                                    </HighlightConfig>
                                    <Label 
                                        Display="InsideEnd" 
                                        Field="price" 
                                        Color="#000" 
                                        Orientation="Vertical" 
                                        TextAlign="Center"
                                        />
                                    <Listeners>
                                        <ItemMouseUp Fn="onMouseUp" />
                                    </Listeners>
                                </ext:BarSeries>
                            </Series>
                            <Plugins>
                                <ext:ChartItemEvents runat="server" />
                            </Plugins>
                        </ext:CartesianChart>

                        <ext:PolarChart 
                            runat="server" 
                            Margin="0" 
                            InsetPaddingSpec="15 30 15 30" 
                            Width="200"
                            StandardTheme="Blue">
                            <Store>
                                <ext:Store 
                                    ID="RadarStore" 
                                    runat="server" 
                                    Data="<%# RadarData %>" 
                                    AutoDataBind="true">
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="Name" />
                                                <ext:ModelField Name="Data" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <Interactions>
                                <ext:RotateInteraction />
                            </Interactions>
                            <Axes>
                                <ext:CategoryAxis Position="Angular" Grid="true">
                                    <Label FontSize="10" />
                                </ext:CategoryAxis>
                                <ext:NumericAxis MajorTickSteps="5" Minimum="0" Maximum="100" Position="Radial" Grid="true" />
                            </Axes>
                            <Series>
                                <ext:RadarSeries 
                                    AngleField="Name" 
                                    RadiusField="Data" 
                                    ShowMarkers="true">
                                    <Marker>
                                        <ext:CircleSprite Radius="4" FillStyle="rgb(69,109,159)" />
                                    </Marker>
                                    <StyleSpec>
                                        <ext:Sprite FillStyle="rgb(194,214,240)" Opacity="0.5" LineWidth="0.5" />
                                    </StyleSpec>
                                </ext:RadarSeries>
                            </Series>
                        </ext:PolarChart>
                    </Items>
                </ext:Panel>

                <ext:Panel 
                    runat="server" 
                    Flex="1" 
                    Border="false" 
                    BodyStyle="background-color: transparent;">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>

                    <Items>
                        <ext:GridPanel 
                            ID="CompanyGrid" 
                            runat="server" 
                            Flex="6" 
                            StoreID="CompanyStore">
                            <ColumnModel>
                                <Columns>
                                    <ext:Column 
                                        ID="Company" 
                                        runat="server" 
                                        Text="Company" 
                                        Flex="1" 
                                        DataIndex="company" 
                                        />
                                    <ext:Column 
                                        runat="server" 
                                        Text="Price" 
                                        Width="75" 
                                        DataIndex="price" 
                                        Align="Right">
                                        <Renderer Format="UsMoney" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Revenue" 
                                        Width="75" 
                                        DataIndex="revenue" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Growth" 
                                        Width="75" 
                                        DataIndex="growth" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Product" 
                                        Width="75" 
                                        DataIndex="product" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Market" 
                                        Width="75" 
                                        DataIndex="market" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>

                            <Listeners>
                                <SelectionChange Fn="onSelectionChange" />
                            </Listeners>
                        </ext:GridPanel>

                        <ext:FieldSet 
                            runat="server" 
                            Margin="5" 
                            Flex="4"  
                            MarginSpec="0 0 0 5"
                            Title="Company Details">
                            <Defaults>
                                <ext:Parameter Name="Width" Value="240" />
                                <ext:Parameter Name="LabelWidth" Value="90" />
                                <ext:Parameter Name="Disabled" Value="true" />
                            </Defaults>

                            <Items>
                                <ext:NumberField 
                                    runat="server" 
                                    FieldLabel="Price" 
                                    Name="price" 
                                    MinValue="0" 
                                    MaxValue="100" 
                                    EnforceMaxLength="true" 
                                    MaxLength="5">
                                    <Listeners>
                                        <Change Buffer="200" Fn="afterEdit" />
                                    </Listeners>
                                </ext:NumberField>

                                <ext:NumberField 
                                    runat="server" 
                                    FieldLabel="Revenue %" 
                                    Name="revenue" 
                                    MinValue="0" 
                                    MaxValue="100" 
                                    EnforceMaxLength="true" 
                                    MaxLength="5">
                                    <Listeners>
                                        <Change Buffer="200" Fn="afterEdit" />
                                    </Listeners>
                                </ext:NumberField>

                                <ext:NumberField 
                                    runat="server" 
                                    FieldLabel="Growth %" 
                                    Name="growth" 
                                    MinValue="0" 
                                    MaxValue="100" 
                                    EnforceMaxLength="true" 
                                    MaxLength="5">
                                    <Listeners>
                                        <Change Buffer="200" Fn="afterEdit" />
                                    </Listeners>
                                </ext:NumberField>

                                <ext:NumberField 
                                    runat="server" 
                                    FieldLabel="Product %" 
                                    Name="product" 
                                    MinValue="0" 
                                    MaxValue="100" 
                                    EnforceMaxLength="true" 
                                    MaxLength="5">
                                    <Listeners>
                                        <Change Buffer="200" Fn="afterEdit" />
                                    </Listeners>
                                </ext:NumberField>

                                <ext:NumberField 
                                    runat="server" 
                                    FieldLabel="Market %" 
                                    Name="market" 
                                    MinValue="0" 
                                    MaxValue="100" 
                                    EnforceMaxLength="true" 
                                    MaxLength="5">
                                    <Listeners>
                                        <Change Buffer="200" Fn="afterEdit" />
                                    </Listeners>
                                </ext:NumberField>
                            </Items>
                        </ext:FieldSet>                                
                    </Items>
                </ext:Panel>
            </Items>
        </ext:FormPanel>
    </form>    
</body>
</html>