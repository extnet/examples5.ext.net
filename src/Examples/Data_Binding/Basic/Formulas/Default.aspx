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
                x = 10
            },

            // formulas : Object
            // An object that defines named values whose value is managed by function calls. The names of the properties of this object are assigned as values in the ViewModel.
            // More information at http://docs-origin.sencha.com/extjs/5.0.1/#!/api/Ext.app.bind.Formula
            formulas = new
            {
                quad = new JFunction("return get('twice') * 2;", "get"),
                twice = new JFunction("return get('x') * 2;", "get")
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Formulas - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Formulas</h1>

        <p>This example shows data binding using formulas (calculated properties). This example <br />
           also demonstrates automatic dependency resolution between formulas that depend on each <br />
           other's values.
        </p>

        <ext:Panel
            runat="server"
            Width="370"
            BodyPadding="10"
            Title="View Model Formulas"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <Items>
                <ext:NumberField runat="server" FieldLabel="Number" BindString="{x}" />
                <ext:DisplayField runat="server" FieldLabel="Calculated" BindString="{x} * 2 = {twice} / {x} * 4 = {quad}" />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>