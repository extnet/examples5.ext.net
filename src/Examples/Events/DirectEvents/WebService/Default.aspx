<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectEvents Summary - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var sayHello = function (result) {
            var params = result.extraParamsResponse || {};

            if (params.Greeting) {
                alert(params.Greeting);
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DirectEvent connecting to [WebMethod] WebService</h1>

        <p>The following sample demonstrates configuring an DirectEvent to connect to an ASP.NET WebService [WebMethod] and two options for returning data back to the client.</p>

        <p>The first Button calls a <code>[WebMethod]</code> and returns a simple script which gets executed on the client upon a successful response.</p>

        <p>The second Button calls a <code>[WebMethod]</code> and returns an new parameter with a "Greeting".
        The value of the Greeting parameter is then used to populate a simple JavaScript <code>alert</code> message.</p>

        <h3>Example</h3>

        <ext:Panel
            runat="server"
            Title="Say Hello"
            Width="300"
            Height="185"
            Frame="true"
            ButtonAlign="Center"
            Layout="Form">
            <Items>
                <ext:TextField
                    ID="txtName"
                    runat="server"
                    FieldLabel="Name"
                    EmptyText="Your name here..."
                    AnchorHorizontal="100%"
                    />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="[WebMethod]">
                    <DirectEvents>
                        <Click
                            Url="TestService.asmx/SayHello1"
                            Type="Load"
                            Method="POST"
                            CleanRequest="true">
                            <ExtraParams>
                                <ext:Parameter Name="name" Value="#{txtName}.getValue()" Mode="Raw" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>

                <ext:Button runat="server" Text="[WebMethod] with Params">
                    <DirectEvents>
                        <Click
                            Success="sayHello(result);"
                            Url="TestService.asmx/SayHello2"
                            Type="Load"
                            Method="POST"
                            CleanRequest="true">
                            <ExtraParams>
                                <ext:Parameter Name="name" Value="#{txtName}.getValue()" Mode="Raw" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>