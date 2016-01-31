<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComboBox with show/hide of custom FieldTrigger - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>ComboBox with show/hide of custom FieldTrigger</h1>
        
        <ext:ComboBox runat="server" MinChars="1">
            <Items>
                <ext:ListItem Text="1" />
                <ext:ListItem Text="2" />
                <ext:ListItem Text="3" />
                <ext:ListItem Text="4" />
                <ext:ListItem Text="5" />
            </Items>
            <Triggers>
                <ext:FieldTrigger Icon="Clear" Hidden="true" Weight="-1" />
            </Triggers>
            <Listeners>
                <Select Handler="this.getTrigger(0).show();" />
                <BeforeQuery Handler="this.getTrigger(0)[this.getRawValue().toString().length == 0 ? 'hide' : 'show']();" />
                <TriggerClick Handler="if (index == 0) { 
                                           this.clearValue(); 
                                           this.getTrigger(0).hide();
                                       }" />
            </Listeners>
        </ext:ComboBox>
    </form>
</body>
</html>