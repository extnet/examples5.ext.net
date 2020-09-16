<%@ Page Language="C#" %>

<script runat="server">
    protected void UploadClick(object sender, DirectEventArgs e)
    {
        string tpl = "Uploaded file: {0}<br/>Size: {1} bytes";

        if (this.FileUploadField1.HasFile)
        {
           X.Msg.Show(new MessageBoxConfig
            {
                Buttons = MessageBox.Button.OK,
                Icon = MessageBox.Icon.INFO,
                Title = "Success",
                Message = string.Format(tpl, this.FileUploadField1.PostedFile.FileName, this.FileUploadField1.PostedFile.ContentLength)
            });
        }
        else
        {
           X.Msg.Show(new MessageBoxConfig
            {
                Buttons = MessageBox.Button.OK,
                Icon = MessageBox.Icon.ERROR,
                Title = "Fail",
                Message = "No file uploaded"
            });
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        #fi-button-msg {
            border: 2px solid #ccc;
            padding: 5px 10px;
            background: #eee;
            margin: 5px;
            float: left;
        }
    </style>

    <script>
        var showFile = function (fb, v) {
            if (v) {
                var el = Ext.get('fi-button-msg');
                el.update('<b>Selected:</b> ' + v);

                if (!el.isVisible()) {
                    el.slideIn('t', {
                        duration: .2,
                        easing: 'easeIn',
                        callback: function () {
                            el.highlight();
                        }
                    });
                } else {
                    el.highlight();
                }
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>File Upload Field</h1>

        <h2>Basic FileUpload</h2>

        <p>A typical file upload field with Ext style.  Direct editing of the text field cannot be done in a
            consistent, cross-browser way, so it is always read-only in this implementation.</p>

        <ext:FileUploadField
            ID="BasicField"
            runat="server"
            Width="400"
            IconCls="x-md md-icon-attach-file"
            />

        <ext:Button runat="server" Text="Get File Path">
            <Listeners>
                <Click Handler="var v = #{BasicField}.getValue(); Ext.Msg.alert('Selected&nbsp;File', v && v != '' ? v : 'None');" />
            </Listeners>
        </ext:Button>

        <h2>Basic FileUpload (Button-only)</h2>

        <p>You can also render the file input as a button without the text field, with access to the field's value via the
            standard <tt>TextField</tt> interface or by handling the <tt>FileSelected</tt> event (as in this example).</p>

        <ext:FileUploadField runat="server" ButtonOnly="true">
            <Listeners>
                <Change Fn="showFile" />
            </Listeners>
        </ext:FileUploadField>

        <div id="fi-button-msg" style="display:none;"></div>
        <div class="x-clear"></div>

        <h2>Form Example</h2>

        <p>The FileUploadField can also be used in standard form layouts, with support for anchoring, validation (the
            field is required in this example), empty text, etc.</p>

        <ext:FormPanel
            ID="BasicForm"
            runat="server"
            Width="500"
            Frame="true"
            Title="File Upload Form"
            PaddingSummary="10px 10px 0 10px"
            LabelWidth="50">
            <Defaults>
                <ext:Parameter Name="anchor" Value="95%" Mode="Value" />
                <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                <ext:Parameter Name="msgTarget" Value="side" Mode="Value" />
            </Defaults>
            <Items>
                <ext:TextField ID="PhotoName" runat="server" FieldLabel="Name" />
                <ext:FileUploadField
                    ID="FileUploadField1"
                    runat="server"
                    EmptyText="Select an image"
                    FieldLabel="Photo"
                    ButtonText=""
                    IconCls="x-md md-icon-add-photo-alt"
                    />
            </Items>
            <Listeners>
                <ValidityChange Handler="#{SaveButton}.setDisabled(!valid);" />
            </Listeners>
            <Buttons>
                <ext:Button
                    ID="SaveButton"
                    runat="server"
                    Text="Save"
                    Disabled="true">
                    <DirectEvents>
                        <Click
                            OnEvent="UploadClick"
                            Before="if (!#{BasicForm}.getForm().isValid()) { return false; }
                                Ext.Msg.wait('Uploading your photo...', 'Uploading');"

                            Failure="Ext.Msg.show({
                                title   : 'Error',
                                msg     : 'Error during uploading',
                                minWidth: 200,
                                modal   : true,
                                icon    : Ext.Msg.ERROR,
                                buttons : Ext.Msg.OK
                            });">
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" Text="Reset">
                    <Listeners>
                        <Click Handler="#{BasicForm}.getForm().reset();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>