<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<object> data = new List<object> {
            new { FirstName = "Bill", LastName = "Foot" },
            new { FirstName = "Bill", LastName = "Little" },
            new { FirstName = "Bob", LastName = "Jones" },
            new { FirstName = "Bob", LastName = "Train" },
            new { FirstName = "Chris", LastName = "Johnson" }
        };

        this.Store1.DataSource = data;
        this.Store1.DataBind();

        this.ResourceManager1.RegisterOnReadyScript("onSpin(App.SpinnerField1);");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spinner Plugin - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onSpin = function (spinner, direction) {
            var step = 0,
                minValue = 0,
                maxValue = App.Store1.getCount() - 1;

            if (direction) {
                step = direction === "up" ? -1 : 1;
            }

            newIndex = Ext.Number.constrain(spinner.index + step, minValue, maxValue);
            spinner.index = newIndex;
            spinner.setValue(App.Store1.getAt(newIndex).get('FullName'));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />

        <h1>Custom SpinnerField</h1>

        <p>This demonstrates custom implementation of the SpinnerField functionality.</p>

        <p>It's just an example. In a real application it would be best to create a custom control inherited from a SpinnerField.</p>

        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="FirstName" />
                        <ext:ModelField Name="LastName" />
                        <ext:ModelField Name="FullName">
                            <Convert Handler="return record.data.LastName + ', ' + record.data.FirstName;" />
                        </ext:ModelField>
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>

        <ext:FormPanel
            runat="server"
            Title="Form"
            Width="400"
            BodyPadding="18"
            LabelWidth="150">
            <Items>
                <ext:SpinnerField
                    ID="SpinnerField1"
                    runat="server"
                    Index="2">
                    <Listeners>
                        <Spin Fn="onSpin" Buffer="100" />
                    </Listeners>
                </ext:SpinnerField>
            </Items>
        </ext:FormPanel>
   </form>
</body>
</html>
