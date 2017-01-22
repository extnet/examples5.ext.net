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
    <title>Window Toast Playground - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Window Toast Playground</h1>

        <p>
            Choose the message and the location on screen you want the Toast displayed,
            then click "Toast!". In this page's source code you can see different ways to
            trigger the toast.
        </p>

        <ext:FormPanel runat="server">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
            </LayoutConfig>
            <Defaults>
                <ext:Parameter Name="margin" Value="5px" />
            </Defaults>
            <Items>
                <ext:TextArea ID="toastText" runat="server" FieldLabel="Toast Contents" Text="My toast!" />
                <ext:FieldSet runat="server" Title="Toast title">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Checkbox ID="enableTitle" runat="server" FieldLabel="Show title" />
                        <ext:TextField ID="toastTitle" runat="server" FieldLabel="Toast" />
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet runat="server" Title="Toast position">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Checkbox ID="enableToastAlign" runat="server" FieldLabel="Specify Toast alignment on screen" />
                        <ext:ComboBox ID="toastAlign" runat="server" ForceSelection="true" FieldLabel="Position to show on screen">
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
                <ext:FieldSet runat="server" Title="Extra settings">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
                    </LayoutConfig>
                    <Defaults>
                        <ext:Parameter Name="labelWidth" Value="250" />
                    </Defaults>
                    <Items>
                        <ext:Checkbox runat="server" ID="enableExtra" FieldLabel="Use extra settings" />
                        <ext:Container runat="server" Layout="HBoxLayout">
                            <Defaults>
                                <ext:Parameter Name="width" Value="48%" />
                                <ext:Parameter Name="labelWidth" Value="250" />
                            </Defaults>
                            <Items>
                                <ext:Checkbox runat="server" ID="stickWhileHover" FieldLabel="Stick the toast while mouse is over it" />
                                <ext:Checkbox runat="server" ID="disabled" FieldLabel="Grayed out / disabled" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="HBoxLayout">
                            <Defaults>
                                <ext:Parameter Name="width" Value="48%" />
                                <ext:Parameter Name="labelWidth" Value="250" />
                            </Defaults>
                            <Items>
                                <ext:Checkbox ID="closemd" runat="server" FieldLabel="Close when clicking the mouse anywhere" />
                                <ext:Checkbox ID="autoClose" runat="server" FieldLabel="Close automatically after a delay" Checked="true" />
                            </Items>
                        </ext:Container>
                        <ext:TextField ID="acDelay" runat="server" FieldLabel="Delay (in milisseconds) to automatically close" Text="2500" />
                    </Items>
                </ext:FieldSet>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Toast!"
                    Icon="Accept"
                    OnDirectClick="Button1_Click"
                    />
            </Items>
        </ext:FormPanel>
        <ext:Toast
            ID="Toast1" 
            runat="server"
            StickWhileHover="true">
            <Content>
                This toast is defined in markup and shows once -- once the page is loaded.
            </Content>
        </ext:Toast>
    </form>
</body>
</html>