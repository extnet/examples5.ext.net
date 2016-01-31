<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Xml" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ajax Linked Combos - Ext.NET Examples</title>

    <script runat="server">
        protected void CitiesRefresh(object sender, StoreReadDataEventArgs e)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(HttpContext.Current.Server.MapPath("Cities.xml"));
            List<object> data = new List<object>();

            foreach (XmlNode cityNode in xmlDoc.SelectNodes(string.Concat("countries/country[@code='", this.ComboBox1.SelectedItem.Value, "']/city")))
            {
                string id = cityNode.SelectSingleNode("id").InnerText;
                string name = cityNode.SelectSingleNode("name").InnerText;

                data.Add(new { Id = id, Name = name });
            }
            
            this.CitiesStore.DataSource = data;

            this.CitiesStore.DataBind();
        }
    </script>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
<form runat="server">
    <ext:ResourceManager runat="server" />
    
    <ext:ComboBox 
        ID="ComboBox1" 
        runat="server" 
        Editable="false" 
        QueryMode="Local"
        TriggerAction="All" 
        EmptyText="Select a country">
        <Listeners>
            <Select Handler="#{ComboBox2}.clearValue(); #{CitiesStore}.reload();" />
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
        ID="ComboBox2" 
        runat="server" 
        TypeAhead="true" 
        QueryMode="Local"
        ForceSelection="true" 
        TriggerAction="All" 
        DisplayField="name" 
        ValueField="id"
        EmptyText="Loading..." 
        ValueNotFoundText="Loading...">
        <Store>
            <ext:Store 
                runat="server" 
                ID="CitiesStore" 
                AutoLoad="false" 
                OnReadData="CitiesRefresh">               
                <Model>
                    <ext:Model runat="server" IDProperty="Id">
                        <Fields>
                            <ext:ModelField Name="id" Type="String" ServerMapping="Id" />
                            <ext:ModelField Name="name" Type="String" ServerMapping="Name" />
                        </Fields>
                    </ext:Model>
                </Model>
                <Listeners>
                    <Load Handler="#{ComboBox2}.setValue(#{ComboBox2}.store.getAt(0).get('id'));" />
                </Listeners>
            </ext:Store>
        </Store>    
    </ext:ComboBox>
</form>
</body>
</html>