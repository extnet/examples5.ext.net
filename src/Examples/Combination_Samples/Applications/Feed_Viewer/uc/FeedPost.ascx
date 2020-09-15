<%@ Control Language="C#" %>

<ext:Panel
    runat="server"
    Cls="preview"
    Scrollable="Both"
    Border="true">
    <DockedItems>
        <ext:Toolbar runat="server" Dock="Top">
            <Items>
                <ext:Button runat="server" Text="View in new tab" IconCls="tab-new">
                    <Listeners>
                        <Click Handler="FeedViewer.FeedInfo.tabOpen(this.up('panel').active);" />
                    </Listeners>
                </ext:Button>

                <ext:ToolbarSeparator />

                <ext:Button runat="server" Text="Go to post" IconCls="post-go">
                    <Listeners>
                        <Click Handler="window.open(this.up('panel').active.get('link'));" />
                    </Listeners>
                </ext:Button>
            </Items>
        </ext:Toolbar>    
    </DockedItems>

    <Tpl runat="server">
        <Html>
             <div class="post-data">
                <span class="post-date">{pubDate:this.formatDate}</span>
                <h3 class="post-title">{title}</h3>
                <h4 class="post-author">by {author:this.defaultValue}</h4>
             </div>
             <div class="post-body">{content:this.getBody}</div>
        </html>        
        <Functions>
            <ext:JFunction Name="getBody" Fn="function (value) {return Ext.util.Format.stripScripts(value);}" />
            <ext:JFunction Name="defaultValue" Fn="function (v) {return v ? v : 'Unknown';}" />
            <ext:JFunction Name="formatDate" Fn="function (v) {return v ? Ext.Date.format(v, 'M j, Y, g:i a') : '';}" />
        </Functions>
    </Tpl>
</ext:Panel>
