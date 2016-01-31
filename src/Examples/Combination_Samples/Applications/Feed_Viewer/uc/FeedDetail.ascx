<%@ Control Language="C#" %>

<script runat="server">
    protected void GridAdded(object sender, ComponentAddedEventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            return;
        }
        
        GridPanel grid = (GridPanel)e.Control;
        grid.Listeners.SelectionChange.Handler = "var selected = selections[0]; if (selected) {var post = this.up('[cls=feed-detail]').down('[cls=preview]'); post.active = selected; post.update(selected.data);}";        
    }
</script>

<ext:Panel runat="server"
    Cls="feed-detail"    
    Layout="BorderLayout">
    <Items>
        <ext:Panel runat="server" 
            Layout="FitLayout" 
            Region="Center" 
            Flex="2" 
            MinHeight="200" 
            MinWidth="150">
            <TopBar>
                <ext:Toolbar runat="server" Cls="x-docked-noborder-top">
                    <Items>
                        <ext:Button runat="server" IconCls="open-all" Text="Open All">
                            <Listeners>
                                <Click Handler="FeedViewer.FeedInfo.tabOpen(this.up('panel').down('gridpanel').store.getRange());" />
                            </Listeners>
                        </ext:Button>

                        <ext:ToolbarSeparator />

                        <ext:CycleButton runat="server" 
                            Text="Reading Pane"
                            PrependText="Preview: "
                            ShowText="true">
                            <Menu>
                                <ext:Menu runat="server" Cls="reading-menu">
                                    <Items>
                                        <ext:CheckMenuItem runat="server" Text="Bottom" Checked="true" IconCls="preview-bottom" />
                                        <ext:CheckMenuItem runat="server" Text="Right" IconCls="preview-right" />
                                        <ext:CheckMenuItem runat="server" Text="Hide" IconCls="preview-hide" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                            <Listeners>
                                <Change Fn="FeedViewer.FeedDetail.readingPaneChange" />
                            </Listeners>
                        </ext:CycleButton>

                        <ext:Button runat="server" IconCls="summary" Text="Summary" EnableToggle="true" Pressed="true">
                            <Listeners>
                                <Toggle Handler="this.up('panel').down('gridpanel').getView().getPlugin('preview').toggleExpanded(pressed);" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <Items>
                <ext:UserControlLoader runat="server" Path="uc/FeedGrid.ascx" OnComponentAdded="GridAdded" />    
            </Items>
        </ext:Panel>        

        <ext:Container runat="server" 
            Layout="FitLayout"
            Region="South"
            Split="true"
            Flex="2"
            MinHeight="150">
            <Items>
                <ext:UserControlLoader runat="server" Path="uc/FeedPost.ascx" />
            </Items>
        </ext:Container>

        <ext:Panel runat="server" 
            Region="East"
            Layout="FitLayout"
            Flex="1"
            Split="true"
            Hidden="true"
            MinWidth="150"
            Border="false">
        </ext:Panel>
    </Items>
</ext:Panel>