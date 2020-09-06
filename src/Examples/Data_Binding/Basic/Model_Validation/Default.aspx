<%@ Page Language="C#" %>

<script runat="server">
    public class MyModel
    {
        public static object Model = new
        {
            // links : Object
            // Links provide a way to assign a simple name to a more complex bind. The primary use for this is to assign names to records in the data model.
            links = new
            {
                theCustomer = new
                {
                    type = "Customer",
                    id = 1
                }
            }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Model Validation - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Model Validation</h1>

        <p>This example shows simple data binding to models (Ext.data.Model). When the value is <br />
           changed by the user, the change is reflected to the model and is then validated. The <br />
           validation is reflected back to the form field to which the value is bound. The <br />
           validation is based on the length of the field. By looking at the model code, you can <br />
           see the validator that is attached to the field. <br />
        </p>

        <ext:Model runat="server" Name="Customer">
            <Fields>
                <ext:ModelField Name="name" />
                <ext:ModelField Name="phone" Type="String" />
            </Fields>
            <Validators>
                <ext:PresenceValidator Field="name" />
                <ext:FormatValidator Field="phone" Matcher="^\d{3}-?\d{3}-?\d{4}$" Message="Must be in the format xxx-xxx-xxxx" />
            </Validators>
            <Proxy>
                <ext:AjaxProxy Url="customers.json" />
            </Proxy>
        </ext:Model>

        <ext:Panel
            runat="server"
            Title="Customer Details"
            Width="360"
            BodyPadding="18"
            Layout="Anchor"
            DefaultAnchor="-30"
            ModelValidation="true"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <Items>
                <ext:TextField runat="server" FieldLabel="Name" MsgTarget="Side" BindString="{theCustomer.name}" />
                <ext:TextField runat="server" FieldLabel="Phone" MsgTarget="Side" BindString="{theCustomer.phone}" />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>