<%@ Control Language="C#"  %>

<ext:Panel
    ID="ImgDetailPanel"
    runat="server"
    Width="150"
    Region="East"
    Split="true"
    MinWidth="150">
    <CustomConfig>
        <ext:ConfigItem Name="loadRecord" Value="function (image) {
            this.body.hide();
            this.tpl.overwrite(this.body, image.data);
            this.body.slideIn('l', {
                duration: 250
            });}" 
         Mode="Raw"
         />
    </CustomConfig>
    <Tpl runat="server">
        <Html>
            <div class="details">
                <tpl for=".">
                    <tpl if="!Ext.isIE6">
                        <img src="{url}" />
                    </tpl>
                    <tpl if="Ext.isIE6">
                        <div style="width:74px;height:74px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{url}")"></div>
                    </tpl>
                    <div class="details-info">
                        <b>File Name:</b>
                        <span>{name}</span>
                        <b>File URL:</b>
                        <span><a href="{url}" target="_blank">{name}</a></span>
                        <b>Size:</b>
                        <span>{sizeString}</span>
                    </div>
                </tpl>
            </div>
        </html>
    </Tpl>
</ext:Panel>