<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Form with AbsoluteLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        /* Custom rule to make the toolbar fit within a framed panel with no margin: */
        .email-form .x-panel-mc .x-panel-tbar .x-toolbar {
            border-top: 1px solid #C2D6EF;
            border-left: 1px solid #C2D6EF;
            border-bottom: 1px solid #99BBE8;
            margin: -5px -4px 0;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:Panel
                    runat="server"
                    Header="false"
                    Border="false"
                    BodyPadding="18"
                    Layout="Fit">
                    <Items>
                        <ext:Panel
                            runat="server"
                            Title="New Email"
                            Cls="email-form"
                            Frame="true"
                            BodyStyle="10px 5px 5px;"
                            Layout="Fit">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Send" IconCls="x-md md-icon-email" />
                                        <ext:Button runat="server" Text="Save" IconCls="x-md md-icon-save" />
                                        <ext:Button runat="server" Text="Check Spelling" IconCls="x-md md-icon-spellcheck" />
                                        <ext:Button runat="server" Text="Print" IconCls="x-md md-icon-print" />
                                        <ext:ToolbarFill runat="server" />
                                        <ext:Button runat="server" Text="Attach a File" IconCls="x-md md-icon-attachment" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:Container runat="server" Layout="Absolute">
                                    <Items>
                                        <ext:Label runat="server" X="0" Y="10" Text="From:" />
                                        <ext:TextField runat="server" X="55" Y="10" AnchorHorizontal="100%" />
                                        <ext:Label runat="server" X="0" Y="38" Text="To:" />
                                        <ext:Button runat="server" Text="Contacts..." X="55" Y="37" />
                                        <ext:TextField runat="server" X="135" Y="37" AnchorHorizontal="100%" />
                                        <ext:Label runat="server" X="0" Y="65" Text="Subject:" />
                                        <ext:TextField runat="server" X="55" Y="64" AnchorHorizontal="100%" />
                                        <ext:TextArea
                                            runat="server"
                                            X="0"
                                            Y="91"
                                            AnchorHorizontal="100%"
                                            AnchorVertical="100%"
                                            />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>