<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BuildTree(TreePanel1.Root);
            this.BuildTree(TreePanel2.Root);
        }
    }

    private Ext.Net.NodeCollection BuildTree(Ext.Net.NodeCollection Children)
    {
        if (Children == null)
        {
            Children = new Ext.Net.NodeCollection();
        }

        Ext.Net.Node root = new Ext.Net.Node();
        root.Text = "Root";
        Children.Add(root);

        for (int i = 0; i < 3; i++)
        {
            Ext.Net.Node node = new Ext.Net.Node();
            node.Text = "TextField node";
            node.Leaf = true;
            node.CustomAttributes.Add(new ConfigItem("editor", "0", ParameterMode.Raw));
            root.Children.Add(node);

            node = new Ext.Net.Node();
            node.Text = "1";
            node.Leaf = true;
            node.CustomAttributes.Add(new ConfigItem("editor", "1", ParameterMode.Raw));
            root.Children.Add(node);

            node = new Ext.Net.Node();
            node.Text = "ComboBox node";
            node.Leaf = true;
            node.CustomAttributes.Add(new ConfigItem("editor", "2", ParameterMode.Raw));
            root.Children.Add(node);
        }

        return Children;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with Editor - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel with Editor</h1>

        <h3>Tree Editor Filter</h3>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Icon="Anchor"
            Title="Tree Editors Filter"
            Scrollable="Both"
            Width="250"
            CollapseFirst="True"
            RootVisible="False">
            <Fields>
                <ext:ModelField Name="editor" Type="Int" />
            </Fields>
            <Editor>
                <ext:TextField runat="server" />
                <ext:NumberField runat="server" />
                <ext:ComboBox runat="server" Editable="false">
                    <Items>
                        <ext:ListItem Text="Item 1" />
                        <ext:ListItem Text="Item 2" />
                    </Items>
                </ext:ComboBox>
            </Editor>

            <EditorStrategy Handler="return record.data.editor;" />

            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
         </ext:TreePanel>

        <h3>TreePanel with Active Editor</h3>

        <ext:TreePanel
            ID="TreePanel2"
            runat="server"
            Icon="Anchor"
            Title="Tree Active Editor"
            Scrollable="Both"
            Width="250"
            CollapseFirst="True"
            ActiveEditor="Editor1"
            RootVisible="False">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Editor1" ToggleGroup="editor" Pressed="true">
                            <Listeners>
                                <Click Handler="#{TreePanel2}.activeEditorIndex = 0;" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Editor2" ToggleGroup="editor">
                            <Listeners>
                                <Click Handler="#{TreePanel2}.activeEditorIndex = 1;" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Editor3" ToggleGroup="editor">
                            <Listeners>
                                <Click Handler="#{TreePanel2}.activeEditorIndex = 2;" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Editor>
                <ext:TextField runat="server" />
                <ext:NumberField runat="server" />
                <ext:ComboBox runat="server" ForceSelection="true">
                    <Items>
                        <ext:ListItem Text="Item 1" />
                        <ext:ListItem Text="Item 2" />
                    </Items>
                </ext:ComboBox>
            </Editor>

            <EditorStrategy Handler="return panel.activeEditorIndex || 0;" />

            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
         </ext:TreePanel>
    </form>
</body>
</html>