<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Regions Weights - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void ChangeWeights(object sender, DirectEventArgs e)
        {
            X.ControlsScripting = false;
            
            this.BorderLayoutPanel.Items[0].Weight = Convert.ToInt32(WestWeight.Number);
            this.BorderLayoutPanel.Items[1].Weight = Convert.ToInt32(NorthWeight.Number);
            this.BorderLayoutPanel.Items[2].Weight = Convert.ToInt32(SouthWeight.Number);
            this.BorderLayoutPanel.Items[3].Weight = Convert.ToInt32(EastWeight.Number);
            
            X.ControlsScripting = true;

            this.BorderLayoutPanel.Render(Window1, 0, RenderMode.InsertTo);
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Regions Weights</h1>
        
    <ext:Window 
        ID="Window1" 
        runat="server" 
        Title="Regions Weights" 
        Width="800" 
        Height="550"
        Border="false" 
        Closable="false">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>
        <Items>
            <ext:Panel ID="BorderLayoutPanel" runat="server" Flex="1" Layout="BorderLayout">
                <Items>
                    <ext:Panel runat="server" Title="West" Region="West" Width="200" />
                    <ext:Panel runat="server" Title="North" Region="North" Height="100" />
                    <ext:Panel runat="server" Title="South" Region="South" Height="100" />
                    <ext:Panel runat="server" Title="East" Region="East" Width="200" />

                    <ext:Panel runat="server" Region="Center" Title="Center" />
                </Items>
            </ext:Panel>

            <ext:Panel runat="server" Title="Settings" Height="200" BodyPadding="6" PaddingSpec="5 0 0 0">
                <LayoutConfig>
                    <ext:HBoxLayoutConfig Align="Stretch" />
                </LayoutConfig>
                <Items>
                    <ext:FormPanel ID="Weights" runat="server" Border="false" Width="300">                                
                        <Defaults>
                            <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                        </Defaults>
                
                        <Items>
                            <ext:NumberField ID="WestWeight" runat="server" FieldLabel="West" Number="0" />
                            <ext:NumberField ID="NorthWeight" runat="server" FieldLabel="North" Number="0" />
                            <ext:NumberField ID="SouthWeight" runat="server" FieldLabel="South" Number="0" />
                            <ext:NumberField ID="EastWeight" runat="server" FieldLabel="East" Number="0" />
                        </Items>

                        <DirectEvents>
                            <FieldChange OnEvent="ChangeWeights" Before="return this.isValid();" Buffer="100" />
                        </DirectEvents>
                    </ext:FormPanel>

                    <ext:Container runat="server" Flex="1">                        
                        <Items>     
                            <ext:DisplayField runat="server" Text="Cases:" />                       

                            <ext:Container runat="server">                 
                                <Defaults>
                                    <ext:Parameter Name="margin" Value="5 0 0 20" />
                                </Defaults>                
                                <Items>
                                    <ext:HyperlinkButton runat="server" Text="Case 1 (West : 20)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({WestWeight:20, NorthWeight:0, SouthWeight:0, EastWeight:0});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>
                                    
                                    <ext:HyperlinkButton runat="server" Text="Case 2 (East : 20)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({EastWeight:20, NorthWeight:0, SouthWeight:0, WestWeight:0});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>

                                    <ext:HyperlinkButton runat="server" Text="Case 3 (West : 20, East : 20)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({EastWeight:20, NorthWeight:0, SouthWeight:0, WestWeight:20});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>

                                    <ext:HyperlinkButton runat="server" Text="Case 4 (West : 20, South : 30, East : 20)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({WestWeight:20, NorthWeight:0, SouthWeight:30, EastWeight:20});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>
                                    
                                    <ext:HyperlinkButton runat="server" Text="Case 5 (West : 20, North : 30, East : 20)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({WestWeight:20, NorthWeight:30, SouthWeight:0, EastWeight:20});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>

                                    <ext:HyperlinkButton runat="server" Text="Case 6 (West : 60, North : 50, South : 45, East : 40)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({EastWeight:40, NorthWeight:50, SouthWeight:45, WestWeight:60});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>

                                    <ext:HyperlinkButton runat="server" Text="Case 7 (West : 40, North : 50, South : 45, East : 60)">
                                        <Listeners>
                                            <Click Handler="#{Weights}.setValue({EastWeight:60, NorthWeight:50, SouthWeight:45, WestWeight:40});" />
                                        </Listeners>
                                    </ext:HyperlinkButton>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Container>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Window>
</body>
</html>