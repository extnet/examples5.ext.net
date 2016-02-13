<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TextField with Icons - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>TextField with Icons</h1>

    <h2>TextField</h2>

    <ext:TextField runat="server">
        <Triggers>
            <ext:FieldTrigger Icon="SimpleEllipsis" />
            <ext:FieldTrigger Icon="SimpleMagnify" />
            <ext:FieldTrigger Icon="SimplePlus" />
        </Triggers>
    </ext:TextField>

   <h2>ComboBox</h2>

    <ext:ComboBox runat="server" TriggerIcon="SimpleArrowDown">
        <Items>
            <ext:ListItem Text="Item 1" />
            <ext:ListItem Text="Item 2" />
            <ext:ListItem Text="Item 3" />
            <ext:ListItem Text="Item 4" />
            <ext:ListItem Text="Item 5" />
        </Items>
        <Triggers>
            <ext:FieldTrigger Icon="SimpleEllipsis" />
            <ext:FieldTrigger Icon="SimpleMagnify" />
            <ext:FieldTrigger Icon="SimplePlus" />
        </Triggers>
    </ext:ComboBox>

    <h2>DateField</h2>

    <ext:DateField runat="server" TriggerIcon="SimpleDate" />

    <h2>TimeField</h2>

    <ext:TimeField runat="server" TriggerIcon="SimpleTime" />
</html>
