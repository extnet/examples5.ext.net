<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Fixed Height TabPanel with options - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <div>
            <h1>Fixed Height TabPanel with options</h1>
            <p>Tabs with no tab strip and a fixed height that scroll the content.</p>
        </div>

        <div>
            <ext:TabPanel
                ID="TabPanel1"
                runat="server"
                ActiveTabIndex="0"
                Width="960"
                Height="250"
                Plain="true">
                <Items>
                    <ext:Panel
                        ID="Tab1"
                        runat="server"
                        Title="Normal Tab"
                        Html="My content was added with the Html Property."
                        BodyPadding="18"
                        Scrollable="Both"
                        />
                    <ext:Panel
                        ID="Tab2"
                        runat="server"
                        Title="Closable Tab"
                        Html="You can close this Tab."
                        BodyPadding="18"
                        Closable="true"
                        />
                    <ext:Panel
                        ID="Tab3"
                        runat="server"
                        Title="Ajax Tab"
                        BodyPadding="18"
                        Scrollable="Both">
                        <Loader runat="server" Url="ajax.aspx">
                            <LoadMask ShowMask="true" />
                        </Loader>
                    </ext:Panel>
                    <ext:Panel
                        ID="Tab4"
                        runat="server"
                        Title="Event Tab"
                        Html="I am tab 3's content. I also have an event listener attached."
                        BodyPadding="18"
                        Scrollable="Both">
                        <Listeners>
                            <Activate Handler="Ext.Msg.alert('Event', this.title + ' was activated.');" Delay="1" />
                        </Listeners>
                    </ext:Panel>
                    <ext:Panel
                        ID="Tab5"
                        runat="server"
                        Title="Disabled Tab"
                        Disabled="true"
                        Html="Can't see me cause I'm disabled"
                        Scrollable="Both"
                        />
                </Items>
            </ext:TabPanel>
        </div>
    </form>
</body>
</html>
