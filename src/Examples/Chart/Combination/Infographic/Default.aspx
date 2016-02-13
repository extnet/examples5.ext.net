<%@ Page Language="C#" %>
<%@ Register Src="~/Examples/Chart/Combination/Infographic/Store.ascx" TagName="UnemploymentStore" TagPrefix="uc" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>The US Unemployment Infographic - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script src="ArcText.js"></script>
    <script>
        // Returns color based on percentage change in unemployment.
        function getStateColor(unemployment) {
            if (unemployment < -1.5) {
                return 'rgba(114, 166, 185, 1.0)';
            } else if (unemployment < -0.5) {
                return 'rgba(194, 212, 221, 1.0)';
            } else if (unemployment < 0.5) {
                return 'rgba(126, 135, 142, 1.0)';
            } else if (unemployment < 1.5) {
                return 'rgba(179, 113, 114, 1.0)';
            } else {
                return 'rgba(146, 50, 51, 1.0)';
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <%--<h2>The US Unemployment Infographic</h2>

        <p>The US Unemployment Infographic shows how to create what might seem like a distinct</p>
        <p>type of chart, but in fact is only a fancy combination of standard features:</p>
        <p>polar chart with multiple 'pie' series and a cartesian chart.</p>
        <p>The unique look is achieved by a heavy use of sprites and renderers</p>
        <p>to style the chart, and the only custom component is the 'arctext' sprite that</p>
        <p>is used to put a text along a curve.</p>--%>

        <uc:UnemploymentStore runat="server" />

        <ext:Viewport runat="server" Layout="FitLayout">
            <Items>
                <ext:Container runat="server" OverflowY="Auto">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Pack="Center"  />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Width="990" Layout="AbsoluteLayout">
                            <Items>
                                <ext:UserControlLoader runat="server" Path="Polar1.ascx" />
                                <ext:UserControlLoader runat="server" Path="Polar2.ascx" />
                                <ext:UserControlLoader runat="server" Path="Cartesian.ascx" />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
