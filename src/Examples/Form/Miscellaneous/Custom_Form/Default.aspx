<%@ Page Language="C#" %>

<script runat="server">
    public class SearchField : TextField
    {
        public override string InstanceOf
        {
            get
            {
                return "Ext.net.SearchField";
            }
        }

        public override string XType
        {
            get
            {
                return "searchfield";
            }
        }

        public override ConfigOptionsCollection ConfigOptions
        {
            get
            {
                ConfigOptionsCollection list = base.ConfigOptions;
                list.Add("storeID", new ConfigOption("storeID", new SerializationOptions("store", JsonMode.ToClientID), "", this.StoreID));

                return list;
            }
        }

        /// <summary>
        /// The data store to use.
        /// </summary>
        [ConfigOption("store", JsonMode.ToClientID)]
        [System.ComponentModel.DefaultValue("")]
        public virtual string StoreID
        {
            get
            {
                return this.State.Get<string>("StoreID", "");
            }
            set
            {
                this.State.Set("StoreID", value);
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        SearchField field = new SearchField
        {
            Width = 400,
            FieldLabel = "Search",
            LabelWidth = 50,
            StoreID = "PostStore1"
        };

        TopToolbar1.Items.Add(field);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom Form Fields - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="styles.css" rel="stylesheet" />
    <script src="SearchField.js"></script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Form Fields</h1>
        <p>
            Ext.Net provides many types of form fields to build interactive and rich forms. However, it also
            provides a complete framework for building new types of fields quickly. The search field below
            is an example.
        </p>

        <ext:Panel
            runat="server"
            Title="Forum Search"
            Cls="search-results"
            Height="500"
            Width="960"
            Layout="Fit">
            <Items>
                <ext:DataView
                    runat="server"
                    OverflowY="Auto"
                    ItemSelector="div.search-item"
                    EmptyText="<div class='x-grid-empty'>No Matching Threads</div>">
                    <Tpl runat="server">
                        <Html>
                            <tpl for=".">
                                <div class="search-item">
                                    <h3><span>{lastPost:this.formatDate}<br>by {author}</span>
                                    <a href="https://www.sencha.com/forum/showthread.php?t={topicId}&p={postId}" target="_blank">{title}</a></h3>
                                    <p>{excerpt}</p>
                                </div>
                            </tpl>
                        </Html>
                        <Functions>
                            <ext:JFunction Name="formatDate" Handler="return Ext.Date.format(value, 'M j, Y');" Args="value" />
                        </Functions>
                    </Tpl>
                    <Store>
                        <ext:Store ID="PostStore1" runat="server" PageSize="25">
                            <Model>
                                <ext:Model runat="server" IDProperty="post_id">
                                    <Fields>
                                        <ext:ModelField Name="postId" Mapping="post_id" />
                                        <ext:ModelField Name="title" Mapping="topic_title" />
                                        <ext:ModelField Name="topicId" Mapping="topic_id" />
                                        <ext:ModelField Name="author" Mapping="author" />
                                        <ext:ModelField
                                            Name="lastPost"
                                            Mapping="post_time"
                                            Type="Date"
                                            DateFormat="timestamp"
                                            />
                                        <ext:ModelField Name="excerpt" Mapping="post_text" />
                                    </Fields>
                                </ext:Model>
                            </Model>

                            <Proxy>
                                <ext:JsonPProxy Url="https://www.sencha.com/forum/topics-remote.php">
                                    <Reader>
                                        <ext:JsonReader RootProperty="topics" TotalProperty="totalCount" />
                                    </Reader>
                                </ext:JsonPProxy>
                            </Proxy>
                        </ext:Store>
                    </Store>
                </ext:DataView>
            </Items>

            <DockedItems>
                <ext:Toolbar
                    ID="TopToolbar1"
                    runat="server"
                    Dock="Top">
                </ext:Toolbar>

                <ext:PagingToolbar
                    runat="server"
                    Dock="Bottom"
                    StoreID="PostStore1"
                    DisplayMsg="Topics {0} - {1} of {2}"
                    EmptyMsg="No topics to display"
                    />
            </DockedItems>
        </ext:Panel>
    </form>
</body>
</html>
