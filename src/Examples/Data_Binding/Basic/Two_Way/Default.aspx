<%@ Page Language="C#" %>

<script runat="server">
    public class MyModel
    {
        public static object Model = new
        {
            //data : Object
            //This object holds the arbitrary data that populates the ViewModel and is then available for binding.
            data = new
            {
                title = "The title"
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Two way Data Binding - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Two way Data Binding</h1>

        <p>This example shows simple two way data binding. When the value is changed by the user <br />
           in the field, the change is reflected in the panel title. Similarly, when the value is <br />
           changed in the view model, the same change is reflected in the text field.
        </p>

        <ext:Panel
            runat="server"
            Width="300"
            BodyPadding="10"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <Bind>
                <ext:Parameter Name="title" Value="{title}" />
            </Bind>
            <Items>
                <ext:TextField
                    runat="server"
                    FieldLabel="Title"
                    LabelWidth="50"
                    BindString="{title}"
                    />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>