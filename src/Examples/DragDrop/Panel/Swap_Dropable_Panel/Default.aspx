<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (Container region in Viewport1.Items)
        {
            Ext.Net.Panel p = (Ext.Net.Panel)region.Items[0];

            p.DraggablePanelConfig = new DragSource
            {
                Group = "panelDD",
                StartDrag = 
                {
                    Fn = "startDrag"
                },
                
                EndDrag =
                {
                    Fn = "endDrag"
                }
            };
        }
    }
</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Draggable Panels within a Viewport - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .invite {
            background-color : #99bbe8 !important;
        }
        
        .x-drop-marker {
            background-color : silver;
        }
    </style>
    <script>
        var notifyDrop = function (source, e, data) {
            var targetCt = Ext.getCmp(this.el.dom.id),
                targetPanel = targetCt.items.get(0),
                sourceCt = data.panel.ownerCt;

            sourceCt.add(targetPanel);
            targetCt.add(data.panel);

            Ext.defer(function () {
                targetPanel.updateLayout();
                data.panel.updateLayout();
            }, 1);            
        };

        var startDrag = function () {            
            Ext.select(".dropable").addCls("x-drop-marker");
            Ext.select(".draggable").hide();
            this.panelProxy.moveOnDrag = false;
        };

        var endDrag = function () {            
            Ext.select(".dropable").removeCls("x-drop-marker");
            Ext.select(".draggable").show();
            Ext.panel.DD.prototype.endDrag.apply(this, arguments);            
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport ID="Viewport1" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Container 
                    runat="server" 
                    Region="North" 
                    Cls="dropable" 
                    Layout="Fit"
                    Height="100" 
                    MarginSpec="10 10 5 10">
                    <Items>
                        <ext:Panel runat="server" Cls="draggable" Title="North" />
                    </Items>
                </ext:Container>
                <ext:Container 
                    runat="server" 
                    Region="East" 
                    Cls="dropable" 
                    Layout="Fit"
                    Width="200" 
                    MarginSpec="5 10 5 10">
                    <Items>
                        <ext:Panel runat="server" Cls="draggable" Title="East" />
                    </Items>
                </ext:Container>
                <ext:Container 
                    runat="server" 
                    Region="West" 
                    Cls="dropable" 
                    Layout="Fit"
                    Width="200" 
                    MarginSpec="5 10 5 10">
                    <Items>
                        <ext:Panel runat="server" Cls="draggable" Title="West" />
                    </Items>
                </ext:Container>
                <ext:Container
                    runat="server" 
                    Region="South" 
                    Cls="dropable" 
                    Layout="Fit"
                    Height="100" 
                    MarginSpec="5 10 10 10">
                    <Items>
                        <ext:Panel runat="server" Cls="draggable" Title="South" />
                    </Items>
                </ext:Container>
                <ext:Container 
                    runat="server" 
                    Region="Center" 
                    Cls="dropable" 
                    Layout="Fit"
                    MarginSpec="5 0 5 0">
                    <Items>
                        <ext:Panel 
                            runat="server" 
                            Cls="draggable" 
                            Title="Center" 
                            BodyPadding="5" 
                            Html="Drag/Drop Panel Headers to a different Viewport Region" />
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>

        <ext:DropTarget 
            runat="server" 
            Target="${.dropable}" 
            Group="panelDD" 
            OverClass="invite">
            <NotifyDrop Fn="notifyDrop" />
            <NotifyOut Handler="this.el.removeCls('invite');" />
            <NotifyOver Handler="Ext.select('.dropable').removeCls('invite'); this.el.addCls('invite');" />
        </ext:DropTarget>
    </form>
</body>
</html>