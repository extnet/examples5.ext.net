<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Template Widget Rendering - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />    

    <script type="text/javascript">        
        function addTab(tabPanel) {
            var title = Ext.Date.format(new Date(), 'H:i:s'),
                data = [],                
                tab = App.getTab({title: title});

            for ( var i = 0; i < 6; i++ ) {
                data.push({name : Math.floor(Math.random() * 10)});
            }

            tabPanel.add(tab);
            tabPanel.setLastTabAsActive();

            tab.down("dataview").store.loadData(data);
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Template Widget Rendering</h1>          

        <ext:Window runat="server"
            Title="Tabs"
            Width="680"
            Height="500"
            Layout="FitLayout">
            <Items>
                <ext:TabPanel runat="server">
                    <Bin>
                        <ext:UserControlLoader runat="server" Path="Tab.ascx" />
                    </Bin>
                    <TabBar>
                        <ext:Button runat="server"
                            Icon="Add"
                            Flat="true"
                            Handler="addTab(this.up('tabpanel'));" />
                    </TabBar>
                </ext:TabPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
