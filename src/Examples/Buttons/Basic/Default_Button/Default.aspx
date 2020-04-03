<%@ Page Language="C#" %>

<html>
<head runat="server">
    <title>Default Button - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <h1>Default Button</h1>

        <ext:ResourceManager runat="server" />

        <ext:Container
            runat="server"
            Layout="VBox"
            Height="650">
            <Defaults>
                <ext:Parameter Name="margin" Value="0 0 24 0" Mode="Value" />
            </Defaults>
            <Items>
                <ext:FormPanel
                    runat="server"
                    Title="Last Button by default"
                    BodyPadding="5"
                    Width="350">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Item 1" />
                        <ext:TextField runat="server" FieldLabel="Item 2" />
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" Text="Button1" />
                        <ext:Button runat="server" Text="Button2" OnClientClick="Ext.Msg.alert('ENTER', 'ENTER is intercepted by Button2');" />
                    </Buttons>
                </ext:FormPanel>

                <ext:FormPanel
                    runat="server"
                    Title="Button by Index"
                    DefaultButton="1"
                    BodyPadding="5"
                    Width="350">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Item 1" />
                        <ext:TextField runat="server" FieldLabel="Item 2" />
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" Text="Button1" />
                        <ext:Button runat="server" Text="Button2" OnClientClick="Ext.Msg.alert('ENTER', 'ENTER is intercepted by Button2');" />
                        <ext:Button runat="server" Text="Button3" />
                        <ext:Button runat="server" Text="Button4" />
                    </Buttons>
                </ext:FormPanel>

                <ext:FormPanel
                    runat="server"
                    Title="Button by ID"
                    DefaultButton="Button2"
                    BodyPadding="5"
                    Width="350">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Item 1" />
                        <ext:TextField runat="server" FieldLabel="Item 2" />
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" Text="Button1" />
                        <ext:Button runat="server" ID="Button2" Text="Button2"
                            OnClientClick="Ext.Msg.alert('ENTER', 'ENTER is intercepted by Button2');" />
                        <ext:Button runat="server" Text="Button3" />
                        <ext:Button runat="server" Text="Button4" />
                    </Buttons>
                </ext:FormPanel>

                <ext:FormPanel
                    runat="server"
                    Title="Button by Selector"
                    DefaultButton="button[text=Button2]"
                    BodyPadding="5"
                    Width="350">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Item 1" />
                        <ext:TextField runat="server" FieldLabel="Item 2" />
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" Text="Button1" />
                        <ext:Button runat="server" Text="Button2" OnClientClick="Ext.Msg.alert('ENTER', 'ENTER is intercepted by Button2');" />
                        <ext:Button runat="server" Text="Button3" />
                        <ext:Button runat="server" Text="Button4" />
                    </Buttons>
                </ext:FormPanel>
            </Items>
        </ext:Container>
    </form>
</body>
</html>