<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        string tpl = "Age : {0}<br />Test : {1}";

        this.Label1.Html = string.Format(tpl, this.NumberField1.Number, this.NumberField2.Number);
    }
</script>
    
<!DOCTYPE html>

<html>
<head runat="server">
    <title>NumberField - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>NumberField</h1>

        <ext:Panel 
            ID="Panel1" 
            runat="server" 
            Title="Simple Form"
            Width="250"
            Frame="true"
            Layout="Form"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="LabelWidth" Value="40" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:NumberField ID="NumberField1" runat="server" FieldLabel="Age" />
                <ext:NumberField 
                    ID="NumberField2" 
                    runat="server" 
                    FieldLabel="Test" 
                    MinValue="0"
                    MaxValue="100"
                    AllowDecimals="true"
                    DecimalPrecision="1"
                    Step="0.4"
                    />
            </Items>
            <Buttons>
                <ext:Button ID="Button1" runat="server" Text="Submit">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" />
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Panel>
        
        <ext:Label ID="Label1" runat="server" />
    </form>
</body>
</html>
