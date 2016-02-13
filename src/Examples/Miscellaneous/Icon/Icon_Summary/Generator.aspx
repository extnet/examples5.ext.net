<%@ Page Language="C#" %>

<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<string> icons = Enum.GetNames(typeof(Icon)).ToList<string>();

        icons.Remove("None");

        List<object> data = new List<object>(icons.Count);

        icons.ForEach(icon => data.Add(
            new
            {
                name = icon,
                url = this.ResourceManager1.GetIconUrl((Icon)Enum.Parse(typeof(Icon), icon))
            }
        ));

        Store store = this.DataView1.GetStore();
        store.DataSource = data;
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Icons - Ext.NET Examples</title>
    <style>
        body {
            padding : 20px;
            font    : normal 11px arial,helvetica,sans-serif;
        }

        .thumb-wrap {
            float  : left;
            width  : 150px;
            height : 22px;
            color  : #333;
        }

        .thumb-wrap img {
            width : 16px;
            vertical-align : middle;
        }
    </style>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />

    <ext:DataView
        ID="DataView1"
        runat="server"
        ItemSelector="div.thumb-wrap">
        <Store>
            <ext:Store runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="name" />
                            <ext:ModelField Name="url" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <Template runat="server">
            <Html>
                <tpl for=".">
                    <div class="thumb-wrap" id="{name}">
                        <div class="thumb"><img src="{url}" title="{name}">&nbsp;{name}</div>
                    </div>
                </tpl>
                <div class="x-clear"></div>
            </Html>
        </Template>
    </ext:DataView>
</body>
</html>