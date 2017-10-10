<%@ Page Language="C#" %>
<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void HandleBtnClick(object sender, DirectEventArgs e)
    {
        TextField1.InputMask.SetPattern("99/99/9999");
        TextField1.Call("setNote", "99/99/9999");
    }
</script>

<html>
<head runat="server">
    <title>Native Input Mask - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script type="text/javascript">
        var toggleInputMask = function () {
            var newPattern = '(999) 999-9999';
            if (App.TextField1.inputMask.getPattern() == newPattern) {
                newPattern = '(99) 9999-9999';
            };

            App.TextField1.inputMask.setPattern(newPattern);
            App.TextField1.setNote(newPattern);
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Native Input Mask</h1>
        <p>The Native InputMask is a TextField feature, used to add an input mask to the field.</p>
        <p>It has been introduced in Ext.NET 4.5 (ExtJS 6.5.2) and is a simpler approach to the InputMask plugin.</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="550"
            Title="Input Mask"
            Closable="false"
            BodyPadding="5">
            <Items>
                <ext:Container runat="server" WidthSpec="100%" Layout="FormLayout">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="200" />
                    </Defaults>
                    <Items>
                        <ext:TextField runat="server" Note="(999) 999-9999" FieldLabel="Phone">
                            <InputMask Pattern="(999) 999-9999" />
                        </ext:TextField>

                        <ext:TextField runat="server" Note="*9.99" FieldLabel="* means any character accepted">
                            <InputMask Pattern="*9.99" />
                        </ext:TextField>

                        <%-- This is currently broken. Can't input any text at all when set. --%>
                        <%-- Notified Sencha at: https://www.sencha.com/forum/showthread.php?465846 --%>
                        <%--<ext:TextField
                            runat="server"
                            FieldLabel="Keep mask displayed"
                            Note="(999) 999-9999"
                            AutoHideInputMask="false">
                            <InputMask Pattern="(999) 999-9999" />
                        </ext:TextField>--%>

                        <ext:TextField runat="server" Note="00.000-000 (zero or nine are the same)" FieldLabel="Wildcard with 0's">
                            <InputMask Pattern="00.000-000" />
                        </ext:TextField>

                        <ext:TextField
                            runat="server"
                            Note="99.999-999 (quick string pattern)"
                            FieldLabel="String pattern"
                            InputMaskString="99.999-999" />

                        <ext:TextField runat="server" ID="TextField1" Note="(999) 999-9999" FieldLabel="Masked Input">
                            <InputMask Pattern="(999) 999-9999" />
                        </ext:TextField>
                    </Items>
                </ext:Container>

                <ext:Container runat="server" Layout="HBoxLayout" WidthSpec="100%">
                    <Items>
                        <ext:Button runat="server" Text="Change Input Mask (server-side)" OnDirectClick="HandleBtnClick" />
                        <ext:ToolbarSpacer runat="server" Width="25" />
                        <ext:Button runat="server" Text="Change Input Mask (client-side)" Handler="toggleInputMask();" />
                    </Items>
                </ext:Container>
            </Items>
        </ext:Window>
   </form>
</body>
</html>
