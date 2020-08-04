<%@ Page Language="C#" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Buttons of Field - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Buttons of Field</h1>

        <ext:Window
            runat="server"
            Width="550"
            Title="Buttons of Field"
            Closable="false"
            Layout="Form"
            BodyPadding="5">
            <Defaults>
                <ext:Parameter Name="LabelWidth" Value="200" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Right buttons">
                    <RightButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </RightButtons>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="Left buttons">
                     <LeftButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </LeftButtons>
                </ext:TextField>

                <ext:TextField runat="server" FieldLabel="StandOut buttons">
                     <RightButtons>
                        <ext:Button runat="server" Icon="Add" StandOut="true" />
                        <ext:Button runat="server" Icon="Accept" Flat="false" />
                    </RightButtons>
                </ext:TextField>

                <ext:DateField
                    runat="server"
                    FieldLabel="Menu button"
                    HideTrigger="true"
                    EmptyText="Insert a date">
                    <RightButtons>
                        <ext:Button runat="server" StandOut="true" Text="Insert...">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem
                                            runat="server"
                                            Text="Today"
                                            Handler="this.up('datefield').setValue(new Date());"
                                            />
                                        <ext:MenuItem
                                            runat="server"
                                            Text="Tomorrow"
                                            Handler="this.up('datefield').setValue(Ext.Date.add(new Date(), Ext.Date.DAY, 1));"
                                            />
                                        <ext:MenuItem
                                            runat="server"
                                            Text="+One week"
                                            Handler="this.up('datefield').setValue(Ext.Date.add(new Date(), Ext.Date.WEEK, 1));"
                                            />
                                        <ext:MenuItem
                                            runat="server"
                                            Text="+Two week"
                                            Handler="this.up('datefield').setValue(Ext.Date.add(new Date(), Ext.Date.WEEK, 2));"
                                            />
                                        <ext:MenuItem
                                            runat="server"
                                            Text="+One month"
                                            Handler="this.up('datefield').setValue(Ext.Date.add(new Date(), Ext.Date.MONTH, 1));"
                                            />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                    </RightButtons>
                </ext:DateField>

                <ext:TextField runat="server" FieldLabel="Left and right buttons">
                    <LeftButtons>
                        <ext:Button runat="server" Icon="UserAdd" />
                        <ext:Button runat="server" Icon="UserAlert" />
                    </LeftButtons>
                    <RightButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </RightButtons>
                </ext:TextField>

                <ext:TextField
                    runat="server"
                    FieldLabel="Show buttons on mouse over"
                    RightButtonsShowMode="MouseOver"
                    EmptyText="Move mouse here">
                    <RightButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </RightButtons>
                </ext:TextField>

                <ext:TextField
                    runat="server"
                    FieldLabel="Show buttons on focus"
                    RightButtonsShowMode="Focus"
                    EmptyText="Click here">
                    <RightButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </RightButtons>
                </ext:TextField>

                <ext:TextField
                    runat="server"
                    FieldLabel="Show buttons if non blank"
                    RightButtonsShowMode="NonBlank"
                    EmptyText="Type something">
                    <RightButtons>
                        <ext:Button runat="server" Icon="Add" />
                        <ext:Button runat="server" Icon="Accept" />
                    </RightButtons>
                </ext:TextField>
            </Items>
        </ext:Window>
   </form>
</body>
</html>
