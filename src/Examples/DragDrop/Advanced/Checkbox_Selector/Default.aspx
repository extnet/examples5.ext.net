<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        for (int i = 0; i < 100; i++)
        {
            this.Panel1.Items.Add(new Checkbox(false));
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Click and Drag to Select Items - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>        
        var startTrack = function () {
	        this.checkboxes = [];
	        var cb;
	        
	        Ext.select(".x-form-item", false).each(function (checkEl) {
	            cb = Ext.getCmp(checkEl.dom.id);
	            cb.setValue(false);
	            this.checkboxes.push(cb);
	        }, this);
        };
        
        dragTrack = function () {
	        var cb, sel;
	        
	        for (var i = 0, l = this.checkboxes.length; i < l; i++) {
	            cb = this.checkboxes[i];	  
	            sel = this.dragRegion.intersect(cb.el.getRegion());
	            
	            if (cb.checked && !sel) {
	                cb.setValue(false);
	            } else if (!cb.checked && sel) {
	                cb.setValue(true);
	            }
	        }
		};
        
        var endTrack = function () {
	        delete this.checkboxes;
		};
    </script>
    
    <style>
        .cb-cell td{
            padding-right  : 10px;
            padding-bottom : 5px;
        }
        
        .black-view-selector {
            position     : absolute;
            left         : 0;
            top          : 0;
            width        : 0;
            background   : black;
            border       : 1px dotted gray;
	        opacity      : .3;
            -moz-opacity :  .3;
            filter       : alpha(opacity=30);
            zoom         : 1;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />         
        
        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Panel runat="server" Region="North" Height="40">
                    <Content>
                        <h3>Click and Drag to Select Items</h3>
                    </Content>
                </ext:Panel>
                
                <ext:Panel 
                    ID="Panel1" 
                    runat="server" 
                    Cls="cb-cell"
                    Region="Center"
                    BodyPadding="10"
                    Layout="TableLayout">
                    <LayoutConfig>
                        <ext:TableLayoutConfig Columns="10" />
                    </LayoutConfig>
                </ext:Panel>
            </Items>
        </ext:Viewport>      
        
        <ext:DragTracker 
            ID="DragTracker1"
            runat="server" 
            ConstrainTo="={#{Panel1}.body}"
            Target="={#{Panel1}.body}"
            ProxyCls="black-view-selector">
            <Listeners>
                <DragStart Fn="startTrack" />
                <Drag      Fn="dragTrack" />
                <DragEnd   Fn="endTrack" />
            </Listeners>
        </ext:DragTracker>
    </form>    
</body>
</html>