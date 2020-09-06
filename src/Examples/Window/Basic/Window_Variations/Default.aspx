<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Windows Example - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Window Variations</h1>

        <p>This illustrates the <code>headerPosition</code> config of Panels, and also relative z-index management.</p>
        <p>The third Window owns two floating Windows who's z-indices are managed relative
            to its z-index. When that Window is occluded by another Window, and you click
            to bring it to the front, both its dependent Windows move to the front too.</p>
        <p>Constraining Windows is also demonstrated.</p>

        <ext:Window
            runat="server"
            Height="270"
            Width="480"
            X="480"
            Y="480"
            Title="Constraining Window"
            Closable="false"
            Plain="true"
            Layout="Fit">
            <Items>
                <ext:Window
                    runat="server"
                    Title="Constrained Window"
                    Width="270"
                    Height="180"
                    X="20"
                    Y="20"
                    Constrain="true"
                    Layout="Fit">
                    <Items>
                        <ext:Panel runat="server" Border="false" />
                    </Items>
                </ext:Window>

                <ext:Window
                    runat="server"
                    Title="Constrain Header"
                    Width="270"
                    Height="180"
                    X="120"
                    Y="120"
                    ConstrainHeader="true"
                    Layout="Fit">
                    <Items>
                        <ext:Panel runat="server" Border="false" />
                    </Items>
                </ext:Window>

                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Left Header"
            Width="480"
            Height="270"
            X="10"
            Y="270"
            Plain="true"
            HeaderPosition="Left"
            Layout="Fit">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Right Header"
            Width="480"
            Height="270"
            X="500"
            Y="270"
            HeaderPosition="Right"
            Layout="Fit">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>

        <ext:Window
            runat="server"
            Title="Bottom Header"
            Width="480"
            Height="270"
            X="10"
            Y="480"
            Plain="true"
            HeaderPosition="Bottom"
            Layout="Fit">
            <Items>
                <ext:Panel runat="server" Border="false" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>