<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        //PropertyGrid1.Source contains changed data
        //you can handle this data: read, save and etc

        StringBuilder html = new StringBuilder();
        html.Append("<table class=\"data\">");
        html.Append("<tr><th>Name</th><th>Value</th></tr>");

        // Loop through all PropertyGridParameters and reference by Index.

        foreach (PropertyGridParameter param in this.PropertyGrid1.Source)
        {
            html.Append("<tr>");
            html.Append("<td>" + param.Name + "</td>");
            html.Append("<td>" + param.Value.ToString() + "</td>");
            html.Append("</tr>");
        }
        html.Append("</table>");

        this.Label1.Html = html.ToString();

        // Data can be referenced by the PropertyGridParameter
        // "Name" value as well.
        // string name = this.PropertyGrid1.Source["(name)"].Value;
    }

    protected void AddPropertyClick(object sender, DirectEventArgs e)
    {
        PropertyGrid1.AddProperty(new PropertyGridParameter
        {
            Name = "dynProp1",
            Value = "DynamicValue",
            DisplayName = "Dynamic Property",
            Renderer =
            {
                Handler = "metadata.tdCls = 'red-label'; return value;"
            },
            Editor =
            {
                new TextField
                {
                   Triggers =
                   {
                      new FieldTrigger
                      {
                         Icon = TriggerIcon.SimpleEllipsis,
                         Tag = "ellipsis"
                      }
                   },

                   Listeners =
                   {
                      TriggerClick = {
                          Handler = PropertyGrid1.ClientID + ".editingPlugin.completeEdit(); Ext.Msg.alert('Trigger click', tag + ' trigger click');"
                      }
                   }
                }
            }
        });
    }

    protected void RemovePropertyClick(object sender, DirectEventArgs e)
    {
        PropertyGrid1.RemoveProperty("dynProp1");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>PropertyGrid with Button DirectEvent - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .data th {
            font-weight : bold;
        }

        .data th, .data td {
            padding : 4px;
            border  : 1px solid black;
        }

        .red-label{
            color:Red;
        }

        .blue-label{
            color:Blue;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>PropertyGrid with Button DirectEvent</h1>

        <ext:PropertyGrid
            ID="PropertyGrid1"
            runat="server"
            Width="300"
            SortableColumns="false">
            <Source>
                <ext:PropertyGridParameter Name="(name)" Value="Properties Grid" />
                <ext:PropertyGridParameter Name="grouping" Value="false" Mode="Raw" />
                <ext:PropertyGridParameter Name="autoFitColumns" Value="true" Mode="Raw" />
                <ext:PropertyGridParameter Name="productionQuality" Value="false" Mode="Raw" />
                <ext:PropertyGridParameter Name="created" Value="10/15/2006">
                    <Editor>
                        <ext:DateField runat="server" Format="MM/dd/yyyy" />
                    </Editor>
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="tested" Value="false" Mode="Raw">
                    <Renderer Handler="metadata.tdCls = 'red-label'; return value;" />
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="version" Value="0.01" EditorType="Number" />
                <ext:PropertyGridParameter Name="borderWidth" Value="5" Mode="Raw">
                    <Editor>
                        <ext:NumberField runat="server" />
                    </Editor>
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="color" DisplayName="Color" Value="Red">
                    <Editor>
                        <ext:ComboBox runat="server" ForceSelection="true">
                            <Items>
                                <ext:ListItem Text="Red" />
                                <ext:ListItem Text="Green" />
                                <ext:ListItem Text="Blue" />
                            </Items>
                        </ext:ComboBox>
                    </Editor>
                    <Renderer Handler="return Ext.String.format('<span style=\'color: {0};\'>{1}</span>', value.toLowerCase(), value);" />
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="trigger" Value="TriggerField" DisplayName="Trigger Field">
                    <Renderer Handler="metadata.tdCls = 'blue-label';
                                       return value;" />
                    <Editor>
                        <ext:TextField runat="server">
                            <Triggers>
                                <ext:FieldTrigger Icon="SimpleEllipsis" Tag="ellipsis" />
                            </Triggers>
                            <Listeners>
                                <TriggerClick Handler="#{PropertyGrid1}.editingPlugin.completeEdit();
                                                       Ext.Msg.alert('Trigger click', tag + ' trigger click');" />
                            </Listeners>
                        </ext:TextField>
                    </Editor>
                </ext:PropertyGridParameter>
            </Source>

            <Buttons>
                <ext:Button runat="server" Text="Add property">
                    <DirectEvents>
                        <Click OnEvent="AddPropertyClick" />
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" Text="Remove property">
                    <DirectEvents>
                        <Click OnEvent="RemovePropertyClick" />
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" ID="Button1" Text="Save" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" />
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:PropertyGrid>

        <p><ext:Label ID="Label1" runat="server" /></p>
    </form>

</body>
</html>