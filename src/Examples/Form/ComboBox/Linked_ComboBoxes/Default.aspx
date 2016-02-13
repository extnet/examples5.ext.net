<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Linked ComboBoxes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <ext:ResourcePlaceHolder runat="server" Mode="Script" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Store ID="CitiesStore" runat="server">
            <Proxy>
                <ext:AjaxProxy runat="server" Url="Cities.asmx/GetCities">
                    <ActionMethods Read="POST" />
                     <Reader>
                        <ext:XmlReader Record="City" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="id" Type="String" Mapping="Id" />
                        <ext:ModelField Name="name" Type="String" Mapping="Name" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                <ext:StoreParameter Name="countryCode" Value="#{Countries}.getValue()" Mode="Raw" />
            </Parameters>
            <Listeners>
                <Load Handler="#{Cities}.setValue(#{Cities}.store.getAt(0).get('id'));" />
            </Listeners>
        </ext:Store>

        <ext:ComboBox
            ID="Countries"
            runat="server"
            Editable="false"
            QueryMode="Local"
            ForceSelection="true"
            TriggerAction="All"
            EmptyText="Select a country">
            <SelectedItems>
                <ext:ListItem Value="GB" />
            </SelectedItems>
            <Listeners>
                <Select Handler="#{Cities}.clearValue();
                                 #{CitiesStore}.load();" />
            </Listeners>
            <Items>
                <ext:ListItem Text="Belgium" Value="BE" />
                <ext:ListItem Text="Brazil" Value="BR" />
                <ext:ListItem Text="Bulgaria" Value="BG" />
                <ext:ListItem Text="Canada" Value="CA" />
                <ext:ListItem Text="Chile" Value="CL" />
                <ext:ListItem Text="Cyprus" Value="CY" />
                <ext:ListItem Text="Finland" Value="FI" />
                <ext:ListItem Text="France" Value="FR" />
                <ext:ListItem Text="Germany" Value="DE" />
                <ext:ListItem Text="Hungary" Value="HU" />
                <ext:ListItem Text="Ireland" Value="IE" />
                <ext:ListItem Text="Israel" Value="IL" />
                <ext:ListItem Text="Italy" Value="IT" />
                <ext:ListItem Text="Lithuania" Value="LT" />
                <ext:ListItem Text="Mexico" Value="MX" />
                <ext:ListItem Text="Netherlands" Value="NL" />
                <ext:ListItem Text="New Zealand" Value="NZ" />
                <ext:ListItem Text="Norway" Value="NO" />
                <ext:ListItem Text="Pakistan" Value="PK" />
                <ext:ListItem Text="Poland" Value="PL" />
                <ext:ListItem Text="Romania" Value="RO" />
                <ext:ListItem Text="Slovakia" Value="SK" />
                <ext:ListItem Text="Slovenia" Value="SI" />
                <ext:ListItem Text="Spain" Value="ES" />
                <ext:ListItem Text="Sweden" Value="SE" />
                <ext:ListItem Text="Switzerland" Value="CH" />
                <ext:ListItem Text="United Kingdom" Value="GB" />
            </Items>
        </ext:ComboBox>

        <ext:ComboBox
            ID="Cities"
            runat="server"
            StoreID="CitiesStore"
            Editable="false"
            QueryMode="Local"
            ForceSelection="true"
            TriggerAction="All"
            DisplayField="name"
            ValueField="id"
            EmptyText="Loading..."
            ValueNotFoundText="Loading..."
            />
    </form>
</body>
</html>