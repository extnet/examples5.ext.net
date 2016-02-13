<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Windows Example - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .x-panel-body p {
            margin: 10px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Windows Example</h1>

        <p>This illustrates the <code>headerPosition</code> config of Panels, and also relative z-index management.</p>
        <p>The third Window owns two floating Windows who's z-indices are managed relative
            to <i>its</i> z-index. When that Window is occluded by another Window, and you click
            to bring it to the front, both its dependent Windows move to the front too.</p>
        <p>This also illustrates constraining Windows.</p>

        <ext:Window
            runat="server"
            Height="200"
            Width="400"
            X="450"
            Y="450"
            Title="Constraining Window, plain: true"
            Closable="false"
            Plain="true"
            Layout="FitLayout">
            <Items>
                <ext:Window
                    runat="server"
                    Title="Constrained Window"
                    Width="200"
                    Height="100"
                    X="20"
                    Y="20"
                    Constrain="true"
                    Layout="FitLayout">
                    <Items>
                        <ext:Panel runat="server" Border="false" />
                    </Items>
                </ext:Window>

                <ext:Window
                    runat="server"
                    Title="Header-Constrained Win"
                    Width="200"
                    Height="100"
                    X="120"
                    Y="120"
                    ConstrainHeader="true"
                    Layout="FitLayout">
                    <Items>
                        <ext:Panel runat="server" Border="false" />
                    </Items>
                </ext:Window>

                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Left Header, plain: true"
            Width="400"
            Height="200"
            X="10"
            Y="200"
            Plain="true"
            HeaderPosition="Left"
            Layout="FitLayout">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Right Header, plain: true"
            Width="400"
            Height="200"
            X="450"
            Y="200"
            HeaderPosition="Right"
            Layout="FitLayout">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Bottom Header, plain: true"
            Width="400"
            Height="200"
            X="10"
            Y="450"
            Plain="true"
            HeaderPosition="Bottom"
            Layout="FitLayout">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>