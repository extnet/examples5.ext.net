<%@ Page Language="C#" %>
<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // This page has no postback/ajax interactions so we don't test for it

        // the code below just binds a good height/width to the panel depending on the active theme
        var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

        switch (curTheme.Theme)
        {
            case Ext.Net.Theme.Triton:
            case Ext.Net.Theme.CrispTouch:
            case Ext.Net.Theme.NeptuneTouch:
                Window1.Height = 475;
                break;
            case Ext.Net.Theme.Gray:
            case Ext.Net.Theme.Default:
                Window1.Height = 335;
                break;
            case Ext.Net.Theme.Crisp:
                Window1.Height = 370;
                break;
            case Ext.Net.Theme.Neptune:
            case Ext.Net.Theme.Aria:
                Window1.Height = 375;
                break;
            default:
                // If ever any other theme take place, then use the biggest of the values above
                Window1.Height = 475;
                break;
        }
    }
</script>

<html>
<head runat="server">
    <title>Input Mask - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style type="text/css">
        .x-form-item-body {
            height: initial
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Input Mask</h1>
        <p>InputMask is a plugin for TextField, used to add an input mask to the field.</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="550"
            Title="Input Mask"
            Closable="false"
            Layout="Form"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="LabelWidth" Value="200" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" Note="(999) 999-9999" FieldLabel="Phone">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="(999) 999-9999" />
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" Note="(999) 999-9999?+99999" FieldLabel="All symbols after '?' are optional.">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="(999) 999-9999?+99999" />
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" Note="~9.99" FieldLabel="~ is custom mask symbol (+ or -)">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="~9.99">
                            <MaskSymbols>
                                <ext:MaskSymbol Name="~" Regex="[+-]" />
                            </MaskSymbols>
                        </ext:InputMask>
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Custom common placeholder" Note="(999) 999-9999  (Always visible mask)">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="(999) 999-9999" Placeholder="#" AlwaysShow="true" />
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Custom placeholders" Note="Input a date">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="dt/mn/yzzz">
                            <MaskSymbols>
                                <ext:MaskSymbol Name="d" Regex="[0123]" Placeholder="d" />
                                <ext:MaskSymbol Name="t" Regex="[0-9]" Placeholder="d" />
                                <ext:MaskSymbol Name="m" Regex="[01]" Placeholder="m" />
                                <ext:MaskSymbol Name="n" Regex="[0-9]" Placeholder="m" />
                                <ext:MaskSymbol Name="y" Regex="[12]" Placeholder="y" />
                                <ext:MaskSymbol Name="z" Regex="[0-9]" Placeholder="y" />
                            </MaskSymbols>
                        </ext:InputMask>
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="ClearWhenInvalid=false" Note="Always visible mask">
                    <Plugins>
                        <ext:InputMask runat="server"
                            Mask="(999) 999-9999"
                            AlwaysShow="true"
                            ClearWhenInvalid="false"
                            InvalidMaskText="The value doesn't match the mask" />
                    </Plugins>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Unmask on blur" Note="(999) 999-9999">
                    <Plugins>
                        <ext:InputMask runat="server" Mask="(999) 999-9999" UnmaskOnBlur="true" />
                    </Plugins>
                </ext:TextField>
            </Items>
        </ext:Window>
   </form>
</body>
</html>
