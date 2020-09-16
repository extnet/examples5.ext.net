<%@ Page Language="C#" %>

<%@ Register Src="~/Examples/DragDrop/Basic/Dom/HtmlMarkup.ascx" TagPrefix="uc" TagName="HtmlMarkup" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop with DOM Elements - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="styles.css" rel="stylesheet" />

    <script>
        Ext.ns("App").ddOverrides = {
            // Called the instant the element is dragged.
            startDrag: function () {
                // Cache the drag "phantom" element
                if (!this.dEl) {
                    this.dEl = Ext.get(this.getDragEl());
                }

                // Cache the original element
                if (!this.el) {
                    this.el = Ext.get(this.getEl());
                }

                // Make the original icon less visible to indicate it is really about to be moved
                this.el.applyStyles({ opacity: 0.4 });

                this.dEl.applyStyles({
                    border: "",
                    // Trim the sides to 8 pixels to have it match the icons
                    width: (this.el.getWidth() - 8) + "px",
                    height: (this.el.getHeight() - 8) + "px",
                    "z-index": 2000
                });

                // Create an exact copy of the element on the cursor
                this.dEl.update(this.el.dom.innerHTML);

                // adding this class is the trick to have drop areas to work
                // If you just avoid this and then use this.el.dom.outerHTML above, the mouse will
                // be always above the div and will never trigger an dropEnter event.
                this.dEl.addCls(this.el.dom.className);

                this.lastTarget = null;
            },

            // Called when the drag operation completes
            endDrag: function () {
                // Create the animation configuration object
                var animCfgObj = {
                    easing: 'ease',
                    duration: 500,
                    opacity: 1,
                    scope: this,
                };

                // Invoke the animation according to the drop success/failure
                if (this.lastTarget == null) {
                    // After dragging, remove transparency effect of moved element.
                    this.el.animate(animCfgObj);
                } else {
                    // Remove the drop invitation
                    this.el.removeCls('dropOK');

                    // Get exact position where the drag-dropped item were released
                    var destXY = this.dEl.getXY();

                    animCfgObj.callback = function () {
                        // Remove the position attribute
                        this.el.dom.style.position = '';

                        // Finally, add the item to the target div
                        Ext.get(this.lastTarget).appendChild(this.el);
                    };

                    // animate icon to where the mouse dropped it
                    this.el.setXY([destXY[0], destXY[1]], animCfgObj);
                }
            },

            // Only called when the drag element is dragged over the a drop target with the same ddgroup
            onDragEnter: function (evtObj, targetElId) {
                var vehicleAllowed = true;

                // Determine if currently selected car type is allowed in the drop area
                if ((this.el.id.indexOf("truck") == 0 && targetElId == "cars") ||
                    (this.el.id.indexOf("car") == 0 && targetElId == "trucks")) {
                    vehicleAllowed = false;
                };

                // Colorize the drag target if the drag node's parent is not the same as the drop target
                // and is valid for the car type
                if (targetElId != this.el.dom.parentNode.id && vehicleAllowed) {
                    this.el.addCls('dropOK');
                    this.dEl.addCls('dropOK');
                    this.lastTarget = Ext.get(targetElId);
                } else {
                    // Remove the invitation
                    this.onDragOut();
                    this.lastTarget = null;
                }
            },

            // Only called when element is dragged out of a dropzone with the same ddgroup
            onDragOut: function (evtObj, targetElId) {
                this.el.removeCls('dropOK');
                this.dEl.removeCls('dropOK');
                this.lastTarget = null;
            }
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <uc:HtmlMarkup runat="server" />

    <%-- Set as drag zones on every item inside both the cars and trucks divs --%>
    <ext:DDProxy
        runat="server"
        Target="${#cars div}"
        Group="carsDDGroup"
        IsTarget="false">
        <StartDrag Fn="App.ddOverrides.startDrag" />
        <EndDrag Fn="App.ddOverrides.endDrag" />
        <OnDragEnter Fn="App.ddOverrides.onDragEnter" />
        <OnDragOut Fn="App.ddOverrides.onDragOut" />
    </ext:DDProxy>

    <ext:DDProxy
        runat="server"
        Target="${#trucks div}"
        Group="carsDDGroup"
        IsTarget="false">
        <StartDrag Fn="App.ddOverrides.startDrag" />
        <EndDrag Fn="App.ddOverrides.endDrag" />
        <OnDragEnter Fn="App.ddOverrides.onDragEnter" />
        <OnDragOut Fn="App.ddOverrides.onDragOut" />
    </ext:DDProxy>

    <%-- Set as drop zones both 'rented' and 'repair' divs --%>
    <ext:DropZone runat="server" Target="rented" Group="carsDDGroup" />
    <ext:DropZone runat="server" Target="repair" Group="carsDDGroup" />

    <%-- Set drop zones on cars and trucks divs (they're specially treated to allow correct items back) --%>
    <ext:DropZone runat="server" Target="cars" Group="carsDDGroup" />
    <ext:DropZone runat="server" Target="trucks" Group="carsDDGroup" />
</body>
</html>