<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            string path = Server.MapPath("../../../DataView/Shared/images/thumbs");
            string[] files = System.IO.Directory.GetFiles(path);

            List<object> data = new List<object>(files.Length);
            
            foreach (string fileName in files)
            {
                System.IO.FileInfo file = new System.IO.FileInfo(fileName);
                
                data.Add(new { name = file.Name,
                               url = "../../../DataView/Shared/images/thumbs/" + file.Name,
                               size = file.Length,
                               lastmod = file.LastAccessTime });
            }

            Store store = this.GridPanel1.GetStore();
            
            store.DataSource = data;
            store.DataBind();
        }
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        foreach (SelectedRow row in this.RowSelectionModel1.SelectedRows)
        {
            sb.AppendFormat("RecordID: {0}&nbsp;&nbsp;&nbsp;&nbsp;Row index: {1}<br/>", row.RecordID, row.RowIndex);
        }
        
        this.Label1.Html = sb.ToString();
    }

    protected void Clear_Click(object sender, DirectEventArgs e)
    {
        this.GridPanel1.GetSelectionModel().ClearSelection();
    }

    protected void Add_Click(object sender, DirectEventArgs e)
    {
        this.GridPanel1.GetSelectionModel().Select((object)"zack.jpg", true);
    }

    protected void SubmitSelection(object sender, DirectEventArgs e)
    {
        string json = e.ExtraParams["Values"];

        Dictionary<string, string>[] images = JSON.Deserialize<Dictionary<string, string>[]>(json);

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' cellspacing=\"15\">");
        bool addText = true;

        foreach (Dictionary<string, string> row in images)
        {
            if (addText)
            {
                sb.Append("<tr>");
            
                foreach (KeyValuePair<string, string> keyValuePair in row)
                {
                    sb.AppendFormat("<td style=\"white-space:nowrap;font-weight:bold;\">{0}</td>", keyValuePair.Key);
                }
                
                sb.Append("</tr>");

                addText = false;
            }

            sb.Append("<tr>");
            
            foreach (KeyValuePair<string, string> keyValuePair in row)
            {
                sb.AppendFormat("<td style=\"white-space:nowrap;\">{0}</td>", keyValuePair.Value);
            }
            
            sb.Append("</tr>");
        }
        
        sb.Append("</table>");
        this.Label1.Html = sb.ToString();
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>GridPanel - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <script>
        var selectionChanged = function (selModel, selected) {
			var count = selected.length, s = count != 1 ? "s" : "";
			App.Panel1.setTitle("Simple GridPanel (" + count + " item" + s + " selected)");
		};
    </script>   
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>ListView Example</h1>
        
        <p>Ext.Net 2 replaces Ext.ListView with the default GridPanel.</p>
        
        <ext:Panel 
            ID="Panel1" 
            runat="server" 
            Width="800" 
            Height="300"
            Title="Simple List <i>View (0 items selected)</i>"
            Layout="Fit">
            <Items>
                <ext:GridPanel ID="GridPanel1" runat="server">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server" IDProperty="name">
                                    <Fields>
                                        <ext:ModelField Name="name" />
                                        <ext:ModelField Name="url" />      
                                        <ext:ModelField Name="size" Type="Int" />
                                        <ext:ModelField Name="lastmod" Type="Date" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel>
                        <Columns>
                            <ext:TemplateColumn
                                runat="server"
                                Text="File" 
                                Flex="15" 
                                DataIndex="url" 
                                TemplateString='<img style="width:60px;height:45px;" src="{url}" />' 
                                />
                            <ext:Column 
                                runat="server"
                                Text="File" 
                                Flex="35" 
                                DataIndex="name" 
                                />
                            <ext:TemplateColumn 
                                runat="server"
                                Text="Last Modified" 
                                Flex="30" 
                                DataIndex="lastmod" 
                                TemplateString='{lastmod:date("m-d h:i a")}' 
                                />
                            <ext:TemplateColumn
                                runat="server" 
                                Text="Size" 
                                Flex="20" 
                                DataIndex="size" 
                                Align="Right" 
                                TemplateString="{size:fileSize}" 
                                />
                        </Columns>    
                    </ColumnModel>
                    <View>
                        <ext:GridView 
                            runat="server" 
                            EmptyText="No Images to Display" />
                    </View>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>
                    <Listeners>
                        <SelectionChange Fn="selectionChanged" /> 
                    </Listeners> 
                </ext:GridPanel>
            </Items>        
            <Buttons>
                <ext:Button runat="server" Text="Submit Selected" OnDirectClick="Button1_Click" />
                <ext:Button runat="server" Text="Submit Selected with Values">
                    <DirectEvents>
                        <Click OnEvent="SubmitSelection">
                            <ExtraParams>
                                <ext:Parameter 
                                    Name="Values" 
                                    Value="#{GridPanel1}.getRowsValues({ selectedOnly : true })" 
                                    Mode="Raw"
                                    Encode="true" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" Text="Clear Selections" OnDirectClick="Clear_Click" />
                <ext:Button runat="server" Text="Add 'Zack' to Selection " OnDirectClick="Add_Click" />
            </Buttons>
        </ext:Panel>
        
        <div style="width:788px; border:1px solid gray; padding:5px;">
            <ext:Label ID="Label1" runat="server" />
        </div>
    </form>
</body>
</html>