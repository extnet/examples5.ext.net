<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store1.Data = new List<object>
            {
                new { FirstName = "John",  LastName = "Last" },
                new { FirstName = "Betty", LastName = "Rubble" },
                new { FirstName = "Mike",  LastName = "Vazovsky" }
            };

            Store2.Data = new List<object>
            {
                new
                {
                    Directory = "Folder1",
                    Files = new List<object>
                    {
                        new { file = "CV.doc" },
                        new { file = "readme.txt" },
                    }
                },

                new
                {
                    Directory = "Folder2",
                    Files = new List<object>
                    {
                        new { file = "Salary.xls" },
                        new { file = "RealSalary.xls" },
                        new { file = "readme.txt" },
                    }
                },

                new
                {
                    Directory = "Folder3",
                    Files = new List<object>
                    {
                        new { file = "About.pdf" }
                    }
                }
            };
        }
    }

    [DirectMethod]
    public void GetFile(string directory, string file)
    {
        X.Msg.Alert("Content of File", directory + "/" + file).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ComponentView Overview - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>ComponentView Overview</h1>

        <p>ComponentView is plugin allows to inject widgets inside view template</p>

        <br />

        <ext:Panel
            runat="server"
            Title="Inject by Value (widget as editor)"
            Width="360"
            Layout="Fit">
            <Items>
                <ext:DataView runat="server" Padding="6" DisableSelection="true">
                    <Store>
                        <ext:Store ID="Store1" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="FirstName" />
                                        <ext:ModelField Name="LastName" />
                                        <ext:ModelField Name="Description" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ItemTpl runat="server">
                        <Html>
                            <table style="border: solid 1px gray; margin-bottom: 6px;" width="100%">
                                <tr>
                                    <td width="50%" valign="top" style="padding:6px;">
                                        <p>FirstName: {FirstName}</p>
                                        <p>FirstName: {LastName}</p>
                                    </td>
                                    <td width="50%" valign="top" style="padding:6px;">
                                        <p>Description:</p>
                                        {DescriptionArea}
                                    </td>
                                </tr>
                            </table>
                        </Html>
                    </ItemTpl>
                    <Plugins>
                        <ext:ComponentView runat="server">
                            <Items>
                                <ext:ViewItem Value="DescriptionArea" BoundField="Description">
                                    <Component>
                                        <ext:TextArea runat="server" Height="60" />
                                    </Component>
                                </ext:ViewItem>
                            </Items>
                        </ext:ComponentView>
                    </Plugins>
                </ext:DataView>
            </Items>
        </ext:Panel>

        <br />

        <ext:Panel
            runat="server"
            Title="Inject by Selector"
            Width="360"
            Layout="Fit">
            <Items>
                <ext:DataView runat="server" Padding="6">
                    <Store>
                        <ext:Store ID="Store2" runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Directory" />
                                        <ext:ModelField Name="Files" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ItemTpl runat="server">
                        <Html>
                            <div>Files of {Directory}</div>
                            <tpl for="Files">
                                <div class="file-button" file="{file}"></div>
                            </tpl>
                            <br />
                        </Html>
                    </ItemTpl>
                    <Plugins>
                        <ext:ComponentView runat="server">
                            <Items>
                                <ext:ViewItem Selector="div.file-button">
                                    <Component>
                                        <ext:Button runat="server" Handler="App.direct.GetFile(this.record.data.Directory, this.text);" />
                                    </Component>
                                </ext:ViewItem>
                            </Items>
                            <Listeners>
                                <BeforeComponentBind Handler="component.text = target.getAttribute('file');" />
                            </Listeners>
                        </ext:ComponentView>
                    </Plugins>
                </ext:DataView>
            </Items>
        </ext:Panel>

        <br />

        <p>Combobox with widgets</p>

        <ext:ComboBox runat="server">
            <Items>
                <ext:ListItem Text="Item 1" />
                <ext:ListItem Text="Item 2" />
                <ext:ListItem Text="Item 3" />
                <ext:ListItem Text="Item 4" />
                <ext:ListItem Text="Item 5" />
            </Items>
            <ListConfig>
                <ItemTpl runat="server">
                    <Html>
                        <div style="height: 24px; position: relative;">
                            <div style="margin-top:3px;">{field1}</div>
                            <div class="remove-trigger" style="position:absolute; right:0px; top:0px; line-height: 12px;"></div>
                        </div>
                    </Html>
                </ItemTpl>
                <Plugins>
                    <ext:ComponentView runat="server">
                        <Items>
                            <ext:ViewItem Selector="div.remove-trigger">
                                <Component>
                                    <ext:Button
                                        runat="server"
                                        Icon="Decline"
                                        ToolTip="Delete"
                                        Flat="true"
                                        Handler="var view = this.parentView.view; Ext.defer(view.pickerField.alignPicker, 1, view.pickerField); view.store.remove(this.record);" />
                                </Component>
                            </ext:ViewItem>
                        </Items>
                    </ext:ComponentView>
                </Plugins>
            </ListConfig>
        </ext:ComboBox>
    </form>
</body>
</html>
