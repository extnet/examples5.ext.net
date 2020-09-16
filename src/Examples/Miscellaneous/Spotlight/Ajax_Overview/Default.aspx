<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.UpdateButtons(null);
        }
    }

    protected void UpdateSpot(object sender, DirectEventArgs e)
    {
        string cmp = e.ExtraParams["cmp"];

        if (cmp == null)
        {
            this.Spot.Hide();

            this.UpdateButtons(null);
        }
        else
        {
            Ext.Net.Panel panel = (Ext.Net.Panel)Ext.Net.Utilities.ControlUtils.FindControl(this, cmp);

            this.Spot.Show(panel);

            this.UpdateButtons(panel);
        }
    }

    private void UpdateButtons(Ext.Net.Panel panel)
    {
        this.Button1.Disabled = panel != null ? panel.ID != "Panel1" : true;
        this.Button2.Disabled = panel != null ? panel.ID != "Panel2" : true;
        this.Button3.Disabled = panel != null ? panel.ID != "Panel3" : true;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spotlight - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Spotlight</h1>

        <p>This control allows you to restrict input to a particular element by masking all other page content.</p>

        <ext:Spotlight
            ID="Spot"
            runat="server"
            Easing="EaseOut"
            Duration="300"
            />

        <ext:Button runat="server" Text="Start">
            <DirectEvents>
                <Click OnEvent="UpdateSpot">
                    <ExtraParams>
                        <ext:Parameter Name="cmp" Value="Panel1" />
                    </ExtraParams>
                </Click>
            </DirectEvents>
        </ext:Button>

        <ext:Panel
            runat="server"
            Border="false"
            Layout="Table"
            ShrinkWrap="Width">
            <LayoutConfig>
                <ext:TableLayoutConfig Columns="3" />
            </LayoutConfig>
            <Items>
                <ext:Panel
                    ID="Panel1"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button1" runat="server" Text="Next Panel">
                            <DirectEvents>
                                <Click OnEvent="UpdateSpot">
                                    <ExtraParams>
                                        <ext:Parameter Name="cmp" Value="Panel2" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
                <ext:Panel
                    ID="Panel2"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="Next Panel">
                            <DirectEvents>
                                <Click OnEvent="UpdateSpot">
                                    <ExtraParams>
                                        <ext:Parameter Name="cmp" Value="Panel3" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>

                <ext:Panel
                    ID="Panel3"
                    runat="server"
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="180"
                    Html="Some panel content goes here!"
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button
                            ID="Button3"
                            runat="server"
                            Text="Done"
                            OnDirectClick="UpdateSpot"
                            />
                    </Buttons>
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
