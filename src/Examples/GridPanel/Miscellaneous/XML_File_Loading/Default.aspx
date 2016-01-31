<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>XML File Loading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>XML file loading</h1>
    
    <p>This example shows how to load a data from an XML file directly.</p>

    <ext:GridPanel 
        runat="server" 
        Width="600" 
        Height="300" 
        Title="Plants" 
        Frame="true">
        <Store>
            <ext:Store runat="server">
                <Proxy>
                    <ext:AjaxProxy runat="server" Url="../../Shared/Plants.xml">
                        <Reader>
                            <ext:XmlReader Record="plant" />
                        </Reader>
                    </ext:AjaxProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="common" />
                            <ext:ModelField Name="botanical" />
                            <ext:ModelField Name="light" />
                            <ext:ModelField Name="price" Type="Float" />
                            <ext:ModelField Name="availability" Type="Date" DateFormat="MM/dd/yyyy" />
                            <ext:ModelField Name="indoor" Type="Boolean" />
                        </Fields>
                    </ext:Model>
                </Model>
                <Sorters>
                    <ext:DataSorter Property="common" Direction="ASC" />
                </Sorters>        
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
		    <Columns>
                <ext:Column 
                    runat="server" 
                    Text="Common Name" 
                    DataIndex="common" 
                    Flex="1" 
                    />
                <ext:Column 
                    runat="server" 
                    Text="Light" 
                    DataIndex="light" 
                    Width="130" 
                    />
                <ext:Column 
                    runat="server" 
                    Text="Price" 
                    DataIndex="price" 
                    Width="70" 
                    Align="right">
                    <Renderer Format="UsMoney" />
                </ext:Column>
                <ext:DateColumn 
                    runat="server" 
                    Text="Available" 
                    DataIndex="availability" 
                    Width="95" 
                    Format="yyyy-MM-dd" 
                    />
                <ext:Column 
                    runat="server" 
                    Text="Indoor?" 
                    DataIndex="indoor" 
                    Width="55" 
                    />
		    </Columns>
        </ColumnModel>
    </ext:GridPanel>
</body>
</html>