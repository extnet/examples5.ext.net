<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Draggable Panel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .invite {
            background-color : #99bbe8 !important;
        }

        .x-drop-marker {
            background-color : silver;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Container
                    runat="server"
                    Region="North"
                    Cls="dropable"
                    Layout="Fit"
                    Height="100"
                    MarginSpec="10 10 5 10" />
                <ext:Container
                    runat="server"
                    Region="East"
                    Cls="dropable"
                    Layout="Fit"
                    Width="200"
                    MarginSpec="5 10 5 10" />
                <ext:Container
                    runat="server"
                    Region="West"
                    Cls="dropable"
                    Layout="Fit"
                    Width="200"
                    MarginSpec="5 10 5 10" />
                <ext:Container
                    runat="server"
                    Region="South"
                    Cls="dropable"
                    Layout="Fit"
                    Height="100"
                    MarginSpec="5 10 10 10" />
                <ext:Container
                    runat="server"
                    Region="Center"
                    Cls="dropable"
                    Layout="Fit"
                    MarginSpec="5 0 5 0">
                    <Items>
                        <ext:Panel runat="server" Title="Drag me" IconCls="x-md md-icon-open-with">
                            <DraggablePanelConfig runat="server" Group="panelDD">
                                <StartDrag handler="Ext.select('.dropable').addCls('x-drop-marker'); this.panelProxy.moveOnDrag = false;" />
                                <EndDrag handler="Ext.select('.dropable').removeCls('x-drop-marker'); Ext.panel.DD.prototype.endDrag.apply(this, arguments);" />
                            </DraggablePanelConfig>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>

        <ext:DropTarget
            runat="server"
            Target="${.dropable}"
            Group="panelDD"
            OverClass="invite">
            <NotifyDrop Handler="var cmp = Ext.getCmp(this.el.dom.id);cmp.add(data.panel);Ext.defer(data.panel.updateLayout, 1, data.panel);" />
            <NotifyOver Handler="Ext.select('.dropable').removeCls('invite'); this.el.addCls('invite');" />
        </ext:DropTarget>
    </form>
</body>
</html>