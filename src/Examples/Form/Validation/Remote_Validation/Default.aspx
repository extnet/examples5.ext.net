<%@ Page Language="C#" %>

<script runat="server">
    protected void CheckField(object sender, RemoteValidationEventArgs e)
    {
        TextField field = (TextField)sender;

        if (field.Text == "Valid")
        {
            e.Success = true;
        }
        else
        {
            e.Success = false;
            e.ErrorMessage = "'Valid' is valid value only";
        }

        System.Threading.Thread.Sleep(1000);
    }

    protected void CheckCombo(object sender, RemoteValidationEventArgs e)
    {
        ComboBox combo = (ComboBox)sender;

        if (combo.SelectedItem.Value == "2")
        {
            e.Success = true;
        }
        else
        {
            e.Success = false;
            e.ErrorMessage = "'Valid' is valid value only";
        }

        System.Threading.Thread.Sleep(1000);
    }

    [DirectMethod]
    public object DirectCheckField(string value)
    {
        if (value == "Valid")
        {
            return true;
        }
        else
        {
            return "'Valid' is valid value only";
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Remote Validation - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:FormPanel
            runat="server"
            Title="Remote Validation Form"
            BodyPadding="18"
            Frame="true"
            Width="500"
            DefaultAnchor="100%">
            <FieldDefaults LabelWidth="250" PreserveIndicatorIcon="true" />
            <Items>
                <ext:TextField runat="server" FieldLabel="No validation" />
                <ext:TextField runat="server" FieldLabel="Client only validation" AllowBlank="false" />
                <ext:TextField runat="server" FieldLabel="Server only validation" IsRemoteValidation="true">
                    <RemoteValidation OnValidation="CheckField" />
                </ext:TextField>
                <ext:TextField runat="server" FieldLabel="DirectFn validation" IsRemoteValidation="true">
                    <RemoteValidation DirectFn="App.direct.DirectCheckField" />
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Client and server validation" IsRemoteValidation="true" AllowBlank="false">
                    <RemoteValidation OnValidation="CheckField" />
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Client and server validation (web service)" IsRemoteValidation="true" AllowBlank="false">
                    <RemoteValidation Url="ValidationService.asmx/CheckField" Json="true" />
                </ext:TextField>

                <ext:ComboBox
                    runat="server"
                    AllowBlank="false"
                    Editable="false"
                    FieldLabel="ComboBox"
                    IsRemoteValidation="true">
                  <RemoteValidation OnValidation="CheckCombo" />
                  <Items>
                      <ext:ListItem Text="Invalid" Value="1" />
                      <ext:ListItem Text="Valid" Value="2" />
                  </Items>
                </ext:ComboBox>
            </Items>
            <Buttons>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Submit"
                    Disabled="true"
                    />
            </Buttons>
            <Listeners>
                <ValidityChange Handler="#{Button1}.setDisabled(!valid);" />
            </Listeners>
       </ext:FormPanel>
    </form>
</body>
</html>
