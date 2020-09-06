<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            SparkHolder.Items.Add(this.CreateSpark(SparkType.Text, Values.Text));
        }
    }

    protected void OnTypeChange(object sender, DirectEventArgs e)
    {
        SparkHolder.RemoveAll();
        this.CreateSpark(SparkType.Text, Values.Text).AddTo(SparkHolder);
    }

    private SparklineBase CreateSpark(string type, string values)
    {
        SparklineBase spark = (SparklineBase)System.Activator.CreateInstance("Ext.Net", "Ext.Net." + type + "SparkLine").Unwrap();
        spark.Height = 25;
        spark.Width = 100;
        spark.Values = values.Split(',').Select(v => Convert.ToDouble(v)).ToArray();

        return spark;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>SparkLine - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var validator = function (v) {
            var result = [];

            v = v.replace(/\s/g, '');
            v = v.replace(/,$/, '');
            v = v.split(',');

            for (var i = 0; i < v.length; i++) {
                if (!Ext.isNumeric(v[i])) {
                    return 'Value must be a comma separated array of numbers';
                }
            }

            return true;
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>SparkLine Example</h1>

        <ext:Panel
            runat="server"
            Height="480"
            Width="960"
            Frame="true"
            Title="Sparklines"
            BodyPadding="18">
            <Items>
                <ext:TextField
                    ID="Values"
                    runat="server"
                    FieldLabel="Values"
                    Text="6,10,4,-3,7,2">
                    <Validator Fn="validator" />
                    <DirectEvents>
                        <Change OnEvent="OnTypeChange" Buffer="500" />
                    </DirectEvents>
                </ext:TextField>

                <ext:ComboBox
                    ID="SparkType"
                    runat="server"
                    FieldLabel="Type"
                    Editable="false"
                    Text="Line">
                    <DirectEvents>
                        <Change OnEvent="OnTypeChange" Buffer="500" />
                    </DirectEvents>
                    <Items>
                        <ext:ListItem Text="Line" />
                        <ext:ListItem Text="Box" />
                        <ext:ListItem Text="Bullet" />
                        <ext:ListItem Text="Discrete" />
                        <ext:ListItem Text="Pie" />
                        <ext:ListItem Text="TriState" />
                    </Items>
                </ext:ComboBox>

                <ext:Container ID="SparkHolder" runat="server" PaddingSpec="0 0 0 105" />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>