<%@ Page Language="C#" %>

<script runat="server">
    public static string TEST_HTML_1 = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed egestas gravida nibh, quis porttitor felis
                    venenatis id. Nam sodales mollis quam eget venenatis. Aliquam metus lorem, tincidunt ut egestas imperdiet, convallis
                    lacinia tortor. Mauris accumsan, nisl et sodales tristique, massa dui placerat erat, at venenatis tortor libero nec
                    tortor. Pellentesque quis elit ac dolor commodo tincidunt. Curabitur lorem eros, tincidunt quis viverra id, lacinia
                    sed nisl. Quisque viverra ante eu nisl consectetur hendrerit.";

    public static string TEST_HTML_2 = @"<b>This tab is scrollable.</b><br /><br />
                    Aenean sit amet quam ipsum. Nam aliquet ullamcorper lorem, vel commodo neque auctor quis. Vivamus ac purus in
                    tortor tempor viverra eget a magna. Nunc accumsan dolor porta mauris consequat nec mollis felis mattis. Nunc ligula nisl,
                    tempor ut pellentesque et, viverra eget tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sodales
                    rhoncus massa, sed lobortis risus euismod at. Suspendisse dictum, lectus vitae aliquam egestas, quam diam consequat augue,
                    non porta odio ante a dui. Vivamus lacus mi, ultrices sed feugiat elementum, ultrices et lectus. Donec aliquet hendrerit magna,
                    in venenatis ante faucibus ut. Duis non neque magna. Quisque iaculis luctus nibh, id pellentesque lorem egestas non. Phasellus
                    id risus eget felis auctor scelerisque. Fusce porttitor tortor eget magna pretium viverra. Sed tempor vulputate felis aliquam
                    scelerisque. Quisque eget libero non lectus tempus varius eu a tortor.
                    <br /><br />
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed egestas gravida nibh, quis porttitor felis
                    venenatis id. Nam sodales mollis quam eget venenatis. Aliquam metus lorem, tincidunt ut egestas imperdiet, convallis
                    lacinia tortor. Mauris accumsan, nisl et sodales tristique, massa dui placerat erat, at venenatis tortor libero nec
                    tortor. Pellentesque quis elit ac dolor commodo tincidunt. Curabitur lorem eros, tincidunt quis viverra id, lacinia
                    sed nisl. Quisque viverra ante eu nisl consectetur hendrerit.";
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Icon Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" MarginSpec="0 0 10 0">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:TabPanel
                runat="server"
                Width="400"
                Height="295"
                MarginSpec="0 0 20 0">
                <Defaults>
                    <ext:Parameter Name="bodyPadding" Value="10" Mode="Raw" />
                    <ext:Parameter Name="scrollable" Value="both" />
                </Defaults>
                <Items>
                    <ext:Panel
                        runat="server"
                        IconCls="x-md md-icon-home"
                        Html="<%# TEST_HTML_1  %>"
                        AutoDataBind="true" />

                    <ext:Panel
                        runat="server"
                        IconCls="x-md md-icon-link"
                        Html="<%# TEST_HTML_2  %>"
                        AutoDataBind="true" />

                    <ext:Panel
                        runat="server"
                        IconCls="x-md md-icon-star-border"
                        Disabled="true" />
                </Items>
            </ext:TabPanel>

            <ext:TabPanel
                runat="server"
                Width="400"
                Height="295"
                MarginSpec="0 0 20 0"
                Plain="true">
                <Defaults>
                    <ext:Parameter Name="bodyPadding" Value="10" Mode="Raw" />
                    <ext:Parameter Name="scrollable" Value="both" />
                </Defaults>
                <Items>
                    <ext:Panel
                        runat="server"
                        Title="Active Tab"
                        IconCls="x-md md-icon-home"
                        Html="<%# TEST_HTML_1  %>"
                        AutoDataBind="true"
                        />

                    <ext:Panel
                        runat="server"
                        Title="Inactive Tab"
                        IconCls="x-md md-icon-link"
                        Html="<%# TEST_HTML_2  %>"
                        AutoDataBind="true"
                        />

                    <ext:Panel
                        runat="server"
                        Title="Disabled Tab"
                        IconCls="x-md md-icon-star-border"
                        Disabled="true"
                        />
                </Items>
            </ext:TabPanel>
        </Items>
    </ext:Viewport>
</body>
</html>