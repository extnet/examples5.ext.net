<%@ Page Language="C#" %>

<script runat="server">
    protected void CompleteEdit(object sender, DirectEventArgs e)
    {
        this.AjaxLabel.Html = e.ExtraParams["value"];
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Editor Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .editable {
            font    : 14px Tahoma;
            padding : 3px 5px;
            cursor  : pointer;
            margin-bottom : 20px;
        }

        .editableBlock .x-label-value
        {
            display: block;
        }

        .editable-over {
            background-color: #ffc;
        }

        .x-form-field-editor {
            font : 12px Tahoma;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:TabPanel runat="server" Border="false">
                    <Defaults>
                        <ext:Parameter Name="BodyStyle" Value="padding:10px;" Mode="Value" />
                    </Defaults>
                    <Items>
                        <ext:Panel ID="Tab1" runat="server" Title="Labels">
                            <Content>
                                <ext:Label
                                    ID="Label1"
                                    runat="server"
                                    Cls="editable"
                                    IconCls="x-md md-icon-edit"
                                    OverCls="editable-over"
                                    Text="With predefined field and fixed width">
                                    <Editor>
                                        <ext:Editor runat="server" Shadow="false" Alignment="tl-tl?">
                                            <Field>
                                                <ext:TextField
                                                    runat="server"
                                                    Cls="x-form-field-editor"
                                                    Width="480" />
                                            </Field>
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                                <br />
                                <br />
                                <ext:Label
                                    ID="Label2"
                                    runat="server"
                                    Cls="editable"
                                    IconCls="x-md md-icon-edit"
                                    OverCls="editable-over"
                                    Text="With standard field and auto width">
                                    <Editor>
                                        <ext:Editor runat="server" Shadow="false" Alignment="tl-tl?">
                                            <AutoSizeConfig Width="BoundEl" />
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                                <br />
                                <br />
                                <ext:Label
                                    ID="Label4"
                                    runat="server"
                                    Cls="editable"
                                    IconCls="x-md md-icon-edit"
                                    OverCls="editable-over"
                                    Text="Double click editing">
                                    <Editor>
                                        <ext:Editor runat="server" ActivateEvent="dblclick" Shadow="false" Alignment="tl-tl?">
                                            <AutoSizeConfig Width="BoundEl" />
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                                <br />
                                <br />
                                <ext:Label ID="Label5" runat="server"
                                    Cls="editable"
                                    IconCls="x-md md-icon-edit"
                                    OverCls="editable-over"
                                    Text="Custom editor aligment">
                                    <Editor>
                                        <ext:Editor runat="server" HideEl="false" Shadow="false">
                                            <AutoSizeConfig Width="BoundEl" />
                                            <AlignmentConfig ElementAnchor="TopLeft" TargetAnchor="BottomLeft" />
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                                <br />
                                <br />
                                <ext:Label ID="Label3" runat="server"
                                    Cls="editable editableBlock"
                                    Html="<hr/><p>With TextArea</p><p>Line1</p><p>Line2</p><hr/>">
                                    <Editor>
                                        <ext:Editor runat="server" Shadow="false" Alignment="tl-tl?" UseHtml="true" AutoSize="true">
                                            <Field>
                                                <ext:TextArea runat="server" Cls="x-form-field-editor" Width="500" ID="TextArea1" />
                                            </Field>
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                                <br />
                                <br />
                                <asp:Label ID="aspLabel" runat="server" Text="&amp;lt;asp:Label> with Editor" />

                                <p><ext:Editor runat="server" Target="aspLabel" Shadow="false" Alignment="tl-tl?"  UseHtml="true" /></p>
                            </Content>
                        </ext:Panel>

                        <ext:Panel ID="Tab2" runat="server" Title="Divs">
                            <Content>
                                <div class="editable" field="txt">Lorem ipsum dolor sit amet #1</div>
                                <div class="editable" field="txt">Lorem ipsum dolor sit amet #2</div>
                                <div class="editable" field="tar">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas a urna. Praesent libero. Nullam vitae nisl. Maecenas pellentesque, magna eget pharetra fermentum, tortor dolor suscipit est, ultricies sollicitudin turpis orci vitae quam. Vestibulum augue diam, auctor ac, interdum eu, egestas ac, leo. Nulla justo mauris, mollis quis, consectetur non, varius ac, nunc. Sed facilisis. Sed elementum. Praesent tortor. Maecenas ipsum tellus, fringilla nec, scelerisque sed, scelerisque a, nulla. Phasellus eleifend interdum arcu. Nulla porta ligula placerat tortor.</div>

                                <ext:Editor ID="TextLineEditor" runat="server" AutoSize="true" Shadow="false" />

                                <ext:Editor ID="TextBlockEditor" runat="server" AutoSize="true" Shadow="false">
                                    <Field>
                                        <ext:TextArea runat="server" />
                                    </Field>
                                </ext:Editor>
                            </Content>
                            <Listeners>
                                <Activate Handler="#{TextLineEditor}.retarget(Ext.select('#Tab2 [field=txt].editable', true)); #{TextBlockEditor}.retarget(Ext.select('#Tab2 [field=tar].editable', true));" Single="true" />
                            </Listeners>
                        </ext:Panel>

                        <ext:Panel ID="Tab3" runat="server" Title="Ajax Update">
                            <Items>
                                <ext:Label
                                    ID="AjaxLabel"
                                    runat="server"
                                    Cls="editable"
                                    IconCls="x-md md-icon-edit"
                                    OverCls="editable-over"
                                    Text="Ajax Label">
                                    <Editor>
                                        <ext:Editor
                                            ID="AjaxLabelEditor"
                                            runat="server"
                                            Shadow="false"
                                            Alignment="tl-tl?"
                                            UpdateEl="false">
                                            <AutoSizeConfig Width="BoundEl" />
                                            <DirectEvents>
                                                <Complete OnEvent="CompleteEdit">
                                                    <EventMask
                                                        ShowMask="true"
                                                        Target="CustomTarget"
                                                        CustomTarget="={#{Tab3}.body}" />
                                                    <ExtraParams>
                                                        <ext:Parameter Name="value" Value="value" Mode="Raw" />
                                                    </ExtraParams>
                                                </Complete>
                                            </DirectEvents>
                                        </ext:Editor>
                                    </Editor>
                                </ext:Label>
                            </Items>
                        </ext:Panel>

                        <ext:Panel runat="server" Title="Editor Panel">
                            <Items>
                                <ext:Panel
                                    ID="Panel1"
                                    runat="server"
                                    Width="610"
                                    Height="480"
                                    Html="Content"
                                    BodyPadding="18"
                                    Title="Editor panel">
                                    <TopBar>
                                        <ext:Toolbar runat="server">
                                            <Items>
                                                <ext:Button
                                                    ID="Button1"
                                                    runat="server"
                                                    Text="Edit"
                                                    IconCls="x-md md-icon-edit">
                                                    <Listeners>
                                                        <Click Handler="this.setDisabled(true);#{Button2}.setDisabled(false);#{PanelEditor}.startEdit(#{Panel1}.getBody());" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button
                                                    ID="Button2"
                                                    runat="server"
                                                    Text="Save"
                                                    IconCls="x-md md-icon-save"
                                                    Disabled="true">
                                                    <Listeners>
                                                        <Click Handler="this.setDisabled(true);#{Button1}.setDisabled(false);#{PanelEditor}.completeEdit();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:Toolbar>
                                    </TopBar>
                                </ext:Panel>
                                <ext:Editor
                                    ID="PanelEditor"
                                    runat="server"
                                    HtmlDecode="true"
                                    UseHtml="true"
                                    AutoSize="true"
                                    Alignment="tl-tl?"
                                    AllowBlur="false"
                                    Shadow="False">
                                    <AutoSizeConfig Width="BoundEl" Height="BoundEl" />
                                    <Field>
                                        <ext:HtmlEditor ID="HtmlEditor1" runat="server">
                                            <CustomConfig>
                                                <%-- ExtJS bug. Editor requires a field's getRawValue, but HtmlEditor doesn't have such the method --%>
                                                <ext:ConfigItem Name="getRawValue" Value="function() { return ''; }" Mode="Raw" />
                                            </CustomConfig>
                                        </ext:HtmlEditor>
                                    </Field>
                                    <Listeners>
                                        <StartEdit Handler="this.field.iframeEl.setHeight(this.field.getHeight() - this.field.getToolbar().getHeight() - 4); this.field.textareaEl.setHeight(this.field.getHeight() - this.field.getToolbar().getHeight() - 4);" Delay="10" />
                                    </Listeners>
                                </ext:Editor>
                            </Items>
                            <Listeners>
                                <Deactivate Handler="#{Button1}.setDisabled(false);#{Button2}.setDisabled(true);#{PanelEditor}.completeEdit();" />
                            </Listeners>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>