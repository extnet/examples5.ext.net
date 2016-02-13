<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic"%>

<script runat="server">
    private int NewIndex
    {
        get
        {
            return (int) (Session["newIndex"] ?? 1);
        }
        set
        {
            Session["newIndex"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            string path = Server.MapPath("../../../DataView/Shared/images/touch-icons");
            string[] files = System.IO.Directory.GetFiles(path);

            List<object> data = new List<object>(files.Length);

            foreach (string fileName in files)
            {
                System.IO.FileInfo fi = new System.IO.FileInfo(fileName);

                data.Add(new
                {
                    name = fi.Name,
                    url = "../../../DataView/Shared/images/touch-icons/" + fi.Name
                });
            }

            this.Store1.DataSource = data;
            this.Store1.DataBind();
        }
    }

    protected void NewAlbumClick(object sender, DirectEventArgs e)
    {
        TreePanel1.GetRootNode().AppendChild(new Node
        {
            NodeID = (++NewIndex).ToString(),
            CustomAttributes =
            {
                new ConfigItem("name", "Album " + NewIndex, ParameterMode.Value)
            },
            IconCls = "album-btn",
            AllowDrag = false,
            EmptyChildren = true
        });
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Organizing Images into Albums</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="resources/organizer.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Organizing Images into Albums</h1>
        <p>This example shows demonstrates how you can drop anything into the tree.</p>
        <p>This example also shows how a customized DragZone can be
        applied to a JsonView to get automatic lightweight drag and drop of asynchronously loaded data.</p>
        <p>The multi image drag drop added a little complexity to the code, but hopefully it is still easy to follow.</p>
        <p>For simplicity, there is no validation on the names you enter in the tree node editor and you can drag the same picture
        into an album as many times as you want.</p>
        <p>Hold shift/control to select multiple images in the main images view. You can drag those images into the tree.</p>

        <ext:Panel
            runat="server"
            Width="700"
            Height="490"
            Layout="BorderLayout">
            <Items>
                <ext:TreePanel
                    ID="TreePanel1"
                    runat="server"
                    Region="West"
                    Width="200"
                    Padding="5"
                    Title="My Albums"
                    RootVisible="false"
                    DisplayField="name">

                    <View>
                        <ext:TreeView runat="server">
                            <Plugins>
                                <ext:TreeViewDragDrop runat="server" DDGroup="organizerDD" />
                            </Plugins>
                        </ext:TreeView>
                    </View>

                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" Text="New Album" IconCls="album-btn">
                                    <DirectEvents>
                                        <Click OnEvent="NewAlbumClick" />
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>

                    <Store>
                        <ext:TreeStore runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="name" />
                                    </Fields>
                                </ext:Model>
                            </Model>

                            <Root>
                                <ext:Node NodeID="root" Expanded="true" AllowDrop="false">
                                    <Children>
                                        <ext:Node
                                            AllowDrag="false"
                                            EmptyChildren="true"
                                            IconCls="album-btn">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="name" Value="Album 1" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Root>
                        </ext:TreeStore>
                    </Store>

                    <Editor>
                        <ext:TextField
                            runat="server"
                            AllowBlank="false"
                            BlankText="A name is required"
                            SelectOnFocus="true" />
                    </Editor>

                    <Plugins>
                        <ext:CellEditing runat="server" />
                    </Plugins>
                </ext:TreePanel>

                <ext:Panel
                    runat="server"
                    Region="Center"
                    Title="My Images"
                    Layout="FitLayout"
                    PaddingSpec="5 5 5 0">
                    <Items>
                        <ext:DataView
                            ID="ImageView"
                            runat="server"
                            TrackOver="true"
                            Cls="x-image-view"
                            AutoScroll="true"
                            ItemSelector="div.thumb-wrap"
                            MultiSelect="true"
                            SingleSelect="false">
                            <Tpl runat="server">
                                <Html>
                                    <tpl for=".">
                                        <div class="thumb-wrap">
                                            <div class="thumb">
                                                 <tpl if="!Ext.isIE6">
                                                    <img src="{url}" />
                                                </tpl>
                                                <tpl if="Ext.isIE6">
                                                    <div style="width:76px;height:76px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\"{url}\")"></div>
                                                </tpl>
                                            </div>
                                            <span>{name}</span>
                                        </div>
                                    </tpl>
                                </Html>
                            </Tpl>
                            <Store>
                                <ext:Store ID="Store1" runat="server">
                                    <Model>
                                        <ext:Model runat="server" IDProperty="name">
                                            <Fields>
                                                <ext:ModelField Name="name" />
                                                <ext:ModelField Name="url" />
                                                <ext:ModelField Name="leaf" DefaultValue="true" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>

                            <Plugins>
                                <ext:DataViewDragSelector runat="server" />
                                <ext:DataViewDraggable runat="server">
                                    <DDConfig runat="server" Group="organizerDD" />
                                    <GhostTpl runat="server">
                                        <Html>
                                            <tpl for=".">
                                                <img src="{url}" />
                                                <tpl if="xindex % 4 == 0"><br /></tpl>
                                            </tpl>
                                            <div class="count">
                                                {[values.length]} images selected
                                            <div>
                                        </Html>
                                    </GhostTpl>
                                </ext:DataViewDraggable>
                            </Plugins>
                        </ext:DataView>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>