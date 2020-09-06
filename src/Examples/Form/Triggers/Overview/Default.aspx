<%@ Page Language="C#" %>

<script runat="server">
    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        this.Button3.Disabled = true;
        this.TextField3.ShowTrigger(3);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Overview of triggers - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var triggerHandler = function (field, trigger, index) {
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.Window1.show();
                    App.Window1.alignTo(trigger);
                    break;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Overview of triggers</h1>

        <h2>1. With TriggerClick Listener</h2>

        <ext:TextField
            ID="TextField1"
            runat="server"
            Width="200"
            EmptyText="Click Trigger Button -->">
            <Triggers>
                <ext:FieldTrigger Icon="Combo" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="Ext.Msg.alert('Message', 'You Clicked the Trigger!');" />
            </Listeners>
        </ext:TextField>

        <h2>2. With Dialog Editor</h2>

        <ext:TextField
            ID="TextField2"
            runat="server"
            Width="200"
            Editable="false">
            <Triggers>
                <ext:FieldTrigger Icon="Clear" QTip="Click to clear field" Hidden="true" />
                <ext:FieldTrigger Icon="Ellipsis" QTip="Click to choose value" />
            </Triggers>
            <Listeners>
                <TriggerClick Fn="triggerHandler" />
            </Listeners>
        </ext:TextField>

        <ext:Window
            ID="Window1"
            runat="server"
            MinWidth="165"
            MinHeight="125"
            Resizable="false"
            Title="Choose value"
            Hidden="true"
            Icon="ColorSwatch"
            BodyPadding="18"
            Layout="Fit">
            <Items>
                <ext:ColorPicker runat="server">
                    <Listeners>
                        <Select
                            Handler="
                                var tf = #{TextField2};
                                tf.getTrigger(0).show();
                                tf.setValue('#' + color);
                                tf.getEl().down('input.x-form-text').setStyle('background', '#' + color);
                                #{Window1}.hide();"
                                />
                    </Listeners>
                </ext:ColorPicker>
            </Items>
        </ext:Window>

        <h2>3. With Multiple Triggers</h2>

        <ext:TextField ID="TextField3" runat="server" Width="200">
            <Triggers>
                <ext:FieldTrigger Icon="Date" QTip="Custom tip" />
                <ext:FieldTrigger Icon="Clear" QTip="<b>Title</b><br/>Custom title" />
                <ext:FieldTrigger Icon="Search" />
                <ext:FieldTrigger Icon="Combo" Hidden="true" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="Ext.Msg.alert('Message', 'TriggerIndex: ' + index + '<br /><br />Text: ' + this.getValue());" />
            </Listeners>
        </ext:TextField>

        <br/>

        <ext:Button ID="Button3" runat="server" Text="Show hidden Trigger (via DirectEvent)">
            <%--<Listeners>
                <Click Handler="#{TextField3}.getTrigger(3).show();" />
            </Listeners>--%>
            <DirectEvents>
                <Click OnEvent="Button3_Click">
                    <EventMask ShowMask="true" />
                </Click>
            </DirectEvents>
        </ext:Button>
    </form>
</body>
</html>
