<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .custom-trigger {
            background-image: url(resources/images/custom-trigger.gif) !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Theme="Gray" />

        <p>Demonstrates how to apply a custom icon on a trigger.</p>
        <p>The icon in this example is designed for the classic themes - Gray and Blue.</p>
        <p>For new themes like Crisp and Neptune, the icon should be adjusted (at least, size).</p>

        <ext:TextField runat="server" Width="200" EmptyText="Click Trigger Button -->">
            <Triggers>
                <ext:FieldTrigger IconCls="custom-trigger" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="Ext.Msg.alert('Message', 'You Clicked the Trigger!');" />
            </Listeners>
        </ext:TextField>
    </form>
</body>
</html>
