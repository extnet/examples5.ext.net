<%@ Page Language="C#" %>

<script runat="server">
    public List<object> Data
    {
        get
        {
            return new List<object>()
            {
                new {FirstName = "First 1", LastName = "Last 1"},
                new {FirstName = "First 2", LastName = "Last 2"},
                new {FirstName = "First 3", LastName = "Last 3"},
                new {FirstName = "First 4", LastName = "Last 4"},
                new {FirstName = "First 5", LastName = "Last 5"}
            };
        }
    }

    [DirectMethod]
    public List<object> GetData(string parameters)
    {
        return this.Data;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Loader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <h1>Data Loader</h1>

    <ext:ResourceManager runat="server" />

    <ext:Panel
        runat="server"
        Height="200"
        Width="200"
        Data="<%# Data %>"
        AutoDataBind="true"
        BodyPadding="10"
        Title="Inline Data">
        <Tpl runat="server">
            <Html>
                <tpl for=".">
                    <p>{FirstName} - {LastName}</p>
                </tpl>
            </Html>
        </Tpl>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"
        Height="200"
        Width="200"
        BodyPadding="10"
        Title="Data from direct method">
        <Tpl runat="server">
            <Html>
                <tpl for=".">
                    <p>{FirstName} - {LastName}</p>
                </tpl>
            </Html>
        </Tpl>
        <Loader DirectMethod="#{DirectMethods}.GetData" Mode="Data">
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"
        Height="200"
        Width="200"
        BodyPadding="10"
        Title="Data from http handler">
        <Tpl runat="server">
            <Html>
                <tpl for=".">
                    <p>{FirstName} - {LastName}</p>
                </tpl>
            </Html>
        </Tpl>
        <Loader Url="DataHandler.ashx" Mode="Data">
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"
        Height="200"
        Width="200"
        BodyPadding="10"
        Title="Data from JSON web service">
        <Tpl runat="server">
            <Html>
                <tpl for=".">
                    <p>{FirstName} - {LastName}</p>
                </tpl>
            </Html>
        </Tpl>
        <Loader runat="server" Url="DataService.asmx/GetData" Mode="Data">
            <AjaxOptions Json="true" />
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

</body>
</html>