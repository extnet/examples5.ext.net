<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Badge - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-badge-badge110 {
            min-width: 110px;
            height: 110px;
            border: none;
            box-shadow: none;
            -moz-box-shadow: none;
            -webkit-box-shadow: none;
        }

        .x-badge-badge110 .x-badge-wrap {
            background: none;
            min-width: 110px;
            height: 110px;
        }

        .x-badge-badge110 .x-badge-inner {
            padding: 43px 0px 16px 6px;
            font-size: 64px;
        }

        .badge1 {
            background: url(badges/badge1.png);
        }

        .badge2 {
            background: url(badges/badge2.png);
        }

        .badge3 {
            background: url(badges/badge3.png);
        }

        .badge4 {
            background: url(badges/badge4.png);
        }

        .badge5 {
            background: url(badges/badge5.png);
        }

        .badge6 {
            background: url(badges/badge6.png);
        }

        .badge7 {
            background: url(badges/badge7.png);
        }

        .badge8 {
            background: url(badges/badge8.png);
        }

        .badge9 {
            background: url(badges/badge9.png);
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Container runat="server" Layout="Column" Width="720">
        <Defaults>
            <ext:Parameter Name="width" Value="150" />
            <ext:Parameter Name="height" Value="75" />
            <ext:Parameter Name="margin" Value="40" />
            <ext:Parameter Name="title" Value="Panel" />
        </Defaults>
        <Items>
            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge1"
                        HideEmpty="false"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge2"
                        Text="2"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge3"
                        Text="3"
                        TextStyle="color:yellow;"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge4"
                        HideEmpty="false"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge5"
                        Text="5"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge6"
                        HideEmpty="false"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge7"
                        Text="7"
                        TextStyle="text-decoration:underline;color:black;"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge8"
                        HideEmpty="false"
                        />
                </Plugins>
            </ext:Panel>

            <ext:Panel runat="server">
                <Plugins>
                    <ext:Badge
                        runat="server"
                        ScaleCustom="badge110"
                        Cls="badge9"
                        HideEmpty="false"
                        />
                </Plugins>
            </ext:Panel>
        </Items>
    </ext:Container>
</body>
</html>
