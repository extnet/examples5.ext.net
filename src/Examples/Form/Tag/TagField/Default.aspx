<%@ Page Language="C#" %>

<script runat="server">
    protected void SubmitHandler(object sender, DirectEventArgs e)
    {
        string tags = "";

        foreach (Tag tag in Tags1.Tags)
        {
            tags += " " + tag.Text;
        }

        X.Msg.Alert("Tags", tags).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TagField - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TagField</h1>

        <h2>Basic</h2>

        <p>Custom values  allowed, input can be moved with left/right arrows</p>

        <ext:TagField runat="server" Width="500" TypeAhead="true">
            <Tags>
                <ext:Tag Value="1" />
            </Tags>
            <Items>
                <ext:Tag Value="1" Text="George" Icon="User" />
                <ext:Tag Value="2" Text="Bob" Icon="UserAdd" />
                <ext:Tag Value="3" Text="John" Icon="UserAlert" />
                <ext:Tag Value="4" Text="Bill" Icon="UserB" />
                <ext:Tag Value="5" Text="Ronald" Icon="UserDelete" />
            </Items>
        </ext:TagField>

        <br />

        <h2>Forcing values</h2>

        <p>Forcing values from the store</p>

        <ext:TagField
            runat="server"
            Width="500"
            ForceSelection="true"
            Editable="false"
            InputMoving="false">
            <Tags>
                <ext:Tag Value="1" />
            </Tags>
            <Items>
                <ext:Tag Value="1" Text="George" Icon="User" />
                <ext:Tag Value="2" Text="Bob" Icon="UserAdd" />
                <ext:Tag Value="3" Text="John" Icon="UserAlert" />
                <ext:Tag Value="4" Text="Bill" Icon="UserB" />
                <ext:Tag Value="5" Text="Ronald" Icon="UserDelete" />
            </Items>
        </ext:TagField>

        <br />

        <h2>Hide selected</h2>

        <p>Hide selected Tags in the picker</p>

        <ext:TagField
            runat="server"
            Width="500"
            ForceSelection="true"
            Editable="false"
            InputMoving="false"
            HideSelected="true">
            <Tags>
                <ext:Tag Value="1" />
                <ext:Tag Value="2" />
                <ext:Tag Value="3" />
            </Tags>
            <Items>
                <ext:Tag Value="1" Text="George" Icon="User" />
                <ext:Tag Value="2" Text="Bob" Icon="UserAdd" />
                <ext:Tag Value="3" Text="John" Icon="UserAlert" />
                <ext:Tag Value="4" Text="Bill" Icon="UserB" />
                <ext:Tag Value="5" Text="Ronald" Icon="UserDelete" />
            </Items>
        </ext:TagField>

        <br />

        <h2>Floating</h2>

        <p>Tags can float to new line</p>

        <ext:TagField
            runat="server"
            Width="200"
            HideTrigger="true"
            Editable="false">
            <Tags>
                <ext:Tag Value="1" />
                <ext:Tag Value="2" />
                <ext:Tag Value="3" />
                <ext:Tag Value="4" />
                <ext:Tag Value="5" />
            </Tags>
            <Items>
                <ext:Tag Value="1" Text="George" Icon="User" />
                <ext:Tag Value="2" Text="Bob" Icon="UserAdd" />
                <ext:Tag Value="3" Text="John" Icon="UserAlert" />
                <ext:Tag Value="4" Text="Bill" Icon="UserB" />
                <ext:Tag Value="5" Text="Ronald" Icon="UserDelete" />
            </Items>
        </ext:TagField>

        <br />

        <h2>Actions</h2>

        <p>Add/remove Tags manually</p>

        <ext:TagField
            ID="Tags1"
            runat="server"
            Width="500"
            TypeAhead="true"
            EmptyText="[Add tags]" >
            <Items>
                <ext:Tag Value="1" Text="George" Icon="User" />
                <ext:Tag Value="2" Text="Bob" Icon="UserAdd" />
                <ext:Tag Value="3" Text="John" Icon="UserAlert" />
                <ext:Tag Value="4" Text="Bill" Icon="UserB" />
                <ext:Tag Value="5" Text="Ronald" Icon="UserDelete" />
            </Items>
        </ext:TagField>
        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:Button runat="server" Text="Add George" Handler="#{Tags1}.addTag('1');" />
                <ext:Button runat="server" Text="Add Ext.Net" Handler="#{Tags1}.addTag('Ext.Net');" />
                <ext:Button runat="server" Text="Remove George" Handler="#{Tags1}.removeTag('1');" />
                <ext:Button runat="server" Text="Set value" Handler="#{Tags1}.setValue(['1', '2']);" />
                <ext:Button runat="server" Text="Submit" OnDirectClick="SubmitHandler" />
            </Items>
        </ext:Container>
    </form>
</body>
</html>