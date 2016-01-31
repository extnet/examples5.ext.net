<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TagLabel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .red-text div
        {
            color:red;
        }

        .blue-text div
        {
            color:green;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>TagLabel</h1>

        <h2>Simple Tags</h2>

        <ext:TagLabel runat="server">
            <Tags>
                <ext:Tag Text="Tag 1" />
                <ext:Tag Text="Tag 2" />
                <ext:Tag Text="Tag 3" />
            </Tags>
        </ext:TagLabel>

        <br />

        <h2>Simple Tags with Icons</h2>
        
        <ext:TagLabel runat="server">
            <Tags>
                <ext:Tag Text="Tag 1" Icon="UserAdd" />
                <ext:Tag Text="Tag 2" Icon="UserAlert" />
                <ext:Tag Text="Tag 3" Icon="UserDelete" />
            </Tags>
        </ext:TagLabel>
        
        <br />

        <h2>Simple Tags with custom Css and ToolTips</h2>
        
        <ext:TagLabel runat="server">
            <Tags>
                <ext:Tag Text="Tag 1" Cls="red-text" QTip="Red text" />
                <ext:Tag Text="Tag 2" Cls="blue-text" QTip="Blue text" />
                <ext:Tag Text="Tag 3" Style="color:teal;font-weight:bold;" QTip="Teal text" />
            </Tags>
        </ext:TagLabel>
        
        <br />

        <h2>Closable Tags</h2>

        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:TagLabel runat="server" DefaultClosable="true" Width="180">
                    <Tags>
                        <ext:Tag Text="Tag 1" />
                        <ext:Tag Text="Tag 2" />
                        <ext:Tag Text="Tag 3" Closable="false" />
                    </Tags>
                </ext:TagLabel>

                <ext:Button runat="server" Text="Show tags" Handler="alert(this.prev().getValue());" />
            </Items>
        </ext:Container>  
        
        <br />      

        <h2>Stacked Tags</h2>

        <ext:TagLabel runat="server" Stacked="true" Width="100">
            <Tags>
                <ext:Tag Text="Tag 1" />
                <ext:Tag Text="Tag 2" />
                <ext:Tag Text="Tag 3" />
            </Tags>
        </ext:TagLabel>

        <br />

        <h2>Selectable Tags (first single selection, second simple selection)</h2>

        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:TagLabel runat="server" SelectionMode="Single" TrackOver="true">
                    <Tags>
                        <ext:Tag Text="Tag 1" />
                        <ext:Tag Text="Tag 2" />
                        <ext:Tag Text="Tag 3" Closable="false" />
                    </Tags>
                </ext:TagLabel>

                <ext:Button 
                    runat="server" 
                    Text="Show selected tags" 
                    Handler="alert(Ext.Array.pluck(this.prev().getSelected(), 'text').join(','));" 
                    />
            </Items>
        </ext:Container>  

        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:TagLabel runat="server" SelectionMode="Simple">
                    <Tags>
                        <ext:Tag Text="Tag 1" />
                        <ext:Tag Text="Tag 2" />
                        <ext:Tag Text="Tag 3" Closable="false" />
                    </Tags>
                </ext:TagLabel>

                <ext:Button 
                    runat="server" 
                    Text="Show selected tags" 
                    Handler="alert(Ext.Array.pluck(this.prev().getSelected(), 'text').join(','));" 
                    />
            </Items>
        </ext:Container>  

        <br />

        
        <h2>Tags with Menu (right-click)</h2>

        <ext:TagLabel runat="server">
            <Tags>
                <ext:Tag Text="Tag 1" />
                <ext:Tag Text="Tag 2" />
                <ext:Tag Text="Tag 3" />
            </Tags>
            <Menu>
                <ext:Menu runat="server">
                    <Items>
                        <ext:MenuItem 
                            runat="server" 
                            Text="Add"
                            Icon="Add"
                            Handler="var menu = this.up('menu'); menu.tagLabel.insert(menu.tagLabel.indexOf(menu.activeTag), {text: Ext.id()});" 
                            />
                        <ext:MenuItem 
                            runat="server" 
                            Text="Delete" 
                            Icon="Decline" 
                            Handler="var menu = this.up('menu'); menu.tagLabel.remove(menu.activeTag);" 
                            />
                    </Items>
                </ext:Menu>
            </Menu>
        </ext:TagLabel>
   </form>
</body>
</html>
