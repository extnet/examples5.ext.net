<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Custom XML file loading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var mapId = function (data) {
            return data.id;
        };

        var mapCategory = function (data) {
            return data.attributes["name"].value;
        };

        var mapLinks = function (data) {
            var xmlNode = data,
                nodes = xmlNode.childNodes,
                links = [],
                i,
                j,
                link,
                url;

            for (i = 0; i < nodes.length; i++) {
                link = nodes[i];
                if (link.nodeName === "link") {
                    for (j = 0; j < link.childNodes.length; j++) {
                        url = link.childNodes[j];
                        if (url.nodeName === "url") {
                            links.push([url.childNodes[0].data]);
                        }
                    }
                }
            }

            return links;
        };

        // This handler will override default load() call (on row expand) that will try to load
        // data from an inexistent proxy in the store.
        var innerStoreLoadHandler = function (store, records, successful, operation) {
            // Only attempt to load data if the expand opearion correctly bound it to the store's placeholder
            if (this.outerRecord) {
                this.loadData(this.outerRecord);
            }
        }

        // This handler will prepare the inner store to load the corresponding row's inner data.
        var expandRowHandler = function (item, record, body, row, rowIndex) {
            // Bind the inner panel's store the data we want it to load.
            App.StoreLinks.outerRecord = record.get('links');

            // Block events from outside controls from triggering on the expanded row.
            body.swallowEvent(['click', 'mousedown', 'mouseup', 'dblclick'], true);
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Custom XML File Loading</h1>

    <p>This example shows how to load a data from a custom XML file directly.</p>

    <ext:GridPanel
        runat="server"
        Title="Categories"
        Frame="true"
        Height="400"
        Width="400">
        <Store>
            <ext:Store runat="server">
                <Proxy>
                    <ext:AjaxProxy Url="categories.xml">
                        <Reader>
                            <ext:XmlReader Record="category" />
                        </Reader>
                    </ext:AjaxProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="id">
                                <MappingFunction Fn="mapId" />
                            </ext:ModelField>
                            <ext:ModelField Name="category">
                                <MappingFunction Fn="mapCategory" />
                            </ext:ModelField>
                            <ext:ModelField Name="links">
                                <MappingFunction Fn="mapLinks" />
                            </ext:ModelField>
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column
                    runat="server"
                    ID="Category"
                    Text="Category"
                    DataIndex="category"
                    Flex="1" />
                <ext:Column
                    runat="server"
                    Text="ID"
                    DataIndex="id" />
            </Columns>
        </ColumnModel>
        <Plugins>
            <ext:RowExpander runat="server">
                <Component>
                    <ext:GridPanel runat="server" Height="175" Title="Links">
                        <Store>
                            <ext:Store ID="StoreLinks" runat="server">
                                <Model>
                                    <ext:Model runat="server">
                                        <Fields>
                                            <ext:ModelField Name="link" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                                <Listeners>
                                    <Load Fn="innerStoreLoadHandler" />
                                </Listeners>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column runat="server" Text="Link" DataIndex="link" Flex="1" />
                            </Columns>
                        </ColumnModel>
                    </ext:GridPanel>
                </Component>
                <Listeners>
                    <Expand Fn="expandRowHandler" />
                </Listeners>
            </ext:RowExpander>
        </Plugins>
    </ext:GridPanel>
</body>
</html>