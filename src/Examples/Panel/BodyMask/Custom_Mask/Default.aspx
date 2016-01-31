<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <style>      
          div.botright {
            display    : block;
            position   : absolute;
            bottom     : 0;
            right      : 0;
            width      : 105px;
            height     : 105px;
            border     : 1px solid #ddd;
            background : #eee;
          }
    </style> 
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Demonstrates how to show custom load mask while frame loading.</h1>

        <p>The animation will be shown at the right bottom corner of page</p>
                
        <ext:Window 
            ID="Window1" 
            runat="server" 
            Width="500" 
            Height="470" 
            Icon="Link"
            Title="Frame Loader" 
            Closable="false">
            <Loader runat="server" Url="http://ext.net" Mode="Frame">
                <Listeners>
                    <BeforeLoad Handler="Ext.get('maskDiv').removeCls('x-hidden-display');" />
                    <Load Handler="Ext.get('maskDiv').addCls('x-hidden-display');" />
                </Listeners>
            </Loader>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Load Ext.NET forums">
                            <Listeners>
                                <Click Handler="#{Window1}.load('http://forums.ext.net');" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button runat="server" Text="Refresh" Icon="ArrowRotateClockwise">
                            <Listeners>
                                <Click Handler="#{Window1}.reload();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Window>
        
        <div id="maskDiv" class="botright x-hidden-display">     
            <img src="loading.gif" />
        </div>
    </form>
</body>
</html>
