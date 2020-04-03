<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net.Examples" Namespace="Ext.Net.Examples.SimpleTasks" TagPrefix="task" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple Tasks - Ext.NET Examples</title>

    <link href="resources/main.css" rel="stylesheet" />
    <script src="resources/main.js"></script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Namespace="" />

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <task:TasksTopBar runat="server" Region="North" />
                <task:TasksTree
                    ID="TasksTree1"
                    runat="server"
                    Region="West"
                    MarginSpec="3 0 3 3"
                    RootVisible="false"
                    MinWidth="120"
                    Split="true">
                        <Listeners>
                            <BeforeCollapse Handler="this.setTitle('');" />
                            <BeforeExpand Handler="this.setTitle(this.initialConfig.title);" />
                        </Listeners>
                    </task:TasksTree>
                <task:TasksGrid
                    ID="TasksGrid1"
                    runat="server"
                    Region="Center"
                    MarginSpec="3 3 3 0"
                    />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>