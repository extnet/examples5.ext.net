<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Anchor Layout with Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            Title="Resize Me"
            Width="500"
            Height="480"
            MinWidth="300"
            MinHeight="200"
            Plain="true"
            BodyPadding="18"
            ButtonAlign="Center"
            LabelWidth="55"
            Layout="Anchor">
            <Items>
                <ext:TextField
                    runat="server"
                    FieldLabel="Send to"
                    AnchorHorizontal="100%"
                    />
                <ext:TextField
                    runat="server"
                    FieldLabel="Subject"
                    AnchorHorizontal="100%"
                    />
                <ext:TextArea
                    runat="server"
                    HideLabel="true"
                    AnchorHorizontal="100%"
                    AnchorVertical="-53"
                    />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" IconCls="x-md md-icon-save" />
                <ext:Button runat="server" Text="Cancel" IconCls="x-md md-icon-cancel" />
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>