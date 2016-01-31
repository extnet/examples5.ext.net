<%@ Page Language="C#" %>

<script runat="server">
    protected void Change1Click(object sender, DirectEventArgs e)
    {
        this.Field1.IndicatorIcon = Icon.Accept;
        this.ResourceManager1.RegisterIcon(Icon.Accept);
    }

    protected void Change1_1Click(object sender, DirectEventArgs e)
    {
        this.Field1.IndicatorTip = "New tooltip";
    }

    protected void Change2Click(object sender, DirectEventArgs e)
    {
        this.Field2.IndicatorText = "New indicator's text";
    }

    protected void Change3Click(object sender, DirectEventArgs e)
    {
        this.Field3.IndicatorCls = "blue-text";
    }

    protected void ChangeVisibility(object sender, DirectEventArgs e)
    {
        if (e.ExtraParams["id"] == mnuShowIndicator.ConfigID)
        {
            this.Field3.HideIndicator();
        }
        else
        {
            this.Field3.ShowIndicator();
        }
    }
</script>
    
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Field Indicator - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <style>
        .red-text {
            color     : red;
            font-size : large;
        }
        
        .blue-text {
            color     : blue;
            font-size : large;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:FormPanel 
            ID="FormPanel1" 
            runat="server" 
            Width="785" 
            Title="Example" 
            BodyPadding="6">
            <Items>
                <ext:TextField 
                    ID="Field1" 
                    runat="server" 
                    FieldLabel="Field1" 
                    IndicatorIcon="Information"
                    Anchor="-5" 
                    IndicatorTip="A Indicator ToolTip" 
                    />
                <ext:TextField 
                    ID="Field2" 
                    runat="server" 
                    FieldLabel="Field2" 
                    IndicatorIcon="Add"
                    IndicatorText="Indicator" 
                    Anchor="-5" 
                    AllowBlank="false" 
                    MsgTarget="Side" 
                    />
                <ext:TextField 
                    ID="Field3" 
                    runat="server" 
                    FieldLabel="Field3" 
                    IndicatorText="*" 
                    IndicatorCls="red-text" 
                    />
                <ext:TextField 
                    ID="Field4" 
                    runat="server" 
                    AllowBlank="false"
                    FieldLabel="Field4" 
                    IndicatorIcon="BulletRed"
                    IndicatorTip="It is required field"
                    />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Change Icon - Field1" OnDirectClick="Change1Click" />
                <ext:Button runat="server" Text="Change Tooltip - Field1" OnDirectClick="Change1_1Click" />
                <ext:Button runat="server" Text="Change Text - Field2" OnDirectClick="Change2Click" />
                <ext:Button runat="server" Text="Change Css Class - Field3" OnDirectClick="Change3Click" />
                <ext:CycleButton runat="server" ShowText="true" MenuArrow="false">
                    <Menu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:CheckMenuItem 
                                    ID="mnuHideIndicator" 
                                    runat="server" 
                                    Icon="Decline"
                                    Text="Hide indicator - Field3"
                                    Checked="true" 
                                    />
                                <ext:CheckMenuItem 
                                    ID="mnuShowIndicator" 
                                    runat="server"
                                    Icon="Add" 
                                    Text="Show indicator - Field3" 
                                    />
                            </Items>
                        </ext:Menu>
                    </Menu>
                    <DirectEvents>
                        <Change OnEvent="ChangeVisibility">
                            <ExtraParams>
                                <ext:Parameter Name="id" Value="item.id" Mode="Raw" />
                            </ExtraParams>
                        </Change>
                    </DirectEvents>
                </ext:CycleButton>
            </Buttons>
        </ext:FormPanel>
    </form>    
</body>
</html>