<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
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
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        foreach (SelectedRow row in ImageView.SelectedRows)
        {
            sb.AppendFormat("RecordID: {0}&nbsp;&nbsp;&nbsp;&nbsp;Row index: {1}<br/>", row.RecordID, row.RowIndex);
        }

        this.Label1.Html = sb.ToString();
    }

    protected void Clear_Click(object sender, DirectEventArgs e)
    {
        ImageView.DeselectAll();
    }

    protected void Add_Click(object sender, DirectEventArgs e)
    {
        ImageView.Select(new ModelProxy[] { ImageView.GetStore().GetById("zack.jpg") }, true);
    }

    protected void SubmitSelection(object sender, DirectEventArgs e)
    {
        string json = e.ExtraParams["Values"];

        Dictionary<string, string>[] images = JSON.Deserialize<Dictionary<string, string>[]>(json);

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' cellspacing='15'>");
        bool addHeader = true;

        foreach (Dictionary<string, string> row in images)
        {
            if (addHeader)
            {
                sb.Append("<tr>");
                foreach (KeyValuePair<string, string> keyValuePair in row)
                {
                    sb.Append("<td style='white-space:nowrap;font-weight:bold;'>");

                    sb.Append(keyValuePair.Key);

                    sb.Append("</td>");
                }
                sb.Append("</tr>");

                addHeader = false;
            }

            sb.Append("<tr>");

            foreach (KeyValuePair<string, string> keyValuePair in row)
            {
                sb.Append("<td style='white-space:nowrap;'>");

                sb.Append(keyValuePair.Value);

                sb.Append("</td>");
            }

            sb.Append("</tr>");
        }
        sb.Append("</table>");
        this.Label1.Html = sb.ToString();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DataView Overview - Ext.Net Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="data-view.css" rel="stylesheet" />

    <ext:XScript runat="server">
        <script>
            var prepareData = function (data) {
                data.shortName = Ext.util.Format.ellipsis(data.name, 15);
                data.sizeString = Ext.util.Format.fileSize(data.size);
                data.dateString = Ext.Date.format(data.lastmod, "m/d/Y g:i a");

                return data;
            };

            var selectionChanged = function (selModel, selected) {
                var l = selected.length, s = l != 1 ? 's' : '';
                #{Panel1}.setTitle('Simple DataView (' + l + ' item' + s + ' selected)');
            };
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DataView Example</h1>

        <p>This example shows how to use an Ext.view.View.  It demonstrates editable labels (click<br />
        any of the photo labels), basic multi-select (using ctrl or shift) and drag selection.</p>

        <ext:Store ID="Store1" runat="server" >
            <Model>
                <ext:Model runat="server" IDProperty="name">
                    <Fields>
                        <ext:ModelField Name="name" />
                        <ext:ModelField Name="url" />
                        <ext:ModelField Name="size" Type="Int" />
                        <ext:ModelField Name="lastmod" Type="Date" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:Panel
            ID="Panel1"
            runat="server"
            Cls="images-view"
            Frame="true"
            Width="800"
            Collapsible="true"
            Layout="FitLayout"
            Title="Simple DataView (0 items selected)">
            <Items>
                <ext:DataView
                    ID="ImageView"
                    runat="server"
                    StoreID="Store1"
                    MultiSelect="true"
                    OverItemCls="x-item-over"
                    ItemSelector="div.thumb-wrap"
                    EmptyText="No images to display"
                    TrackOver="true">
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

                    <Plugins>
                        <ext:DataViewDragSelector runat="server" />
                        <ext:DataViewLabelEditor runat="server" DataIndex="name" />
                    </Plugins>
                </ext:DataView>
            </Items>

            <Buttons>
                <ext:Button runat="server" Text="Submit selected">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" />
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="Submit selected with values">
                    <DirectEvents>
                        <Click
                            OnEvent="SubmitSelection">
                            <ExtraParams>
                                <ext:Parameter
                                    Name="Values"
                                    Value="#{ImageView}.getRowsValues({ selectedOnly : true })"
                                    Mode="Raw"
                                    Encode="true" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="Clear Selection">
                    <DirectEvents>
                        <Click OnEvent="Clear_Click" />
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="Add 'Zack' to selection ">
                    <DirectEvents>
                        <Click OnEvent="Add_Click" />
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Panel>

        <div style="width:788px; border:1px solid gray; padding:5px;">
            <ext:Label ID="Label1" runat="server" />
        </div>
    </form>
</body>
</html>