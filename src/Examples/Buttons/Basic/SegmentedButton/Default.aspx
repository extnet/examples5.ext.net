<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>SegmentedButton Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Segmented buttons</h1>

    <p>This example shows how to use segmented buttons. Segmented buttons are just containers
       with regular buttons inside, with some special styling and options added. By default,
       all the child buttons will be part of a toggleGroup, but this behavior can be customized
       using the <code>allowToggle</code> and <code>allowMultiple</code> config options. </p>

    <ext:Container runat="server" Layout="FormLayout">
        <Items>
            <ext:FieldContainer runat="server" FieldLabel="Toggle Group">
                <Items>
                    <ext:SegmentedButton runat="server">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" Pressed="true" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Multiple Toggle">
                <Items>
                    <ext:SegmentedButton runat="server" AllowMultiple="true" Values="0,2">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="No Toggle">
                <Items>
                    <ext:SegmentedButton runat="server" AllowToggle="false">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Icons and Arrows">
                <Items>
                    <ext:SegmentedButton runat="server" AllowToggle="false">
                        <Items>
                            <ext:Button runat="server" Text="Button" Icon="Add" />
                            <ext:Button runat="server" Text="Menu Button">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Menu Item 1" />
                                            <ext:MenuItem runat="server" Text="Menu Item 2" />
                                            <ext:MenuItem runat="server" Text="Menu Item 3" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:SplitButton runat="server" Text="Split Button">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Menu Item 1" />
                                            <ext:MenuItem runat="server" Text="Menu Item 2" />
                                            <ext:MenuItem runat="server" Text="Menu Item 3" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:SplitButton>
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>
        </Items>
    </ext:Container>

    <h2>Vertical segmented buttons</h2>

    <p>Aligning segmented buttons vertically is a simple as setting the <code>vertical</code> config to <code>true</code>. </p>

    <ext:Container runat="server" Layout="ColumnLayout">
        <Defaults>
            <ext:Parameter Name="labelAlign" Value="top" />
            <ext:Parameter Name="margin" Value="0 20 0 0" />
        </Defaults>
        <Items>
            <ext:FieldContainer runat="server" FieldLabel="Toggle Group">
                <Items>
                    <ext:SegmentedButton runat="server" Vertical="true">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" Pressed="true" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Multiple Toggle">
                <Items>
                    <ext:SegmentedButton
                        runat="server"
                        AllowMultiple="true"
                        Values="0,2"
                        Vertical="true">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="No Toggle">
                <Items>
                    <ext:SegmentedButton runat="server" AllowToggle="false" Vertical="true">
                        <Items>
                            <ext:Button runat="server" Text="Option One" />
                            <ext:Button runat="server" Text="Option Two" />
                            <ext:Button runat="server" Text="Option Three" />
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>

            <ext:FieldContainer runat="server" FieldLabel="Icons and Arrows">
                <Items>
                    <ext:SegmentedButton runat="server" AllowToggle="false" Vertical="true">
                        <Items>
                            <ext:Button runat="server" Text="Button" Icon="Add" />
                            <ext:Button runat="server" Text="Menu Button">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Menu Item 1" />
                                            <ext:MenuItem runat="server" Text="Menu Item 2" />
                                            <ext:MenuItem runat="server" Text="Menu Item 3" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:SplitButton runat="server" Text="Split Button">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:MenuItem runat="server" Text="Menu Item 1" />
                                            <ext:MenuItem runat="server" Text="Menu Item 2" />
                                            <ext:MenuItem runat="server" Text="Menu Item 3" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:SplitButton>
                        </Items>
                    </ext:SegmentedButton>
                </Items>
            </ext:FieldContainer>
        </Items>
    </ext:Container>
</body>
</html>