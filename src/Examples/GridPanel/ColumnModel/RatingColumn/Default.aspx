<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.Data;
            this.Store1.DataBind();
        }
    }

    private object[] Data
    {
        get
        {
            return new object[]
            {
                new object[] { "3m Co", 1, 3, 1 },
                new object[] { "Alcoa Inc", 2, 2.7, 2 },
                new object[] { "Altria Group Inc", 3.5, 2, 3 },
                new object[] { "American Express Company", 4, 1.3, 4 },
                new object[] { "American International Group, Inc.", 5, 0, 5 }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RatingColumn - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" /> 
    
    <style>
        .number-selected {
	        background : transparent url(star_n.png) repeat-x left center;
        }
        
        .number-unselected {
	        background : transparent url(star_fade_n.png) repeat-x left center;
        }
    </style>       
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>Rating Column</h1>
    
    <ext:GridPanel 
        ID="GridPanel1"
        runat="server" 
        Title="Array Grid" 
        Width="600" 
        Height="350">
        <Store>
            <ext:Store ID="Store1" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="company" />
                            <ext:ModelField Name="rating1" Type="Float" />
                            <ext:ModelField Name="rating2" Type="Float" />
                            <ext:ModelField Name="rating3" Type="Float" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />                
                <ext:RatingColumn runat="server" Text="Rating" DataIndex="rating1" />
                <ext:RatingColumn runat="server" Text="Editable" DataIndex="rating2" RoundToTick="false" Editable="true" />
                <ext:RatingColumn runat="server" Text="Custom" DataIndex="rating3" SelectedCls="number-selected" UnselectedCls="number-unselected" />
            </Columns>
        </ColumnModel>       
    </ext:GridPanel>          
</body>
</html>