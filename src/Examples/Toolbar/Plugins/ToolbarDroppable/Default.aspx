<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.ResourceManager1.RegisterIcon(Icon.MoneyAdd);
            this.ResourceManager1.RegisterIcon(Icon.MoneyDelete);

            this.Store1.DataSource = new object[] {
                new object[] {1,  "3m Co",71.72,0.02,0.03,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {2,  "Alcoa",29.01,0.42,1.47,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {3,  "Altria Group",83.81,-0.28,0.34,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {4,  "American Express",52.55,0.01,0.02,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {5,  "Microsoft",25.84,-0.14,0.54,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {6,  "Pfizer Inc",27.96,-0.4,1.45,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {7,  "Coca-Cola",45.07,0.26,0.58,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {8,  "Home Depot.",34.64,0.35,1.02,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {9,  "Procter & Gamble",61.91,0.01,0.02,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {10, "United Technologies",63.26,-0.55,0.88,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {11, "Verizon Communications",35.57,0.39,1.11,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")},
                new object[] {12, "Wal-Mart Stores",45.45,-0.73,1.63,DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt")}
            };

            this.Store1.DataBind();
        }
    }

    protected void ToolbarItemCreate(object sender, ToolbarItemCreateEventArgs e)
    {
        string company = e.ExtraParams["company"];
        double change = double.Parse(e.ExtraParams["change"], System.Globalization.CultureInfo.GetCultureInfo("en-US"));

        e.Item = new Ext.Net.Button
        {
            Text = company,
            Icon = change > 0 ? Icon.MoneyAdd : Icon.MoneyDelete,
            CustomConfig = {
                new ConfigItem("reorderable", "true", ParameterMode.Raw)
            },
            Handler = string.Format("function () {{alert({0});}}", JSON.Serialize(company))
        };

        System.Threading.Thread.Sleep(2000);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Droppable Toolbars - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var createItem = function (data) {
            var record = data.draggedRecord;

            return new Ext.Button({
                text   : record.get('company'),
                iconCls : record.get('change') > 0 ? 'icon-moneyadd' : 'icon-moneydelete',
                reorderable : true,
                handler : function () {alert(record.get('company'));}
            });
        };

        var getDragData = function (e) {
            var view = App.DataView1,
                sourceEl = e.getTarget(view.itemSelector, 10);

            if (sourceEl) {
                d = sourceEl.cloneNode(true);
                d.id = Ext.id();

                return {
                    ddel: d,
                    sourceEl: sourceEl,
                    repairXY: Ext.fly(sourceEl).getXY(),
                    sourceStore: view.store,
                    draggedRecord: view.getRecord(sourceEl)
                };
            }
        };
    </script>

    <style>
        .company {
          float   : left;
          width   : 179px;
          height  : 55px;
          margin  : 5px;
          padding : 5px;
          cursor  : pointer;
        }

        .company h3 {
          font-weight : bold !important;
          margin      : 0px;
        }

        .company .up {
            color : green;
        }

        .company .down {
            color : red;
        }

        .company.x-view-selected {
            background-color : #efefef;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <h1>Droppable Toolbars</h1>

        <p>This example sets up a dataview with some draggable items which can be dropped onto the toolbar.</p>
        <p>The toolbar is configured with the Ext.ux.ToolbarDroppable plugin and a Ext.ux.ToolbarReorderer plugin.</p>


        <ext:Panel
            runat="server"
            Width="960"
            Height="480"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server" EnableOverflow="true">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Drag items here (local mode):" />
                    </Items>
                    <Plugins>
                        <ext:ToolbarDroppable runat="server">
                            <CreateItem Fn="createItem" />
                        </ext:ToolbarDroppable>

                        <ext:BoxReorderer runat="server" />
                    </Plugins>
                </ext:Toolbar>
            </TopBar>

            <Items>
                <ext:DataView
                    ID="DataView1"
                    runat="server"
                    EmptyText="No items to display"
                    SingleSelect="true"
                    Scrollable="Both"
                    OverItemCls="x-view-over"
                    ItemSelector="div.company">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="id" />
                                        <ext:ModelField Name="company" />
                                        <ext:ModelField Name="price" Type="Float" />
                                        <ext:ModelField Name="change" Type="Float" />
                                        <ext:ModelField Name="pctChange" Type="Float" />
                                        <ext:ModelField Name="lastChange" Type="Date" DateFormat="yyyy-MM-dd hh:mm:tt" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Tpl runat="server">
                        <Html>
                            <tpl for=".">
                                <div class="company">
                                    <h3>{company}</h3>
                                    <p class="{[values.change > 0 ? "up" : "down"]}">{[values.change > 0 ? "Up" : "Down"]} {pctChange} since {lastChange:date("d/m/Y")}</p>
                                </div>
                            </tpl>
                        </Html>
                    </Tpl>
                </ext:DataView>
            </Items>

            <BottomBar>
                 <ext:Toolbar runat="server" EnableOverflow="true">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Drag items here (remote mode):" />
                    </Items>
                    <Plugins>
                        <ext:ToolbarDroppable runat="server" Remote="true" OnItemCreate="ToolbarItemCreate">
                            <Listeners>
                                <BeforeRemoteCreate Handler="remoteOptions.company = dragSource.dragData.draggedRecord.get('company');remoteOptions.change = dragSource.dragData.draggedRecord.get('change');" />
                                <RemoteCreate Handler="if (message) { alert(message); }" />
                            </Listeners>
                        </ext:ToolbarDroppable>

                        <ext:BoxReorderer runat="server" />
                    </Plugins>
                </ext:Toolbar>
            </BottomBar>
        </ext:Panel>

        <ext:DragZone runat="server" Target="App.DataView1.getEl()">
            <GetDragData Fn="getDragData" />
            <GetRepairXY Handler="return this.dragData.repairXY;" />
        </ext:DragZone>
    </form>
</body>
</html>