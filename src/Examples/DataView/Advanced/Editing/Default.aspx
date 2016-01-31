<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.Net Examples - Editing</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />   
    <link href="app.css" rel="stylesheet" />
    <script src="app.js"></script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Editable DataView</h1>        
              
        <h2>Todos</h2>
        
        <ext:TextField 
            runat="server" 
            Cls="todo-field"
            Width="470"
            EmptyText="What needs to be done?"
            EnableKeyEvents="true">
            <Listeners>
                <KeyDown  Fn="addTodo" />
            </Listeners>
        </ext:TextField>
        
        <ext:Checkbox ID="Checkbox1" runat="server" BoxLabel="Mark all as complete" Hidden="true">
            <Listeners>
                <Change Fn="checkAllClick" />
            </Listeners>
        </ext:Checkbox>
        
        <br />
        <ext:DataView 
            ID="TodoList"
            runat="server"
            Width="470"
            Cls="todo-list"
            ItemSelector="li">
            <AutoEl Tag="Ul" />
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Id" />
                                <ext:ModelField Name="Label" />
                                <ext:ModelField Name="Checked" Type="Boolean" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Listeners>
                        <Update Fn="onListChange" />
                        <DataChanged Fn="onListChange" Buffer="50" />
                    </Listeners>
                </ext:Store>
            </Store>
            <Tpl>
                <Html>
                    <tpl for=".">
		                <li class="<tpl if="Checked">done</tpl> <tpl if="editing">editing</tpl>">
		                    <div class="view">
		                        <input type="checkbox" <tpl if="Checked">checked</tpl> />
		                        <label>{Label}</label>
		                        <a class="destroy"></a>
		                    </div>
		                    <input class="edit" type="text" value="{Label}">
		                </li>
		            </tpl>
                </html>            </Tpl>
            <Listeners>
                <AfterRender Fn="initEvents" />
                <ItemDblClick Fn="startEdit" />
            </Listeners>
        </ext:DataView>

        <ext:Toolbar ID="Toolbar1" runat="server" Width="470" Hidden="true">
            <Items>
                <ext:Container runat="server" />
                <ext:ToolbarFill />
                <ext:Button runat="server" Handler="clearAll" StandOut="true" />
            </Items>
        </ext:Toolbar>

        <div id="instructions">
            Double-click to edit a todo
	    </div> 
    </form>
</body>
</html>