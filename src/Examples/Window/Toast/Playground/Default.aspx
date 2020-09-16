<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        Toast toastObj;
        
        // Simplest approach: only drop the message.
        if (!(enableTitle.Checked || enableToastAlign.Checked || enableExtra.Checked))
        {
            X.Toast(toastText.Text);

            return;
        }
        
        // Now just specify the title.
        if (enableTitle.Checked && !(enableToastAlign.Checked || enableExtra.Checked))
        {
            X.Toast(toastText.Text, toastTitle.Text);

            return;
        }
        
        // Now both title and alignment
        if (enableTitle.Checked && enableToastAlign.Checked && !enableExtra.Checked)
        {
            var align = FetchToastAlign();
            
            X.Toast(toastText.Text, toastTitle.Text, align);

            return;
        }
        
        // From now on, with enableExtra
        // No title nor alignment, just extra settings (object override required)
        if (!(enableTitle.Checked || enableToastAlign.Checked))
        {
            toastObj = new Toast()
            {
                Html = toastText.Text
            };
        }

        // Title but not alignment (from now on, only object overrides used)
        else if (enableTitle.Checked && !enableToastAlign.Checked)
        {
            toastObj = new Toast()
            {
                Html = toastText.Text,
                Title = toastTitle.Text
            };
        }
        
        // No title but alignment 
        else if (!enableTitle.Checked && enableToastAlign.Checked)
        {
            toastObj = new Toast()
            {
                Html = toastText.Text,
                Align = FetchToastAlign()
            };
        }
        
        // Everything enabled
        else
        {
            toastObj = new Toast()
            {
                Html = toastText.Text,
                Title = toastTitle.Text,
                Align = FetchToastAlign(),
            };
        }
        
        // Common settings bound to the toast
        toastObj.StickWhileHover = stickWhileHover.Checked;
        toastObj.Disabled = disabled.Checked;
        toastObj.CloseOnMouseDown = closemd.Checked;
        toastObj.AutoClose = autoClose.Checked;
        toastObj.AutoCloseDelay = GetAutoCloseDelay();

        X.Toast(toastObj);

        return;
    }

    private ToastAlign FetchToastAlign()
    {
        if (toastAlign != null && toastAlign.Value != null)
        {
            return (ToastAlign)JSON.EnumParse(typeof(ToastAlign), (string)toastAlign.Value);
        }

        return ToastAlign.Default;
    }
    
    private int GetAutoCloseDelay()
    {
        int acd;

        if (acDelay == null || acDelay.Text == null)
        {
            return 1000; // Just to be safe
        }
        
        if (int.TryParse(acDelay.Text, out acd))
        {
            return acd;
        }
        else
        {
            acDelay.SetText("1000");

            return 1000; // just return 1 second if the value was not parseable.
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toast Playground - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Toast Playground</h1>

        <p>
            Choose the message and the location on screen you want the Toast displayed,
            then click <code>Toast!</code> Button.
        </p>

        <ext:Panel
            runat="server"
            Width="720"
            BodyPadding="18"
            ButtonAlign="Right">
            <Items>
                <ext:TextArea
                    ID="toastText"
                    runat="server"
                    FieldLabel="Message"
                    Text="My toast!"
                    />
                <ext:FieldSet runat="server" Title="Title">
                    <Items>
                        <ext:Checkbox ID="enableTitle" runat="server" FieldLabel="Enable" />
                        <ext:TextField ID="toastTitle" runat="server" FieldLabel="Title" />
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet runat="server" Title="Position">
                    <Items>
                        <ext:Checkbox ID="enableToastAlign" runat="server" FieldLabel="Enable" />
                        <ext:ComboBox
                            ID="toastAlign"
                            runat="server"
                            ForceSelection="true"
                            FieldLabel="Position">
                            <Items>
                                <ext:ListItem Text="Bottom Right" Value="br" />
                                <ext:ListItem Text="Bottom Left" Value="bl" />
                                <ext:ListItem Text="Top Right" Value="tr" />
                                <ext:ListItem Text="Top Left" Value="tl" />
                                <ext:ListItem Text="Top" Value="t" />
                                <ext:ListItem Text="Left" Value="l" />
                                <ext:ListItem Text="Bottom" Value="b" />
                                <ext:ListItem Text="Right" Value="r" />
                            </Items>
                            <SelectedItems>
                                <ext:ListItem Text="Bottom Right" Value="br" />
                            </SelectedItems>
                        </ext:ComboBox>
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet runat="server" Title="Settings">
                    <Items>
                        <ext:Checkbox ID="enableExtra" runat="server" FieldLabel="Enable" />
                        <ext:Container runat="server" Layout="HBox">
                            <Defaults>
                                <ext:Parameter Name="width" Value="48%" />
                                <ext:Parameter Name="labelWidth" Value="250" />
                            </Defaults>
                            <Items>
                                <ext:Checkbox runat="server" ID="stickWhileHover" FieldLabel="Sticky" />
                                <ext:Checkbox runat="server" ID="disabled" FieldLabel="Disabled" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="HBox">
                            <Defaults>
                                <ext:Parameter Name="width" Value="48%" />
                                <ext:Parameter Name="labelWidth" Value="250" />
                            </Defaults>
                            <Items>
                                <ext:Checkbox ID="closemd" runat="server" FieldLabel="Close on page click" />
                                <ext:Checkbox
                                    ID="autoClose"
                                    runat="server"
                                    FieldLabel="Close after delay"
                                    Checked="true"
                                    />
                            </Items>
                        </ext:Container>
                        <ext:TextField
                            ID="acDelay"
                            runat="server"
                            FieldLabel="Delay"
                            Text="2500"
                            />
                    </Items>
                </ext:FieldSet>
            </Items>
            <Buttons>
                <ext:Button
                    runat="server"
                    Text="Toast!"
                    IconCls="x-md md-icon-check-circle-outline"
                    OnDirectClick="Button1_Click"
                    />
            </Buttons>
        </ext:Panel>
        <ext:Toast runat="server" StickWhileHover="true">
            <Content>
                This toast is defined in markup and shows once -- once the page is loaded.
            </Content>
        </ext:Toast>
    </form>
</body>
</html>