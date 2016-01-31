<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Cell Editing - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var addPlant = function (btn) {
            // Create a model instance
            var r = Ext.create('Plant', {
                    common: 'New Plant 1',
                    light: 'Mostly Shady',
                    price: 0,
                    availability: Ext.Date.clearTime(new Date()),
                    indoor: false
                }),
                grid = btn.up("gridpanel");

            grid.store.insert(0, r);
            Ext.Function.defer(function() {
                grid.editingPlugin.startEditByPosition({row: 0, column: 0});
            }, 100);
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>Cell Editing Grid Example</h1>

    <p>This example shows how to enable users to edit the contents of a grid.</p>

    <ext:GridPanel 
        runat="server" 
        Width="600" 
        Height="300" 
        Title="Edit Plants?" 
        Frame="true">
        <Store>
            <ext:Store runat="server">
                <Proxy>
                    <ext:AjaxProxy runat="server" Url="../../Shared/Plants.xml">
                        <Reader>
                            <ext:XmlReader Record="plant" />
                        </Reader>
                    </ext:AjaxProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server" Name="Plant">
                        <Fields>
                            <ext:ModelField Name="common" Type="String" />
                            <ext:ModelField Name="botanical" Type="String" />
                            <ext:ModelField Name="light" />
                            <ext:ModelField Name="price" Type="Float" />
                            <ext:ModelField Name="availability" Type="Date" DateFormat="MM/dd/yyyy" />
                            <ext:ModelField Name="indoor" Type="Boolean" />
                        </Fields>
                    </ext:Model>
                </Model>
                <Listeners>
                    <Load Handler="Ext.Msg.show({
                                        title: 'Store Load Callback',
                                        msg: 'store was loaded, data available for processing',
                                        modal: false,
                                        icon: Ext.Msg.INFO,
                                        buttons: Ext.Msg.OK
                                    });" Single="true" />
                </Listeners>
            </ext:Store>
        </Store>
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Button runat="server" Text="Add Plant" Handler="addPlant" />
                </Items>
            </ext:Toolbar>
        </TopBar>
        <ColumnModel runat="server">
		    <Columns>
                <ext:Column 
                    runat="server" 
                    Text="Common Name" 
                    DataIndex="common" 
                    Flex="1">
                    <Editor>
                        <ext:TextField runat="server" AllowBlank="false" />
                    </Editor>
                </ext:Column>

                <ext:Column 
                    runat="server" 
                    Text="Light" 
                    DataIndex="light" 
                    Width="130">
                    <Editor>
                        <ext:ComboBox runat="server"
                            TypeAhead="true"
                            SelectOnTab="true">
                            <Items>
                                <ext:ListItem Text="Shade" />
                                <ext:ListItem Text="Mostly Shady" />
                                <ext:ListItem Text="Sun or Shade" />
                                <ext:ListItem Text="Mostly Sunny" />
                                <ext:ListItem Text="Sunny" />
                            </Items>
                        </ext:ComboBox>
                    </Editor>
                </ext:Column>

                <ext:Column 
                    runat="server" 
                    Text="Price" 
                    DataIndex="price" 
                    Width="70" 
                    Align="right">
                    <Renderer Format="UsMoney" />
                    <Editor>
                        <ext:NumberField runat="server" AllowBlank="false" MinValue="0" MaxValue="100000">
                        </ext:NumberField>
                    </Editor>
                </ext:Column>

                <ext:DateColumn 
                    runat="server" 
                    Text="Available" 
                    DataIndex="availability" 
                    Width="95" 
                    Format="MMM dd, yyyy">
                    <Editor>
                        <ext:DateField runat="server" 
                            Format="yyyy-MM-dd" 
                            MinDate="01.01.2006" 
                            DisabledDays="0,6"
                            DisabledDaysText="Plants are not available on the weekends">
                        </ext:DateField>
                    </Editor>
                </ext:DateColumn>

                <ext:CheckColumn 
                    runat="server" 
                    Text="Indoor?" 
                    DataIndex="indoor"
                    StopSelection="false"
                    Editable="true"
                    Width="55" />

                <ext:ImageCommandColumn runat="server" Width="30" Sortable="false">
                    <Commands>
                        <ext:ImageCommand Icon="Decline" ToolTip-Text="Delete Plant" CommandName="delete">                            
                        </ext:ImageCommand>
                    </Commands>
                    <Listeners>
                        <Command Handler="this.up('gridpanel').store.removeAt(recordIndex);" />
                    </Listeners>
                </ext:ImageCommandColumn>
		    </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:CellSelectionModel runat="server" />
        </SelectionModel>
        <Plugins>
            <ext:CellEditing runat="server" ClicksToEdit="1" />
        </Plugins>
    </ext:GridPanel>
</body>
</html>