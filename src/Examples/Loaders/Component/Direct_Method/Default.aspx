<%@ Page Language="C#" %>

<%@ Import Namespace="Panel=Ext.Net.Panel" %>

<script runat="server">
    [DirectMethod]
    public string Items()
    {
        return ComponentLoader.ToConfig(new List<AbstractComponent>() { 
                new Panel { Title="Item 1", Icon = Icon.UserBrown },
                new Panel { Title="Item 2", Icon = Icon.UserGray },
                new Panel { Title="Item 3", Icon = Icon.UserGreen }
            }
        );
    }

    [DirectMethod]
    public static string UserControl()
    {
        return ComponentLoader.ToConfig("~/Examples/Loaders/_Shared/Items.ascx");
    }

    [DirectMethod]
    public static string DynamicUserControl()
    {
        return ComponentLoader.ToConfig("~/Examples/Loaders/_Shared/DynamicItems.ascx");
    }

    [DirectMethod]
    public static string AddTab(string parameters)
    {
        Dictionary<string, string> prms = JSON.Deserialize<Dictionary<string, string>>(parameters);
        
        return ComponentLoader.ToConfig(new Panel { 
            Title = prms["name"], 
            Icon = Icon.TabAdd, 
            Html = "Server time: " + DateTime.Now.ToLongTimeString() 
        });
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Loader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <h1>Component Loader (DirectMethod)</h1>
    
    <ext:ResourceManager runat="server" />    
    
    <ext:Panel
        runat="server"         
        Height="200" 
        Width="350"
        Layout="AccordionLayout"
        Title="Load Items from the Page (DirectMethod, AutoLoad)">
        <Loader 
            runat="server" 
            DirectMethod="#{DirectMethods}.Items"
            Mode="Component">
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"         
        Height="200" 
        Width="500"
        Layout="FitLayout"
        Title="Load UserControl from the Page (static DirectMethod, manual loading)">
        <Loader 
            runat="server" 
            AutoLoad="false"
            DirectMethod="#{DirectMethods}.UserControl" 
            Mode="Component">
            <LoadMask ShowMask="true" />
        </Loader>
        <Buttons>
            <ext:Button runat="server" Text="Load" Icon="PluginGo">
                <Listeners>
                    <Click Handler="this.up('panel').load();this.disable();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"         
        Height="200" 
        Width="500"
        Layout="AccordionLayout"
        Title="Load UserControl from the Page (static DirectMethod, dynamic inner items)">
        <Loader 
            runat="server" 
            DirectMethod="#{DirectMethods}.DynamicUserControl" 
            Mode="Component">
            <LoadMask ShowMask="true" />
        </Loader>        
    </ext:Panel>

    <br />
    <br />

    <p>Load Tab from the Page (persist current items)</p>

    <ext:TabPanel
        runat="server"         
        Height="200" 
        Width="500">
        <Loader 
            runat="server" 
            AutoLoad="false"
            RemoveAll="false"
            DirectMethod="#{DirectMethods}.AddTab" 
            Mode="Component">
            <LoadMask ShowMask="true" />
            <Params>
                <ext:Parameter Name="name" Value="Ext.Date.format(new Date(), 'h:i:s')" Mode="Raw" />
            </Params>
        </Loader>
        <Items>
            <ext:Panel runat="server" Title="Tab 1" />
        </Items>
        <Buttons>
            <ext:Button runat="server" Text="Add Tab" Icon="PluginGo">
                <Listeners>
                    <Click Handler="this.up('panel').load({callback:function () {this.setActiveTab(this.items.getCount()-1)}, scope: this.up('panel')});" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:TabPanel>
</body>
</html>