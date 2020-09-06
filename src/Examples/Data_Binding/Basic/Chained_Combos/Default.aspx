<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Chained ComboBoxes - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Chained ComboBoxes</h1>

        <p>This example shows how to chain two combo boxes together.</p>

        <ext:Panel
            runat="server"
            Width="360"
            Layout="Anchor"
            BodyPadding="18"
            DefaultAnchor="-30"
            ReferenceHolder="true"
            Title="Location"
            ViewModel="<%# true %>"
            AutoDataBind="true">
            <Items>
                <ext:ComboBox
                    runat="server"
                    FieldLabel="Country"
                    Reference="country"
                    Publishes="value">
                    <Items>
                        <ext:ListItem Text="USA" />
                        <ext:ListItem Text="Canada" />
                    </Items>
                </ext:ComboBox>

                <ext:ComboBox
                    runat="server"
                    FieldLabel="State"
                    DisplayField="state"
                    ValueField="abbrev"
                    QueryMode="Remote">
                    <Bind>
                        <ext:Parameter Name="visible" Value="{country.value}" />
                        <ext:Parameter Name="filters" Value="{property: 'country', value: '{country.value}'}" Mode="Raw" />
                    </Bind>
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="abbr" />
                                        <ext:ModelField Name="state" />
                                        <ext:ModelField Name="description" />
                                        <ext:ModelField Name="country" />
                                    </Fields>
                                </ext:Model>
                            </Model>

                            <Proxy>
                                <ext:AjaxProxy Url="states.json" />
                            </Proxy>
                        </ext:Store>
                    </Store>
                </ext:ComboBox>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>