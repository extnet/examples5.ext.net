<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Render Template - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Render Template</h1>
        <p>This is a custom component render template (not real error)</p>

        <br />
        <br />

        <ext:Component runat="server">
            <RenderTpl runat="server">
                <Html>
                    <div style="border: 1px solid gray; padding: 10px;">
                        <h1 id="{id}-title" data-ref="title">{title}</h1>
                        <p>{msg}</p>
                    </div>
                </Html>
            </RenderTpl>
            <RenderData>
                <ext:Parameter Name="title" Value="Error" />
                <ext:Parameter Name="msg" Value="Something went wrong" />
            </RenderData>
            <ChildEls>
                <ext:ChildElement Name="title" />
            </ChildEls>
            <Listeners>
                <AfterRender Handler="this.title.setStyle({color: 'red'});" />
            </Listeners>
        </ext:Component>
    </form>
</body>
</html>
