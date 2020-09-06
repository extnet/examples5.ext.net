<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var renderTopic = function (value, p, record) {
            return Ext.String.format(
                '<a href="http://sencha.com/forum/showthread.php?t={2}" target="_blank">{0}</a>',
                value,
                record.data.forumtitle,
                record.getId(),
                record.data.forumid
            );
        };

        var groupchange = function (store, groupers) {
            var sortable = !store.isGrouped(),
                grid = App.GridPanel1,
                headers = grid.headerCt.getVisibleGridColumns(),
                i,
                len = headers.length;

            for (i = 0; i < len; i++) {
                headers[i].sortable = (headers[i].sortable !== undefined) ? headers[i].sortable : sortable;
            }
        };

        // This particular service cannot sort on more than one field, so if grouped, disable sorting
        var beforeprefetch = function (store, operation) {
            if (operation.groupers && operation.groupers.length) {
                delete operation.sorters;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Infinite Scrolling</h1>

        <p>Introduced with Ext.Net 2, the Infinite Scrolling support for GridPanels enables you to load any number of records into a grid without paging.</p>
        <p>This grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        <p>The number of rendered rows is only just larger than the visible row count. As the edge of the rendered data scrolls towards being in
        view, the table is refreshed, and repositioned to maintain visual scroll position.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Width="720"
            Height="500"
            Title="Sencha.com - Browse Forums">
            <Store>
                <ext:Store
                    runat="server"
                    RemoteSort="true"
                    Buffered="true"
                    RemoteGroup="true"
                    LeadingBufferZone="300"
                    PageSize="100">
                    <Proxy>
                        <ext:JsonPProxy
                            Url="http://www.sencha.com/forum/remote_topics/index.php"
                            SimpleSortMode="true"
                            SimpleGroupMode="true"
                            GroupParam="sort"
                            GroupDirectionParam="dir">
                            <Reader>
                                <ext:JsonReader RootProperty="topics" TotalProperty="totalCount" />
                            </Reader>
                        </ext:JsonPProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="threadid">
                            <Fields>
                                <ext:ModelField Name="title" />
                                <ext:ModelField Name="forumtitle" />
                                <ext:ModelField Name="forumid" />
                                <ext:ModelField Name="author" />
                                <ext:ModelField Name="replycount" Type="Int" />
                                <ext:ModelField Name="lastpost" Type="Date" DateFormat="timestamp" />
                                <ext:ModelField Name="lastposter" />
                                <ext:ModelField Name="excerpt" />
                                <ext:ModelField Name="threadid" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="threadid" Direction="ASC" />
                    </Sorters>
                    <Listeners>
                        <GroupChange Fn="groupchange" />
                        <BeforePrefetch Fn="beforeprefetch" />
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
                        DataIndex="author"
                        Hidden="true" />
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
                        Groupable="false">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i A'" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" TrackOver="false" />
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" PruneRemoved="false" Mode="Multi" />
            </SelectionModel>
            <Features>
                <ext:Grouping runat="server" HideGroupedHeader="false" />
            </Features>
        </ext:GridPanel>
    </form>
</body>
</html>