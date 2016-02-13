<%@ Page Language="C#" %>

<script runat="server">
    public const string Template = "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio.";

    protected void CreateCallout(object sender, DirectEventArgs e)
    {
        X.Msg.Callout(this.Panel1, new Callout {
            Html = "The callout will be hidden and destroyed in 5 seconds",
            Alignment = AnchorPoint.RightTop,
            DismissDelay=5000,
            CloseAction = CloseAction.Destroy,
            Height = 120,
            Width = 100
        }).Show(true);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Callout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        h3.x-callout-header {
            /* to deactivate h3 rule from resources/css/examples.css */
            font-family: inherit;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Callout</h1>

    <h2>Anchor</h2>

    <ext:Panel
        runat="server"
        Frame="true"
        Header="false"
        Width="610"
        BodyPadding="10"
        Layout="ColumnLayout">
        <Defaults>
            <ext:Parameter Name="Margin" Value="20" />
            <ext:Parameter Name="Width" Value="150" />
            <ext:Parameter Name="Html" Value="<%# Template %>" AutoDataBind="true" />
        </Defaults>
        <Items>
            <ext:Callout runat="server" Title="TopLeft" Alignment="TopLeft" />
            <ext:Callout runat="server" Title="Top" Alignment="Top" />
            <ext:Callout runat="server" Title="TopRight" Alignment="TopRight" />

            <ext:Callout runat="server" Title="RightTop" Alignment="RightTop" />
            <ext:Callout runat="server" Title="Right" Alignment="Right" />
            <ext:Callout runat="server" Title="RightBottom" Alignment="RightBottom" />

            <ext:Callout runat="server" Title="BottomLeft" Alignment="BottomLeft" />
            <ext:Callout runat="server" Title="Bottom" Alignment="Bottom" />
            <ext:Callout runat="server" Title="BottomRight" Alignment="BottomRight" />

            <ext:Callout runat="server" Title="LeftTop" Alignment="LeftTop" />
            <ext:Callout runat="server" Title="Left" Alignment="Left" />
            <ext:Callout runat="server" Title="LeftBottom" Alignment="LeftBottom" />
        </Items>
    </ext:Panel>

    <br />
    <br />

    <h2>Toolbar and Widget</h2>

    <ext:Button runat="server" Text="Click">
        <Callouts>
            <ext:Callout runat="server" Title="Header" Icon="Comment" BodyStyle="padding:1px;">
                <HeaderToolbar>
                    <ext:Toolbar runat="server" Flat="true">
                        <Items>
                            <ext:Button
                                runat="server"
                                Icon="Decline"
                                ToolTip="Close"
                                Handler="this.up('toolbar').callout.hide();"
                                />
                        </Items>
                    </ext:Toolbar>
                </HeaderToolbar>

                <BodyWidget>
                    <ext:Container
                        runat="server"
                        Layout="AccordionLayout"
                        Width="300"
                        Height="150">
                        <Items>
                            <ext:Panel runat="server" Title="Section1" Html="Content" />
                            <ext:Panel runat="server" Title="Section2" Html="Content" />
                            <ext:Panel runat="server" Title="Section3" Html="Content" />
                        </Items>
                    </ext:Container>
                </BodyWidget>
            </ext:Callout>
        </Callouts>
    </ext:Button>

    <br />
    <br />

    <h2>Trigger</h2>

    <ext:Panel
        runat="server"
        Frame="true"
        Header="false"
        Width="610"
        AutoDataBind="true"
        Layout="HBoxLayout">
        <Defaults>
            <ext:Parameter Name="Margin" Value="10" />
        </Defaults>
        <Items>
            <ext:Button runat="server" Text="Show on Click">
                <Callouts>
                    <ext:Callout runat="server" Html="<%# Template %>" Width="150" />
                </Callouts>
            </ext:Button>

            <ext:Button runat="server" Text="Show on Hover">
                <Callouts>
                    <ext:Callout runat="server" Html="<%# Template %>" Width="150" Trigger="Hover" />
                </Callouts>
            </ext:Button>

            <ext:Button runat="server" Text="Manual" Handler="this.callouts[0].toggle();">
                <Callouts>
                    <ext:Callout runat="server" Html="<%# Template %>" Width="150" Trigger="Manual" />
                </Callouts>
            </ext:Button>

            <ext:TextField runat="server" AllowBlank="false" MsgTarget="None" Note="Show on Focus">
                <Callouts>
                    <ext:Callout runat="server" Title="Errors" Width="150" Trigger="Focus">
                        <Listeners>
                            <BeforeShow Handler="var errors = this.calloutOwner.getErrors(); if (errors.length == 0) {return false;} this.setHtml(errors.join('<br/>'));" />
                        </Listeners>
                    </ext:Callout>
                </Callouts>
            </ext:TextField>
        </Items>
    </ext:Panel>

    <br />
    <br />

    <h2>UI</h2>

    <ext:Panel
        runat="server"
        Frame="true"
        Header="false"
        Width="610"
        BodyPadding="10"
        AutoDataBind="true"
        Layout="ColumnLayout">
        <Defaults>
            <ext:Parameter Name="Margin" Value="20" />
            <ext:Parameter Name="Width" Value="150" />
            <ext:Parameter Name="Html" Value="<%# Template %>" AutoDataBind="true" />
            <ext:Parameter Name="anchor" Value="bottom" />
        </Defaults>
        <Items>
            <ext:Callout runat="server" Title="Default" />
            <ext:Callout runat="server" Title="Primary" UI="Primary" />
            <ext:Callout runat="server" Title="Success" UI="Success" />
            <ext:Callout runat="server" Title="Info" UI="Info" />
            <ext:Callout runat="server" Title="Danger" UI="Danger" />
            <ext:Callout runat="server" Title="Warning" UI="Warning" />
        </Items>
    </ext:Panel>

    <br />
    <br />

    <h2>Dynamic</h2>

    <div style="margin-left:200px;">
        <ext:Panel
            ID="Panel1"
            runat="server"
            Title="Dynamic Creation"
            Frame="true"
            Width="250"
            Height="100">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            runat="server"
                            Text="Client side"
                            Handler="if (this.callout) {this.callout.toggle(); return;} this.callout = Ext.Msg.callout(this.up('panel'), {alignment:'lefttop', html: 'LeftTop callout', height: 100, width:100});"
                            />
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Server side" OnDirectClick="CreateCallout" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
    </div>
</body>
</html>
