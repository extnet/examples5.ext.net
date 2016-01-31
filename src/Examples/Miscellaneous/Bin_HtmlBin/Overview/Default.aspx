<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
  
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<object> data = new List<object>
        {
            new {Text = "Text 1", Value = 1},
            new {Text = "Text 2", Value = 2},
            new {Text = "Text 3", Value = 3}
        };
 
        this.Store1.DataSource = data;
        this.Store2.DataSource = data;

        this.Store1.DataBind();
        this.Store2.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Bin and HtmlBin Overview - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Bin and HtmlBin Overview</h1>
        
        <p>The Bin and HtmlBin features helps a developer to organize the things modularly.</p>
        
        <p>The Bin is a collection for Ext.NET controls.</p>
        
        <p>The main difference between Bin and Items:</p>

        <br/>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;- The Bin controls are not rendered (client side to DOM) automatically;</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;- The Bin controls don't participate in the layout logic.</p>
        <br/>
        
        <p>The HtmlBin is for raw HTML.<p>
       
        <ext:FormPanel 
            ID="FormPanel1" 
            runat="server" 
            Height="350" 
            Width="350" 
            Title="Form"
            Layout="VBoxLayout">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Bin>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Text" />
                                <ext:ModelField Name="Value" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
                 
                <ext:Store ID="Store2" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Text" />
                                <ext:ModelField Name="Value" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
                 
                <ext:Menu ID="Menu1" runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Item from Menu1" Icon="Application" />
                    </Items>
                </ext:Menu>
                 
                <ext:Menu ID="Menu2" runat="server">
                    <Items>
                        <ext:MenuItem runat="server" Text="Item from Menu2" Icon="Note" />
                    </Items>
                </ext:Menu>
            </Bin>
             
            <Items>
                <ext:ComboBox 
                    runat="server"
                    FieldLabel="ComboBox1"
                    StoreID="Store1"
                    DisplayField="Text"
                    ValueField="Value"
                    TriggerAction="All"
                    QueryMode="Local" />               
                 
                <ext:ComboBox 
                    runat="server"
                    FieldLabel="ComboBox2"
                    StoreID="Store2"
                    DisplayField="Text"
                    ValueField="Value"
                    TriggerAction="All"
                    QueryMode="Local" />
                 
                <ext:Panel 
                    runat="server"
                    Title="Menu Area 1 - Click right button"
                    Flex="1"
                    ContextMenuID="Menu1" />               
                 
                <ext:Panel 
                    runat="server"
                    Title="Menu Area 2 - Click right button"
                    Flex="1"
                    ContextMenuID="Menu2" />  
            </Items>
             
            <Buttons>
                <ext:Button runat="server" Text="Get Store1" OnClientClick="getStore1();" />
                <ext:Button runat="server" Text="Get Store2" OnClientClick="getStore2();" />
                <ext:Button runat="server" Text="Show Menu1" OnClientClick="showMenu1(e);" />
                <ext:Button runat="server" Text="Show Menu2" OnClientClick="showMenu2(e);" />
            </Buttons>
            <HtmlBin>
                <ext:XScript runat="server">
                    <script>
                        var getStore1 = function () {
                             alert(#{FormPanel1}.getBinComponent(0));   
                        };

                        var getStore2 = function () {
                             alert(#{FormPanel1}.getBinComponent(1));   
                        };

                        var showMenu1 = function (e) {
                            #{FormPanel1}.getBinComponent("Menu1").showAt(e.getXY());
                        };

                        var showMenu2 = function (e) {
                            #{Menu2}.showAt(e.getXY());
                        };
                    </script>
                </ext:XScript>
            </HtmlBin>
        </ext:FormPanel>
    </form>    
</body>
</html>