<%@ Control Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        DataView view = Ext.Net.Utilities.ControlUtils.FindControl<DataView>(this);
        view.Store.Primary.DataSource = new List<object> { 
            new {name = "1"},
            new {name = "2"},
            new {name = "3"},
            new {name = "4"},
            new {name = "5"},
            new {name = "6"}
        };
    }
</script>

<ext:DataView
    runat="server"
    TrackOver="true"
    ItemSelector=".x-newtab-item"
    OverItemCls="x-newtab-over-item">
    <Tpl runat="server">
        <Html>
            <tpl for=".">
                <div class="x-newtab-item">
                    <h1>{name}</h1>
                </div>
            </tpl>
        </Html>        
    </Tpl>
    <Store>
        <ext:Store runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="name" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
    </Store>
</ext:DataView>