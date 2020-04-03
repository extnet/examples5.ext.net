<%@ Page Language="C#" %>

<script runat="server">
    protected void UpdateSource_Click(object sender, DirectEventArgs e)
    {
        this.PropertyGrid1.SetSource(new PropertyGridParameterCollection()
        {
            new PropertyGridParameter()
            {
                Name = "(name)",
                Value = "Property GridPanel"
            },
            new PropertyGridParameter()
            {
                Name = "grouping",
                Value = "false"
            },
            new PropertyGridParameter()
            {
                Name = "autoFitColumns",
                Value = "true"
            },
            new PropertyGridParameter()
            {
                Name = "productionQuality",
                Value = "true"
            },
            new PropertyGridParameter()
            {
                Name = "created",
                Value = "new Date()",
                Mode = ParameterMode.Raw
            },
            new PropertyGridParameter()
            {
                Name = "tested",
                Value = "false"
            },
            new PropertyGridParameter()
            {
                Name = "version",
                Value = "0.8"
            },
            new PropertyGridParameter()
            {
                Name = "borderWidth",
                Value = "2"
            }
        }, true);
    }

    protected void NewDataSource_Click(object sender, DirectEventArgs e)
    {
        this.PropertyGrid1.SetSource(new PropertyGridParameterCollection()
        {
            new PropertyGridParameter()
            {
                Name = "firstName",
                Value = "Mike",
                DisplayName = "First Name"
            },
            new PropertyGridParameter()
            {
                Name = "lastName",
                Value = "Bray",
                DisplayName = "Last Name"
            },
            new PropertyGridParameter()
            {
                Name = "dob",
                Value = "new Date(1986, 3, 15)",
                Mode = ParameterMode.Raw,
                DisplayName = "D.O.B"
            },
            new PropertyGridParameter()
            {
                Name = "color",
                Value = "Red",
                DisplayName = "Color",
                Editor =
                {
                    new ComboBox()
                    {
                        Items =
                        {
                            new Ext.Net.ListItem("Red"),
                            new Ext.Net.ListItem("Green"),
                            new Ext.Net.ListItem("Blue")
                        },
                        ForceSelection = true
                    }
                },
                Renderer =
                {
                    Handler = "return Ext.String.format('<span style=\"color: {0};\">{1}</span>', value.toLowerCase(), value)"
                }
            },
            new PropertyGridParameter()
            {
                Name = "score",
                Value = "null",
                DisplayName = "Score",
                EditorType = PropertyGridEditorType.Number
            }
        }, true);
    }
</script>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Property GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Viewport runat="server"  MarginSpec="0 0 10 0">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:Container runat="server" Width="275" Height="300">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Container runat="server" Layout="HBox" MarginSpec="0 0 10 0">
                            <Items>
                                <ext:Button
                                    runat="server"
                                    Text="Update source"
                                    OnDirectClick="UpdateSource_Click" />

                                <ext:Button
                                    runat="server"
                                    Text="New data source"
                                    OnDirectClick="NewDataSource_Click"
                                    MarginSpec="0 0 0 10" />
                            </Items>
                        </ext:Container>
                        <ext:PropertyGrid ID="PropertyGrid1" runat="server">
                            <Source>
                                <ext:PropertyGridParameter Name="(name)" Value="Property GridPanel" />
                                <ext:PropertyGridParameter Name="grouping" Value="false" />
                                <ext:PropertyGridParameter Name="autoFitColumns" Value="true" />
                                <ext:PropertyGridParameter Name="productionQuality" Value="false" />
                                <ext:PropertyGridParameter Name="created" Value="Ext.Date.parse('10/15/2006', 'm/d/Y')" Mode="Raw" />
                                <ext:PropertyGridParameter Name="tested" Value="false" DisplayName="QA" />
                                <ext:PropertyGridParameter Name="version" Value="0.01" />
                                <ext:PropertyGridParameter Name="borderWidth" Value="5" DisplayName="Border Width" />
                            </Source>
                        </ext:PropertyGrid>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>