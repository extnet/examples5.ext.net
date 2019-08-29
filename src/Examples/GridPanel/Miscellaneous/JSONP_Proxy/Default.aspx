<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ScriptTag Proxy - Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-grid-cell-topic b {
            font-family : tahoma, verdana;
            display     : block;
        }
        .x-grid-cell-topic b i {
            font-weight : normal;
            font-style  : normal;
            color       : #000;
        }
        .x-grid-cell-topic .x-grid-cell-inner {
            white-space : normal;
        }
        .x-grid-cell-topic a {
            color : #385F95;
            text-decoration : none;
        }
        .x-grid-cell-topic a:hover {
            text-decoration : underline;
        }

        .x-grid-rowbody div {
            margin : 5px 5px 10px 5px !important;
        }

        .x-grid-row-expanded td.x-grid-cell{
            border-bottom-width:0px;
        }
    </style>

    <script>
        var template = function (value, metadata, record, rowIndex, colIndex, store) {
            return Ext.String.format(
                '<b><a href="http://sencha.com/forum/showthread.php?t={2}" target="_blank">{0}</a></b><a href="http://sencha.com/forum/forumdisplay.php?f={3}" target="_blank">{1} Forum</a>',
                value,
                record.data.forumtitle,
                record.getId(),
                record.data.forumid
            );
        };

        var renderLast = function (value, p, r) {
            return Ext.String.format('{0}<br/>by {1}', Ext.Date.dateFormat(value, 'M j, Y, g:i a'), r.data['lastposter']);
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:GridPanel
        ID="GridPanel1"
        runat="server"
        Width="700"
        Height="500"
        DisableSelection="true"
        Title="ExtJS.com - Browse Forums">
        <Store>
            <ext:Store runat="server" RemoteSort="true" PageSize="50">
                <Proxy>
                    <ext:JsonPProxy Url="http://www.sencha.com/forum/topics-browse-remote.php" SimpleSortMode="true">
                        <Reader>
                            <ext:JsonReader RootProperty="topics" TotalProperty="totalCount" IDProperty="threadid" />
                        </Reader>
                    </ext:JsonPProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="title" />
                            <ext:ModelField Name="forumtitle" />
                            <ext:ModelField Name="forumid" />
                            <ext:ModelField Name="author" />
                            <ext:ModelField Name="replycount" Type="Int" />
                            <ext:ModelField Name="lastpost" Mapping="lastpost" Type="Date" DateFormat="timestamp" />
                            <ext:ModelField Name="lastposter" />
                            <ext:ModelField Name="excerpt" />
                            <ext:ModelField Name="threadid" />
                        </Fields>
                    </ext:Model>
                </Model>
                <Sorters>
                    <ext:DataSorter Property="lastpost" Direction="DESC" />
                </Sorters>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column ID="topic" runat="server" Text="Topic" DataIndex="title" Width="420" Flex="1" Sortable="false">
                    <Renderer Fn="template" />
                </ext:Column>
                <ext:Column runat="server" Text="Author" DataIndex="author" Width="100" Hidden="true" Sortable="true" />
                <ext:Column runat="server" Text="Replies" DataIndex="replycount" Width="70" Align="End" Sortable="true" />
                <ext:Column runat="server" Text="Last Post" DataIndex="lastpost" Width="150" Sortable="true">
                    <Renderer Fn="renderLast" />
                </ext:Column>
            </Columns>
        </ColumnModel>
        <BottomBar>
            <ext:PagingToolbar runat="server" DisplayInfo="true" DisplayMsg="Displaying topics {0} - {1} of {2}" EmptyMsg="No topics to display">
                <Items>
                    <ext:ToolbarSeparator />
                    <ext:Button runat="server" Text="Show Preview" Pressed="true" EnableToggle="true">
                        <Listeners>
                            <Toggle Handler="var view = #{GridPanel1}.view; view.preview = pressed; view.refresh();" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </ext:PagingToolbar>
        </BottomBar>
        <View>
            <ext:GridView runat="server" TrackOver="false" StripeRows="false">
                <GetRowClass Handler="return 'x-grid-row-expanded';" />
            </ext:GridView>
        </View>
        <Features>
            <ext:RowBody ID="Preview1" runat="server">
                <GetAdditionalData Handler="return {rowBodyColspan : this.view.headerCt.getColumnCount(), rowBody : '<div>' + data.excerpt + '</div>', rowBodyCls : this.view.preview !== false ? '' : 'x-hidden'};" />
            </ext:RowBody>
        </Features>
    </ext:GridPanel>
</body>
</html>