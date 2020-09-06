<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Locking Buffer Rendered TreeGrid Example - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var renderTitle = function (value, p, record) {
            return value ? Ext.String.format(
                '<a href="http://sencha.com/forum/showthread.php?t={1}" target="_blank">{0}</a>',
                value,
                record.data.threadid
            ) : '';
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>
            Locking Buffer Rendered TreeGrid Example
        </h1>
        <p>
             Tree with buffered rendering of nodes so that extremely large trees can be rendered.
        </p>
        <p>
            At least since Ext.NET 4 (ExtJS 6), the <b>BufferedRenderer</b> feature is enabled by default in all Tree Panels (like any grid panel) and can be disabled with the <b>BufferedRenderer="false"</b> setting in the panel.
        </p>

        <ext:TreePanel
            runat="server"
            Title="Forum Folder Summary"
            Width="960"
            Height="480"
            Collapsible="true"
            UseArrows="true"
            RootVisible="false"
            BufferedRenderer="true"
            Animate="false">
            <Store>
                <ext:TreeStore runat="server" LazyFill="true">
                     <Model>
                         <ext:Model runat="server" IDProperty="postid">
                             <Fields>
                                 <ext:ModelField Name="title" NullConvert="true" />
                                 <ext:ModelField Name="threadid" NullConvert="true" />
                                 <ext:ModelField Name="username" NullConvert="true" />
                                 <ext:ModelField Name="userid" NullConvert="true" />
                                 <ext:ModelField Name="dateline" Type="Date" DateFormat="timestamp" />
                                 <ext:ModelField Name="postid" NullConvert="true" />
                                 <ext:ModelField Name="forumtitle" NullConvert="true" />
                                 <ext:ModelField Name="forumid" NullConvert="true" />
                                 <ext:ModelField Name="replycount" Type="Int" />
                                 <ext:ModelField Name="lastpost" Type="Date" DateFormat="timestamp" />
                                 <ext:ModelField Name="excerpt" NullConvert="true" />
                             </Fields>
                         </ext:Model>
                    </Model>
                    <Proxy>
                        <ext:AjaxProxy Url="forum-data.json">
                            <Reader>
                                <ext:JsonReader />
                            </Reader>
                        </ext:AjaxProxy>
                    </Proxy>
                </ext:TreeStore>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:TreeColumn runat="server" Text="Forum" Width="275" DataIndex="forumtitle" Locked="true" />
                    <ext:Column runat="server" Text="User" Width="120" DataIndex="username" />
                    <ext:Column runat="server" Text="Title" Width="480" DataIndex="title">
                        <Renderer Fn="renderTitle" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
        </ext:TreePanel>
    </form>
</body>
</html>