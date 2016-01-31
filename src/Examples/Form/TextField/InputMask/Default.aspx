<%@ Page Language="C#" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Input Mask - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Input Mask</h1>
        <p>InputMask is a plugin for TextField, used to add an input mask to the field.</p>
        
        <ext:Window 
            runat="server" 
            Width="550"
            Height="370"            
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
