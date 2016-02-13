<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Xml File Loading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <asp:XmlDataSource ID="XmlDataSource1" runat="server"
            DataFile="~/Examples/TreePanel/Loaders/Xml_File_Loading/authors.xml">
        </asp:XmlDataSource>

        <ext:TreePanel runat="server" Height="300" Width="250">
            <Store>
                <ext:TreeStore runat="server" DataSourceID="XmlDataSource1">
                    <DataBindings>
                        <ext:NodeBinding DataMember="Authors" Text="Authors List" />
                        <ext:NodeBinding DataMember="Author" TextField="name" />
                        <ext:NodeBinding DataMember="blog" HrefField="url" TextField="url" Leaf="true" />
                    </DataBindings>
                </ext:TreeStore>
            </Store>
        </ext:TreePanel>
    </form>
</body>
</html>