<%@ Control Language="C#" %>

<ext:Window runat="server"
    Plain="true"
    Width="500"
    Height="140"
    Title="Add Feed"
    IconCls="feed"
    Layout="Fit"
    Resizable="false">
    <Items>
        <ext:FormPanel runat="server"
            BodyPaddingSummary="12 10 10"
            Border="false"
            Unstyled="true">
            <Items>
                <ext:ComboBox runat="server"
                    ItemId="feed"
                    FieldLabel="Enter the URL of the feed to add"
                    LabelAlign="Top"
                    MsgTarget="Under"
                    Anchor="100%">
                    <ListConfig>
                        <ItemTpl>
                            <Html>
                                <div class="feed-picker-url">{field1}</div>
                                <div class="feed-picker-title">{field2}</div>
                            </html>                        </ItemTpl>
                    </ListConfig>
                    <Items>
                        <ext:ListItem Text="CNN Top Stories" Value="http://rss.cnn.com/rss/edition.rss" />
                        <ext:ListItem Text="ESPN Top News" Value="http://sports.espn.go.com/espn/rss/news" />
                        <ext:ListItem Text="Sci/Tech - Google News" Value="http://news.google.com/news?ned=us&topic=t&output=rss" />
                        <ext:ListItem Text="Yahoo Software News" Value="http://rss.news.yahoo.com/rss/software" />
                    </Items>
                </ext:ComboBox>
            </Items>
        </ext:FormPanel>
    </Items>
    <Buttons>
        <ext:Button runat="server" Text="Add Feed">
            <Listeners>
                <Click Fn="FeedViewer.FeedWindow.onAddClick" />
            </Listeners>
        </ext:Button>
        <ext:Button runat="server" Text="Cancel">
            <Listeners>
                <Click Handler="this.up('window').destroy();" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Window>