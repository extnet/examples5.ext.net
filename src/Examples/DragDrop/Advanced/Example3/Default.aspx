<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        PatientStore.DataSource = new List<object>
        {
            new { InsuranceCode="11111", Name="Fred Bloggs", Address="Main Street", Telephone="555 1234 123" },
            new { InsuranceCode="22222", Name="Fred West", Address="Cromwell Street", Telephone="666 666 666" },
            new { InsuranceCode="33333", Name="Fred Mercury", Address="Over The Rainbow", Telephone="555 321 0987" },
            new { InsuranceCode="44444", Name="Fred Forsyth", Address="Blimp Street", Telephone="555 111 2222" },
            new { InsuranceCode="55555", Name="Fred Douglass", Address="Talbot County, Maryland", Telephone="N/A" }
        };

        HospitalStore.DataSource = new List<object>
        {
            new { Code="AAAAA", Name="Saint Thomas", Address="Westminster Bridge Road, SE1 7EH", Telephone="020 7188 7188" },
            new { Code="BBBBB", Name="Queen's Medical Centre", Address="Derby Road, NG7 2UH", Telephone="0115 924 9924" },
            new { Code="CCCCC", Name="Saint Bartholomew", Address="West Smithfield, EC1A 7BE", Telephone="020 7377 7000" },
            new { Code="DDDDD", Name="Royal London", Address="Whitechapel, E1 1BB", Telephone="020 7377 7000" }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag&amp;Drop - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .app-header .x-panel-body {
            background-color: #ddd;
            padding-left: 5px;
        }

        .app-header h1 {
            font-family: verdana,arial,sans-serif;
            font-size: 20px;
            color: #15428B;
        }

        .hospital-target {
            border: 1px solid red;
            margin: 5px;
            padding: 5px;
            font-size: small;
            cursor: default;
        }

            .hospital-target.hospital-target-hover {
                background-color: #C0C0C0;
            }

        .patient-source {
            cursor: pointer;
        }

        .patient-view table {
            border-collapse: separate;
            border-spacing: 2px;
        }

        .patient-view td {
            font-family: verdana,arial,sans-serif;
            font-size: 12px;
        }

        td.patient-label {
            background-color: #ddd;
            border: 1px solid #bbb;
            font-weight: bold;
            text-align: right;
            width: 100px;
            padding: 0px 3px 0px 0px;
        }

        .patient-over {
            background-color: #EFEFEF;
            cursor: pointer;
        }

        .patient-selected {
            background-color: #DFE8F6;
            cursor: pointer;
        }
    </style>

    <script>
        /*
         * Here is where we "activate" the DataView.
         * We have decided that each node with the class "patient-source" encapsulates a single draggable
         * object.
         *
         * So we inject code into the DragZone which, when passed a mousedown event, interrogates
         * the event to see if it was within an element with the class "patient-source". If so, we
         * return non-null drag data.
         *
         * Returning non-null drag data indicates that the mousedown event has begun a dragging process.
         * The data must contain a property called "ddel" which is a DOM element which provides an image
         * of the data being dragged. The actual node clicked on is not dragged, a proxy element is dragged.
         * We can insert any other data into the data object, and this will be used by a cooperating DropZone
         * to perform the drop operation.
         */


        //      On receipt of a mousedown event, see if it is within a draggable element.
        //      Return a drag data object if so. The data object can contain arbitrary application
        //      data, but it should also contain a DOM element in the ddel property to provide
        //      a proxy to drag.
        var getDragData = function (e) {
            var view = App.PatientView,
                sourceEl = e.getTarget(view.itemSelector, 10);

            if (sourceEl) {
                d = sourceEl.cloneNode(true);
                d.id = Ext.id();

                return (view.dragData = {
                    sourceEl: sourceEl,
                    repairXY: Ext.fly(sourceEl).getXY(),
                    ddel: d,
                    patientData: view.getRecord(sourceEl).data
                });
            }
        };

        //      Provide coordinates for the proxy to slide back to on failed drag.
        //      This is the original XY coordinates of the draggable element.
        var getRepairXY = function () {
            return this.dragData.repairXY;
        };




        /*
         * Here is where we "activate" the GridPanel.
         * We have decided that the element with class "hospital-target" is the element which can receieve
         * drop gestures. So we inject a method "getTargetFromEvent" into the DropZone. This is constantly called
         * while the mouse is moving over the DropZone, and it returns the target DOM element if it detects that
         * the mouse if over an element which can receieve drop gestures.
         *
         * Once the DropZone has been informed by getTargetFromEvent that it is over a target, it will then
         * call several "onNodeXXXX" methods at various points. These include:
         *
         * onNodeEnter
         * onNodeOut
         * onNodeOver
         * onNodeDrop
         *
         * We provide implementations of each of these to provide behaviour for these events.
         */


        //      If the mouse is over a target node, return that node. This is
        //      provided as the "target" parameter in all "onNodeXXXX" node event handling functions
        var getTargetFromEvent = function (e) {
            return e.getTarget(".hospital-target");
        };


        //      On entry into a target node, highlight that node.
        var onNodeEnter = function (target, dd, e, data) {
            Ext.fly(target).addCls("hospital-target-hover");
        };


        //      On exit from a target node, unhighlight that node.
        var onNodeOut = function (target, dd, e, data) {
            Ext.fly(target).removeCls("hospital-target-hover");
        };


        //      While over a target node, return the default drop allowed class which
        //      places a "tick" icon into the drag proxy.
        var onNodeOver = function (target, dd, e, data) {
            return Ext.dd.DropZone.prototype.dropAllowed;
        };


        //      On node drop, we can interrogate the target node to find the underlying
        //      application object that is the real target of the dragged data.
        //      In this case, it is a Record in the GridPanel's Store.
        //      We can use the data set up by the DragZone's getDragData method to read
        //      any data we decided to attach.
        var onNodeDrop = function (target, dd, e, data) {
            var rowBody = Ext.fly(target).findParent('.x-grid-rowbody-tr', null, false),
                mainRow = rowBody.previousSibling,
                h = App.HospitalGrid.getView().getRecord(mainRow),
                targetEl = Ext.get(target),
                html = targetEl.dom.innerHTML;

            if (html == 'Drop Patient Here') {
                html = data.patientData.Name;
            } else {
                html = data.patientData.Name + ', ' + targetEl.dom.innerHTML;
            }

            targetEl.update(html);
            Ext.Msg.alert('Drop gesture', 'Dropped patient ' + data.patientData.Name +
                ' on hospital ' + h.data.Name);
            return true;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:Container
                    runat="server"
                    Cls="app-header"
                    Height="30"
                    Region="North"
                    Html="<h1>Patient Hospital Assignment</h1>"
                    MarginSpec="5" />

                <ext:Panel
                    runat="server"
                    Title="Patients"
                    Width="300"
                    Region="West"
                    MarginSpec="0 5 5 5">
                    <Items>
                        <ext:DataView
                            ID="PatientView"
                            runat="server"
                            Cls="patient-view"
                            OverItemCls="patient-over"
                            SelectedItemCls="patient-selected"
                            SimpleSelect="true"
                            ItemSelector="div.patient-source">
                            <Store>
                                <ext:Store ID="PatientStore" runat="server">
                                    <Model>
                                        <ext:Model runat="server" IDProperty="InsuranceCode">
                                            <Fields>
                                                <ext:ModelField Name="Name" />
                                                <ext:ModelField Name="Address" />
                                                <ext:ModelField Name="Telephone" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <Tpl runat="server">
                                <Html>
                                    <tpl for=".">
                                        <div class="patient-source">
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td class="patient-label">Name</td>
                                                        <td class="patient-name">{Name}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="patient-label">Address</td>
                                                        <td class="patient-name">{Address}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="patient-label">Telephone</td>
                                                        <td class="patient-name">{Telephone}</td>
                                                    </tr>
                                                </tbody>
                                             </table>
                                         </div>
                                     </tpl>
                                </html>                            </Tpl>
                        </ext:DataView>
                    </Items>
                </ext:Panel>

                <ext:GridPanel
                    ID="HospitalGrid"
                    runat="server"
                    Title="Hospitals"
                    Region="Center"
                    MarginSpec="0 5 5 0">
                    <Store>
                        <ext:Store ID="HospitalStore" runat="server">
                            <Model>
                                <ext:Model runat="server" IDProperty="Code">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Address" />
                                        <ext:ModelField Name="Telephone" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel>
                        <Columns>
                            <ext:Column runat="server" DataIndex="Name" Text="NAME" Width="200" />
                            <ext:Column runat="server" DataIndex="Address" Text="Address" Width="300" />
                            <ext:Column runat="server" DataIndex="Telephone" Text="Telephone" Width="100" />
                        </Columns>
                    </ColumnModel>
                    <Features>
                        <ext:RowBody runat="server" RowBodyDivCls="hospital-target">
                            <GetAdditionalData
                                Handler="return {rowBody: 'Drop Patient Here', rowBodyDivCls:'hospital-target'};" />
                        </ext:RowBody>
                    </Features>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>

        <ext:DragZone runat="server" Target="={#{PatientView}.getEl()}">
            <GetDragData Fn="getDragData" />
            <GetRepairXY Fn="getRepairXY" />
        </ext:DragZone>

        <ext:DropZone runat="server" Target="={#{HospitalGrid}.getView().el}">
            <GetTargetFromEvent Fn="getTargetFromEvent" />
            <OnNodeEnter Fn="onNodeEnter" />
            <OnNodeOut Fn="onNodeOut" />
            <OnNodeOver Fn="onNodeOver" />
            <OnNodeDrop Fn="onNodeDrop" />
        </ext:DropZone>
    </form>
</body>
</html>