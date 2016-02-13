<%@ Page Language="C#" %>

<script runat="server">
    public static string TEST_HTML = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed egestas gravida nibh, quis porttitor felis venenatis id. Nam sodales mollis quam eget venenatis. Aliquam metus lorem, tincidunt ut egestas imperdiet, convallis lacinia tortor.";
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic Panel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:Container
                runat="server"
                StyleSpec="background:transparent;"
                MarginSpec="0 0 10 0">
                <LayoutConfig>
                    <ext:TableLayoutConfig Columns="3" />
                </LayoutConfig>
                <Defaults>
                    <ext:Parameter Name="Width" Value="200" Mode="Raw" />
                    <ext:Parameter Name="Height" Value="200" Mode="Raw" />
                    <ext:Parameter Name="BodyPadding" Value="10" Mode="Raw" />
                    <ext:Parameter Name="AutoScroll" Value="true" Mode="Raw" />
                    <ext:Parameter Name="Margin" Value="10" Mode="Raw" />
                    <ext:Parameter Name="Frame" Value="true" Mode="Raw" />
                    <ext:Parameter Name="Html" Value="<%# TEST_HTML %>" Mode="Value" AutoDataBind="true" />
                </Defaults>
                <Items>
                    <ext:Panel runat="server" />
                    <ext:Panel runat="server" Title="Title" />
                    <ext:Panel runat="server" Title="Header icons">
                        <Tools>
                            <ext:Tool Type="Pin" />
                            <ext:Tool Type="Refresh" />
                            <ext:Tool Type="Search" />
                            <ext:Tool Type="Save" />
                        </Tools>
                    </ext:Panel>
                    <ext:Panel
                        runat="server"
                        ColSpan="3"
                        Title="Collapsed Panel"
                        Collapsed="true"
                        Collapsible="true"
                        Width="640"
                        Frame="true" />
                </Items>
            </ext:Container>
        </Items>
    </ext:Viewport>
</body>
</html>