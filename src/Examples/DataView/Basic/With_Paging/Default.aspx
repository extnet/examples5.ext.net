<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>


<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string path = Server.MapPath("../../Shared/images/thumbs");
        string[] files = System.IO.Directory.GetFiles(path);

        List<object> data = new List<object>(files.Length);

        foreach (string fileName in files)
        {
            System.IO.FileInfo fi = new System.IO.FileInfo(fileName);
            data.Add(new { name = fi.Name,
                           url = "../../Shared/images/thumbs/" + fi.Name,
                           size = fi.Length,
                           lastmod = fi.LastAccessTime });
        }

        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DataView with Paging - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <ext:XScript runat="server">
        <script>
            var prepareData = function (data) {
                data.shortName = Ext.util.Format.ellipsis(data.name, 15);
                data.sizeString = Ext.util.Format.fileSize(data.size);
                data.dateString = Ext.Date.format(data.lastmod, "m/d/Y g:i a");

                return data;
            };

            var selectionChanged = function (dv,nodes) {
                var l = nodes.length,
                    s = l != 1 ? 's' : '';

                #{ImagePanel}.setTitle('Simple DataView (' + l + ' item' + s + ' selected)');
            };
        </script>
    </ext:XScript>

    <style>
        .images-view .x-panel-body {
            background: white;
            font: 11px Arial, Helvetica, sans-serif;
        }
        .images-view .thumb {
            background: #dddddd;
            padding: 3px;
        }
        .images-view .thumb img {
            height: 60px;
            width: 80px;
        }
        .images-view .thumb-wrap {
            float: left;
            margin: 4px;
            margin-right: 0;
            padding: 5px;
            text-align:center;
        }
        .images-view .thumb-wrap span {
            display: block;
            overflow: hidden;
            text-align: center;
        }

        .images-view .x-view-over {
            border:1px solid #dddddd;
            background: #efefef url(../../Shared/images/row-over.gif) repeat-x left top;
            padding: 4px;
        }

        .images-view .x-item-selected {
            background: #eff5fb url(../../Shared/images/selected.gif) no-repeat right bottom;
            border:1px solid #99bbe8;
            padding: 4px;
        }
        .images-view .x-item-selected .thumb {
            background:transparent;
        }

        .images-view .loading-indicator {
            font-size:11px;
            background-image :url(../../Shared/images/loading.gif);
            background-repeat: no-repeat;
            background-position: left;
            padding-left:20px;
            margin:10px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DataView Example with paging</h1>

        <ext:Panel
            runat="server"
            ID="ImagePanel"
            Cls="images-view"
            Frame="true"
            Width="535"
            Collapsible="true"
            Title="Simple DataView (0 items selected)">
            <Items>
                <ext:DataView
                    runat="server"
                    MultiSelect="true"
                    OverItemCls="x-view-over"
                    TrackOver="true"
                    ItemSelector="div.thumb-wrap"
                    EmptyText="No images to display">
                    <Store>
                        <ext:Store ID="Store1" runat="server" PageSize="5">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="name" />
                                        <ext:ModelField Name="url" />
                                        <ext:ModelField Name="size" Type="Int" />
                                        <ext:ModelField Name="lastmod" Type="Date" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Tpl runat="server">
                        <Html>
                            <tpl for=".">
                                <div class="thumb-wrap" id="{name}">
                                    <div class="thumb"><img src="{url}" title="{name}"></div>
                                    <span class="x-editable">{shortName}</span>
                                </div>
                            </tpl>
                            <div class="x-clear"></div>
                        </html>                    </Tpl>
                    <PrepareData Fn="prepareData" />
                    <Listeners>
                        <SelectionChange Fn="selectionChanged" />
                    </Listeners>
                </ext:DataView>
            </Items>
            <BottomBar>
                <ext:PagingToolbar runat="server" StoreID="Store1" HideRefresh="true" />
            </BottomBar>
        </ext:Panel>
    </form>
</body>
</html>