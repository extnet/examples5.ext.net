<%@ Page Language="C#" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        object toastObj;
        
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
            var align = fetchToastAlign();
            
            X.Toast(toastText.Text, toastTitle.Text, align);
            return;
        }
        
        // From now on, with enableExtra
        // No title nor alignment, just extra settings (object override required)
        if (!(enableTitle.Checked || enableToastAlign.Checked))
        {
            toastObj = new
            {
                html = toastText.Text,
                stickWhileHover = stickWhileHover.Checked
            };
            
            X.Toast(toastObj);
            return;
        }

        // Title but not alignment (from now on, only object overrides used)
        if (enableTitle.Checked && !enableToastAlign.Checked)
        {
            toastObj = new
            {
                html = toastText.Text,
                title = toastTitle.Text,
                stickWhileHover = stickWhileHover.Checked
            };

            X.Toast(toastObj);
            return;
        }
        
        // No title but alignment 
        if (!enableTitle.Checked && enableToastAlign.Checked)
        {
            toastObj = new
            {
                html = toastText.Text,
                align = (string)toastAlign.Value, // now we don't need to map it back to ToastAlign
                stickWhileHover = stickWhileHover.Checked
            };

            X.Toast(toastObj);
            return;
        }
        
        // Everything enabled
        toastObj = new
        {
            html = toastText.Text,
            title = toastTitle.Text,
            align = (string)toastAlign.Value, // now we don't need to map it back to ToastAlign
            stickWhileHover = stickWhileHover.Checked,
            closable = closable.Checked,
            closeOnMouseDown = closemd.Checked,
            autoClose = autoClose.Checked,
            autoCloseDelay = getAutoCloseDelay()
        };

        X.Toast(toastObj);
        return;
    }

    private ToastAlign fetchToastAlign()
    {
        if (toastAlign != null && toastAlign.Value != null)
        {
            return (ToastAlign)JSON.EnumParse(typeof(ToastAlign), (string)toastAlign.Value);
        }

        return ToastAlign.Default;
    }
    
    private int getAutoCloseDelay()
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
                <ext:TextArea runat="server" ID="toastText" FieldLabel="Toast Contents" Text="My toast!" />
                <ext:FieldSet runat="server" Title="Toast title">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Checkbox runat="server" ID="enableTitle" FieldLabel="Show title" />
                        <ext:TextField runat="server" ID="toastTitle" FieldLabel="Toast" />
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet runat="server" Title="Toast position">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Pack="Start" Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Checkbox runat="server" ID="enableToastAlign" FieldLabel="Specify Toast alignment on screen" />
                        <ext:ComboBox runat="server" ID="toastAlign" ForceSelection="true" FieldLabel="Position to show on screen">
                            <Items>
                                <ext:ListItem Text="At the Bottom Right Corner" Value="br" />
                                <ext:ListItem Text="At the Bottom Left Corner" Value="bl" />
                                <ext:ListItem Text="At the Top Right Corner" Value="tr" />
                                <ext:ListItem Text="At the Top Left Corner" Value="tl" />
                                <ext:ListItem Text="At Top" Value="t" />
                                <ext:ListItem Text="At Left" Value="l" />
                                <ext:ListItem Text="At Bottom" Value="b" />
                                <ext:ListItem Text="At Right" Value="r" />
                            </Items>
                            <SelectedItems>
                                <ext:ListItem Text="At the Bottom Right Corner" Value="br" />
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
                                <ext:Checkbox runat="server" ID="closable" FieldLabel="Show a button to close the toast" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="HBoxLayout">
                            <Defaults>
                                <ext:Parameter Name="width" Value="48%" />
                                <ext:Parameter Name="labelWidth" Value="250" />
                            </Defaults>
                            <Items>
                                <ext:Checkbox runat="server" ID="closemd" FieldLabel="Close when clicking the mouse anywhere" />
                                <ext:Checkbox runat="server" ID="autoClose" FieldLabel="Close automatically after a delay" />
                            </Items>
                        </ext:Container>
                        <ext:TextField runat="server" ID="acDelay" FieldLabel="Delay (in milisseconds) to automatically close" Text="2500" />
                    </Items>
                </ext:FieldSet>
                <ext:Button
                    runat="server"
                    ID="Button1"
                    Text="Toast!"
                    Icon="Exclamation"
                    OnDirectClick="Button1_Click"
                    />
            </Items>
        </ext:FormPanel>
        <ext:Toast
            runat="server"
            ID="Toast1" 
            StickWhileHover="true">
            <Content>
                This toast is defined in markup and shows once -- once the page is loaded.
            </Content>
        </ext:Toast>
    </form>
</body>
</html>