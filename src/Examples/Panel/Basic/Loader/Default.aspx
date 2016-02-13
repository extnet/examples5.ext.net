<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        this.Panel1.Html = DateTime.Now.ToLongTimeString();
    }

    protected void Button2_Click(object sender, DirectEventArgs e)
    {
        this.Panel2.Loader.SuspendScripting();
        this.Panel2.Loader.Url = "Child.aspx";
        this.Panel2.Loader.DisableCaching = true;
        this.Panel2.LoadContent();
    }

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
        this.Panel2.LoadContent("Child.aspx", true);
    }

    protected void Button4_Click(object sender, DirectEventArgs e)
    {
        this.Panel3.Loader.SuspendScripting();
        this.Panel3.Loader.Url = "Child.aspx";
        this.Panel3.Loader.Mode = LoadMode.Frame;
        this.Panel3.Loader.DisableCaching = true;
        this.Panel3.LoadContent();
    }

    protected void Button5_Click(object sender, DirectEventArgs e)
    {
        this.Panel3.LoadContent(new ComponentLoader()
        {
            Url = "Child.aspx",
            Mode = LoadMode.Frame,
            DisableCaching = true
        });
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Setting Html and Loader Properties - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <h1>Setting Html and Loader Properties</h1>

    <ext:ResourceManager runat="server" />

    <h2>Html Property</h2>

    <p>Setting the &lt;Content> region or setting the .Html property will add the text directly to the "body" of the Panel.</p>

    <ext:Panel
        ID="Panel1"
        runat="server"
        Width="350"
        Height="200"
        Title="Html"
        BodyPadding="5">
        <Content>
            <%= DateTime.Now.ToLongTimeString() %>
        </Content>
        <Buttons>
            <ext:Button runat="server" Text="Set Html Property" OnDirectClick="Button1_Click" />
        </Buttons>
    </ext:Panel>

    <h2>Loader with Html Mode</h2>

    <%--
    <p>The .AutoLoad property must be set with a url. The url can be either a local or remote url. A url is considered remote if it starts with "http".</p>
    <p>The .AutoLoad property functions differently depending on the whether the url is local or remote.</p>
    <p>If the url is a local url, the Panel will make an Ajax request for the url and replace the body of the Panel with the html from the &lt;body> of the Page being requested.
    Think of this functionality as a "merge" of the two Pages.</p>
    <p>If the local url/Page contains JavaScript or Css (StyleSheet), the JavaScript is executed and the Css is applied to the Parent Page where the requesting Panel is located.</p>
    <p>If the local url (Child) is a ASP.NET .aspx Page with a &lt;form runat="server">, and the Child Page can perform PostBacks, the combined Page may not function properly and the Child PostBack may cause a JavaScript error or Exception.</p>
    <p>If PostBacks are required in the Child Page, please set the .AutoLoadIFrame property as noted below.</p>
    <p>If the .AutoLoad property is set with a remote url (starts with "http"), an &lt;iframe> will automatically added to the body of the Panel and the url will be loaded into the &lt;iframe>. This is the same functionality as the .AutoLoadIFrame property.</p>
    --%>

    <ext:Panel
        ID="Panel2"
        runat="server"
        Width="350"
        Height="200"
        Title="Merge Mode"
        BodyPadding="5">
        <Loader runat="server" Url="Child.aspx" Mode="Html">
            <LoadMask ShowMask="true" />
        </Loader>
        <Buttons>
            <ext:Button runat="server" Text="Set Property">
                <DirectEvents>
                    <Click OnEvent="Button2_Click" Method="GET" />
                </DirectEvents>
            </ext:Button>
            <ext:Button runat="server" Text="Load" OnDirectClick="Button3_Click" />
        </Buttons>
    </ext:Panel>

    <h2>Loader with Frame Mode</h2>

    <ext:Panel
        ID="Panel3"
        runat="server"
        Width="350"
        Height="200"
        Title="Frame Mode">
        <Loader
            runat="server"
            Url="Child.aspx"
            Mode="Frame"
            ShowMask="true">
            <LoadMask ShowMask="true" />
        </Loader>
        <Buttons>
            <ext:Button runat="server" Text="Set Property" OnDirectClick="Button4_Click" />
            <ext:Button runat="server" Text="Load" OnDirectClick="Button5_Click" />
        </Buttons>
    </ext:Panel>
</body>
</html>
