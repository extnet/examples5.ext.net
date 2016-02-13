<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling with remote filtering - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var renderTopic = function (value, p, record) {
            return Ext.String.format(
                '<a href="http://sencha.com/forum/showthread.php?p={1}" target="_blank">{0}</a>',
                value,
                record.getId()
            );
        };

        var searchFieldTriggerClick = function (field, trigger, index) {
            var me = field,
                store = me.up("grid").getStore(),
                value = me.getValue();

            if(index == 0) {
                me.setValue('');
                store.clearFilter();
                trigger.hide();
            }
            else{
                if (value.length > 0) {
                    // Param name is ignored here since we use custom encoding in the proxy.
                    // id is used by the Store to replace any previous filter
                    store.filter({
                        id: store.proxy.filterParam,
                        property: store.proxy.filterParam,
                        value: value
                    });
                    me.getTrigger(0).show();
                }
            }
        };

        var onSpecialKey = function (field, e) {
             if (e.getKey() === e.ENTER) {
                searchFieldTriggerClick(field, null, 1);
                e.stopEvent();
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Infinite Scrolling with remote filtering</h1>

        <p>Introduced with Ext.Net 2, the Infinite Scrolling support for GridPanels enables you to load any number of records into a grid without paging.</p>
        <p>This grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        <p>A filtering UI is included which applies a remote filter and reloads the grid beginning at page one.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Width="700"
            Height="500"
            Collapsible="true"
            Title="Sencha.com - Browse Forums">
            <Store>
                <ext:Store
                    runat="server"
                    Buffered="true"
                    RemoteFilter="true"
                    LeadingBufferZone="1000"
                    PageSize="50">
                    <Proxy>
                        <ext:JsonPProxy
                            Url="http://www.sencha.com/forum/topics-remote.php"
                            SimpleSortMode="true"
                            FilterParam="query">
                            <Reader>
                                <ext:JsonReader RootProperty="topics" TotalProperty="totalCount" />
                            </Reader>
                            <CustomConfig>
                                <ext:ConfigItem
                                    Name="encodeFilters"
                                    Value="function (filters) { return filters[0].getValue(); }"
                                    Mode="Raw" />
                            </CustomConfig>
                        </ext:JsonPProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="post_id">
                            <Fields>
                                <ext:ModelField Name="title" Mapping="topic_title" />
                                <ext:ModelField Name="forumtitle" Mapping="forum_title" />
                                <ext:ModelField Name="forumid" Type="Int" />
                                <ext:ModelField Name="username" Mapping="author" />
                                <ext:ModelField Name="replycount" Mapping="reply_count" Type="Int" />
                                <ext:ModelField Name="lastpost" Mapping="post_time" Type="Date" DateFormat="timestamp" />
                                <ext:ModelField Name="lastposter" />
                                <ext:ModelField Name="excerpt" />
                                <ext:ModelField Name="topic_id" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Listeners>
                        <TotalCountChange Handler="#{GridPanel1}.down('#status').update({ count: this.getTotalCount() });" />
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="50" />
                    <ext:Column
                        runat="server"
                        Text="Topic"
                        DataIndex="title"
                        Flex="1">
                        <Renderer Fn="renderTopic" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Author"
                        DataIndex="username"
                        Hidden="true"
                        Sortable="false" />
                    <ext:Column
                        runat="server"
                        Text="Replies"
                        DataIndex="replycount"
                        Width="70"
                        Align="Center"
                        Sortable="false" />
                    <ext:Column
                        runat="server"
                        Text="Last Post"
                        DataIndex="lastpost"
                        Width="130"
                        Sortable="false">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i A'" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" TrackOver="false" EmptyText="<h1 style='margin:20px;'>No matching results</h1>" />
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" PruneRemoved="false" Mode="Multi" />
            </SelectionModel>
            <DockedItems>
                <ext:Toolbar runat="server" Dock="Top">
                    <Items>
                        <ext:TextField
                            runat="server"
                            Width="400"
                            FieldLabel="Search"
                            LabelWidth="50">
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" Hidden="true" />
                                <ext:FieldTrigger Icon="Search" />
                            </Triggers>
                            <Listeners>
                                <TriggerClick Fn="searchFieldTriggerClick" />
                                <SpecialKey Fn="onSpecialKey" />
                            </Listeners>
                        </ext:TextField>

                        <ext:ToolbarFill />

                        <ext:Component
                            runat="server"
                            ItemID="status"
                            StyleSpec="margin-right:5px;">
                            <Tpl runat="server">
                                <Html>
                                    Matching threads: {count}
                                </Html>
                            </Tpl>
                        </ext:Component>
                    </Items>
                </ext:Toolbar>
            </DockedItems>
        </ext:GridPanel>
    </form>
</body>
</html>