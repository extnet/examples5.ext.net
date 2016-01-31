<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]            
            {
                new object[] { true,  false, 1,  "LG KS360", 54, "240 x 320 pixels", "2 Megapixel", "Pink", "Slider", 359, 2 },
                new object[] { true,  true,  2,  "Sony Ericsson C510a Cyber-shot", 180, "320 x 240 pixels", "3.2 Megapixel", "Future black", "Candy bar", 11, 0 },
                new object[] { true,  true,  3,  "LG PRADA KE850", 155, "240 x 400 pixels", "2 Megapixel", "Black", "Candy bar", 113, 0 },
                new object[] { true,  true,  4,  "Nokia N900 Smartphone 32 GB", 499, "800 x 480 pixels", "5 Megapixel", "( the image of the product displayed may be of a different color )", "Slider", 320, 3.500000 },
                new object[] { true,  false, 5,  "Motorola RAZR V3", 65, "96 x 80 pixels", "0.3 Megapixel", "Silver", "Folder type phone", 5, 2.2 },
                new object[] { true,  true,  6,  "LG KC910 Renoir", 242, "240 x 400 pixels", "8 Megapixel", "Black", "Candy bar", 79, 0 },
                new object[] { true,  true,  7,  "BlackBerry Curve 8520 BlackBerry", 299, "320 x 240 pixels", "2 Megapixel", "Frost", "Candy bar", 320, 2.64 },
                new object[] { true,  true,  8,  "Sony Ericsson W580i Walkman", 120, "240 x 320 pixels", "2 Megapixel", "Urban gray", "Slider", 1, 0 },
                new object[] { true,  true,  9,  "Nokia E63 Smartphone 110 MB", 170, "320 x 240 pixels", "2 Megapixel", "Ultramarine blue", "Candy bar", 319, 2.36 },
                new object[] { true,  true,  10, "Sony Ericsson W705a Walkman", 274, "320 x 240 pixels", "3.2 Megapixel", "Luxury silver", "Slider", 5, 0 },
                new object[] { false, false, 11, "Nokia 5310 XpressMusic", 140, "320 x 240 pixels", "2 Megapixel", "Blue", "Candy bar", 344, 2 },
                new object[] { false, true,  12, "Motorola SLVR L6i", 50, "128 x 160 pixels", "", "Black", "Candy bar", 38, 0 },
                new object[] { false, true,  13, "T-Mobile Sidekick 3 Smartphone 64 MB", 75, "240 x 160 pixels", "1.3 Megapixel", "", "Sidekick", 115, 0 },
                new object[] { false, true,  14, "Audiovox CDM8600", 5, "", "", "", "Folder type phone", 1, 0 },
                new object[] { false, true,  15, "Nokia N85", 315, "320 x 240 pixels", "5 Megapixel", "Copper", "Dual slider", 143, 2.6 },
                new object[] { false, true,  16, "Sony Ericsson XPERIA X1", 399, "800 x 480 pixels", "3.2 Megapixel", "Solid black", "Slider", 14, 0 },
                new object[] { false, true,  17, "Motorola W377", 77, "128 x 160 pixels", "0.3 Megapixel", "", "Folder type phone", 35, 0 },
                new object[] { true,  true,  18, "LG Xenon GR500", 1, "240 x 400 pixels", "2 Megapixel", "Red", "Slider", 658, 2.8 },
                new object[] { true,  false, 19, "BlackBerry Curve 8900 BlackBerry", 349, "480 x 360 pixels", "3.2 Megapixel", "", "Candy bar", 21, 2.44 },
                new object[] { true,  false, 20, "Samsung SGH U600 Ultra Edition 10.9", 135, "240 x 320 pixels", "3.2 Megapixel", "", "Slider", 169, 2.2 }        
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.Net Examples - Animated DataView</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="animated-dataview.css" rel="stylesheet" />

    <script>
        var filterData = function (slider) {
            var store = App.Store1,
                values = slider.getValues();

            store.suspendEvents();
            store.clearFilter();
            store.resumeEvents();
            store.filter([{
                fn: function (record) {
                    return record.get('price') >= values[0] && record.get('price') <= values[1];
                }
            }]);

            store.sort('name', 'ASC');
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Animated DataView Example</h1>

        <p>This example uses the Ext.ux.DataView.Animated plugin to animate the changes to a DataView.</p>

        <ext:Panel
            runat="server"
            Title="Animated DataView"
            Height="555"
            Width="650"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:DisplayField runat="server" Text="Filter phone price:&nbsp;" />
                        <ext:Slider
                            runat="server"
                            HideLabel="true"
                            Width="300"
                            XMinValue="0"
                            MaxValue="500"
                            Numbers="100,200">
                            <Listeners>
                                <AfterRender Fn="filterData" Delay="10" />
                                <Change Fn="filterData" Buffer="70" />
                            </Listeners>
                        </ext:Slider>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:DataView
                    ID="phones"
                    runat="server"
                    DeferInitialRefresh="false"
                    ItemSelector="div.phone"
                    OverItemCls="phone-hover"
                    MultiSelect="true"
                    AutoScroll="true"
                    Cls="phones-view"
                    TrackOver="true">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server" IDProperty="id">
                                    <Fields>
                                        <ext:ModelField Name="hasEmail" Type="Boolean" />
                                        <ext:ModelField Name="hasCamera" Type="Boolean" />
                                        <ext:ModelField Name="id" Type="Int" />
                                        <ext:ModelField Name="name" />
                                        <ext:ModelField Name="price" Type="Int" />
                                        <ext:ModelField Name="screen" />
                                        <ext:ModelField Name="camera" />
                                        <ext:ModelField Name="color" />
                                        <ext:ModelField Name="type" />
                                        <ext:ModelField Name="reviews" Type="Int" />
                                        <ext:ModelField Name="screen-size" Type="Int" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="name" Direction="ASC" />
                            </Sorters>
                        </ext:Store>
                    </Store>
                    <Tpl runat="server">
                        <Html>
                            <tpl for=".">
                                <div class="phone">
                                    <tpl if="!Ext.isIE6">
                                        <img width="64" height="64" src="../../Shared/images/phones/{[values.name.replace(/ /g, "-")]}.png" />
                                    </tpl>
                                    <tpl if="Ext.isIE6">
                                        <div style="width:74px;height:74px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../../Shared/images/phones/{[values.name.replace(/ /g, "-")]}.png',sizingMethod='scale');"></div>
                                    </tpl>
                                    <strong>{name}</strong>
                                    <span>{price:usMoney} ({reviews} Review{[values.reviews == 1 ? "" : "s"]})</span>
                                </div>
                            </tpl>
                        </Html>
                    </Tpl>
                    <Plugins>
                        <ext:DataViewAnimated runat="server" Duration="550" IDProperty="id" />
                    </Plugins>
                </ext:DataView>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
