<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormLayout Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .yellowBg {
            background-color : yellow;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel
            runat="server"
            Frame="true"
            Title="Label Style and Separator"
            Width="400"
            Layout="Form">
            <Defaults>
                <ext:Parameter Name="LabelStyle" Value="color:red;" Mode="Value" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" />
                <ext:TextField
                    runat="server"
                    FieldLabel="Label"
                    LabelStyle="color:blue;"
                    LabelSeparator="-"
                    />
            </Items>
        </ext:Panel>

        <br />

        <ext:Panel
            ID="Panel1"
            runat="server"
            Frame="true"
            Title="Without labels"
            Width="400"
            Layout="Form">
            <Defaults>
                <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" />
                <ext:TextField runat="server" FieldLabel="Label" />
            </Items>
        </ext:Panel>

        <br />

        <ext:Panel
            ID="Panel2"
            runat="server"
            Frame="true"
            Title="Item style"
            Width="400"
            Layout="Form">
            <Defaults>
                <ext:Parameter Name="Cls" Value="yellowBg" Mode="Value" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" />
                <ext:TextField runat="server" FieldLabel="Label" />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>