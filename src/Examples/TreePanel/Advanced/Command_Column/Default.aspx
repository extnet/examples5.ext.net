<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with CommandColumn - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void ToggleMode(object sender, DirectEventArgs e)
        {
            X.ControlsScripting = false;
            // Suspend script generation during property changing
            ((CommandColumn)TreePanel1.ColumnModel.Columns[1]).OverOnly = ToggleButton.Pressed;
            X.ControlsScripting = true;
            
            TreePanel1.Update();
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>TreePanel with CommandColumn</h1>
        
        <br />
        <br />

        <ext:Button ID="ToggleButton" runat="server" 
            Text="Over only" 
            AllowDepress="true" 
            EnableToggle="true">
            <DirectEvents>
                <Toggle OnEvent="ToggleMode" />
            </DirectEvents>
        </ext:Button>
            
        <br />

        <ext:TreePanel 
            ID="TreePanel1" 
            runat="server" 
            Title="My Task List"
            Icon="Accept"
            Height="400"
            Width="250"
            UseArrows="true"
            AutoScroll="true"
            Animate="true"            
            HideHeaders="true"
            RootVisible="false">
            <Root>
                <ext:Node>
                    <Children>
                        <ext:Node Text="To Do" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Go jogging" Leaf="true" />
                                <ext:Node Text="Take a nap" Leaf="true" />
                                <ext:Node Text="Clean house" Leaf="true" />
                            </Children>
                        </ext:Node>
                        
                        <ext:Node Text="Grocery List" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Bananas" Leaf="true" />
                                <ext:Node Text="Milk" Leaf="true" />
                                <ext:Node Text="Cereal" Leaf="true" />
                                
                                <ext:Node Text="Energy foods" Icon="Folder" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Coffee" Leaf="true" />
                                        <ext:Node Text="Red Bull" Leaf="true" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                        
                        <ext:Node Text="Kitchen Remodel" Icon="Folder" Expanded="true">
                            <Children>
                                <ext:Node Text="Finish the budget" Leaf="true" />
                                <ext:Node Text="Call contractors" Leaf="true" />
                                <ext:Node Text="Choose design" Leaf="true" />
                            </Children>
                        </ext:Node>
                    </Children>
                </ext:Node>
            </Root>
            
            <ColumnModel>
                <Columns>
                    <ext:TreeColumn runat="server" Flex="1" DataIndex="text" />
                    <ext:CommandColumn runat="server" Width="40">
                        <Commands>
                            <ext:GridCommand CommandName="Edit" Icon="PageWhiteEdit" ToolTip-Text="Edit task" />
                        </Commands>
                        <PrepareToolbar Handler="return record.data.leaf;" />
                        <Listeners>
                            <Command Handler="Ext.Msg.alert('Edit', record.data.text);" />
                        </Listeners>
                    </ext:CommandColumn>
                </Columns>
            </ColumnModel>
                  
         </ext:TreePanel>
    </form>
</body>
</html>