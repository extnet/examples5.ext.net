<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = FiltersTestData.Data;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Field for FilterHeader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script src="custom_behaviour.js"></script>

    <script>
        var getCompanyValue = function () {
            var value = this.getComponent(1).getValue();
            return (Ext.isEmpty(value) ? "" : this.getComponent(0).text) + value;
        };

        var getSizeValue = function () {
            var text = [];

            this.menu.items.each(function (item) {
                if (item.checked) {
                    text.push(item.text);
                }
            });

            if (text.length == 0) {
                return "";
            } else {
                return "any " + text.join(",");
            }
        };

        var onItemCheck = function (menuItem) {
            var checked = false,
                button = menuItem.up('button');

            menuItem.parentMenu.items.each(function (item) {
                if (item.checked) {
                    checked = true;
                    return false;
                }
            });

            if (checked) {
                button.setText("[Filtered]");
            } else {
                button.setText("[No Filter]");
            }

            menuItem.up('grid').filterHeader.onFieldChange(button);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Field for FilterHeader</h1>

        <p>In this example we use custom behaviour from <a href="../Custom_Behaviour/" target="_blank">Custom Behaviour</a> example</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="450"
            Height="480"
            Closable="false"
            Title="Example"
            Layout="Fit">
            <Items>
                <ext:GridPanel runat="server">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server" IDProperty="Id">
                                    <Fields>
                                        <ext:ModelField Name="Id" Type="Int" />
                                        <ext:ModelField Name="Company" Type="String" />
                                        <ext:ModelField Name="Size" Type="String" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="Company" Direction="ASC" />
                            </Sorters>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column
                                runat="server"
                                Text="ID"
                                DataIndex="Id"
                                Filterable="false"
                                Width="40"
                                />
                            <ext:Column runat="server" Text="Company" DataIndex="Company" Width="250">
                                <Items>
                                    <ext:Container runat="server" Layout="HBox" Margin="2">
                                        <Items>
                                            <ext:CycleButton runat="server" ShowText="true" Width="70" ForceIcon="#Magnifier">
                                                <Menu>
                                                    <ext:Menu runat="server">
                                                        <Items>
                                                            <ext:CheckMenuItem runat="server" Text="=" ToolTip="Equals" />
                                                            <ext:CheckMenuItem runat="server" Text="+" Checked="true" ToolTip="Starts with" />
                                                            <ext:CheckMenuItem runat="server" Text="-" ToolTip="Ends with" />
                                                            <ext:CheckMenuItem runat="server" Text="*" ToolTip="Contains" />
                                                            <ext:CheckMenuItem runat="server" Text="!" ToolTip="Doesn't contain" />
                                                        </Items>
                                                    </ext:Menu>
                                                </Menu>
                                                <Listeners>
                                                    <Change Handler="this.up('grid').filterHeader.onFieldChange(this.up('container'));" />
                                                </Listeners>
                                            </ext:CycleButton>

                                            <ext:TextField runat="server" Flex="1">
                                                <Plugins>
                                                    <ext:ClearButton runat="server" />
                                                </Plugins>
                                                <Listeners>
                                                    <Change Handler="this.up('grid').filterHeader.onFieldChange(this.up('container'));" />
                                                </Listeners>
                                            </ext:TextField>
                                        </Items>
                                        <CustomConfig>
                                            <ext:ConfigItem Name="getValue" Value="getCompanyValue" Mode="Raw" />
                                        </CustomConfig>
                                    </ext:Container>
                                </Items>
                            </ext:Column>

                            <ext:Column runat="server" Text="Size" DataIndex="Size" Width="120">
                                <Items>
                                    <ext:Button runat="server" Text="[No Filter]">
                                        <Menu>
                                            <ext:Menu runat="server">
                                                <Defaults>
                                                    <ext:Parameter Name="HideOnClick" Value="false" Mode="Raw" />
                                                    <ext:Parameter Name="CheckHandler" Value="onItemCheck" Mode="Raw" />
                                                </Defaults>
                                                <Items>
                                                    <ext:CheckMenuItem runat="server" Text="extra small" />
                                                    <ext:CheckMenuItem runat="server" Text="small" />
                                                    <ext:CheckMenuItem runat="server" Text="medium" />
                                                    <ext:CheckMenuItem runat="server" Text="large" />
                                                    <ext:CheckMenuItem runat="server" Text="extra large" />
                                                </Items>
                                            </ext:Menu>
                                        </Menu>
                                        <CustomConfig>
                                            <ext:ConfigItem Name="getValue" Value="getSizeValue" Mode="Raw" />
                                        </CustomConfig>
                                    </ext:Button>
                                </Items>
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <Plugins>
                        <ext:FilterHeader runat="server" />
                    </Plugins>
                </ext:GridPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
