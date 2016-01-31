<%@ Page Language="C#" %>

<script runat="server">
    protected void ShowValue(object sender, DirectEventArgs e)
    {
        StringBuilder sb = new StringBuilder(256);

        foreach (Ext.Net.ListItem item in ItemSelector1.SelectedItems)
        {
            sb.AppendFormat("Value={0}, Index={1}, Text={2} <br/>", item.Value, item.Index, item.Text);
        }

        X.Msg.Alert("Selection", sb.ToString()).Show();
    }    
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Overview of MultiSelect - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .label {
            font    : bold 11px tahoma,arial,sans-serif;
            width   : 300px;
            height  : 25px;
            padding : 5px 0;
            border  : 1px dotted #99bbe8;
            color   : #15428b;
            cursor  : default;
            margin  : 10px;
            background  : #dfe8f6;
            text-align  : center;
            margin-left : 0px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:FormPanel
            runat="server"
            Title="ItemSelector Test"
            Width="700"
            BodyPadding="10"
            Height="300"
            Layout="FitLayout">
            <Items>
                <ext:ItemSelector
                    ID="ItemSelector1"
                    runat="server"
                    FieldLabel="ItemSelector"
                    AllowBlank="false"
                    MsgTarget="Side"
                    FromTitle="Available"
                    ToTitle="Selected">
                    <Items>
                        <ext:ListItem Text="One Hundred Twenty Three" Value="123" />
                        <ext:ListItem Text="One" Value="1" />
                        <ext:ListItem Text="Two" Value="2" />
                        <ext:ListItem Text="Three" Value="3" />
                        <ext:ListItem Text="Four" Value="4" />
                        <ext:ListItem Text="Five" Value="5" />
                        <ext:ListItem Text="Six" Value="6" />
                        <ext:ListItem Text="Seven" Value="7" />
                        <ext:ListItem Text="Eight" Value="8" />
                        <ext:ListItem Text="Nine" Value="9" />
                    </Items>
                    <SelectedItems>
                        <ext:ListItem Value="3" />
                        <ext:ListItem Value="4" />
                        <ext:ListItem Value="6" />
                    </SelectedItems>
                </ext:ItemSelector>
            </Items>
            <DockedItems>
                <ext:Toolbar runat="server" Dock="Top">
                    <Items>
                        <ext:Button runat="server" Text="Options">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Get value" Handler="Ext.Msg.alert('Value is a split array', App.ItemSelector1.getValue().join(', '));" />
                                        <ext:MenuItem runat="server" Text="Set value (2,3)" Handler="App.ItemSelector1.setValue(['2', '3']);" />
                                        <ext:CheckMenuItem
                                            runat="server"
                                            Text="Toggle enabled"
                                            Checked="true"
                                            CheckHandler="function (item, checked) { 
                                                              App.ItemSelector1.setDisabled(!checked); 
                                                          }" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>

                <ext:Toolbar runat="server" Dock="Bottom">
                    <Defaults>
                        <ext:Parameter Name="minWidth" Value="75" />
                    </Defaults>
                    <Items>
                        <ext:ToolbarFill />
                        <ext:Button runat="server" Text="Clear" Handler="if (!App.ItemSelector1.disabled) { App.ItemSelector1.clearValue(); }" />
                        <ext:Button runat="server" Text="Reset" Handler="App.ItemSelector1.reset();" />
                        <ext:Button runat="server" Text="Save" OnDirectClick="ShowValue" />
                    </Items>
                </ext:Toolbar>
            </DockedItems>
        </ext:FormPanel>
    </form>
</body>
</html>
