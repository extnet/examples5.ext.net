<%@ Control Language="C#" %>

<ext:GridPanel runat="server"
    Cls="feed-grid">
    <Store>
        <ext:Store runat="server" AutoLoad="false">
            <Model>
                <ext:Model runat="server" Name="FeedItem">
                    <Fields>
                        <ext:ModelField Name="title" />
                        <ext:ModelField Name="author" />
                        <ext:ModelField Name="pubDate">
                            <Convert Handler="return Ext.Date.parse(value.substring(0, value.length - 4), 'D, d M Y H:i') ||
                                                     Ext.Date.parse(value.substring(0, value.length - 4), 'D, d M Y H:i:s') ||
                                                     Ext.Date.parse(value, 'D, d M Y H:i:s O');" />
                        </ext:ModelField>
                        <ext:ModelField Name="link" />
                        <ext:ModelField Name="description">
                            <MappingFunction Fn="function(raw) {
                                                    var DQ = Ext.dom.Query,
                                                        content = DQ.selectNode('content', raw),
                                                        key;

                                                    if (content && DQ.getNodeValue(content)) {
                                                        key = 'description';
                                                    } else {
                                                        key = 'title';
                                                    }
                                                    return DQ.selectValue(key, raw);

                                                }" />
                        </ext:ModelField>
                        <ext:ModelField Name="content">
                            <MappingFunction Fn="function(raw) {
                                                    var DQ = Ext.dom.Query,
                                                        content = DQ.selectNode('content', raw);

                                                    if (!content || !DQ.getNodeValue(content)) {
                                                        content = DQ.selectNode('description', raw);
                                                    }
                                                    return DQ.getNodeValue(content, '');
                                                }" />
                        </ext:ModelField>
                    </Fields>                    
                </ext:Model>
            </Model>

            <Proxy>
                <ext:AjaxProxy Url="~/Examples/Combination_Samples/Applications/Feed_Viewer/FeedProxy.ashx">
                    <Reader>
                        <ext:XmlReader Record="item" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>

            <Sorters>
                <ext:DataSorter Property="pubDate" Direction="DESC" />
            </Sorters>
        </ext:Store>
    </Store>

    <Listeners>
        <Render Handler="this.store.on('load', function () {if(this.store.getCount()>0) {this.getSelectionModel().select(0);}}, this); FeedViewer.FeedGrid.loadFeed(this, this.up().up().url);" />
        <SelectionChange Handler="var post = this.up('[cls=feed-detail]').down('[cls=preview]'), active = selected[0]; if(active) {post.active = active; post.update(active.data);}" />
    </Listeners>

    <View>
        <ext:GridView runat="server">
            <Plugins>
                <ext:Preview runat="server" PluginId="preview" BodyField="description" />
            </Plugins>
            <Listeners>
                <ItemDblClick Handler="FeedViewer.FeedInfo.tabOpen(record);" />
            </Listeners>
        </ext:GridView>
    </View>

    <ColumnModel>
        <Columns>
            <ext:Column runat="server" Text="Title" DataIndex="title" Flex="1">
                <Renderer Handler="return Ext.String.format('<div class=\'topic\'><b>{0}</b><span class=\'author\'>{1}</span></div>', value, record.get('author') || 'Unknown');" />
            </ext:Column>
            <ext:Column runat="server" Text="Author" DataIndex="author" Hidden="true" Width="200" />
            <ext:Column runat="server" Text="Date" DataIndex="pubDate" Width="200">
                <Renderer Fn="FeedViewer.FeedGrid.formatDate" />
            </ext:Column>
        </Columns>
    </ColumnModel>
</ext:GridPanel>