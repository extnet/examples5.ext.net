<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormPanel Labels with Editor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>
        var bodyInit = function () {
            this.body.on("dblclick", function (e, t) {
                App.Editor1.startEdit(t);
            }, null, {
                delegate : "label.x-form-item-label"
            });
            
            this.header.titleCmp.textEl.on("dblclick", function (e, t) {
                App.Editor2.startEdit(t);
            });
        };
        
        var beforeComplete = function (editor, value, startValue) {
            // Just ensure we have a ':' as the last char of label.
            
            if (value.charAt(value.length - 1) != ":") { 
                editor.setValue(editor.getValue() + ":");
            } 
            
            return true;
        };
        
        var complete = function (editor, value, startValue) {
            // Notify user the Editor value has changed.
            Ext.Msg.notify("Editor Changed", 
                Ext.String.format("<b>{0}</b><br />changed to<br /><b>{1}</b>", startValue, value));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>FormPanel Labels with Editor</h1>
        
        <p>Double-click on the Field Labels and the Panel Title to activate the Editor.</p>
        
        <ext:FormPanel 
            runat="server"
            Title="User Details"
            LabelWidth="110"
            Width="350"
            Height="185"
            Icon="User"
            BodyPadding="5"
            Layout="Form">
            <Items>
                <ext:TextField 
                    runat="server" 
                    FieldLabel="First Name" 
                    AnchorHorizontal="100%" 
                    EmptyText="<-- Double-click Label or Title"
                    />
                <ext:TextField runat="server" FieldLabel="Middle Name" AnchorHorizontal="100%" />
                <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="100%" />
                <ext:DateField runat="server" FieldLabel="D.O.B" AnchorHorizontal="100%" />
            </Items>
            <Listeners>
                <AfterRender Fn="bodyInit" />
            </Listeners>
        </ext:FormPanel>
        
        <ext:Editor 
            ID="Editor1" 
            runat="server"
            Shadow="false"
            Offsets="0,5"
            Alignment="l-l"
            IgnoreNoChange="true">
            <Field>
                <ext:TextField 
                    runat="server" 
                    AllowBlank="false" 
                    Width="95" 
                    SelectOnFocus="true" 
                    />
            </Field>
            <Listeners>
                <BeforeComplete Fn="beforeComplete"/>
                <Complete Fn="complete" />
            </Listeners>
        </ext:Editor>
        
        <ext:Editor 
            ID="Editor2" 
            runat="server"
            Shadow="false"
            IgnoreNoChange="true"
            Cls="x-small-editor"
            Offsets="0,10">
            <AlignmentConfig 
                ElementAnchor="BottomLeft" 
                TargetAnchor="BottomLeft" 
                ConstrainViewport="true" 
                />
            <Field>
                <ext:ComboBox 
                    runat="server" 
                    Width="110" 
                    TriggerAction="All"
                    Editable="false">
                    <Items>
                        <ext:ListItem Text="User Details" />
                        <ext:ListItem Text="Developer Details" />
                        <ext:ListItem Text="Manager Details" />
                    </Items>
                </ext:ComboBox>
            </Field>
            <Listeners>
                <Complete Fn="complete" />
            </Listeners>
        </ext:Editor>
    </form>    
</body>
</html>