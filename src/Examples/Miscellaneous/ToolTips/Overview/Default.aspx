<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ToolTips - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .tip-target {
            width      : 185px;
            text-align : center;
            padding    : 5px 0;
            border     : 1px dotted #99bbe8;
            background : #dfe8f6;
            color  : #15428b;
            cursor : default;
            margin : 10px;
            font   : bold 11px tahoma,arial,sans-serif;
            float  : left;
        }

        #content-anchor-tip ul {
            float : left;
            width : 200px;
            list-style-type : disc;
            margin-left     : 15px;
        }

        .ext-ie #content-anchor-tip ul {
            margin : 0;
            padding-left : 15px;
        }

        #content-anchor-tip .thumb {
            float : right;
        }

        #content-anchor-tip .status-icon {
            position : absolute;
            top      : 4px;
            right    : 50px;
            padding  : 0;
            line-height : 0;
        }

        #content-anchor-tip a:link, #content-anchor-tip a:visited {
            color : #339;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ToolTip Examples</h1>

        <div id="tip1" class="tip-target">Basic ToolTip</div>

        <ext:ToolTip runat="server" Target="tip1" Html="A very simple tooltip" />


        <div id="tip2" class="tip-target">AutoHide Disabled</div>

        <ext:ToolTip
            runat="server"
            Target="tip2"
            Html="Click the X to close me"
            Title="My Tip Title"
            AutoHide="false"
            Closable="true"
            Draggable="true"
            />


        <div id="ajax-tip" class="tip-target">Ajax ToolTip</div>

        <ext:ToolTip
            runat="server"
            Target="ajax-tip"
            Width="200"
            DismissDelay="15000">
            <Loader Url="ajax-tip.html">
                <LoadMask ShowMask="true" />
            </Loader>
        </ext:ToolTip>


        <div id="track-tip" class="tip-target">Track Mouse</div>

        <ext:ToolTip
            runat="server"
            Target="track-tip"
            Html="This tip will follow the mouse while it is over the element"
            Title="Mouse Track"
            Width="200"
            TrackMouse="true"
            />

        <div id="tip4" class="tip-target" data-qtip="My QuickTip">QuickTip</div>

        <div class="x-clear"></div>

        <h3>Callout Tip</h3>

        <div id="leftCallout" class="tip-target" style="width: 185px;">Anchor Right, Rich Content</div>

        <ext:ToolTip
            ID="ContentAnchorTip"
            runat="server"
            Target="leftCallout"
            Title="<a href='#'>Rich Content Tooltip</a>"
            Anchor="left"
            Width="200"
            AutoHide="false"
            Closable="true">
            <Content>
                <div id="content-tip">
                    <ul>
                        <li>5 bedrooms</li>
                        <li>2 bathrooms</li>
                        <li>Large backyard</li>
                        <li>Close to transport</li>
                    </ul>
                    <div class="x-clear"></div>
                    <img src="images/house.jpg" alt="Website Thumbnail" style="margin:1px solid grey;padding:1px;height:100px;" />
                </div>
            </Content>
            <Listeners>
                <Render Handler="this.header.on('click', function (e) { Ext.EventObject.stopEvent(); Ext.Msg.alert('Link', 'Link to something interesting.');App.ContentAnchorTip.hide(); }, this, {delegate:'a'});" />
            </Listeners>
         </ext:ToolTip>


        <div id="bottomCallout" class="tip-target" style="width: 185px;">Anchor Below</div>

        <ext:ToolTip
            runat="server"
            Target="bottomCallout"
            Anchor="top"
            AnchorOffset="85"
            Html="This tip's anchor is centered"
            />

        <div id="trackCallout" class="tip-target" style="width: 185px;">Anchor with Tracking</div>

        <ext:ToolTip
            runat="server"
            Target="trackCallout"
            Anchor="right"
            TrackMouse="true"
            Html="Tracking while you move the mouse"
            />
    </form>
</body>
</html>
