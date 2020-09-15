<%@ Control Language="C#"  %>

<script runat="server">
    private List<object> GetImages(string path)
    {
        path = "../../Shared/images/" + path + "/";
        string serverPath = Server.MapPath(path);
        string[] files = System.IO.Directory.GetFiles(serverPath);

        List<object> data = new List<object>(files.Length);

        foreach (string fileName in files)
        {
            System.IO.FileInfo fi = new System.IO.FileInfo(fileName);
            long size = fi.Length;
            string strSize = size < 1024 ? size + " bytes" : (Math.Round(((size * 10.0) / 1024)) / 10) + " KB";
            data.Add(new
            {
                name = fi.Name,
                url = path + fi.Name,
                sizeString = strSize,
                size = size
            });
        }

        return data;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.DataSource = this.GetImages("touch-icons");
    }
</script>


<ext:DataView
    runat="server"
    SingleSelect="true"
    Cls="img-chooser-view"
    OverItemCls="x-view-over"
    ItemSelector="div.thumb-wrap">
    <Store>
        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="name" />
                        <ext:ModelField Name="url" />      
                        <ext:ModelField Name="sizeString" />
                        <ext:ModelField Name="size" Type="Int" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>      
    </Store>
    <Tpl runat="server">
        <Html>
            <tpl for=".">
                <div class="thumb-wrap">
                    <div class="thumb">
                        <tpl if="!Ext.isIE6">
                            <img src="{url}" />
                        </tpl>
                        <tpl if="Ext.isIE6">
                            <div style="width:74px;height:74px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{url}")"></div>
                        </tpl>                    
                    </div>
                    <span>{name}</span>
                </div>
            </tpl>
        </html>    </Tpl>
    <Listeners>
        <SelectionChange Handler="if(selected[0]) {App.ImgDetailPanel.loadRecord(selected[0])}" />
        <ItemDblClick Handler="App.ImgChooserDlg.down('button[text=OK]').fireEvent('click');" />
    </Listeners>
</ext:DataView>